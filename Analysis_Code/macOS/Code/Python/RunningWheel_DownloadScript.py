#RunningWheel_DownloadScript
#This script will only download the data. It will not analyze.
#This is good to use if you are short on time but still want to download the new data and make sure that all spinners are working properly.

import os, re	# os allows you to change make changes to files and paths; re allows you to work with regular expressions.
import GETdata_wheel	#This is a module that I created to download the running wheel data from email.
from openpyxl import load_workbook, Workbook	#This module must be downloaded as a third party module to work with excel files.
from inbox import get_inbox	#This is a module and function necessary for getting the email information.

GETdata_wheel.GETdata_wheel()	#Calls the GETdata_wheel function.