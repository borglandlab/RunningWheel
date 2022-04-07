%% Plotting Running Wheel Data
function Wheel_Plot()

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

% Calling directory path
cd(PATH_dataload)   %Changes the file directory to where my data is stored.

if isfile(Structure)    %Checks to make sure that the file exists before doing anything.
    load(Structure)
end

%% Plotting the distance (m) and velocity (m/h)
disp('creating graphs');
for n = 1:length(WheelData)
    name = char(WheelDirectory(n+1).name);  %Gets name of wheel for titles.
    if ~isempty(WheelDirectory(n+1).table)
        if ~isempty(WheelData(n).Alldata)   %Checks to make sure that there is data on the table before plotting

            figure;
            %The first plot is of the total distance travelled. This is an
            %accumulation throughout the entire experiment.
            ax1 = subplot(2,1,1); hold on;
            plot(WheelData(n).Alldata.Date(WheelData(n).Alldata.Left_greater), WheelData(n).Alldata.Distance_km(WheelData(n).Alldata.Left_greater), 'r*');
            plot(WheelData(n).Alldata.Date(WheelData(n).Alldata.Right_greater), WheelData(n).Alldata.Distance_km(WheelData(n).Alldata.Right_greater), 'b*');
            plot(WheelData(n).Alldata.Date, WheelData(n).Alldata.Distance_km, 'k-');
            x1 = datetime(Acclimation_day1,'TimeZone',timezone);
            x2 = datetime(Restriction_final,'TimeZone',timezone);  %Use this onece you've gotten to the last day of the experiment
            %ylim([0 250]); %I can turn this on if I want to standardize my graphs.
            xlim([x1,x2]);
            if length(name) > 9
                title(['Spinner #' name(9:10) newline char(WheelData(n).Alldata.Date(1)) ' to ' char(WheelData(n).Alldata.Date(length(WheelData(n).Alldata.Date))) newline 'Total Distance: ' num2str(WheelData(n).Alldata.Distance_km(end)) 'km' newline 'Average Speed: ' num2str(mean(WheelData(n).Alldata.Velocity_km_h)) 'km/h']);
            else
                title(['Spinner #' name(9) newline char(WheelData(n).Alldata.Date(1)) ' to ' char(WheelData(n).Alldata.Date(length(WheelData(n).Alldata.Date))) newline 'Total Distance: ' num2str(WheelData(n).Alldata.Distance_km(end)) 'km' newline 'Average Speed: ' num2str(mean(WheelData(n).Alldata.Velocity_km_h)) 'km/h']);
            end
            ylabel('Distance (km)');
            xlabel('Time (Date)');
            legend('clock wise', 'counter-clock wise', 'Location', 'North West');
            hold off

            %The second plot is of the velocity at any given point.
            ax2 = subplot(2,1,2); hold on;
            plot(WheelData(n).Alldata.Date(WheelData(n).Alldata.Left_greater), WheelData(n).Alldata.Velocity_km_h(WheelData(n).Alldata.Left_greater), 'r*');
            plot(WheelData(n).Alldata.Date(WheelData(n).Alldata.Right_greater), WheelData(n).Alldata.Velocity_km_h(WheelData(n).Alldata.Right_greater), 'b*');
            ylim([0 5])
            %title(['Velocity of Mouse #' name(9) newline char(WheelData(n).Alldata.Date(1)) ' to ' char(WheelData(n).Alldata.Date(length(WheelData(n).Alldata.Date)))]);
            ylabel('Velocity (km/h)');
            xlabel('Time (Date)');
            %I linked my x-axis together.
            linkaxes([ax1, ax2], 'x');
            hold off
            %Saving my figures.
            cd(PATH_destination1)
            saveas(gcf,['Mouse_' num2str(n) '_Activity'],'tiff')
            cd(PATH_destination2)
            saveas(gcf,['Mouse_' num2str(n) '_Activity'],'tiff')
        else
            if length(name) > 9
                disp(['no data to show for spinner #' name(9:10)]);
            else
                disp(['no data to show for spinner #' name(9)]);
            end
        end
    else
        if length(name) > 9
            disp(['no data to show for spinner #' name(9:10)]);
        else
            disp(['no data to show for spinner #' name(9)]);
        end
    end
end
clear n name ax1 ax2 x1 x2

disp('Wheel Plots Complete');
end