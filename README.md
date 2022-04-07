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
1. Base Bottom
2. Base Top
3. Sensor Holder
4. Spinner
It is ideal to print the Spinner part with the same infill settings across all running wheels, as this will decrease the variability in weight. Spinners with different weights will spin differently, changing the experience of the mouse and the likelihood that they will use the wheel.

To facilitate greater reproducibility of our 3D printed running wheels, we’ve outlined printer specifications that we selected, and a summary of the printing process.

Following printing of the Spinner magnets must be inserted into the three rectangular openings left. 3 to 4 4x2 mm circular magnets should fit snuggly. Make sure the same number of magnets is in each opening so that the weight is even. The metal ball bearing should also be inserted into the centre opening. The Spinner is designed to hold a 8/8 X 7/8 X 9/32 ball bearing.

Following printing of the Base Top the support material can be removed. A layer of epoxy glue should also be added to the protrusion that the spinner slides onto. This can be done with a medium size paint brush. After the epoxy has hardened (approximately 24 to 48 hours), it should be carefully sanded down until the ball bearing inside of the Spinner can slide on snuggly. If you sand too much away then reapply the epoxy and try again. This makes the protrusion much stronger so that it won’t wear away with the sliding.


#### Specifications for the eryone thinker ER20 and flsun qqs-pro printers
- Adhesion Type: Skirt
- Alternate Extra Wall: Yes
- Avoid Printed Parts When Traveling: Yes
- Combing mode: All
- Custom support blocker for “Base Top.stl”: Only print support material where the slanted roof section meets the horizontal roof section. Place support blockers covering the rest of the Base Top. See attached images to see where to place the support material.
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

With these settings, the printer will print no support blockers. However, for “Base Top.stl” support material should be printed where the slanted roof section meets the horizontal roof section. You need to manually add this. See attached images to see where to place the support material.


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

#### Copying python code to RPi
1. Insert USB drive into RPi containing python code for spinner.
2. Copy spinner.py file to RPi from USB drive
3. Change number in text editor to correspond with spinner number.


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
## Software for using Running Wheel

### Wheel Download Software
You must have python3 installed on you computer to run the data download software. It might work with Python 2, however it has only been tested with Python 3.

In addition, make sure that your system PATH variable includes python or your computer will be unable to find it. Also make sure that the directories used in all code line up with the directories on your computer. See below for more information on changing this.

I have created 3 different python modules that you need to download:
1. GETdata_wheel.py
2. inbox.py
3. send_wheelalert.py

These modules contain the following functions:
GETdata_wheel.py
1. Wheel_RunFirst
2. GETdata_wheel
3. downloadWHEELdata
4. email_patrol
5. length_directory
inbox.py
1. get_inbox
send_wheelalert.py
2. send_wheelalert

In addition, the following python modules must also be installed on your computer (some are third party modules, so you will need to check):
1. os – preinstalled
2. re – preinstalled
3. openpyxl – download using pip
4. datetime – preinstalled
5. pytz – download using pip
6. imaplib – preinstalled
7. email – preinstalled
8. smtplib – preinstalled


### Wheel Analysis Software
The running wheel data is analyzed in MATLAB by the following function:
1. Wheel_Analysis.m

for Wheel_Analysis.m to work properly it needs the following two functions:
1. importLength.m
2. importDirectory.m

Graphs of the total distance travelled and average velocity can quickly be created for each spinner with the gathered data using the following function:
1. Wheel_Plot.m


### Further Analysis of wheel data
To arrange and bin the data collected from the running wheels in more presentable ways, the following script was used:
1. Wheel_Tables.m


### Analysis of mouse weight, food and water consumption
The following function was used to analyze and plot the mouse weight, food consumed, and water consumed each day:
1. MouseWeight_Analysis.m
   - After the morning of the first day of the first restriction (day 8 of experiment), this function will also calculate the 75% cutoff value for each mouse. This is 75% of the final day of baseline.

The function Mouse_Weight.m requires the following 2 functions to work:
1. importDirectory_weights.m
2. importWeights.m

The use of the function MouseWeight_Analysis.m requires that you use our data collection workbook, ABA.xlsx, and store it on DropBox. Before the start of the experiment, a sheet for each day of the experiment should be created. Once this is done, the python function, mouseweight_directory.py, should be used to create a directory at the end of ABA.xlsx that is used by MouseWeight_Analysis.m to properly do the analysis. More information on filling out the ABA.xlsx workbook is below.

The following script was used to create tables with all the data organized according to groups:
1. MouseWeight_Tables.m


### Filling out the ABA.xlsx workbook
The ABA.xlsx workbook has 4 template sheets.
- Acclimation_Template
- Baseline_Template
- Restriction_Template_6hrs
- Restriction_Template_3hrs

1. Make one copy of the Acclimation_Template. In the corresponding location of the table, enter in the date on which the first day of acclimation will occur (example: Saturday, Jun 12, 2021). When you isolate the mice you can also write in the time that this occurred.

2. Make 7 copies of the Baseline_Template. Enter the Day (1 – 7) (example: Baseline (Day 1)) , and the date (example: Monday, June 14, 2021) when this will occur for each sheet.

3. Make 3 copies of the Restriction_Template_6hrs. Enter the Day (8 – 10) (example: Restriction 6hrs (Day 8)), and the date (example: Monday, June 21, 2021) when this will occur for each sheet.

4. Make 8 copies of the Restriction_Template_3hrs. Enter the Day (11 – 18) (example: Restriction 3 hrs (Day 11)), and the date (example: Thursday, June 24, 2021) when this will occur for each sheet.

The name of each sheet/tab should be the date of data collection (ddmmmyyyy) and they should be in chronological order with the templates at the end. These should all be created before the start of the experiment.

#### Create the directory for this workbook
This directory is necessary to use MouseWeight_Analysis.m

1. Open mouseweight_directory.py in a text editor and update the “Directory” and “WORKBOOK”. These should be the location on Dropbox where the workbook can be found and the name of the workbook, respectively.
2. In python, enter:
   1. import os
   2. os.chdir(‘/Users/<USERNAME>/Desktop/RunningWheel/Python_Code’) or os.chdir(‘C:\Users\<USERNAME>\OneDrive\Desktop\ RunningWheel\Python_Code’)
      i. macOS and Windows respectively
   3. from mouseweight_directory import mouseweight_directory
   4. mouseweight_directory()
```{python}
import os
os.chdir(‘/Users/<USERNAME>/Desktop/RunningWheel/Python_Code’)
from mouseweight_directory import mouseweight_directory
mouseweight_directory()
```
3. Check the ABA.xlsx and there should be a new sheet/tab at the end with a directory

   
#### Execution of Wheel Download and Analysis

To provide easy execution of the appropriate download codes, I have created a graphical user interface (GUI) in python that can be opened and used to speedily initiate analysis. The buttons on this GUI are linked to the command/batch files. The code required for running the GUI is:
1. Wheel_GUI.py
- You will need to install applescript using pip3 to use the GUI on macOS
- You will not need to install anything else to use the GUI on Windows

**This GUI contains the following buttons:**
1. Run before first Download (only run once at beginning)
   1. This is linked to the command/batch file START_UP.command or START_UP.bat
   2. This must be run once at the beginning before any data is downloaded and should not be run again.
2. Data Download
   1. This is linked the command/batch file DOWNLOAD.command or DOWNLOAD.bat
   2. Just downloads data from the email account to the excel files on your personal computer.
3. Data Analysis
   1. This is linked to the command/batch file WheelAnalysis_nographs.command or WheelAnalysis_nographs.bat
   2. Just analyzes the data in MATLAB, storing the data in a MATLAB structure.
4. Plot Graphs
   1. This is linked to the command/batch file PlotWheel.command or PlotWheel.bat
   2. Just plots the total distance and velocity for each running wheel using the data from the MATLAB structure.
5.  Data Download and Analysis
   1. This is linked to the command/batch file Download_Analysis.command or Download_Analysis.bat
   2. Downloads the data from the email account, stores it in excel files on your personal computer, and analyzes the data in MATLAB storing the data in a MATLAB structure
6. Data Analysis and Plot Graphs
   1. This is linked to the command/batch file WheelAnalysis_graphs.command or WheelAnalysis_graphs.bat
   2. Analyzes the data in MATLAB, storing it in a MATLAB structure, and then creating graphs of the total distance travelled and the average velocity.
7. Data Download, Analysis, and Plot Graphs
   1. This is linked to the command/batch file Download_Analysis_Plot.command or Download_Analysis_Plot.bat
   2. Downloads the data, analyzes it in MATLAB, and creates graphs of the total distance travelled and average velocity.
   3. This is the main button that I use. The rest are just if you want to do an isolated step of the process.
8. Mouse Weight Download and Plot Graphs
   1. This is linked to the command/batch file MouseWeightAnalysis_graphs.command or MouseWeightAnalysis_graphs.bat
   2. Downloads the mouse weight data from the DropBox location, stores it in a structure, and creates graphs showing the weight of the mouse and the food consumed over the course of the experiment. After the morning of the first restriction day, this will also calculate the 75% cutoff values for each mouse.

When you click on one of these buttons, no noise or impression will be made. However, the Terminal or Command Prompt window will pop-up and you will be able to see the progress of the command you have selected.

For this GUI to work, you will also need the following two python modules in your Python_Code directory:
1. RunningWheel_StartupScript.py
2. RunningWheel_DownloadScript.py


### Setting up software on your personal computer

#### Desktop
Create a folder on the Desktop called “RunningWheel”.
Examples of where this would be for macOS and Windows are below:
- macOS: /Users/<USERNAME>/Desktop/
- Windows (using OneDrive): C:\Users\<USERNAME>\OneDrive\Desktop\

Structure the folder accordingly:
RunningWheel
- Python_Code (folder)
  - GETdata_wheel_nowifi.py
  - GETdata_wheel.py
  - inbox.py
  - RunningWheel_DownloadScript.py
  - RunningWheel_StartupScript.py
  - send_wheelalert.py
  - Wheel_GUI.py
  - mouseweight_directory.py – optional
- Wheel_Data (folder)
  - Where all the running wheel data will be stored
- Wheel_Figures (folder)
  - Where all the MATLAB figures will be stored
- RunningWheel_App (file)
  - This is an alias/shortcut to the command/batch file to open the Wheel_GUI.py

Edits and Updates:
- GETdata_wheel_nowifi.py
  - Update “SavedData_Directory”, “Spinner_List”, and “Spinner_Email”
- GETdata_wheel.py
  - Update “SavedData_Directory”, “Code_Directory”, and “EmailAlert_hours”
- inbox.py
  - Update “host” (only update if you are not using gmail), “username”, and “password”
- send_wheelalert.py
  - Update “HOST”, “username”, “password”, “from_email”, and “to_email”
- Wheel_GUI.py
  - Update “Directory”
- mouseweight_directory.py
  - Update “DIRECTORY”, and “WORKBOOK”

   
#### MATLAB

Place the MATLAB files in the MATLAB folder which is typically found under Documents.
An example for macOS and Windows is below:
- macOS: /Users/<USERNAME>/Documents/MATLAB/MatLab/<MATLAB file>
- Windows (using OneDrive): C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\<MATLAB file>

These files include:
- Wheel_Analysis.m
- Wheel_Plot.m
- Wheel_Tables.m
- importData.m
- importDirectory.m
- importLength.m

Optional files for calculating changes in food, water, and mouse weight:
- MouseWeight_Analysis.m
- MouseWeight_Tables.m
- importDirectory_weights.m
- importWeights.m

Edits and Updates:
- Make sure you have the Statistics and Machine Learning Toolbox
- Wheel_Analysis.m
  - Update the two paths (should correspond MATLAB in general and the MATLAB RunningWheel folder – not necessary to have a RunningWheel folder), “PATH”, “timezone”, “Structure”, and “Wheel_number” (default is 8). If you change the design of the wheel then you may also need to update the “runningwheel_diameter”.
- Wheel_Plot.m
  - Update the two paths, “PATH_dataload”, “PATH_destination1”, “PATH_destination2”, “timezone”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, and “Structure”.
- Wheel_Tables.m
  - Update the two paths, “PATH”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, “timezone”, “Main_table”, “Hourly_table”, and “Structure”. You may also need to update “Groups_variables”, “Control_index”, and “Restricted_index”.
- MouseWeight_Analysis.m
  - Update the two paths, “mouse_savedData2”, “mouse_savedData1”, “Excel_file”, “Structure”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, and “timezone”. You may also need to update “Groups_variables”, “number_mice”, “AdLib”, “Restricted”, and the mouse naming. This analysis is set-up for 16 mice in 4 different groups. Group 1 – Ad Lib with Wheel, Group 2 – Ad Lib with dummy Wheel, Group 3 – Restricted with Wheel, and Group 4 – Restricted with dummy Wheel. They alternate in that order. If you set it up in a different way then this analysis of the mouse weight will not work.
- MouseWeight_Tables
  - Update the two paths, “mouse_savedData2”, “mouse_savedData1”, “Structure”, and “Main_table”. You may also need to update “AdLibWheel_index”, “AdLibDummy_index”, “RestrictedWheel_index”, and “RestrictedDummy_index”

   
#### Command/Batch

Place the command/batch files in a folder that is already in the PATH environment.
Examples of this for the macOS and Windows are below:
- macOS: /Users/<USERNAME>
- Windows: C:\Users\<USERNAME>

These files include (macOS):
- START_UP.command
- DOWNLOAD.command
- WheelAnalysis_nographs.command
- PlotWheel.command
- WheelAnalysis_graphs.command
- Download_Analysis.command
- Download_Analysis_Plot.command
- MouseWeightAnalysis_graphs.command
- OPEN_Wheel_GUI.command
  - Create an alias/shortcut to this file called “RunningWheel_App” and store where ever you like.

You can create the .command files using a text editor and saving them with .command. Save them in your PATH environment as stated above. You will then need to make these files executable. Do this with the following code in a Terminal window:
1. cd /Users/<Username>
   1. This is where your terminal window should be automatically. To double check that your .command files are in this directory you can just enter “ls”
2. chmod +x <Filename>
   1.Example: chmod +x START_UP.command
   2.You will need to do this whenever you edit these files.
```{console}
usermac@USER ~ % cd /Users/<Username>
usermac@User ~ % ls
# Check that your .command files are here
usermac@User ~ % chmod +x <Filename>
```

Edits and Updates that you may need to do:
1. Make sure that the directories are correct for where you’ve put the files on your computer. 
2. You may need to update the MATLAB year (i.e. 2021b)
3. If you are not using python3 then you will need to change that


Files for Windows:
- START_UP.bat
- DOWNLOAD.bat
- WheelAnalysis_nographs.bat
- PlotWheel.bat
- WheelAnalysis_graphs.bat
- Download_Analysis.bat
- Download_Analysis_Plot.bat
- MouseWeightAnalysis_graphs.bat
- OPEN_Wheel_GUI.bat
  - Create an alias/shortcut to this file called “RunningWheel_App” and store where ever you like.

You can create a .bat file using a text editor and saving them with .bat. Save them in your PATH environment as stated above. These files are automatically executable. I found that I was unable to open these files to edit them after creating them. I had to remake them if I needed to edit them.

Edits and Updates that you may need to do:
1. Make sure that the directories are correct for where you’ve put the files on your computer.
2. Make sure that the python.exe directory is correct.
3. Make sure that the MATLAB directory is correct (both matlab.exe and the MATLAB folder under Documents)
