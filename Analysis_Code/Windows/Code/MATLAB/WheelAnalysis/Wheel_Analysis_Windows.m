%% Importing directories and all running wheel data
function Wheel_Analysis()

% Assigning variables
addpath('C:\Users\<USERNAME>\OneDrive\Documents\MATLAB\')    %This path should correspond to you MATLAB folder.
addpath('C:\Users\<USERNAME\OneDrive\Documents\MATLAB\RunningWheel\')   %This path should correspond to the folder where you are keeping your running wheel code.
PATH = 'C:\Users\<USERNAME>\OneDrive\Desktop\RunningWheel\Wheel_Data\'; %This is the folder path where your saved data is located.
timezone = 'America/Edmonton';  %This should be changed to your preferred time zone.
Structure = 'RunningWheelData.mat'; % name of the MATLAB structure that contains/will contain the running wheel data
runningwheel_diameter = 110; % the diameter of the mouses running trajectory (mm)
Wheel_number = 8;   %   This is the number of running wheels that I am using

% Calling directory path
cd(PATH)

%Find existing running wheel matlab file. If this is not the firs time
%that you are using this function you will be able to find it.
if isfile(Structure)
    load(Structure)
    disp('matlab file succesfully loaded');
else
    disp('no matlab file currently exists');    %This will be the case if this is the first time that you are running this function.
    disp('will create new matlab file');
end

if exist('WheelDirectory', 'var')   %This will run if it isn't the first time
    for n = 2:(Wheel_number + 1)
        if ~isempty(WheelDirectory(n).table)
            WheelDirectory(n).previous = height(WheelDirectory(n).table.Tab_Name);  %Important to record the length of the field before importing the new data so that my program knows what is new and what is old.
        else
            WheelDirectory(n).previous = 0;
        end
    end
    clear n

    file_path_directory = PATH + "Wheel_Directory.xlsx";    %This is the name of the directory excel file.
    WheelDirectory(1).table = importLength(file_path_directory, 'Length', [2, (Wheel_number + 1)]);  %Importing the "Length" sheet of the directory excel file.

    %This part here will update the directory so that it's the same as
    %the excel file.
    disp('updating directory');
    for n = 1:height(WheelDirectory(1).table.Spinner)
        WheelDirectory(n+1).name = WheelDirectory(1).table.Spinner(n);
        if WheelDirectory(1).table.Length(n) > 1
            WheelDirectory(n+1).table = importDirectory(file_path_directory, WheelDirectory(1).table.Spinner(n), [2,WheelDirectory(1).table.Length(n)]);
            WheelDirectory(n+1).table.Date.Format = 'dd-MMM-uuuu HH:mm:ss.SSS'; %Defining the format with milliseconds.
            WheelDirectory(n+1).table.Date.TimeZone = 'UTC';    %Specify this data as the UTC timezone - timezone that we used when collecting the data.
            WheelDirectory(n+1).table.Date.TimeZone = timezone;   %Change the time to you preferred timezone.
        else
            WheelDirectory(n+1).table = table([]);
        end
    end
    disp('directory updated');
    clear n;

    %Import data for each spinner
    for n = 2:length(WheelDirectory)    %Start at 2 because the 1 is the "Master" field in the WheelDirectory structure.
        WheelData(n-1).name = WheelDirectory(n).name;   %n-1 because there is no "Master" field in the WheelData structure.

        file_path_data = PATH + WheelDirectory(n).name + '/';   %Folder for the spinner that I am getting data from.

        name = char(WheelDirectory(n).name);    %Define the name of the spinner so that I can report back progress of analysis.

        if ~isempty(WheelDirectory(n).table)    %Checks to see if there is any data (new or old for this spinner)
            if length(name) > 9
                disp(['beginning import for spinner #' name(9:10)]);
            else
                disp(['beginning import for spinner #' name(9)]);
            end
            if WheelDirectory(n).previous < height(WheelDirectory(n).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
                for m = WheelDirectory(n).previous+1:height(WheelDirectory(n).table.Tab_Name)   %This will go through every entry beginning with the first new entry ("previous+1").
                    sheet_path = file_path_data + WheelDirectory(n).table.File(m);  %This will change since I can only hold 49 sheets in each excel file where I'm importing from.
                    WheelData(n-1).dataset(m).datatable = importData(sheet_path, WheelDirectory(n).table.Tab_Name(m), [2, WheelDirectory(n).table.Length(m)]);  %Imports data using a function "importData" where I've set up appropriate parameters.
                    x = m/5;    % These lines of code allow me to report on import progress for every 5th sheeet
                    if isreal(x) && rem(x,1)==0
                        disp(['imported ' num2str(m) ' sheets of ' num2str(height(WheelDirectory(n).table.Tab_Name)) ' total tabs']);
                    end
                end
                if length(name) > 9
                    disp(['completed import for spinner #' name(9:10)]);
                else
                    disp(['completed import for spinner #' name(9)]);
                end
            else
                if length(name) > 9
                    disp(['no new data for spinner #' name(9:10)]);
                else
                    disp(['no new data for spinner #' name(9)]);
                end
            end
        else
            if length(name) > 9
                disp(['no data for spinner #' name(9:10)]);
            else
                disp(['no data for spinner #' name(9)]);
            end
        end
    end
    clear x n m name

    %% Creating variable in data sheets that is the actual time

    % Making the times the actual times, by adding the seconds to the datetime
    % value from the directory
    for i = 1:length(WheelData)
        if ~isempty(WheelDirectory(i+1).table)
            if WheelDirectory(i+1).previous < height(WheelDirectory(i+1).table)    %Compares length of data to previous to see if there is any new data. Will not run with no new data.
                for n = WheelDirectory(i+1).previous+1:length(WheelData(i).dataset) %Will run through starting with the first new data line ("previous+1").
                    Date = NaT(length(WheelData(i).dataset(n).datatable.Time),1);   %Creates an empty time matrix the size of spots I need to fill
                    Date.Format = 'dd-MMM-uuuu HH:mm:ss.SSS';   %Formats the time with milliseconds so that I can be extremely precise (necessary with the speed that the spinners are spinning).
                    Date.TimeZone = 'America/Edmonton'; %Defines the correct timezeone. You will need to change this if you have a different timezone than the Mountain Standard Time (MST).
                    for m = 1:length(WheelData(i).dataset(n).datatable.Time)    %Goes through each line of new data
                        Date(m) = WheelDirectory(i+1).table.Date(n) + seconds(WheelData(i).dataset(n).datatable.Time(m));   %Gets the date with the time in seconds (and milliseconds)
                    end
                    WheelData(i).dataset(n).datatable = addvars(WheelData(i).dataset(n).datatable,Date,'After','Time'); %Adds data to the table
                    WheelData(i).dataset(n).datatable = renamevars(WheelData(i).dataset(n).datatable,["Var2"], ["Date"]);   %Rename variable
                end
                name = char(WheelDirectory(i+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                if length(name) > 9
                    disp(['time modified for spinner #' name(9:10)]);
                else
                    disp(['time modified for spinner #' name(9)]);
                end
            end
        end
    end
    clear i n m Date name

    % Going to create a new Alldata table that I will then add to my
    % existing. It's much faster to do it this way. Otherwise, I have
    % to redo the analysis on all my data, which becomes quite time
    % consuming.

    for n = 1:length(WheelData)
        if ~isempty(WheelDirectory(n+1).table)
            if isfield(WheelData(n), 'Alldata') %Checks to see if the Alldata field has been made yet
                if ~isempty(WheelData(n).Alldata)  %Checks to see if there is data from a previous import
                    name = char(WheelDirectory(n+1).name);  %Defines name (number between 1 and 8)
                    if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table.Tab_Name)    %Compares length of data to previous length of data to see if there is new data to calculate.
                        %Creating an AllnewData table
                        if length(name) > 9
                            disp(['creating All New data table for spinner #' name(9:10)]);
                        else
                            disp(['creating All New data table for spinner #' name(9)]);
                        end
                        AllnewData = WheelData(n).dataset(WheelDirectory(n+1).previous+1).datatable;    %The first line of the AllnewData table is assigned as the first new line of data that was imported.
                        if WheelDirectory(n+1).previous+1 < length(WheelData(n).dataset)    %Checks to see if there is more than just one line of new data
                            for m = WheelDirectory(n+1).previous+2:length(WheelData(n).dataset) %Runs through the rest of the data (after the first line)
                                AllnewData = [AllnewData; WheelData(n).dataset(m).datatable];   %Appends data to the AllnewData table
                            end
                            clear m
                        end

                        L = height(AllnewData.Time(~isnan(AllnewData.Time)));    %Gets the length of the AllnewData table.

                        if L < 1
                            clear AllnewData
                            if length(name) > 9
                                disp(['no new data for spinner #' name(9:10)]);
                            else
                                disp(['no new data for spinner #' name(9)]);
                            end
                            clear L
                        else
                            %Clean up the AllnewData table. This was necessary due to
                            %email reports when no running occured.
                            H = height(AllnewData.Time);
                            for m = 0:(H-1)
                                if isnan(AllnewData.Time(H-m))
                                    AllnewData(H-m,:) = [];
                                end
                            end
                            clear H m

                            Count = [WheelData(n).Alldata.Count(end)+1:(WheelData(n).Alldata.Count(end))+height(AllnewData.Time)]'; %This is the number of events (times that the hall effect sensors were triggered).
                            AllnewData = addvars(AllnewData,Count,'After','Right_value');   %Adds this in as a new variable to the table.
                            clear Count

                            %Creating arrays that I will fill.
                            Left_greater = nan(height(AllnewData.Count), 1);
                            Right_greater = nan(height(AllnewData.Count), 1);

                            %This loop will give me logical values of 1 or 0 for if it.
                            %is trigger the left or right sensor.
                            for m = 1:height(AllnewData.Count)
                                Left_greater(m) = AllnewData.Left_value(m) > AllnewData.Right_value(m);
                                Right_greater(m) = AllnewData.Right_value(m) > AllnewData.Left_value(m);
                            end
                            clear m

                            %Have to redeclare these variables as logical values.
                            Left_greater = logical(Left_greater);
                            Right_greater = logical(Right_greater);

                            %Adding in variables to the table.
                            AllnewData = addvars(AllnewData,Left_greater,'After','Count');
                            AllnewData = addvars(AllnewData,Right_greater,'After','Left_greater');

                            clear Left_greater Right_greater

                            % These variables are necessary for calculating the
                            % distance that the mouse has run.
                            C = 2*pi*(runningwheel_diameter/2); % calculates the circumference that the mouse is running (mm)
                            third_circ = (C/3)/1000;  % calculates a third of the circumference (m)
                            clear C

                            %Calculating the distance.
                            Distance = (AllnewData.Count .* third_circ) ./ 1000;
                            AllnewData = addvars(AllnewData,Distance,'After','Right_greater');  %Adding variable to table.
                            AllnewData = renamevars(AllnewData,['Distance'], ['Distance_km']);

                            %Creating a column for the velocity, which I will calcualte
                            %after appending this table to the Alldata table.
                            Velocity = nan(height(AllnewData.Time),1);
                            AllnewData = addvars(AllnewData,Velocity,'After','Distance_km');    %Adding variable to table
                            AllnewData = renamevars(AllnewData,['Velocity'], ['Velocity_km_h']);

                            clear Distance Velocity

                            L = height(WheelData(n).Alldata.Time);  %Getting the height of the original Alldata table before appending the AllnewData table to it.
                            %I will use this when calculating the velocity.

                            WheelData(n).Alldata = [WheelData(n).Alldata; AllnewData];  %Appending the AllnewData table to the original Alldata table.
                            clear AllnewData

                            %Calculating the velocity
                            if length(name) > 9
                                disp(['calculating velocity for spinner #' name(9:10)]);
                            else
                                disp(['calculating velocity for spinner #' name(9)]);
                            end
                            for m = L+1:height(WheelData(n).Alldata.Time)   %Calculating the velocity for all the new data added ("L+1"), one line at a time.
                                time_s = WheelData(n).Alldata.Date(m) - WheelData(n).Alldata.Date(m-1); %Getting the difference in time between datetime objects.
                                [Y, M, D, H, MN, S] = datevec(time_s);  %Assigning the datetime object to variables.
                                time_seconds = H*3600+MN*60+S;  %Getting the complete time in seconds.
                                distance = WheelData(n).Alldata.Distance_km(m) - WheelData(n).Alldata.Distance_km(m-1); %Getting the difference in distance between the two data lines.
                                WheelData(n).Alldata.Velocity_km_h(m) = distance/time_seconds*3600; %Calculate the velocity (km/h).
                            end

                            if length(name) > 9
                                disp(['velocity calculated for spinner #' name(9:10)]);
                            else
                                disp(['velocity calculated for spinner #' name(9)]);
                            end

                            clear Y M D H MN S time_seconds distance m time_s

                            if length(name) > 9
                                disp(['data for spinner #' name(9:10) ' successfully imported and analyzed']);
                            else
                                disp(['data for spinner #' name(9) ' successfully imported and analyzed']);
                            end
                        end
                    else
                        if length(name) > 9
                            disp(['no new data for spinner #' name(9:10)]);
                        else
                            disp(['no new data for spinner #' name(9)]);
                        end
                    end
                else
                    % Will go to here if the Alldata field exists, but is empty.
                    % Concatenating all my tables
                    WheelData(n).Alldata = WheelData(n).dataset(1).datatable;   %Creating the Alldata table, starting with the first sheet.
                    name = char(WheelDirectory(n+1).name);
                    if length(name) > 9
                        disp(['no previous data exists in All data table for spinner #' name(9:10)]);
                        disp(['creating All data table for spinner #' name(9:10)]);
                    else
                        disp(['no previous data exists in All data table for spinner #' name(9)]);
                        disp(['creating All data table for spinner #' name(9)]);
                    end
                    for m = 2:length(WheelData(n).dataset)  %Adding on all remaining sheets.
                        WheelData(n).Alldata = [WheelData(n).Alldata; WheelData(n).dataset(m).datatable];
                    end

                    % Removing nan values (due to email reports when no running occured)
                    H = height(WheelData(n).Alldata.Time);
                    for m = 0:(H-1)
                        if isnan(WheelData(n).Alldata.Time(H-m))
                            WheelData(n).Alldata(H-m,:) = [];
                        end
                    end
                    clear H m

                    % Create a count from 1 to the length of Alldata
                    Count = [1:height(WheelData(n).Alldata.Time)]'; %This is the number of events (times that the hall effect sensors were triggered).
                    WheelData(n).Alldata = addvars(WheelData(n).Alldata,Count,'After','Right_value');   %Adding variable
                    WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var6'], ['Count']);    %renaming variable
                    clear Count

                    % Create a logical index for when the Left Value is greater than the Right
                    % Value and for when the Right Value is greater than the Left Value
                    Left_greater = nan(height(WheelData(n).Alldata.Count), 1);
                    Right_greater = nan(height(WheelData(n).Alldata.Count), 1);

                    for m = 1:height(WheelData(n).Alldata.Count)
                        Left_greater(m) = WheelData(n).Alldata.Left_value(m) > WheelData(n).Alldata.Right_value(m);
                        Right_greater(m) = WheelData(n).Alldata.Right_value(m) > WheelData(n).Alldata.Left_value(m);
                    end

                    Left_greater = logical(Left_greater);   %Have to redefine as a logical variable for some reason.
                    Right_greater = logical(Right_greater);

                    WheelData(n).Alldata = addvars(WheelData(n).Alldata,Left_greater,'After','Count');  %Adding variables
                    WheelData(n).Alldata = addvars(WheelData(n).Alldata,Right_greater,'After','Var7');
                    WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var7'], ['Left_greater']); %Renaming variables.
                    WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var8'], ['Right_greater']);
                    clear Left_greater Right_greater m

                    %% Creating a variable that contains the actual distance travelled by the mouse
                    % These variables are necessary for calculating the
                    % distance that the mouse has run.
                    C = 2*pi*(runningwheel_diameter/2); % calculates the circumference that the mouse is running (mm)
                    third_circ = (C/3)/1000;  % calculates a third of the circumference (m)
                    clear C

                    %%
                    Distance = (WheelData(n).Alldata.Count .* third_circ) ./ 1000;  %Calculating the distance
                    WheelData(n).Alldata = addvars(WheelData(n).Alldata,Distance,'After','Right_greater');
                    WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var9'], ['Distance_km']);
                    clear Distance

                    %% Getting the velocity

                    if height(WheelData(n).Alldata) == 1
                        name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                        if length(name) > 9
                            disp(['calculating velocity for spinner #' name(9:10)]);
                        else
                            disp(['calculating velocity for spinner #' name(9)]);
                        end
                        WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                        WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.
                        if length(name) > 9
                            disp(['velocity calculated for spinner #' name(9:10)]);
                        else
                            disp(['velocity calculated for spinner #' name(9)]);
                        end
                        clear Y M D H MN S time_seconds distance m time_s

                        if length(name) > 9
                            disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                        else
                            disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                        end

                    elseif height(WheelData(n).Alldata) > 1
                        name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                        if length(name) > 9
                            disp(['calculating velocity for spinner #' name(9:10)]);
                        else
                            disp(['calculating velocity for spinner #' name(9)]);
                        end
                        WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                        WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.

                        %Calculating the velocity for the remaining lines of data.
                        for m = 2:height(WheelData(n).Alldata.Time)
                            time_s = WheelData(n).Alldata.Date(m) - WheelData(n).Alldata.Date(m-1);
                            [Y, M, D, H, MN, S] = datevec(time_s);
                            time_seconds = H*3600+MN*60+S;
                            distance = WheelData(n).Alldata.Distance_km(m) - WheelData(n).Alldata.Distance_km(m-1);
                            WheelData(n).Alldata.Velocity_km_h(m) = distance/time_seconds*3600;
                        end
                        if length(name) > 9
                            disp(['velocity calculated for spinner #' name(9:10)]);
                        else
                            disp(['velocity calculated for spinner #' name(9)]);
                        end
                        clear Y M D H MN S time_seconds distance m time_s

                        if length(name) > 9
                            disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                        else
                            disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                        end
                    end
                    clear name
                end
            else
                % Will go to here if the Alldata field does not already exist
                % Concatenating all my tables
                WheelData(n).Alldata = WheelData(n).dataset(1).datatable;   %Creating the Alldata table, starting with the first sheet.
                name = char(WheelDirectory(n+1).name);
                if length(name) > 9
                    disp(['no previous data exists in All data table for spinner #' name(9:10)]);
                    disp(['creating All data table for spinner #' name(9:10)]);
                else
                    disp(['no previous data exists in All data table for spinner #' name(9)]);
                    disp(['creating All data table for spinner #' name(9)]);
                end
                for m = 2:length(WheelData(n).dataset)  %Adding on all remaining sheets.
                    WheelData(n).Alldata = [WheelData(n).Alldata; WheelData(n).dataset(m).datatable];
                end

                % Removing nan values (due to email reports when no running occured)
                H = height(WheelData(n).Alldata.Time);
                for m = 0:(H-1)
                    if isnan(WheelData(n).Alldata.Time(H-m))
                        WheelData(n).Alldata(H-m,:) = [];
                    end
                end
                clear H m

                % Create a count from 1 to the length of Alldata
                Count = [1:height(WheelData(n).Alldata.Time)]'; %This is the number of events (times that the hall effect sensors were triggered).
                WheelData(n).Alldata = addvars(WheelData(n).Alldata,Count,'After','Right_value');   %Adding variable
                WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var6'], ['Count']);    %renaming variable
                clear Count

                % Create a logical index for when the Left Value is greater than the Right
                % Value and for when the Right Value is greater than the Left Value
                Left_greater = nan(height(WheelData(n).Alldata.Count), 1);
                Right_greater = nan(height(WheelData(n).Alldata.Count), 1);

                for m = 1:height(WheelData(n).Alldata.Count)
                    Left_greater(m) = WheelData(n).Alldata.Left_value(m) > WheelData(n).Alldata.Right_value(m);
                    Right_greater(m) = WheelData(n).Alldata.Right_value(m) > WheelData(n).Alldata.Left_value(m);
                end

                Left_greater = logical(Left_greater);   %Have to redefine as a logical variable for some reason.
                Right_greater = logical(Right_greater);

                WheelData(n).Alldata = addvars(WheelData(n).Alldata,Left_greater,'After','Count');  %Adding variables
                WheelData(n).Alldata = addvars(WheelData(n).Alldata,Right_greater,'After','Var7');
                WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var7'], ['Left_greater']); %Renaming variables.
                WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var8'], ['Right_greater']);
                clear Left_greater Right_greater m

                %% Creating a variable that contains the actual distance travelled by the mouse
                % These variables are necessary for calculating the
                % distance that the mouse has run.
                C = 2*pi*(runningwheel_diameter/2); % calculates the circumference that the mouse is running (mm)
                third_circ = (C/3)/1000;  % calculates a third of the circumference (m)
                clear C

                %%
                Distance = (WheelData(n).Alldata.Count .* third_circ) ./ 1000;  %Calculating the distance
                WheelData(n).Alldata = addvars(WheelData(n).Alldata,Distance,'After','Right_greater');
                WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var9'], ['Distance_km']);
                clear Distance

                %% Getting the velocity

                if height(WheelData(n).Alldata) == 1
                    name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                    if length(name) > 9
                        disp(['calculating velocity for spinner #' name(9:10)]);
                    else
                        disp(['calculating velocity for spinner #' name(9)]);
                    end
                    WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                    WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.
                    if length(name) > 9
                        disp(['velocity calculated for spinner #' name(9:10)]);
                    else
                        disp(['velocity calculated for spinner #' name(9)]);
                    end
                    clear Y M D H MN S time_seconds distance m time_s

                    if length(name) > 9
                        disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                    else
                        disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                    end

                elseif height(WheelData(n).Alldata) > 1
                    name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                    if length(name) > 9
                        disp(['calculating velocity for spinner #' name(9:10)]);
                    else
                        disp(['calculating velocity for spinner #' name(9)]);
                    end
                    WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                    WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.

                    %Calculating the velocity for the remaining lines of data.
                    for m = 2:height(WheelData(n).Alldata.Time)
                        time_s = WheelData(n).Alldata.Date(m) - WheelData(n).Alldata.Date(m-1);
                        [Y, M, D, H, MN, S] = datevec(time_s);
                        time_seconds = H*3600+MN*60+S;
                        distance = WheelData(n).Alldata.Distance_km(m) - WheelData(n).Alldata.Distance_km(m-1);
                        WheelData(n).Alldata.Velocity_km_h(m) = distance/time_seconds*3600;
                    end
                    if length(name) > 9
                        disp(['velocity calculated for spinner #' name(9:10)]);
                    else
                        disp(['velocity calculated for spinner #' name(9)]);
                    end
                    clear Y M D H MN S time_seconds distance m time_s

                    if length(name) > 9
                        disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                    else
                        disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                    end
                end
                clear name
            end
        end
    end
    clear L n name

    cd(PATH)
    save (Structure, '-v7.3')  %Save to MATLAB using '-v7.3' so that it'll create a compressed file. Otherwise it'll be too big to save after a while.

    %This will run if it is the first time
else
    for n = 1:(Wheel_number + 1)     %This must be one greater than the number of wheels that I am recording from.
        WheelDirectory(n).previous = 0; %Sets previous as 0 because this is the first time running this code.
    end
    clear n

    file_path_directory = PATH + "Wheel_Directory.xlsx";
    WheelDirectory(1).name = "Master";  %Creating the "Master field, which will contain the number of files and sheets for each spinner.
    WheelDirectory(1).table = importLength(file_path_directory, 'Length', [2, (Wheel_number + 1)]);  %Importing the "Length" sheet from the directory excel file using the predifined import function "importLength".

    disp('creating directory');
    %Creating the directory, and synching it with the directory excel
    %file.
    for n = 1:height(WheelDirectory(1).table.Spinner)
        WheelDirectory(n+1).name = WheelDirectory(1).table.Spinner(n);
        if WheelDirectory(1).table.Length(n) > 1
            WheelDirectory(n+1).table = importDirectory(file_path_directory, WheelDirectory(1).table.Spinner(n), [2,WheelDirectory(1).table.Length(n)]);
            WheelDirectory(n+1).table.Date.Format = 'dd-MMM-uuuu HH:mm:ss.SSS'; %Defining the format with milliseconds.
            WheelDirectory(n+1).table.Date.TimeZone = 'UTC';    %Specify this data as the UTC timezone - timezone that we used when collecting the data.
            WheelDirectory(n+1).table.Date.TimeZone = timezone;   %Change the time to you preferred timezone.
        else
            WheelDirectory(n+1).table = table([]);
        end
    end
    disp('directory created');
    clear n;

    for n = 2:length(WheelDirectory)    %Will go through each spinner. Starts at 2 because 1 is the "Master" field.
        WheelData(n-1).name = WheelDirectory(n).name;   %Gets the name of the spinner.

        file_path_data = PATH + WheelDirectory(n).name + '/';   %Creates path where data for that spinner will be found.
        name = char(WheelDirectory(n).name);    %Defines name (for keeping track of things) as number between 1 and 8)

        if length(name) > 9
            disp(['beginning import for spinner #' name(9:10)]);
        else
            disp(['beginning import for spinner #' name(9)]);
        end
        if WheelDirectory(n).previous < height(WheelDirectory(n).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field (0 on first time).
            for m = WheelDirectory(n).previous+1:height(WheelDirectory(n).table.Tab_Name)
                sheet_path = file_path_data + WheelDirectory(n).table.File(m);
                if WheelDirectory(1).table.Length(n-1) > 1
                    WheelData(n-1).dataset(m).datatable = importData(sheet_path, WheelDirectory(n).table.Tab_Name(m), [2, WheelDirectory(n).table.Length(m)]);
                    x = m/5;    % These lines of code allow me to report on import progress for every 5th tab
                    if isreal(x) && rem(x,1)==0
                        disp(['imported ' num2str(m) ' tabs of ' num2str(height(WheelDirectory(n).table.Tab_Name)) ' total tabs']);
                    end
                end
            end
            if length(name) > 9
                disp(['competed import for spinner #' name(9:10)]);
            else
                disp(['completed import for spinner #' name(9)]);
            end
        else
            if length(name) > 9
                disp(['no data for spinner #' name(9:10)]);
            else
                disp(['no data for spinner #' name(9)]);
            end
        end
    end
    clear x n m name

    %% Creating variable in data sheets that is the actual time

    % Making the times the actual times, by adding the seconds to the datetime
    % value from the directory
    for i = 1:length(WheelData)
        name = char(WheelDirectory(i+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
        if WheelDirectory(i+1).previous < height(WheelDirectory(i+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            for n = WheelDirectory(i+1).previous+1:length(WheelData(i).dataset) %Will run through starting with the first new data line ("previous+1").
                Date = NaT(height(WheelData(i).dataset(n).datatable.Time),1);   %Creates an empty time matrix the size of spots I need to fill
                Date.Format = 'dd-MMM-uuuu HH:mm:ss.SSS';   %Formats the time with milliseconds so that I can be extremely precise (necessary with the speed that the spinners are spinning).
                Date.TimeZone = 'America/Edmonton'; %Defines the correct timezeone. You will need to change this if you have a different timezone than the Mountain Standard Time (MST).
                for m = 1:height(WheelData(i).dataset(n).datatable.Time)    %Goes through each line of new data
                    Date(m) = WheelDirectory(i+1).table.Date(n) + seconds(WheelData(i).dataset(n).datatable.Time(m));   %Gets the date with the time in seconds (and milliseconds)
                end
                WheelData(i).dataset(n).datatable = addvars(WheelData(i).dataset(n).datatable,Date,'After','Time'); %Adds data to the table
                WheelData(i).dataset(n).datatable = renamevars(WheelData(i).dataset(n).datatable,["Var2"], ["Date"]);   %Rename variable.
            end
            if length(name) > 9
                disp(['time modified for spinner #' name(9:10)]);
            else
                disp(['time modified for spinner #' name(9)]);
            end
        end
    end
    clear i n m Date name

    % Concatenating all my tables

    for n = 1:length(WheelData) %Will do this for each spinner (1 through 8)
        name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            WheelData(n).Alldata = WheelData(n).dataset(1).datatable;   %Creating the Alldata table, starting with the first sheet.
            if length(name) > 9
                disp(['creating All data table for spinner #' name(9:10)]);
            else
                disp(['creating All data table for spinner #' name(9)]);
            end
            for m = 2:length(WheelData(n).dataset)  %Adding on all remaining sheets.
                WheelData(n).Alldata = [WheelData(n).Alldata; WheelData(n).dataset(m).datatable];
            end
        end
    end
    clear n name

    % Removing nan values (due to email reports when no running occured)
    for n = 1:length(WheelData)
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            H = height(WheelData(n).Alldata.Time);
            for m = 0:(H-1)
                if isnan(WheelData(n).Alldata.Time(H-m))
                    WheelData(n).Alldata(H-m,:) = [];
                end
            end
        end
    end
    clear n H m

    % Create a count from 1 to the length of Alldata
    for n = 1:length(WheelData) %For each spinner.
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            Count = [1:height(WheelData(n).Alldata.Time)]'; %This is the number of events (times that the hall effect sensors were triggered).
            WheelData(n).Alldata = addvars(WheelData(n).Alldata,Count,'After','Right_value');   %Adding variable
            WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var6'], ['Count']);    %renaming variable
        end
    end
    clear Count n

    % Create a logical index for when the Left Value is greater than the Right
    % Value and for when the Right Value is greater than the Left Value
    for n = 1:length(WheelData)
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            Left_greater = nan(height(WheelData(n).Alldata.Count), 1);
            Right_greater = nan(height(WheelData(n).Alldata.Count), 1);

            for m = 1:height(WheelData(n).Alldata.Count)
                Left_greater(m) = WheelData(n).Alldata.Left_value(m) > WheelData(n).Alldata.Right_value(m);
                Right_greater(m) = WheelData(n).Alldata.Right_value(m) > WheelData(n).Alldata.Left_value(m);
            end

            Left_greater = logical(Left_greater);   %Have to redefine as a logical variable for some reason.
            Right_greater = logical(Right_greater);

            WheelData(n).Alldata = addvars(WheelData(n).Alldata,Left_greater,'After','Count');  %Adding variables
            WheelData(n).Alldata = addvars(WheelData(n).Alldata,Right_greater,'After','Var7');
            WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var7'], ['Left_greater']); %Renaming variables.
            WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var8'], ['Right_greater']);
        end
    end
    clear Left_greater Right_greater n m

    %% Creating a variable that contains the actual distance travelled by the mouse
    % These variables are necessary for calculating the
    % distance that the mouse has run.
    C = 2*pi*(runningwheel_diameter/2); % calculates the circumference that the mouse is running (mm)
    third_circ = (C/3)/1000;  % calculates a third of the circumference (m)
    clear C

    %%
    for n = 1:length(WheelData)
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            Distance = (WheelData(n).Alldata.Count .* third_circ) ./ 1000;  %Calculating the distance
            WheelData(n).Alldata = addvars(WheelData(n).Alldata,Distance,'After','Right_greater');
            WheelData(n).Alldata = renamevars(WheelData(n).Alldata,['Var9'], ['Distance_km']);
        end
    end
    clear Distance n

    %% Getting the velocity

    for n = 1:length(WheelData)
        if WheelDirectory(n+1).previous < height(WheelDirectory(n+1).table)    %Compares length of new (imported) field to the length of the previous (pre-imported) field.
            if height(WheelData(n).Alldata) == 1
                name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                if length(name) > 9
                    disp(['calculating velocity for spinner #' name(9:10)]);
                else
                    disp(['calculating velocity for spinner #' name(9)]);
                end
                WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.
                if length(name) > 9
                    disp(['velocity calculated for spinner #' name(9:10)]);
                else
                    disp(['velocity calculated for spinner #' name(9)]);
                end
                clear Y M D H MN S time_seconds distance m time_s

                if length(name) > 9
                    disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                else
                    disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                end

            elseif height(WheelData(n).Alldata) > 1
                name = char(WheelDirectory(n+1).name);  %Defines the name (just a number between 1 and 8 or however many spinners you have).
                if length(name) > 9
                    disp(['calculating velocity for spinner #' name(9:10)]);
                else
                    disp(['calculating velocity for spinner #' name(9)]);
                end
                WheelData(n).Alldata.Velocity_km_h = nan(height(WheelData(n).Alldata.Time),1);  %Creates an empty matrix where the velocity data will go.

                WheelData(n).Alldata.Velocity_km_h(1) = WheelData(n).Alldata.Distance_km(1)/(WheelData(n).Alldata.Time(1))*3600;    %Calculating the velocity for the first line of data.

                %Calculating the velocity for the remaining lines of data.
                for m = 2:height(WheelData(n).Alldata.Time)
                    time_s = WheelData(n).Alldata.Date(m) - WheelData(n).Alldata.Date(m-1);
                    [Y, M, D, H, MN, S] = datevec(time_s);
                    time_seconds = H*3600+MN*60+S;
                    distance = WheelData(n).Alldata.Distance_km(m) - WheelData(n).Alldata.Distance_km(m-1);
                    WheelData(n).Alldata.Velocity_km_h(m) = distance/time_seconds*3600;
                end
                if length(name) > 9
                    disp(['velocity calculated for spinner #' name(9:10)]);
                else
                    disp(['velocity calculated for spinner #' name(9)]);
                end
                clear Y M D H MN S time_seconds distance m time_s

                if length(name) > 9
                    disp(['data for wheel #' name(9:10) ' successfully imported and analyzed']);
                else
                    disp(['data for wheel #' name(9) ' successfully imported and analyzed']);
                end
            end
        end
    end
    clear n name

    cd(PATH)
    save (Structure, '-v7.3')  %Save to MATLAB using '-v7.3' so that it'll create a compressed file. Otherwise it'll be too big to save after a while.
end

disp('Wheel Analysis Complete');
end