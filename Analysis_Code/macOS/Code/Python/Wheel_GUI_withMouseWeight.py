import os
from applescript import tell
import tkinter as tk

# Specify directory where your executable files are located (.command or .bat)
Directory = '/Users/<USERNAME>/'

# Specify the names of the following executable files
# Prepares files and folders for data download. Run at the beginning, but only once.
First_file = 'START_UP.command'
# Downloads data from email, parses text files, and loads into an excel file.
Download_file = 'DOWNLOAD.command'
# Creates MATLAB structure and carries out basic analysis for distance travelled and average velocity
Analysis_file = 'WheelAnalysis_nographs.command'
# Creates plots showing distance travelled and average velocity across the entire experiment
Graph_file = 'PlotWheel.command'
# Does both the data download and analysis.
Download_Analysis_file = 'Download_Analysis.command'
# Does both the data analysis and plots the distance and velocity.
Analysis_Graph_file = 'WheelAnalysis_graphs.command'
# Does the data download, analysis, and plots the distance and velocity.
Download_Analysis_Graph_file = 'Download_Analysis_Plot.command'

# This downloads the new mouse weight data and creates a structure
MouseWeightAnalysis_file = 'MouseWeightAnalysis_graphs.command'

window = tk.Tk()
window.title('Running Wheel GUI')

instructions = tk.Label(text='Select the appropriate analysis')
instructions.config(font=("Arial", 20))
instructions.pack()

frame_1 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_1.config(bg="red")
frame_1.pack()
button_1 = tk.Button(master=frame_1, text='Run before first Download\n(only run once at beginning)', width=35, height=2)
button_1.config(font=("Arial", 14))
button_1.pack()
instructions_1 = tk.Label(text='- this will set up the files and folders for downloading running wheel data\n- only run once at the very beginning before downloading any data')
instructions_1.config(font=("Times", 12))
instructions_1.pack()

frame_2 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_2.config(bg="blue")
frame_2.pack()
button_2 = tk.Button(master=frame_2, text='Data Download', width=35, height=1)
button_2.config(font=("Arial", 14))
button_2.pack()
instructions_2 = tk.Label(text='- this will download running wheel data from email and store in\nfiles on your computer')
instructions_2.config(font=("Times", 12))
instructions_2.pack()

frame_3 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_3.config(bg="blue")
frame_3.pack()
button_3 = tk.Button(master=frame_3, text='Data Analysis', width=35, height=1)
button_3.config(font=("Arial", 14))
button_3.pack()
instructions_3= tk.Label(text='- this will create a MATLAB structure with your data and calculate the\ntotal distance and average velocity')
instructions_3.config(font=("Times", 12))
instructions_3.pack()

frame_4 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_4.config(bg="blue")
frame_4.pack()
button_4 = tk.Button(master=frame_4, text='Plot Graphs', width=35, height=1)
button_4.config(font=("Arial", 14))
button_4.pack()
instructions_4 = tk.Label(text='- this will plot graphs of the total distance travelled and the\naverage velocity during this time')
instructions_4.config(font=("Times", 12))
instructions_4.pack()

frame_5 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_5.config(bg="blue")
frame_5.pack()
button_5 = tk.Button(master=frame_5, text='Data Download and Analysis', width=35, height=1)
button_5.config(font=("Arial", 14))
button_5.pack()
instructions_5 = tk.Label(text='- this will download data from your email and perform the MATLAB\nanalysis as explained above')
instructions_5.config(font=("Times", 12))
instructions_5.pack()

frame_6 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_6.config(bg="blue")
frame_6.pack()
button_6 = tk.Button(master=frame_6, text='Data Analysis and Plot Graphs', width=35, height=1)
button_6.config(font=("Arial", 14))
button_6.pack()
instructions_6 = tk.Label(text='- this will perform the MATLAB analysis and plot graphs as explained above')
instructions_6.config(font=("Times", 12))
instructions_6.pack()

frame_7 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_7.config(bg="yellow")
frame_7.pack()
button_7 = tk.Button(master=frame_7, text='Data Download, Analysis, and Plot Graphs', width=35, height=1)
button_7.config(font=("Arial", 14))
button_7.pack()
instructions_7 = tk.Label(text='- this will download data from your email, perform the MATLAB analysis,\nand plot graphs as explained above\n- CLICK THIS TO DO EVERYTHING IN ONE STEP')
instructions_7.config(font=("Times", 12))
instructions_7.pack()

frame_8 = tk.Frame(master=window, relief = tk.GROOVE, borderwidth=5)
frame_8.config(bg="purple")
frame_8.pack()
button_8 = tk.Button(master=frame_8, text='Mouse Weight Download and Plot Graphs', width=35, height=1)
button_8.config(font=("Arial", 14))
button_8.pack()
instructions_8 = tk.Label(text='- this will download mouse weight data and plot graphs')
instructions_8.config(font=("Times", 12))
instructions_8.pack()

def runFirst(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + First_file + '"')

button_1.bind("<Button-1>", runFirst)

def Download(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Download_file + '"')

button_2.bind("<Button-1>", Download)

def Analysis(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Analysis_file + '"')

button_3.bind("<Button-1>", Analysis)

def Graphs(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Graph_file + '"')

button_4.bind("<Button-1>", Graphs)

def Download_Analysis(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Download_Analysis_file + '"')

button_5.bind("<Button-1>", Download_Analysis)

def Analysis_Graphs(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Analysis_Graph_file + '"')

button_6.bind("<Button-1>", Analysis_Graphs)

def Download_Analysis_Graphs(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + Download_Analysis_Graph_file + '"')

button_7.bind("<Button-1>", Download_Analysis_Graphs)

def MouseWeight_Analysis(event):
    os.chdir(Directory)
    tell.app('Terminal', 'do script "' + Directory + MouseWeightAnalysis_file + '"')

button_8.bind("<Button-1>", MouseWeight_Analysis)    

window.mainloop()
