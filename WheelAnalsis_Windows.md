# Software for using Running Wheel (Windows)
---
## Wheel Download Software
You must have Python 3 installed on you computer to run the data download software. It might work with Python 2, however it has only been tested with Python 3. If you are a new Python user, installing [Anaconda](https://www.anaconda.com/products/distribution) will make your life simpler. It includes python and all of the accessory packages needed (such as pip) to run. In addition, you can use COMD.exe Prompt from Anaconda.Navigator, a terminal window that launches within your conda environment.

Make sure that your system PATH variable includes Python or your computer will be unable to find it (not necessary if you have installed Anaconda). This will prevent the code that I am sharing here from working on your computer. You can learn more about how to do this at this [website](https://www.educative.io/edpresso/how-to-add-python-to-the-path-variable-in-mac).

You may also need to install pip separately on your personal computer (not necessary if you have installed Anaconda). Pip is a standard accesory to python, and is what you will use to install third party Python modules, of which we will be using a few. You can learn how to install pip [here](https://pip.pypa.io/en/stable/installation/).

The running wheel system also requires MATLAB, it connects to matlab through a Python module called matlab engine, but this will only work if you already have MATLAB installed on your personal computer. Based on this [reference](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html) from MathWorks, you will need to have a MATLAB version from 2014 or later to run the the matlab engine.

<br/>

## Setting up the Code on your computer
The running wheel system utilizes two different graphical user interfaces (GUI). One is used to set everything up prior to running your experiment so that everything will run smoothly. Once you use this GUI, you do not need to use it again unless a folder directory changes. If you change the location of any files or folders, make sure you run through the setup GUI again. It is best to set everything up once and then don't move anything afterwards.

The second GUI is for running the code. This is what you will use on a regular basis.

The running wheel system can be run as standalone running wheels, or as part of the ABA protocol, as found in our research publication. Make sure you download the appropriate one. Both versions use a setup GUI and then a GUI to run the code, but if you are planning to follow our ABA protocol then the ABA GUI will facilitate this.

<br/>

### Install third party Python modules using pip

Here is a list of the third party modules that you will need to install using pip
1. [openpyxl](https://pypi.org/project/openpyxl/)
2. [pytz](https://pypi.org/project/pytz/)
3. [matlabengine](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html)
4. [pyinstaller](https://pyinstaller.org/en/stable/installation.html)

You will need to install these in a terminal window. Two methods to do this are to open Windows Terminal (application that comes with Windows 10 and later), or to launch COMD.exe Prompt from Anaconda.Navigator (We used the second method). If you use Python on your computer through Anaconda, then you should use COMD.exe Prompt.

To use pip, enter pip or pip3 (depending on which version you are using - pip3 for Python 3) followed by the module you are installing:
```{console}
pip3 install openpyxl
pip3 install pytz
pip3 install matlabengine
pip3 install pyinstaller
```
Pip will take care of finding and installing the module for you, so it's pretty simple.


Additionally, here is a list of python modules, which we use in our code, that are already included with Python:
1. os
2. re
4. datetime
6. imaplib
7. email
8. smtplib
9. tkinter
10. shutil

You should not need to install these using pip

<br/>

### Creating executable files
It is simpler for you to create the executable files than for us to provide them to you, because your personal computer may not allow you to download or use executable files that were created by a nonverified source. So you will need to follow these steps before using either running wheel GUIs. Although the process is the same, for the sake of clarity, due to different names, we have outlined the steps separately for the two versions that we offer.

#### Running Wheel (stand alone)

1. Download the zipped folder called "RunningWheel_System_Windows.zip" from our GitHub repository [here](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/RunningWheel_System_Windows.zip).

2. Create the executable setup file.
    1. Open the unzipped folder --> open the folder titled "Code"
    2. Right click on the folder called "Python" and select "Open in the Terminal" - This will open a Windows Terminal window ready to access files within the "Python" folder. Alternatively you can open CMD.exe Prompt from Anaconda.Navigator and copy and paste the directory address for the "Python" folder. This second method was how we did it.
    3. If you are using the Windows Terminal from the first method then enter the following into the terminal window and press "return" (This will take a bit of time to create your executable file):
	```{console}
	pyinstaller --onefile RunningWheel_Setup.py
	```
    4. If you are using the CMD.exe Prompt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	pyinstaller --onefile RunningWheel_Setup.py
	```
    * You can get the "Python" folder address by right clicking on the "Python" folder in the File Explorer navigator bar and clicking on "Copy address"
    5. Within the "Python" folder, delete the "RunningWheel_Setup.spec" file.
    6. Within the "Python" folder, delete the "build" folder.
    7. Within the "Python" folder, open the "dist" folder and move the file "RunningWheel_Setup" to the folder called "Executable", within the "Code" folder, then delete the "dist" folder.
    8. Double click on the "RunningWheel_Setup" file to run the running wheel setup.
    9. This file is self contained and will run no matter where it is located.

3. Create the executable Running Wheel file.
* pyinstaller can't recognize matlabengine, so you need to manually add it. For this reason there are a few extra steps.
    1. Open the unzipped folder --> open the folder titled "Code"
  2. Right click on the folder called "Python" and select "Open in the Terminal" - This will open a Windows Terminal window ready to access files within the "Python" folder. Alternatively you can open CMD.exe Prompt from Anaconda.Navigator and copy and paste the directory address for the "Python" folder. This second method was how we did it.
    3. If you are using the Windows Terminal from the first method then enter the following into the terminal window and press "return" (This will take a bit of time to create your executable files):
	```{console}
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    4. If you are using the CMD.exe Prompt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    5. Within the "Python" folder, delete the "Wheel_GUI.spec" file.
    6. Within the "Python" folder, delete the "build" folder.
    7. Within the "Python" folder, open the "dist" folder and move the folder "Wheel_GUI" to the folder called "Executable", within the "Code" folder, then delete the "dist" folder.
    8. Again, open a terminal window with the "Python" folder directory as explained above. Then enter the following code into the terminal window:
	```{console}
	python findMATLAB.py
	```
    9. If you are using the CMD.exe Promt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	python findMATLAB.py
	```
    10. In the Finder window that has opened, right click on the "matlab" folder and copy it. Do not delete it.
    11. Open the "Wheel_GUI" that you recently moved into the "Executable" folder, and paste the "matlab" folder there.
    12. Inside of the "Wheel_GUI" folder is an executable file called "Wheel_GUI". Double click on this file to run the running wheel system. This file must remain inside of the "Wheel_GUI" folder for it to work.
    13. You can make this file more accessible by right clicking on it and clicking "Show more options" --> "Create shortcut". This shortcut file can be placed wherever you would like.

<br/>

#### Running Wheel with ABA protocol

1. Download the zipped folder called "RunningWheel_System_ABA_Windows.zip" from our GitHub repository [here](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/RunningWheel_System_ABA_Windows.zip).

2. Create the executable setup file.
    1. Open the unzipped folder --> open the folder titled "Code"
    2. Right click on the folder called "Python" and select "Open in the Terminal" - This will open a Windows Terminal window ready to access files within the "Python" folder. Alternatively you can open CMD.exe Prompt from Anaconda.Navigator and copy and paste the directory address for the "Python" folder. This second method was how we did it.
    3. If you are using the Windows Terminal from the first method then enter the following into the terminal window and press "return" (This will take a bit of time to create your executable files):
	```{console}
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    4. If you are using the CMD.exe Prompt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    * You can get the "Python" folder address by right clicking on the "Python" folder in the File Explorer navigator bar and clicking on "Copy address"
    5. Within the "Python" folder, delete the "RunningWheel_Setup_ABA.spec" file.
    6. Within the "Python" folder, delete the "build" folder.
    7. Within the "Python" folder, open the "dist" folder and move the file "RunningWheel_Setup_ABA" to the folder called "Executable", within the "Code" folder, then delete the "dist" folder.
    8. Double click on the "RunningWheel_Setup_ABA" file to run the running wheel setup.
    9. This file is self contained and will run no matter where it is located.

3. Create the executable Running Wheel file.
* pyinstaller can't recognize matlabengine, so you need to manually add it. For this reason there are a few extra steps.
    1. Open the unzipped folder --> open the folder titled "Code"
  2. Right click on the folder called "Python" and select "Open in the Terminal" - This will open a Winows Terminal window ready to access files within the "Python" folder. Alternatively you can open CMD.exe Prompt from Anaconda.Navigator and copy and paste the directory address for the "Python" folder. This second method was how we did it.
    3. If you are using the Windows Terminal from the first method then enter the following into the terminal window and press "return" (This will take a bit of time to create your executable files):
	```{console}
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    4. If you are using the CMD.exe Prompt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	pyinstaller --onefile RunningWheel_Setup_ABA.py
	```
    5. Within the "Python" folder, delete the "Wheel_GUI_ABA.spec" file.
    6. Within the "Python" folder, delete the "build" folder.
    7. Within the "Python" folder, open the "dist" folder and move the folder "WHeel_GUI_ABA" to the folder called "Executable", within the "Code" folder, then delete the "dist" folder.
    8. Again, open a terminal window with the "Python" folder directory as explained above. The enter the following code into the terminal window:
	```{console}
	python findMATLAB.py
	```
    9. If you are using the CMD.exe Promt then enter the following (change the "Python" folder directory to match yours):
	```{console}
	cd <paste python address here>
	python findMATLAB.py
	```
    10. In the Finder window that has opened, right click on the "matlab" folder and copy it. Do not delete it.
    11. Open the "Wheel_GUI_ABA" folder, that you recently moved into the "Executable" folder, and paste the "matlab" folder there.
    12. Inside of the "Wheel_GUI_ABA" folder is an executable file called "Wheel_GUI_ABA". Double click on this file to run the running wheel system. This file must remain inside of the "Wheel_GUI_ABA" folder for it to work.
    13. You can make this file more accessible by right clicking on it and clicking "Show more options" --> "Create shortcut". This shortcut file can be placed wherever you would like

<br/>

## Running the Setup GUI

Now that you have created the executable files, all the code, files, and folders that you will need to use the running wheels on your computer is there. However, you still need to set it up.

To setup your computer for the running wheel system, double click on the "RunningWheel_Setup" or "RunningWheel_Setup_ABA" (depending on which version you are using) to run the setup/installation GUI. Wait for the GUI to open, and then go through each button and input the requested information.

### Running Wheel (stand alone)
The information entered in through the GUI includes:
1. Location of the Running Wheel Python code
2. Location of the Running Wheel MATLAB code. This is found in a folder called "WheelAnalysis" under a folder called "MATLAB" in the "Code" folder.
3. Location of the general MATLAB folder
    1. This is found in "Documents" and on my computer, I click on a "MATLAB" folder that is found within a folder entitled "MATLAB".
4. Location where you would like to store your Spinner data
5. Primary location to save your MATLAB data
6. Secondary location to save your MATLAB data
7. Timezone for both Python and MATLAB
8. The email address that you will use to send and receive data from the running wheels - this must be a gmail account (create an account specifically for your running wheels)
9. The app specific password for the above email address (You will need to generate an [app specific password](https://support.google.com/mail/answer/185833?hl=en) with gmail that you can then use each time)
10. The email address that you want to receive emergency messages about your running wheels (your personal email address)
11. The duration each running wheel can go without sending an email (if the running wheels are set to send an email every hour, then we set this to 3 hours). This means that if 3 hours elapses without a particular running wheel transmitting data then an alert message will be sent to your personal email address to notify you.
12. Number of running wheels (mouse spinners) you will be using - see important note below on ABA protocol.
13. The first day of the experiment (Must be entered in following the format of DD/MM/YYYY - ex, 01/01/2022 for January first, 20222)
14. After entering in all of this information you will need to select the button to run at the end of start up to set everything up.
* For the locations where you would like to save data you can use the folders provided, or select different folders based on your preferences. For example, we made our secondary MATLAB saving location to be DropBox.

<br/>

### Running Wheel with ABA protocol
In addition to the information above, you will also be asked to enter in the following information:
1. Location of the ABA worksheet template, which is included within the downloaded zip file.
2. The trial number.
3. The first day of acclimation (assumes two days for acclimation, so make sure it's two days before your baseline starts. Again, follow the above format for entering in a date).
4. It is important to note that if you are running the ABA experiment, then the mouse weight analysis is setup for 8 running wheels (16 mice in total). If you plan to use a different number of mice then you will need to edit the matlab files "MouseWeight_Analysis.m" and "MouseWeight_Tables.m", found in the folder called "MouseWeight". They must also follow this order:
    1. Ad Lib with running wheel
    2. Ad Lib with dummy wheel
    3. Food restricted with running wheel (ABA)
    4. Food restricted with dummy wheel
    5. Ad Lib with running wheel
    6. Ad Lib with dummy wheel
    7. Food restricted with running wheel (ABA)
    8. Food restricted with dummy wheel
    9. Ad Lib with running wheel
    10. Ad Lib with dummy wheel
    11. Food restricted with running wheel (ABA)
    12. Food restricted with dummy wheel
    13. Ad Lib with running wheel
    14. Ad Lib with dummy wheel
    15. Food restricted with running wheel (ABA)
    16. Food restricted with dummy wheel
5. Location of MATLAB code for analyzing the mouse weight. This is found in a folder called "MouseWeight" under a folder called "MATLAB" in the "Code" folder.
* For the locations where you would like to save data you can use the folders provided, or select different folders based on your preferences. For example, before running the setup, we moved the ABA_template.xlsx file to DropBox, allowing us to access the generated ABA file from various devices.

<br/>

## Running the Running Wheel GUI
When you open the Running Wheel GUI, it will first ask you to select the location of the Running Wheel Python code. This is because the directory that contains all the paths, directories, and file names is found in this location. After selecting this the GUI will have access to all the information that you entered in through the setup GUI. Depending on whether or not you are following the ABA protocol you will use one of two different GUIs.

### Running Wheel (stand alone)
1. Data Download - will download your data received from the running wheels by the running wheel email address, and create excel workbooks containing this data that matlab will then use for analysis.
2. Data Transfer - No Wifi - will transfer the data if you are following the no wifi protocol that is outlined below.
3. Data Analysis - will analyze the data that has been downloaded, creating a matlab structure containing the distance travelled and and the velocity.
4. Plot Graphs - will create graphs using MATLAB for each running wheel showing the distance travelled and the velocity.
* The next buttons are combinations of the above three buttons
5. Data Download and Analysis
6. Data Analysis and Plot Graphs
7. Data Download, Analysis, and Plot Graphs - this is the button that we would typically use each morning, as it would do everything that we needed to do.

<br/>

### Running Wheel with ABA protocol
In addition to the above buttons, when using the ABA protocol you will also have the following button:
1. Mouse Weight Download and Plot Graphs - will download and analyze the data in the ABA excel file returning graphs that show the mouse weight, food consumed, and water consumed. You should run this each day so that you know when the mice have dropped before 75% of their initial body mass (based on the last day of baseline). For this to work, you need to be filling out the ABA_<date>.xlsx file that the setup GUI created for you. That is why we made ours on DropBox (by putting the template there before running the setup GUI) so it was easy to update from different locations.

<br/>
	
## No Wifi method
As explained in our paper, if you have a poor or no internet connection you will want to use the no wifi method. To do this you will need to set up the raspberry pi in the mouse spinner with the no-wifi code. This process was explained in a previous section. The running data will be stored on the SD card and can be accessed at the end of the experiment. To do so, you will need to manually transfer the spinlog.txt file from your raspberry pi to the computer that is doing the analysis via a USB drive. Then follow these steps:
1. Add the corresponding "_#" to the end of the spinlog.txt file.
	    1. Example: spinlog.txt from spinner_4 becomes spinlog_4.txt
2. Place all the spinlog_#.txt files into the same folder. We created a new folder within the "Spinner_Data" folder called "spinlogs".
3. Once you've done this, the "Data Download" button on the GUI will result in an error, because it is now setup for no wifi data transfer.
4. Run the GUI and select "Data Transfer - No Wifi"
    1. This will transfer all the spinner data to organized excel files that are ready for analysis by MATLAB, as if they had been downloaded.
