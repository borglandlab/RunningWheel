#Importing libraries:
import smtplib
import time
import random
import array as arr
from datetime import date, datetime
from time import gmtime, strftime
import speedtest

import busio
import digitalio
import board
import adafruit_mcp3xxx.mcp3008 as MCP
from adafruit_mcp3xxx.analog_in import AnalogIn
from time import sleep
import socket




SPINNER_NAME = 1  #Corresponds to the wheel number
EMAIL_FREQUENCY = 1     #Corresponds to how often an email will be sent, once every _____ hour.
TRIGGER_THRESHOLD = 30
#Email Variables
SMTP_SERVER = 'smtp.gmail.com' #Email Server (don't change!)
SMTP_PORT = 587 #Server Port (don't change!)
GMAIL_USERNAME = 'email@gmail.com' #change this to match your gmail account
GMAIL_PASSWORD = 'password'  #change this to match your gmail password



#Declaring functions:
class Emailer:
    #This is the function used to send emails
    def sendmail(self, recipient, subject, content):
        #Create Headers for email
        headers = ["From: " + GMAIL_USERNAME, "Subject: " + subject, "To: " + recipient,
                   "MIME-Version: 1.0", "Content-Type: text/html"]
        headers = "\r\n".join(headers)
        #Connect to Gmail Server
        session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        session.ehlo()
        session.starttls()
        session.ehlo()
        #Login to Gmail
        session.login(GMAIL_USERNAME, GMAIL_PASSWORD)
         #Send Email & Exit
        session.sendmail(GMAIL_USERNAME, recipient, headers + "\r\n\r\n" + content)
        session.quit

sender = Emailer()  #setting "sender" as the emailer function
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
#Create email report and put the current time at the top of it
emailReport = [cTime]


s = speedtest.Speedtest()


def is_connected():
    #This function is used to determine if there is an internet connection prior to sending an email
    try:
        # connect to the host -- tells us if the host is actually
        # reachable
        socket.create_connection(("1.1.1.1", 53))
        if round((round(s.upload()) / 1048576), 2) >= 1:
            return True
        else:
            return False
    except OSError:
        pass
    return False



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
    


#Setting up email parameters:
emailContent = "Script Starting V2.0, rest value[" + str(s1nR)+"|"+str(s2nR)+"|"+str(s3nR) + "] Trigger threshold [" + str(sTrig) + "]"
print(emailContent)
emailSubject = "Spinner_" + str(SPINNER_NAME) + " starting"
sendTo = 'borgland.mousebehaviour@gmail.com'
sender.sendmail(sendTo, emailSubject, emailContent)

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
            #If triggered appends trigger time and sensor values to emailReport
            cTime = round(1000*(time.time()-cycleStart))/1000
            emailReport.append(str(cTime)+"|"+str(s1n)+"|"+str(s2n)+"|"+str(s3n))
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
        
        #If sMax is less than or equal to sTrig, tells us that no movement has occured in the last 500 cycles and it's safe to send an email without missing data.
        if sMax <= sTrig:
            #Check to see if current hour time is divisible by three (ie. will send an email every 3 hours)
            if ((cHour % EMAIL_FREQUENCY == 0) and (oHour != cHour)) or (len(emailReport) > 3000):
                oHour = cHour   #Sets old hour to current hour
                print("3 hour have passed, sending email")  #Debugging purposes
                #Reset current time to current GMT time
                cTime = strftime("%Y-%m-%d %H:%M:%S", gmtime())
                #Prepares email content
                emailContent = "Spinner_" + str(SPINNER_NAME) + " Report %s " % emailReport
                emailSubject = "Spinner_" + str(SPINNER_NAME) + " Report " + str(oTime) + " to " + str(cTime)
                #Saves email Content to text file in desired location
                spinlog = open ('/home/pi/Desktop/spinlog_' + str(SPINNER_NAME) + '.txt', 'a+')
                spinlog.write(emailContent)
                spinlog.write('\n')
                spinlog.close()

                #Checks to see if there is an internet connection. If yes, will send an email.
                if is_connected():
                    print("Internet is working")
                    sendTo = 'borgland.mousebehaviour@gmail.com'
                    sender.sendmail(sendTo, emailSubject, emailContent)

                #Clears emailReport and puts the current time at the top
                emailReport = [cTime]
                oTime = strftime("%Y-%m-%d %H:%M:%S", gmtime()) #Sets the old time
                cycleStart = time.time()    #Sets cycle start time
        
        #Resets sMax and cycleCount to 0. Will now run 500 cycles again (Main loop)
        sMax = 0
        cycleCount = 0
