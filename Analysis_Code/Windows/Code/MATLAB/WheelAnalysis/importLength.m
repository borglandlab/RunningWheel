function WheelDirectory = importLength(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  WHEELDIRECTORY = importLength(FILE) reads data from the first worksheet
%  in the Microsoft Excel spreadsheet file named FILE.  Returns the data
%  as a table.
%
%  WHEELDIRECTORY = importLength(FILE, SHEET) reads from the specified
%  worksheet.
%
%  WHEELDIRECTORY = importLength(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  WheelDirectory = importLength("/Users/nathansmac/Desktop/Wheel/DataDownload/Wheel_Directory.xlsx", "Length", [2, 9]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 28-Apr-2021 14:28:37

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    error('please input a sheet name');
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 9];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 3);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":C" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Spinner", "Files", "Length"];
opts.VariableTypes = ["string", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "Spinner", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Spinner", "EmptyFieldRule", "auto");

% Import the data
WheelDirectory = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":C" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    WheelDirectory = [WheelDirectory; tb]; %#ok<AGROW>
end

end