#Importing libraries:
import smtplib
import time
import random
import array as arr
from datetime import date, datetime
from time import gmtime, strftime

import busio
import digitalio
import board
import adafruit_mcp3xxx.mcp3008 as MCP
from adafruit_mcp3xxx.analog_in import AnalogIn
from time import sleep
import socket




SPINNER_NAME = 1  #Corresponds to the wheel number
TRIGGER_THRESHOLD = 30

today = date.today()
scriptStart = strftime("%Y-%m-%d %H:%M:%S", gmtime())
#At startup the old hour is set to -1 and the current hour is set to 0
oHour = -1
cHour = 0
#At startup the current minute is set to the current time and the old minute is then set to the same as the current hour
cMin = int(strftime("%-M"))
oMin = cMin
#At startup the current time is set to the current time in GMT
cTime = strftime("%Y-%m-%d %H:%M:%S", gmtime())
#Create report and put the current time at the top of it
Report = [cTime]


#Declaring hardward:
# create the spi bus
spi = busio.SPI(clock=board.SCK, MISO=board.MISO, MOSI=board.MOSI)
# create the cs (chip select)
cs = digitalio.DigitalInOut(board.D5) 
# create the mcp object
mcp = MCP.MCP3008(spi, cs) 
# create an analog input channel on pin 0, 2, and 4
hf1 = AnalogIn(mcp, MCP.P4)
hf2 = AnalogIn(mcp, MCP.P2)
hf3 = AnalogIn(mcp, MCP.P0)
#Make cycleStart equal to the current time and cycleCount equal to 1 at the beginning
cycleStart = time.time()
cycleCount = 1



#Calibrating the default sensor values:
#Setting sensor sum values to 0 (these variables are only for calibration purposes)
s1nS = 0
s2nS = 0
s3nS = 0
#Assigning sensor variables to analog input pins
s1n = int(abs(hf1.value))
s2n = int(abs(hf2.value))
s3n = int(abs(hf3.value))

print("Starting Calibration Sequence")
cycleAmount = 500
#Read sensor values 500 times
while cycleCount <= cycleAmount:
    s1n = int(abs(hf1.value))
    s2n = int(abs(hf2.value))
    s3n = int(abs(hf3.value))
    print(str(s1n/64)+"|"+str(s2n/64)+"|"+str(s3n/64))
    #Adding sensor values together to take an average
    s1nS += s1n
    s2nS += s2n
    s3nS += s3n
    cycleCount += 1
    sleep(0.05)

#Calculating the average and rounding to a whole number
s1nR = round(s1nS/(64*cycleAmount))
s2nR = round(s2nS/(64*cycleAmount))
s3nR = round(s3nS/(64*cycleAmount))
sTrig = TRIGGER_THRESHOLD
    
Content = "Script Starting V2.0, rest value[" + str(s1nR)+"|"+str(s2nR)+"|"+str(s3nR) + "] Trigger threshold [" + str(sTrig) + "]"
print(Content)  #This will be useful if you are connected to a monitor
spinlog = open ('/home/pi/Desktop/spinlog_' + str(SPINNER_NAME) + '.txt', 'a+')
spinlog.write(Content)  #You won't be able to view this until afterwards, but atleast you can verify at that point.
spinlog.write('\n')
spinlog.close()


#Setting the sensor maximum to 0. This is done at the end of every 500 cycles (ie. cycleAmount = 500).
sMax = 0
clr = True  #Declare clear as true (just at the start)
oTime = strftime("%Y-%m-%d %H:%M:%S", gmtime()) #Setting old time as the currrent GMT time.


#Main Loop:
while 1:
    #Checks sensor values and subtract the noise that was calculated in calibration (s1nR, s2nR, and s3nR)
    #All these numbers have a common denominator of 64, so dividing by 64 makes the math easier.
    s1n = int(abs(hf1.value/64-s1nR))
    s2n = int(abs(hf2.value/64-s2nR))
    s3n = int(abs(hf3.value/64-s3nR))
    #Adds one to the cycle count
    cycleCount += 1
    
    #Checks to see that sensors are cleared from previous rotation.
    if clr:
        #If cleared, checks to see if sensor 1 or 3 values are greater than trigger (30)
        if s1n > sTrig or s3n > sTrig:
            #If triggered appends trigger time and sensor values to Report
            cTime = round(1000*(time.time()-cycleStart))/1000
            Report.append(str(cTime)+"|"+str(s1n)+"|"+str(s2n)+"|"+str(s3n))
            clr = False #Sets sensors to not clear
            
            #Keeping track of the maximum sensor 1 and 3 values (purpose is to check for movement)
            if s1n > sMax:
                sMax = s1n
                
            if s3n > sMax:
                sMax = s3n
    
    #Waits for all sensor values to be less than 15 before setting sensors to clear again
    if s1n < 15 and s2n < 15 and s3n < 15:
            clr = True
    
    #Every 500 cycles it checks for new system times:
    if cycleCount > cycleAmount:
        cHour = int(strftime("%H", gmtime()))
        
        #If sMax is less than or equal to sTrig, tells us that no movement has occured in the last 500 cycles and it's safe to send an  without missing data.
        if sMax <= sTrig:
            #Check to see if current hour time is divisible by three (ie. will send an  every 3 hours)
            if ((cHour % 3 == 0) and (oHour != cHour)) or (len(Report) > 3000):
                oHour = cHour   #Sets old hour to currenet hour
                print("3 hour have passed, sending ")  #Debugging purposes
                #Reset current time to current GMT time
                cTime = strftime("%Y-%m-%d %H:%M:%S", gmtime())
                #Prepares content to be written to text file
                Content = "Spinner_" + str(SPINNER_NAME) +" Report %s " % Report
                spinlog = open ('/home/pi/Desktop/spinlog_' + str(SPINNER_NAME) + '.txt', 'a+')
                spinlog.write(Content)
                spinlog.write('\n')
                spinlog.close()
                Report = [cTime]
                oTime = strftime("%Y-%m-%d %H:%M:%S", gmtime()) #Sets the old time
                cycleStart = time.time()    #Sets cycle start time
        
        #Resets sMax and cycleCount to 0. Will now run 500 cycles again (Main loop)
        sMax = 0
        cycleCount = 0
