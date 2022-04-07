function WheelDirectory = importDirectory(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  WHEELDIRECTORY = IMPORTDIRECTORY(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the data as a table.
%
%  WHEELDIRECTORY = IMPORTDIRECTORY(FILE, SHEET) reads from the specified
%  worksheet.
%
%  WHEELDIRECTORY = IMPORTDIRECTORY(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  WheelDirectory = importDirectory("/Users/nathansmac/Desktop/Wheel/DataDownload/Wheel_Directory.xlsx", "Spinner_1", [2, 46]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 16-Feb-2021 22:22:38

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    error('please input a sheet name');
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    error('please input the data lines');
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 3);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":C" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["File", "Tab_Name", "Date", "Length"];
opts.VariableTypes = ["string", "string", "datetime", "double"];

% Specify variable properties
opts = setvaropts(opts, "Tab_Name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Tab_Name", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "");

% Import the data
WheelDirectory = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":C" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    WheelDirectory = [WheelDirectory; tb]; %#ok<AGROW>
end

end