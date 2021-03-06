# Software for using Running Wheel (Windows)
---
## Wheel Download Software
You must have python3 installed on you computer to run the data download software. It might work with Python 2, however it has only been tested with Python 3.

In addition, make sure that your system PATH variable includes python or your computer will be unable to find it. This will prevent the code that I am sharing here from working on your computer. You can learn more about how to do this at this [website](https://www.educative.io/edpresso/how-to-add-python-to-path-variable-in-windows).

Also, Raspian, the Raspberry Pi operating system automatically comes with python and Pip. However, in addition to downloading python onto your personal computer, you may also need to download pip. You can learn how to do this [here](https://pip.pypa.io/en/stable/installation/).

Finally, make sure that the directories used in all code line up with the directories on your computer. See below for more information on changing this.

I have created 3 different python modules that you need to download:
1. [GETdata_wheel.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/GETdata_wheel.py)
2. [inbox.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/inbox.py)
3. [send_wheelalert.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/send_wheelalert.py)

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
3. [openpyxl](https://pypi.org/project/openpyxl/) – download using pip
4. datetime – preinstalled
5. [pytz](https://pypi.org/project/pytz/) – download using pip
6. imaplib – preinstalled
7. email – preinstalled
8. smtplib – preinstalled

---
## Wheel Analysis Software
The running wheel data is analyzed in MATLAB by the following function:
1. [Wheel_Analysis.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Analysis.m)

for Wheel_Analysis.m to work properly it needs the following two functions:
1. [importLength.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importLength.m)
2. [importDirectory.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importDirectory.m)
3. [importData.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importData.m)

Graphs of the total distance travelled and average velocity can quickly be created for each spinner with the gathered data using the following function:
1. [Wheel_Plot.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Plot.m)

---
## Further Analysis of wheel data
To arrange and bin the data collected from the running wheels in more presentable ways, the following script was used:
1. [Wheel_Tables.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Tables.m)

   
### Execution of Wheel Download and Analysis

To provide easy execution of the appropriate download codes, I have created a graphical user interface (GUI) in python that can be opened and used to speedily initiate analysis. The buttons on this GUI are linked to the batch files. The code required for running the GUI is:
1. [Wheel_GUI.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/Wheel_GUI.py)
- You will not need to install anything else to use the GUI on Windows

**This GUI contains the following buttons:**
1. Run before first Download (only run once at beginning)
   1. This is linked to the batch file START_UP.bat
   2. This must be run once at the beginning before any data is downloaded and should not be run again.
2. Data Download
   1. This is linked the batch file DOWNLOAD.bat
   2. Just downloads data from the email account to the excel files on your personal computer.
3. Data Analysis
   1. This is linked to the batch file WheelAnalysis_nographs.bat
   2. Just analyzes the data in MATLAB, storing the data in a MATLAB structure.
4. Plot Graphs
   1. This is linked to the batch file PlotWheel.bat
   2. Just plots the total distance and velocity for each running wheel using the data from the MATLAB structure.
5.  Data Download and Analysis
   1. This is linked to the batch file Download_Analysis.bat
   2. Downloads the data from the email account, stores it in excel files on your personal computer, and analyzes the data in MATLAB storing the data in a MATLAB structure
6. Data Analysis and Plot Graphs
   1. This is linked to the batch file WheelAnalysis_graphs.bat
   2. Analyzes the data in MATLAB, storing it in a MATLAB structure, and then creating graphs of the total distance travelled and the average velocity.
7. Data Download, Analysis, and Plot Graphs
   1. This is linked to the batch file Download_Analysis_Plot.bat
   2. Downloads the data, analyzes it in MATLAB, and creates graphs of the total distance travelled and average velocity.
   3. This is the main button that I use. The rest are just if you want to do an isolated step of the process.

When you click on one of these buttons, no noise or impression will be made. However, the Command Prompt window will pop-up and you will be able to see the progress of the command you have selected.

For this GUI to work, you will also need the following two python modules in your Python_Code directory:
1. [RunningWheel_StartupScript.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/RunningWheel_StartupScript.py)
2. [RunningWheel_DownloadScript.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/RunningWheel_DownloadScript.py)

---
## Setting up software on your personal computer

### Desktop
Create a folder on the Desktop called “RunningWheel”.
- Example of where this would be for Windows (using OneDrive) is below:
	- C:\Users\<USERNAME>\OneDrive\Desktop\

Structure the "RunningWheel" folder accordingly:
- Python_Code (folder)
  - [GETdata_wheel.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/GETdata_wheel.py)
  - [inbox.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/inbox.py)
  - [RunningWheel_DownloadScript.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/RunningWheel_DownloadScript.py)
  - [RunningWheel_StartupScript.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/RunningWheel_StartupScript.py)
  - [send_wheelalert.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/send_wheelalert.py)
  - [Wheel_GUI.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/Wheel_GUI.py)
- Wheel_Data (folder)
  - Where all the running wheel data will be stored
- Wheel_Figures (folder)
  - Where all the MATLAB figures will be stored
- RunningWheel_App (file)
  - This is an alias/shortcut to the batch file to open the Wheel_GUI.py

#### Must Update:
- [GETdata_wheel.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/GETdata_wheel.py)
  - Update "Spinner_List", "Spinner_Email", “SavedData_Directory”, “Code_Directory”, and “EmailAlert_hours”
```{python}
#This will need to be as long as the number of spinners you have. This variable is used in Wheel_RunFirst and GetData_wheel functions.
Spinner_List = ['Spinner_1',
'Spinner_2',
'Spinner_3',
'Spinner_4',
'Spinner_5',
'Spinner_6',
'Spinner_7',
'Spinner_8']

Spinner_Email = 'email address'	#This is the email where your data from the running wheels is being sent

SavedData_Directory = 'C:\\Users\\<USERNAME>\\OneDrive\\Desktop\\RunningWheel\\Wheel_Data'	#This will need to be the folder directory where the data is saved.
Code_Directory = 'C:\\Users\\<USERNAME>\\OneDrive\\Desktop\\RunningWheel\\Python_Code'	#This will need to be the folder directory where the code is kept.

EmailAlert_hours = 3 	#will send an alert if this number of hours passes without recieving an email
```
- [inbox.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/inbox.py)
  - Update “host” (only update if you are not using gmail), “username”, and “password”
```{python}
# Make sure that this information is correct for you system.
host = 'imap.gmail.com'	#This stays the same unless you are not using gmail
username = 'email address'	#This will need to be the email address that you plan to send and receive with.
												#I've set it up so that the spinners send emails using this email address and they also send it to this email address.
password = 'app specific password'	#This is the app specific password. You need to get this from you gmail account. It will require a little setting up.
```
- [send_wheelalert.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/send_wheelalert.py)
  - Update “HOST”, “username”, “password”, “from_email”, and “to_email”
```{python}
#Changes these so that they correspond to your email account.
HOST = 'smtp.gmail.com'	#This is for a gmail account
username = 'email address'	#Email address
password = 'app specific password'	#App password. You will need to set this up on your google account first.
from_email = 'Mouse Spinners <email address>'	#Email account that will send the alert email.
to_email = 'personal email'	#Email account that you want to receive the alert. I had it sent to my personal email address so that I'd see it immediately.
```
- [Wheel_GUI.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/Wheel_GUI.py)
  - Update “Directory”
```{python}
# Specify directory where your executable files are located (.command or .exe)
Directory = "C:\\Users\\<USERNAME>\\"
```

   
### MATLAB

Place the MATLAB files in the MATLAB folder which is typically found under Documents.
An example for Windows is below (Using OneDrive):
- C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\<MATLAB file>

These files include:
- [Wheel_Analysis.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Analysis.m)
- [Wheel_Plot.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Plot.m)
- [Wheel_Tables.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Tables.m)
- [importData.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importData.m)
- [importDirectory.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importDirectory.m)
- [importLength.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/importLength.m)


#### Must Update:
- Make sure you have the [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html?ef_id=Cj0KCQjwl7qSBhD-ARIsACvV1X3OpXmC9absXSTA4-pBrpWimDmcodpmaS-EzpkjGsTvFY9vyjFwjhoaAlKcEALw_wcB:G:s&s_kwcid=AL!8664!3!521185651561!b!!g!!%2Bmatlab%20%2Bmachine%20%2Blearning&s_eid=ppc_43685094884&q=+matlab%20+machine%20+learning&gclid=Cj0KCQjwl7qSBhD-ARIsACvV1X3OpXmC9absXSTA4-pBrpWimDmcodpmaS-EzpkjGsTvFY9vyjFwjhoaAlKcEALw_wcB)
- [Wheel_Analysis.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Analysis.m)
  - Update the two paths (should correspond MATLAB in general and the MATLAB RunningWheel folder – not necessary to have a RunningWheel folder), “PATH”, “timezone”, “Structure”, and “Wheel_number” (default is 8). If you change the design of the wheel then you may also need to update the “runningwheel_diameter”.
```{MATLAB}
% Assigning variables
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.
PATH = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; %This is the folder path where your saved data is located.
timezone = 'America/Edmonton';  %This should be changed to your preferred time zone.
Structure = 'RunningWheelData.mat'; % name of the MATLAB structure that contains/will contain the running wheel data
runningwheel_diameter = 110; % the diameter of the mouses running trajectory (mm)
Wheel_number = 8;   %   This is the number of running wheels that I am using
```
- [Wheel_Plot.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Plot.m)
  - Update the two paths, “PATH_dataload”, “PATH_destination1”, “PATH_destination2”, “timezone”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, and “Structure”.
```{MATLAB}
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.
PATH_dataload = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; %This is the folder path where your saved data is located.
PATH_destination1 = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Figures\'; %This is the location where you plan to save your figures.
PATH_destination2 = 'C:\Users\<USERNAME>\Dropbox\RunningWheel\';   %This is the secondary location where you plan to save your figures (I saved my figures twice).

timezone = 'America/Edmonton';  %This should be changed to your preferred time zone.
Acclimation_day1 = datetime('21-Sep-2021'); % This should be the first day of the acclimation phase
Baseline_day1 = datetime('23-Sep-2021');    % This should be the first day of the baseline phase
Restriction_final = datetime('now','Format','dd-MM-yyyy'); % This should be the last day of the experiment.
%Restriction_final = datetime('1-Oct-2021');    %Use this is the experiment
%has concluded

Structure = 'RunningWheelData_Jun2021.mat'; % name of the MATLAB structure that contains/will contain the running wheel data
```
- [Wheel_Tables.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/WheelAnalysis/Wheel_Tables.m)
  - Update the two paths, “PATH”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, “timezone”, “Main_table”, “Hourly_table”, and “Structure”. You may also need to update “Groups_variables”, “Control_index”, and “Restricted_index”.
```{MATLAB}
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.
PATH = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; %This is the folder path where your saved data is located.

% Setting my dates
Acclimation_day1 = datetime('8-May-2021'); % This should be the first day of the acclimation phase
Baseline_day1 = datetime('10-May-2021');    % This should be the first day of the baseline phase
Restriction_final = datetime('27-May-2021'); % This should be the last day of the experiment.
%This will be the 8th day of the 3 hour restriction, however the mice are
%removed for the experiment before being restricted on this day.
timezone = 'America/Edmonton';  %This should be changed to your preferred time zone.

% Table names
Main_table = 'RunningWheel_tables.xlsx';
Hourly_table = 'RunningWheel_hourlybin.xlsx';

% Matlab Structre name
Structure = 'RunningWheelData.mat';

% These are the order of the variables/groups in my tables
Groups_variables = {'AdLib1','AdLib3','AdLib5','AdLib7','Restricted2','Restricted4','Restricted6','Restricted8'};

% These are the running wheel numbers that correspond to each group:
Control_index = [1 3 5 7];
Restricted_index = [2 4 6 8];
```

   
### Batch

Place the batch files in a folder that is already in the PATH environment.
Example of this for Windows is below:
- Windows: C:\Users\<USERNAME>

These Files Include:
- [START_UP.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/START_UP.txt)
- [DOWNLOAD.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/DOWNLOAD.txt)
- [WheelAnalysis_nographs.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/WheelAnalysis_nographs.txt)
- [PlotWheel.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/PlotWheel.txt)
- [WheelAnalysis_graphs.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/MouseWeightAnalysis_graphs.txt)
- [Download_Analysis.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/Download_Analysis.txt)
- [Download_Analysis_Plot.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/Download_Analysis_Plot.txt)
- [OPEN_Wheel_GUI.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/OPEN_Wheel_GUI.txt)
  - Create an alias/shortcut to this file called “RunningWheel_App” and store where ever you like.

You can create a .bat file using a text editor and saving them with .bat. Save them in your PATH environment as stated above. These files are automatically executable. I found that I was unable to open these files to edit them after creating them. I had to remake them if I needed to edit them. The files provided here are .txt, so you will need to resave them as .bat.

#### Must Update:
1. Make sure that the directories are correct for where you’ve put the files on your computer.
2. Make sure that the python.exe directory is correct.
```
"C:\Users\<USERNAME>\OneDrive\Desktop\Uni\bin\matlab.exe" -batch
```
3. Make sure that the MATLAB directory is correct (both matlab.exe and the MATLAB folder under Documents)
```
"C:\Users\<USERNAME>\AppData\Local\Programs\Python\Python39\python.exe"
```
---
## Analysis of mouse weight, food and water consumption
	
In our paper, we used the running wheels in the activity-based anorexia (ABA) model. This meant that it was also important for us to collect information on mouse weight, and food and water consumed. I wrote code that would do this analysis along side the running wheel analysis. If you are also employing the ABA model, you may also wish to use the following code. If you are not and only wish to use the running wheels, then you will not need to apply the following section.

### The following functions are needed when you are using the ABA model:
	
#### Desktop
- [mouseweight_directory.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/mouseweight_directory.py)
	- Used to create directory for the ABA.xlsx worbook (outlined below)
- [Wheel_GUI_withMouseWeight.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/Wheel_GUI_withMouseWeight.py)
	- Used to execute running wheel analysis and analysis of weights togther (outlined below)

##### Must Update
- [mouseweight_directory.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/mouseweight_directory.py)
  - Update “DIRECTORY”, and “WORKBOOK”
```{python}
DIRECTORY = 'C:\\Users\\<USERNAME>\\Dropbox\\RunningWheel\\'	#Location where the Mouse weight sheets are located
WORKBOOK = 'ABA.xlsx'
```

#### MATLAB
- [MouseWeight_Analysis.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/MouseWeight_Analysis.m)
	- Used to analyze and plot the mouse weight, food consumed, and water consumed each day
	- After the morning of the first day of the first restriction (day 8 of experiment), this function will also calculate the 75% cutoff value for each mouse. This is 75% of the final day of baseline.
	- Requires the following 2 functions to work:
		1. [importDirectory_weights.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/importDirectory_weights.m)
		2. [importWeights.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/importWeights.m)
	- The use of the function MouseWeight_Analysis.m requires that you use our data collection workbook, [ABA.xlsx](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/ABA.xlsx), and store it on DropBox. Before the start of the experiment, a sheet for each day of the experiment should be created. Once this is done, the python function, mouseweight_directory.py, should be used to create a directory at the end of ABA.xlsx that is used by MouseWeight_Analysis.m to properly do the analysis. More information on filling out the ABA.xlsx workbook is below.
- [MouseWeight_Tables.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/MouseWeight_Tables.m)
	- Used to create tables with all the data organized according to groups.
	
##### Must Update
- [MouseWeight_Analysis.m](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/MouseWeight_Analysis.m)
  - Update the two paths, “mouse_savedData2”, “mouse_savedData1”, “Excel_file”, “Structure”, “Acclimation_day1”, “Baseline_day1”, “Restriction_final”, and “timezone”. You may also need to update “Groups_variables”, “number_mice”, “AdLib”, “Restricted”, and the mouse naming. This analysis is set-up for 16 mice in 4 different groups. Group 1 – Ad Lib with Wheel, Group 2 – Ad Lib with dummy Wheel, Group 3 – Restricted with Wheel, and Group 4 – Restricted with dummy Wheel. They alternate in that order. If you set it up in a different way then this analysis of the mouse weight will not work.
```{MATLAB}
%% Assigning variables

addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.

mouse_savedData2 = 'C:\Users\<USERNAME>\Dropbox\RunningWheel\';    %This is where the excel file is being stored where we are entering in the data (Dropbox for us).
% It is also the secondary location where I am saving my running wheel data.
mouse_savedData1 = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; %This is the primary location on my computer where I am saving my running wheel data.

Excel_file = 'ABA.xlsx';
Structure = 'ABA_weight.mat';

Acclimation_day1 = '12-Jun-2021';   % This should be the first day of the acclimation phase
Restriction_final = '1-Jul-2021'; % This should be the last day of the experiment.
%Restriction_final = 'now' %Last day of experiment (use 'now' if it isn't the last day yet)
timezone = 'America/Edmonton';  %This should be changed to your preferred time zone.

Restriction_day1 = Baseline_day1 + 7;
Today_date = datetime('now');
Today_date.Format = 'dd-MMM-yyyy';

cd(mouse_savedData2)

% These are the order of the variables/groups in my tables
Groups_variables = {'AdLibWheel1',
                    'AdLibWheel5',
                    'AdLibWheel9',
                    'AdLibWheel13', 
                    'AdLibDummy3',
                    'AdLibDummy7',
                    'AdLibDummy11',
                    'AdLibDummy15', 
                    'RestrictedWheel2',
                    'RestrictedWheel6',
                    'RestrictedWheel10',
                    'RestrictedWheel14',
                    'RestrictedDummy4',
                    'RestrictedDummy8',
                    'RestrictedDummy12',
                    'RestrictedDummy16'};

% These are the mouse numbers that correspond to each group:

number_mice = 16; % Total number of mice in the experiment

%This will determine how the analysis is carried out (this is because the
%sheets are filled out differently for the two different groups):
AdLib = [1 2 5 6 9 10 13 14];   %Mice that were fed ad libitum chow
Restricted = [3 4 7 8 11 12 15 16]; %Miece that were food restricted
```
- [MouseWeight_Tables](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/MATLAB/MouseWeight/MouseWeight_Tables.m)
  - Update the two paths, “mouse_savedData2”, “mouse_savedData1”, “Structure”, and “Main_table”. You may also need to update “AdLibWheel_index”, “AdLibDummy_index”, “RestrictedWheel_index”, and “RestrictedDummy_index”
```{MATLAB}
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.

mouse_savedData2 = 'C:\Users\<USERNAME>\Dropbox\RunningWheel\';    %This is where the excel file is being stored where we are entering in the data (Dropbox for us).
% It is also the secondary location where I am saving my running wheel data.
mouse_savedData1 = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; 

Structure = 'ABA_weight.mat';
Main_table = 'RunningWheel_tables.xlsx';

cd(mouse_savedData1)
load(Structure)

%This will determine how the data is sorted into tables:
AdLibWheel_index = [1 5 9 13];    %ControlWheel are mice with ad libitum chow and a running wheel
AdLibDummy_index = [2 6 10 14];   %Mice with ad libitum chow and a dummy wheel
RestrictedWheel_index = [3 7 11 15];    %Mice that are food restricted and a running wheel
RestrictedDummy_index = [4 8 12 16];    %Mice that are food restricted and a dummy wheel
```

	
#### Batch
- [MouseWeightAnalysis_graphs.bat](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/BatchFiles/MouseWeightAnalysis_graphs.txt)


### Filling out the ABA.xlsx workbook
The [ABA.xlsx workbook](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/ABA.xlsx) has 4 template sheets.
- Acclimation_Template
- Baseline_Template
- Restriction_Template_6hrs
- Restriction_Template_3hrs

1. Make one copy of the Acclimation_Template. In the corresponding location of the table, enter in the date on which the first day of acclimation will occur (example: Saturday, Jun 12, 2021). When you isolate the mice you can also write in the time that this occurred.

2. Make 7 copies of the Baseline_Template. Enter the Day (1 – 7) (example: Baseline (Day 1)) , and the date (example: Monday, June 14, 2021) when this will occur for each sheet.

3. Make 3 copies of the Restriction_Template_6hrs. Enter the Day (8 – 10) (example: Restriction 6hrs (Day 8)), and the date (example: Monday, June 21, 2021) when this will occur for each sheet.

4. Make 8 copies of the Restriction_Template_3hrs. Enter the Day (11 – 18) (example: Restriction 3 hrs (Day 11)), and the date (example: Thursday, June 24, 2021) when this will occur for each sheet.

The name of each sheet/tab should be the date of data collection (ddmmmyyyy) and they should be in chronological order with the templates at the end. These should all be created before the start of the experiment.

### Create the directory for this workbook
This directory is necessary to use MouseWeight_Analysis.m

1. You will need to download the python module [mouseweight_directory](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/mouseweight_directory.py) to do this
2. Open mouseweight_directory.py in a text editor and update the “Directory” and “WORKBOOK”. These should be the location on Dropbox where the workbook can be found and the name of the workbook, respectively.
```{python}
DIRECTORY = 'C:\\Users\\<USERNAME>\\Dropbox\\RunningWheel\\'	#Location where the Mouse weight sheets are located
WORKBOOK = 'ABA.xlsx'
```
4. In python, enter:
   1. import os
   2. os.chdir(‘C:\Users\<USERNAME>\OneDrive\Desktop\ RunningWheel\Python_Code’)
   3. from mouseweight_directory import mouseweight_directory
   4. mouseweight_directory()
```{python}
import os
os.chdir(‘C:\\Users\\<USERNAME>\\Desktop\\RunningWheel\\Python_Code\\’)
from mouseweight_directory import mouseweight_directory
mouseweight_directory()
```
3. Check the ABA.xlsx and there should be a new sheet/tab at the end with a directory
   1. Only do this once, or you will create multiple directories, which will create errors when running the code later.


### Execution of Wheel Download and Analysis, and mouse weights

I have created a GUI that will analyze the mouse weights along with the data from the running wheels. The code for running this GUI is:
1. [Wheel_GUI_withMouseWeight.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/Wheel_GUI_withMouseWeight.py)
- You will not need to install anything else to use the GUI on Windows

**Additional button for GUI with mouse weight analysis included:**
1. Mouse Weight Download and Plot Graphs
   1. This is linked to the batch file MouseWeightAnalysis_graphs.bat
   2. Downloads the mouse weight data from the DropBox location, stores it in a structure, and creates graphs showing the weight of the mouse and the food consumed over the course of the experiment. After the morning of the first restriction day, this will also calculate the 75% cutoff values for each mouse.
	
---
## Running Wheels with no wifi connection

If you are running your experiments with no, or a very weak/unreliable wifi connection, then you may wish to use the no wifi mode. If you choose to do this, you will first need to copy all the saved text files from each raspberry pi onto a USB drive and then store them together in a file. You can then use the following code to organize your data into Workbooks. Following this, the data analysis will be the same (i.e. the MATlAB part does not change). All you will need to do is select the “Data Analysis and Plot Graphs” button on the GUI.

- [GETdata_wheel_nowifi.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/GETdata_wheel_nowifi.py)
	- Put this file in the Python_Code folder instead of the Getdata_wheel.py.
	
### Must Update:
- [GETdata_wheel_nowifi.py](https://github.com/borglandlab/RunningWheel/blob/main/Analysis_Code/Windows/Code/Python/GETdata_wheel_nowifi.py)
  - Update “SavedData_Directory”, and “Spinner_List”
```{python}
SavedData_Directory = 'C:\\Users\\<USERNAME>\\OneDrive\\Desktop\\RunningWheel\\Wheel_Data'	#This will need to be the folder directory where the data is saved.

#This will need to be as long as the number of spinners you have. This variable is used in Wheel_RunFirst and GetData_wheel functions.
Spinner_List = ['Spinner_1',
'Spinner_2',
'Spinner_3',
'Spinner_4',
'Spinner_5',
'Spinner_6',
'Spinner_7',
'Spinner_8']
