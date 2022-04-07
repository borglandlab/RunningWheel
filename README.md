# Running Wheel Paper Name

------
## Brief Description
We designed and constructed an open source [running wheel system](https://github.com/borglandlab/RunningWheel/blob/main/Schematics/Wheel_Schematic.jpg) that runs independent of a central computer. The body of these wheels are 3D printed. The wheels operate using a raspberry pi zero W, a small but highly available microprocessor, and are programmed completely in python. Data is transmitted to a personal computer, that can be located anywhere, via email, where it is then automatically downloaded, parsed, and analyzed with python and MATLAB programs. Our running wheel system is simple, adaptable, and completely open source. 

------
## Cost of Running Wheel
| Item									| Supplier				| Unit Cost	| Needed	| Total Cost |
| -------								| ------				| ------	| -----		| -----	     |
| Raspberry Pi Zero W with 16 GB MicroSD card				| BuyaPi.ca				| $34.33	| 1		| $34.33     |
| 10 BIT, 200KSPS, DIP-16 Analog to Digital Converter (MCP3008-I/P)	| Newark Element14			| $3.60		| 1		| $3.60	     |
| PCB Breakout Board	  	    	    	      			| Amazon 				| $1.27		| 1		| $1.27	     |
| Bestol A1302 Ratiometric Linear Hall Effect Sensor Chip		| Amazon				| $1.90		| 3		| $5.70	     |
| 10Kohm resistors	   	       	      	     			| B & E Electronics LTD (Calgary)	| $0.15		| 3		| $0.45	     |
| USB power cable							| Amazon	    			| $4.33		| 1		| $4.33	     |
| USB wall power adapter						| Amazon				| $4.60		| 1		| $4.60	     |
| TUOFENG 20 Gauge Solid Wire						| Amazon				| $0.93		| 1		| $0.93	     |
| 4x2 mm circular magents						| Amazon				| $0.08		| 12		| $0.96	     |
| 8/8 X 7/8 X 9/32 Rubber Seal Ball Bearing				| PM Hobbycraft (Calgary)		| $2.10		| 1		| $2.10	     |
| #4 x 3/8-inch wood screws    	    					| Home Hardware (Calgary)		| $0.16		| 2		| $0.32	     |
| Protective 1/2" copper tubing						| Rona (Calgary)			| $1.11		| 1		| $1.11	     |
| Base Bottom (~22 g of PLA)	  	 				| $29.99/kg from Amazon			| $0.66		| 1		| $0.66	     |
| Base Top (~60 g of PLA)						| $29.99/kg from Amazon			| $1.80		| 1		| $1.80	     |
| Spinner (~72 g of PLA)						| $29.99/kg from Amazon			| $2.16		| 1		| $2.16	     |
| Sensor Holder (~1 g of PLA)						| $29.99/kg from Amazon			| $0.03		| 1		| $0.03	     |
| **Total Cost**								| 					| 		| 		| **$64.35**   |

-----
## Printing and Assembly

### 3D Printing
There are four pieces that need to be printed for each running wheel. It is best to print all pieces for a single wheel from the same printer, as this will improve how well the parts will fit together. The pieces included:
1. [Base Bottom](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Base%20Bottom.STL)
2. [Base Top](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Base%20Top.STL)
3. [Sensor Holder](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Sensor%20Holder.STL)
4. [Spinner](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Spinner.STL)

It is ideal to print the Spinner part with the same infill settings across all running wheels, as this will decrease the variability in weight. Spinners with different weights will spin differently, changing the experience of the mouse and the likelihood that they will use the wheel.

To facilitate greater reproducibility of our 3D printed running wheels, we’ve outlined printer specifications that we selected, and a summary of the printing process.

Following printing of the Spinner magnets must be inserted into the three rectangular openings left. 3 to 4 4x2 mm circular magnets should fit snuggly. Make sure the same number of magnets is in each opening so that the weight is even. The metal ball bearing should also be inserted into the centre opening. The Spinner is designed to hold a 8/8 X 7/8 X 9/32 ball bearing.

Following printing of the Base Top the support material can be removed. A layer of epoxy glue should also be added to the protrusion that the spinner slides onto. This can be done with a medium size paint brush. After the epoxy has hardened (approximately 24 to 48 hours), it should be carefully sanded down until the ball bearing inside of the Spinner can slide on snuggly. If you sand too much away then reapply the epoxy and try again. This makes the protrusion much stronger so that it won’t wear away with the sliding.


#### Specifications for the eryone thinker ER20 and flsun qqs-pro printers
- Adhesion Type: Skirt
- Alternate Extra Wall: Yes
- Avoid Printed Parts When Traveling: Yes
- Combing mode: All
- Custom support blocker for “[Base Top.stl](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Base%20Top.STL)”: Only print support material where the slanted roof section meets the horizontal roof section. Place support blockers covering the rest of the Base Top. See [attached images](https://github.com/borglandlab/RunningWheel/tree/main/3Dprintingfiles/SupportBlockers) to see where to place the support material.
- Enable Retraction: Yes
- Extrude width: 0.46 mm (wall/top/bottom/infill/everything)
- Infill Line Distance: 6.9 mm
- Infill Density: 7%
- Infill Overlap Percentage: 25%
- Infill Patter: Zig zag
- Infill Travel Optimisation: Yes
- Initial Layer Height: 0.24 mm
- Layer height: 0.2 mm
- Material: Generic PLA
- Optimizing wall printing order: Yes
- Print Cooling: 70% at all times
- Print Temperature: 200C (nozzle), 40C (bed)
- Speed: 50 mm/s everything
- Initial Speed: 30 mm/s
- Wall Line count: 2

Before mass printing, the printer bed was cleaned with isopropyl alcohol. An outline of the part was then printed, followed by light glue stick application to the area. After each print, the old purge line/skirt was scraped off the bed. Before printing again, the area was cleaned with a lightly dampened cloth and the print area was again prepared with light glue stick application.


#### Specifications for the Sindoh 3DWOX
- Advanced mode on
- Basic Settings:
- Layer height: 0.2 mm
- Nozzle Temperature: 200C
- Bed Temperature: 40C
- Infill Density: 7%
- Flow Compensation: 100%
- Quality/Shell Settings:
- Bottom Layer Thickness: 0 mm
- Bottom Layer Line Width: 200%
- Retraction Combing: All
- Internal Moving Area: Default
- Wall Thickness: 0.88 mm
- Top/Bottom Thickness: 0.80 mm
- Solid Top: yes
- Solid Bottom: yes
- Wall Printing Direction: Inside to Outside
- Infill Settings:
- Infill Patter: Automatic
- Infill Overlap: 25%
- Skin Type: Line
- Skin Overlap: 15%
- Speed Settings:
- Print Speed: 50 mm/s
- Travel Speed: 130 mm/s
- First Layer Speed: 30 mm/s
- Infill Speed: 0 mm/s
- Top/Bottom Speed: 0 mm/s
- Outer Wall Speed: 0 mm/s
- Inner Wall Speed: 0 mm/s
- Retraction/Cooling Settings:
- Enable Retraction: yes
- Speed: 30 mm/s
- Length: 6.00 mm
- Minimal Travel: 1.50 mm
- Minimal Extrusion Before Retraction: 0.02 mm
- Lowering Bed during Retraction: 0 mm
- Regular Fan Speed: 50%
- Maximum Fan Speed: 50%
- Height at Regular Fan Speed: 0.60 mm
- Enable Cooling Fan: yes
- Minimal Layer Time: 5 sec
- Minimum Speed: 10 mm/s
- Minimum wait period for Lowering Bed: no
- Support:
   - Support: none
   - Bed Adhesion:
   - Bed Adhesion: skirt
   - Skirt Line Count: 1
   - Skirt Line Gap: 3 mm
   - Skirt Minimal Length: 150 mm
- Shape Error Correction: 
   - Combination Mode A: yes

With these settings, the printer will print no support blockers. However, for “[Base Top.stl](https://github.com/borglandlab/RunningWheel/blob/main/3Dprintingfiles/STL/Base%20Top.STL)” support material should be printed where the slanted roof section meets the horizontal roof section. You need to manually add this. See [attached images](https://github.com/borglandlab/RunningWheel/tree/main/3Dprintingfiles/SupportBlockers) to see where to place the support material.


### Assembling the Running Wheel
Each wheel must be assembled using the following electrical components and wiring information. A soldering iron and solder are required to do this.

The 3 hall effect sensors must be inserted inside the 3D printed sensor holder prior to being soldered. This sensor holder fits nicely in the base top of the running wheel.

Electrical Components:
- Raspberry Pi 0 W with a microSD card:
- The MCP 3008 analog to digital converter (ADC)
- 3 A1302 continuous time ratiometric linear hall effect sensors
- 3 10kohm resistors
- A 10 x 10 PCB breakout board (this can be cut to size)
- 20 gauge solid core wires

Wiring (follow the [electrical schematic](https://github.com/borglandlab/RunningWheel/blob/main/Schematics/Electrical_Schematic.jpg)):
- The MCP3008 ADC is soldered to the 10 x 10 PCB breakout board
- Pin 16 (VDD) and pin 15 (Vref) of the MCP3008 are both connected to pin 1 (3.3 V) of the Raspberry Pi.
- Pin 14 (Agnd) and Pin 9 (Dgnd) of the MCP3008 are both connected to pin 6 (ground) of the Raspberry Pi.
- Pin 13 (CLK) of the MCP3008 is connected to pin 23 (GPIO 11) of the raspberry pi.
- Pin 12 (Dout) of the MCP3008 is connected to pin 21 (GPIO 9) of the raspberry pi.
- Pin 11 (Din) of the MCP3008 is connected to pin 19 (GPIO 10) of the raspberry pi.
- Pin 10 (CS/SCDN) of the MCP3008 is connected to pin 24 (GPIO 8) of the raspberry pi.
- Pin 1 of the left (hf1), centre (hf2), and right (hf3) hall effect sensors are all connected to pin 2 (5 V) of the raspberry pi.
- Pin 2 of the left (hf1), centre (hf2), and right (hf3) hall effect sensors are all connected to pin 6 (ground) of the raspberry pi.
- Pin 3 of the left (hf1) hall effect sensor is connected to pin 5 (CH4) of the MCP3008.
- Pin 3 of the centre (hf2) hall effect sensor is connected to pin 3 (CH2) of the MCP3008.
- Pin 3 of the right (hf3) hall effect sensor is connected to pin 1 (CH0) of the MCP3008.
- Each hall effect sensor has a pull-down resistor connecting pin 3 to ground.

-----
## Raspberry Pi Zero W Set up
There are two ways to set up the software on your raspberry pi zero for running wheel use.
1. Clone an SD card
2. Manually install operating system, 3rd party modules, and spinner.py file


### 1. Clone an SD card
On my mac I used an app called [ApplePiBaker](https://www.tweaking4all.com/software/macosx-software/applepi-baker-v2/) to clone an SD card and copy it to a new SD card. You can find the documentation for the ApplePiBaker online.


### 2. Manual installation

#### Downloading Operating System
1. Install [Raspberry Pi Imager](https://www.raspberrypi.com/software/) on your personal computer (This is available for Windows, macOS, and Linux)
2. Insert an SD card into your computer
3. Format the SD card
4. Use Raspberry Pi Imager to load the Raspberry Pi operating system onto the SD card:
   - Operating System: RASPBERRY PI OS (32-BIT)
   - Storage: selected empty SD card
   - Click “Write”


#### Setting up Raspberry Pi
1. Put SD card into Raspberry Pi and turn on - will reboot
2. Set up Country, Language, and Timezone according to your actual timezone
   1. Will ask you to change password. We’ve left ours without a password
3. Select internet connection you plan to use and input password
   1. We’ve connected to our University’s guest account. To ensure that we don’t get kicked out everytime, we’ve added the MAC address for each RPi to the network so that they are permanently in the system. We did this through the IT department.
      1. To find the MAC address, open Terminal and enter “ifconfig” and follow the instructions found at this [website](https://raspberrytips.com/mac-address-on-raspberry-pi/)
      > The MAC address just after the keyword “ether” in the section corresponding to your network interface. It's represented as a 12-digit hexadecimal number (AA:BB:CC:DD:EE:FF).
4. Allow for system to update - this can take a while
5. Reboot/Restart RPi


#### Install Adafruit libraries and configure pi for SPI interface
1. Make sure the Raspberry Pi is connected to the internet
2. Open Terminal
3. Enter: “sudo pip3 install adafruit-blinka”
4. Enter: “sudo pip3 install adafruit-circuitpython-mcp3xxx”
5. Enter: “sudo raspi-config” --> 3 Interface Options —> P4 SPI —> Would you like the SPI interface to be enabled? - “Yes”
6. Enter “sudo reboot”
```{console}
pi@raspberrypi:~ $ sudo pip3 install adafruit-blinka
pi@raspberrypi:~ $ sudo pip3 install adafruit-circuitpython-mcp3xxx
pi@raspberrypi:~ $ sudo raspi-config
# 3 Interface Options —> P4 SPI —> Would you like the SPI interface to be enabled? -> “Yes”
pi@raspberrypi:~ $ sudo reboot
```


#### Install third party module
1. Install Speedtest
```{console}
pi@raspberrypi:~ $ sudo pip3 install speedtest-cli
pi@raspberrypi:~ $ sudo reboot
```


#### Copying python code to RPi
1. Insert USB drive into RPi containing [python code for spinner](https://github.com/borglandlab/RunningWheel/blob/main/Spinner_Code/spinner_WIFI.py)
2. Change name of file from spinner_WIFI.py to spinner.py
3. Copy spinner.py file to RPi from USB drive
4. Change number in text editor to correspond with spinner number ('SPINNER_NAME')
   1. This must be different for each spinner and must be a whole number
6. Update email address ('GMAIL_USERNAME')
7. Update email address password ('GMAIL_PASSWORD')
8. This is also where you you can adjust how often the wheels will send an email ('EMAIL_FREQUENCY') and how easily the hall-effect sensors will trigger ('TRIGGER_THRESHOLD')

```{python}
SPINNER_NAME = 1  #Corresponds to the wheel number
EMAIL_FREQUENCY = 1     #Corresponds to how often an email will be sent, once every _____ hour.
TRIGGER_THRESHOLD = 30
#Email Variables
SMTP_SERVER = 'smtp.gmail.com' #Email Server (don't change!)
SMTP_PORT = 587 #Server Port (don't change!)
GMAIL_USERNAME = 'email@gmail.com' #change this to match your gmail account
GMAIL_PASSWORD = 'password'  #change this to match your gmail password
```


#### Setting up RPi for python program to automatically run at start-up/reboot
1. Open Terminal
2. Enter: “sudo crontab -e”
   1. Crontab is included in Raspbian
3. Scroll to the very bottom and enter: “@reboot sleep 60 && sudo python3 /home/pi/Desktop/spinner.py”
4. Control x --> “Y” --> Enter
5. cd to directory of your script. In our case it’s desktop so we will enter: “cd /home/pi/Desktop/”
6. Chmod file to make it executable by the computer; enter: “sudo chmod +x spinner.py”
7. Reboot, enter: “sudo reboot”
   1. Every time you change the .py file you need to run the chmod
   2. Is also useful as a test
```{console}
pi@raspberrypi:~ $ sudo crontab -e
# scroll to bottom and enter "@reboot sleep 60 && sudo python3 /home/pi/Desktop/spinner.py”
pi@raspberrypi:~ $ cd /home/pi/Desktop/
pi@raspberrypi:~/home/pi/Desktop $ sudo chmod +x spinner.py
pi@raspberrypi:~/home/pi/Desktop $ sudo reboot
```


#### Notes
1. I’ve found that deleting the text file before running new experiments keeps things from corrupting and not working properly.


#### Cloning
Once the raspberry pi is setup, you can clone the SD card as a backup.zip file. Then just clone the backup onto all of your SD cards. After doing this, you will need to go on your raspberry pi to change the name of the spinner on the spinner.py file. Then do the following:
1. Open Terminal
2. cd to directory of your script. In our case it’s desktop so we will enter: “cd /home/pi/Desktop/”
3. Chmod file to make it executable by the computer; enter: “sudo chmod +x spinner.py”
4. Reboot, enter: “sudo reboot”
```{console}
pi@raspberrypi:~ $ /home/pi/Desktop/
pi@raspberrypi:~/home/pi/Desktop $ sudo chmod +x spinner.py
pi@raspberrypi:~/home/pi/Desktop $ sudo reboot
```
This is faster and easier than setting them all up individually.
However, you will still need to make sure that you have the MAC addresses for each raspberry pi.

-----
## Running Wheels with no wifi connection

If you are running your experiments with no, or a very weak/unreliable wifi connection, then you may wish to use the no wifi mode. To run the no wifi mode, these changes from the previous instructions will need to be made:
1. You do not need to install the third party module, Speedtest.
2. You do not need to connect to the wifi during setup.
3. Copy the [no wifi spinner code](https://github.com/borglandlab/RunningWheel/blob/main/Spinner_Code/spinner_noWIFI.py) to the raspberry pi instead of the wifi version.
4. Change name of file from spinner_noWIFI.py to spinner.py
5. Copy spinner.py file to RPi from USB drive
6. Change number in text editor to correspond with spinner number ('SPINNER_NAME')
   1. This must be different for each spinner and must be a whole number
8. This is also where you you can adjust how often the wheels will send an email ('EMAIL_FREQUENCY') and how easily the hall-effect sensors will trigger ('TRIGGER_THRESHOLD')

```{python}
SPINNER_NAME = 1  #Corresponds to the wheel number
TRIGGER_THRESHOLD = 30
```

-----
## Setting up the Running Wheels

To supply power to the raspberry pi a micro USB cable must be connected to the outside micro USB port. The inner micro USB port can only transmit data, so you can plug your keyboard and stuff into that one when you need to. There is also a micro HDMI port that can be used when to connect a monitor. This is on the opposite side from the micro USB power port. You will most likely need a micro HDMI adapter to use this.

Before running connect each raspberry pi to a power source, keyboard (with joystick and trackpad), and monitor. Allow the raspberry pi to boot up. Once the desktop is open, remove or delete the text file. This will ensure that the new data collected in the text file will only be from the current experiment. Unplug the raspberry pi.

When setting up the running wheels, carefully insert the raspberry pi into the Base Top so that the senor holder with sensors is lined up with the hold in the base top. This may require some careful bending of the wires connected to the sensors. The raspberry pi should fit into notches printed on the base bottom. Connect the raspberry pi to a micro USB power cable that is not yet connected to a power supply. Put the screws in place in the front and back of the base top to keep the base bottom connected. Slide the Spinner with the ball bearing on the protrusion of the base top. The running wheel is now ready for calibration. Depending on how much light your 3D printed running wheel base lets through, you may also wish to cover the ACT LED on the raspberry pi with opaque tape.

It is important to note that the mice will chew the USB power cable. We’ve tried a number of different things, but the only reliable solution is to cut and bend copper tubing to protect the cable. The hole in the front of the base top is designed to snuggly fit ½” copper tubing. Tube bending springs can be used to change the shape of the copper tubing without causing kinks. However, you will need to avoid really tight bends because the micro USB cable still needs to be able to slide through the tubing. This will require some playing around to get right depending on how you are setting the wheels up and what type of cage you are using.

### Calibration

Each running wheel is automatically calibrated at start-up. Each time the wheels are connected to power, the spinner must be taped so that the magnets are as far away from the sensors as possible. There are three circular notches on the top of each spinner to aide in identifying the location of the magnets. Prior to connecting to power, running wheels should be placed in the cage in the environment where the experiment will take place. The calibration cycle will begin immediately after the running wheel is connected to power and takes about two to three minutes. You will be notified that the calibration cycle is complete by an email. Remove tape and place mouse in cage. If you are using the no wifi spinner.py version then assume that the calibration has been completed after 3 minutes have passed.

Triggering of the hall-effect sensors will occur when read values are more than 30 above or below the maximum and minimum values read during the calibration cycle. Calibration only needs to be done once at the beginning of the experiment, or after any time the running wheel is disconnected from its power supply.

It is important to bear in mind that hall-effect sensors detect changes in the magnetic field. Hence, any large fluctuations in the magnetic field other than the movement of the magnets on the bottom of the spinner will result in experimental noise. For this reason, it is important to ensure that the environment where you are running these experiments does not have large fluctuations in the magnetic field. Even in a good environment, some magnetic noise will most likely be detected, but it should be infrequent enough so that it will not noticeably change results.

If you feel that there is too much noise, there are a few different solutions:
1.	Disconnect and reconnect the wheel to the power supply to allow for the calibration sequency to run again. It is possible that the baseline noise has changed since calibration was initially done.
2.	Change power supply. It’s possible that the power supply that you are using is noisy.
3.	Change rooms. This may not be an option, but a room with less electrical noise is ideal.
4.	Increase the threshold on the spinner.py. The default threshold value is 30, but this could be increased to 40 or 50. We have only tested the wheels with a threshold value of 30, so we recommend you run some tests to ensure that your higher threshold will still be triggered by the magnets.
5.	Resolder the connections of electrical components.


-----
## Software for using Running Wheel

I have created software for both [macOS](https://github.com/borglandlab/RunningWheel/blob/main/WheelAnalysis_macOS.md) and [Windows](https://github.com/borglandlab/RunningWheel/blob/main/WheelAnalsis_Windows.md). Click on the appropriate link to be taken to the setup and use instructions.
