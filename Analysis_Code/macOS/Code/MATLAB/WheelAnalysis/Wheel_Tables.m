%{
This script was created to analyze and visualize the running wheel data
in different ways. It is divided into different sections, depending on what
anaylsis is desired.

In the final tables, the first two rows should not be used, as these are
the two days of the acclimation phase. In addition, the last row should not
be used, as this is day 8 of the 3 hour food access restriction phase, and
it is not a complete day. I have removed these in the code, so you don't
have to worry about this.

The sections include:
1. assigning variables
2. distance travelled per day and the average velocity per day
3. activity during the 3 hours prior to feeding
4. activity during the 3 hours of feeding
5. activity from 3:30 PM to 6:30PM
6. hourly distances and presenting one day at a time
7. creating tables that can put into prism
8. direction of wheel (clock-wise or counter-clock-wise)
9. Cleaning tables
10. Writing all the tables to excel

This analysis was designed to be done at the end of the experiment.
%}

%% 1. Assigning variables

addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB')    %This path should correspond to you MATLAB folder.
addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB/RunningWheel')   %This path should correspond to the folder where you are keeping your running wheel code.
PATH = '/Users/<USERNAME>/Desktop/Wheel/DataDownload/'; %This is the folder path where your saved data is located.

% Setting my dates
Acclimation_day1 = datetime('12-Jun-2021');
Baseline_day1 = datetime('14-Jun-2021');
Restriction_final = datetime('1-Jul-2021');
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

% Calling directory path
cd(PATH)

%% Load Structure
load(Structure)

%% 2. Presenting data as distance travelled per day and the average velocity per day

x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;
[year_index,month_index,day_index] = ymd(x_date);

for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data;
        WheelData(n).Daily_distance(m).day_km = WheelData(n).Alldata.Distance_km(date_index);
        if length(WheelData(n).Daily_distance(m).day_km) > 0
            WheelData(n).Daily_distance(m).day_km = WheelData(n).Daily_distance(m).day_km - WheelData(n).Daily_distance(m).day_km(1);
        else
            WheelData(n).Daily_distance(m).day_km = [];
        end
        WheelData(n).Daily_distance(m).day_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Daily_velocity(m).day_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);
        WheelData(n).Daily_velocity(m).day_time = WheelData(n).Alldata.Date(date_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_distance)
        if length(WheelData(n).Daily_distance(m).day_km) > 0;
            WheelData(n).Daily_distance(m).sum = WheelData(n).Daily_distance(m).day_km(end);
        else
            WheelData(n).Daily_distance(m).sum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_velocity)
        WheelData(n).Daily_velocity(m).mean = mean(WheelData(n).Daily_velocity(m).day_kmh);
    end
end

x_date = [Baseline_day1 : Restriction_final]';
x_date.TimeZone = timezone;
%{
% Plotting the data
for n = 1:length(WheelDirectory) - 1
    figure;
    ax1 = subplot(2,1,1); hold on;
    plot(x_date, [WheelData(n).Daily_distance.sum],'b*');
    plot(x_date, [WheelData(n).Daily_distance.sum], 'k-');
    x1 = Acclimation_day1;
    x1.TimeZone = timezone;
    x2 = Restriction_final;
    x2.TimeZone = timezone;
    ylim([0 40]);
    xlim([x1,x2]);
    title(['Total distance travelled by mouse #' num2str(n) ' each day']) %newline 'Final Baseline Weight of Mouse: ' num2str(ABA_1.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA_1.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
    ylabel('Distance travelled (km)');
    xlabel('Date');
    hold off
    ax2 = subplot(2,1,2); hold on;
    plot(x_date, [WheelData(n).Daily_velocity.mean],'b*');
    plot(x_date, [WheelData(n).Daily_velocity.mean], 'k-');
    ylim([0 5]);
    title(['Average daily velocity of mouse #' num2str(n)]);
    ylabel('Average velocity (km/h)');
    xlabel('Date');
    linkaxes([ax1, ax2], 'x');
    hold off
    %cd /Users/nathansmac/Desktop/Wheel/Figures/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    %cd /Users/nathansmac/Dropbox/RunningWheel/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
end
%}
clear n ax1 ax2 x1 x2

%% 3. Presenting data as activity during the 3 hours prior to feeding

x_date = [Acclimation_day1 : Restriction_final]';
[year_index,month_index,day_index] = ymd(x_date);
for n = 1:length(x_date)
    x_date_feedtime(n) = datetime(year_index(n), month_index(n), day_index(n), 9, 30, 0);
end
x_date_feedtime.TimeZone = timezone;

x_date_prefeedtime = x_date_feedtime - hours(3);


for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data & x_date_feedtime(m) > WheelData(n).Alldata.Date & x_date_prefeedtime(m) <= WheelData(n).Alldata.Date;
        WheelData(n).Prefeed_distance(m).day_km = WheelData(n).Alldata.Distance_km(date_index);
        if length(WheelData(n).Prefeed_distance(m).day_km) > 0
            WheelData(n).Prefeed_distance(m).day_km = WheelData(n).Prefeed_distance(m).day_km - WheelData(n).Prefeed_distance(m).day_km(1);
        else
            WheelData(n).Prefeed_distance(m).day_km = [];
        end
        WheelData(n).Prefeed_distance(m).day_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Prefeed_velocity(m).day_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);
        WheelData(n).Prefeed_velocity(m).day_time = WheelData(n).Alldata.Date(date_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date_feedtime x_date_prefeedtime

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Prefeed_distance)
        if length(WheelData(n).Prefeed_distance(m).day_km) > 0;
            WheelData(n).Prefeed_distance(m).sum = WheelData(n).Prefeed_distance(m).day_km(end);
        else
            WheelData(n).Prefeed_distance(m).sum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Prefeed_velocity)
        WheelData(n).Prefeed_velocity(m).mean = mean(WheelData(n).Prefeed_velocity(m).day_kmh);
    end
end
%{
% Plotting the data
x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;

for n = 1:length(WheelDirectory) - 1
    figure;
    ax1 = subplot(2,1,1); hold on;
    plot(x_date, [WheelData(n).Prefeed_distance.sum],'b*');
    plot(x_date, [WheelData(n).Prefeed_distance.sum], 'k-');
    x1 = Acclimation_day1;
    x1.TimeZone = timezone;
    x2 = Restriction_final;
    x2.TimeZone = timezone;
    ylim([0 8]);
    xlim([x1,x2]);
    title(['Anticipatory activity by mouse #' num2str(n) ' (3 hours)']) %newline 'Final Baseline Weight of Mouse: ' num2str(ABA_1.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA_1.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
    ylabel('Distance travelled (km)');
    xlabel('Date');
    hold off
    ax2 = subplot(2,1,2); hold on;
    plot(x_date, [WheelData(n).Prefeed_velocity.mean],'b*');
    plot(x_date, [WheelData(n).Prefeed_velocity.mean], 'k-');
    ylim([0 6]);
    title(['Average velocity of mouse #' num2str(n) ' (3 hours)']);
    ylabel('Average velocity (km/h)');
    xlabel('Date');
    linkaxes([ax1, ax2], 'x');
    hold off
    %cd /Users/nathansmac/Desktop/Wheel/Figures/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    %cd /Users/nathansmac/Dropbox/RunningWheel/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
end
%}
clear n ax1 ax2 x1 x2

%% 4. Presenting data as activity during the first 3 hours of feeding

x_date = [Acclimation_day1 : Restriction_final]';
[year_index,month_index,day_index] = ymd(x_date);
for n = 1:length(x_date)
    x_date_feedtime1(n) = datetime(year_index(n), month_index(n), day_index(n), 9, 30, 0);
end
x_date_feedtime1.TimeZone = timezone;

x_date_feedtime3 = x_date_feedtime1 + hours(3);



for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data & x_date_feedtime1(m) <= WheelData(n).Alldata.Date & x_date_feedtime3(m) > WheelData(n).Alldata.Date;
        WheelData(n).Durfeed_distance(m).day_km = WheelData(n).Alldata.Distance_km(date_index);
        if length(WheelData(n).Durfeed_distance(m).day_km) > 0
            WheelData(n).Durfeed_distance(m).day_km = WheelData(n).Durfeed_distance(m).day_km - WheelData(n).Durfeed_distance(m).day_km(1);
        else
            WheelData(n).Durfeed_distance(m).day_km = [];
        end
        WheelData(n).Durfeed_distance(m).day_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Durfeed_velocity(m).day_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);
        WheelData(n).Durfeed_velocity(m).day_time = WheelData(n).Alldata.Date(date_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date_feedtime1 x_date_feedtime3

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Durfeed_distance)
        if length(WheelData(n).Durfeed_distance(m).day_km) > 0;
            WheelData(n).Durfeed_distance(m).sum = WheelData(n).Durfeed_distance(m).day_km(end);
        else
            WheelData(n).Durfeed_distance(m).sum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Durfeed_velocity)
        WheelData(n).Durfeed_velocity(m).mean = mean(WheelData(n).Durfeed_velocity(m).day_kmh);
    end
end
%{
% Plotting the data
x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;

for n = 1:length(WheelDirectory) - 1
    figure;
    ax1 = subplot(2,1,1); hold on;
    plot(x_date, [WheelData(n).Durfeed_distance.sum],'b*');
    plot(x_date, [WheelData(n).Durfeed_distance.sum], 'k-');
    x1 = Acclimation_day1;
    x1.TimeZone = timezone;
    x2 = Restriction_final;
    x2.TimeZone = timezone;
    ylim([0 6]);
    xlim([x1,x2]);
    title(['Activity during food intake period by mouse #' num2str(n) ' (6 hours)']) %newline 'Final Baseline Weight of Mouse: ' num2str(ABA_1.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA_1.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
    ylabel('Distance travelled (km)');
    xlabel('Date');
    hold off
    ax2 = subplot(2,1,2); hold on;
    plot(x_date, [WheelData(n).Durfeed_velocity.mean],'b*');
    plot(x_date, [WheelData(n).Durfeed_velocity.mean], 'k-');
    ylim([0 6]);
    title(['Average velocity of mouse #' num2str(n) ' (6 hours)']);
    ylabel('Average velocity (km/h)');
    xlabel('Date');
    linkaxes([ax1, ax2], 'x');
    hold off
    %cd /Users/nathansmac/Desktop/Wheel/Figures/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    %cd /Users/nathansmac/Dropbox/RunningWheel/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
end
%}
clear n ax1 ax2 x1 x2


%% 5. Presenting data as activity from 3:30 PM to 6:30 PM

x_date = [Acclimation_day1 : Restriction_final]';
[year_index,month_index,day_index] = ymd(x_date);
for n = 1:length(x_date)
    x_date_feedtime1(n) = datetime(year_index(n), month_index(n), day_index(n), 15, 30, 0);
end
x_date_feedtime1.TimeZone = timezone;

x_date_feedtime3 = x_date_feedtime1 + hours(3);



for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data & x_date_feedtime1(m) <= WheelData(n).Alldata.Date & x_date_feedtime3(m) > WheelData(n).Alldata.Date;
        WheelData(n).Postfeed_distance(m).day_km = WheelData(n).Alldata.Distance_km(date_index);
        if length(WheelData(n).Postfeed_distance(m).day_km) > 0
            WheelData(n).Postfeed_distance(m).day_km = WheelData(n).Postfeed_distance(m).day_km - WheelData(n).Postfeed_distance(m).day_km(1);
        else
            WheelData(n).Postfeed_distance(m).day_km = [];
        end
        WheelData(n).Postfeed_distance(m).day_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Postfeed_velocity(m).day_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);
        WheelData(n).Postfeed_velocity(m).day_time = WheelData(n).Alldata.Date(date_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date_feedtime1 x_date_feedtime3

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Postfeed_distance)
        if length(WheelData(n).Postfeed_distance(m).day_km) > 0;
            WheelData(n).Postfeed_distance(m).sum = WheelData(n).Postfeed_distance(m).day_km(end);
        else
            WheelData(n).Postfeed_distance(m).sum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Postfeed_velocity)
        WheelData(n).Postfeed_velocity(m).mean = mean(WheelData(n).Postfeed_velocity(m).day_kmh);
    end
end
%{
% Plotting the data
x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;

for n = 1:length(WheelDirectory) - 1
    figure;
    ax1 = subplot(2,1,1); hold on;
    plot(x_date, [WheelData(n).Postfeed_distance.sum],'b*');
    plot(x_date, [WheelData(n).Postfeed_distance.sum], 'k-');
    x1 = Acclimation_day1;
    x1.TimeZone = timezone;
    x2 = Restriction_final;
    x2.TimeZone = timezone;
    ylim([0 6]);
    xlim([x1,x2]);
    title(['Activity following food intake period by mouse #' num2str(n) ' (3 hours)']) %newline 'Final Baseline Weight of Mouse: ' num2str(ABA_1.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA_1.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
    ylabel('Distance travelled (km)');
    xlabel('Date');
    hold off
    ax2 = subplot(2,1,2); hold on;
    plot(x_date, [WheelData(n).Postfeed_velocity.mean],'b*');
    plot(x_date, [WheelData(n).Postfeed_velocity.mean], 'k-');
    ylim([0 6]);
    title(['Average velocity of mouse #' num2str(n) ' (3 hours)']);
    ylabel('Average velocity (km/h)');
    xlabel('Date');
    linkaxes([ax1, ax2], 'x');
    hold off
    %cd /Users/nathansmac/Desktop/Wheel/Figures/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    %cd /Users/nathansmac/Dropbox/RunningWheel/
    %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
end
%}
clear n ax1 ax2 x1 x2

%% 6. Presenting data as hourly distances and presenting one day at a time
% This is a slow

h_index = [0:23];
for n = 1:length(WheelDirectory) - 1
    for o = 1:length(WheelData(n).Daily_distance)
        for m = 1:length(h_index)
            hour_index = hour(WheelData(n).Daily_distance(o).day_time) == h_index(m);
            WheelData(n).Daily_distance(o).hourly(m).distance = WheelData(n).Daily_distance(o).day_km(hour_index);
            if length(WheelData(n).Daily_distance(o).hourly(m).distance) > 0
                WheelData(n).Daily_distance(o).hourly(m).distance = WheelData(n).Daily_distance(o).hourly(m).distance - WheelData(n).Daily_distance(o).hourly(m).distance(1);
            else
                WheelData(n).Daily_distance(o).hourly(m).distance = [];
            end
            WheelData(n).Daily_distance(o).hourly(m).time = WheelData(n).Daily_distance(o).day_time(hour_index);
            if length(WheelData(n).Daily_distance(o).hourly(m).distance) > 0
                WheelData(n).Daily_distance(o).hourly(m).sum = WheelData(n).Daily_distance(o).hourly(m).distance(end);
            else
                WheelData(n).Daily_distance(o).hourly(m).sum = 0;
            end
        end
    end
end

clear h_index n o m hour_index
%{
% Plotting the data - be careful plotting this, because it will be over 100
% graphs
x_date = [Acclimation_day1 : Restriction_final]';
x_hour = [0:24];
x_hour = duration(hours(x_hour),'format','hh:mm');

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_distance)
        figure; hold on;
        plot(x_hour(1:end-1), [WheelData(n).Daily_distance(m).hourly.sum],'b*');
        plot(x_hour(1:end-1), [WheelData(n).Daily_distance(m).hourly.sum], 'k-');
        ylim([0 3]);
        xlim([x_hour(1),x_hour(end)]);
        title(['Daily activity by mouse #' num2str(n) ' binned per hour for ' datestr(x_date(m))]) %newline 'Final Baseline Weight of Mouse: ' num2str(ABA_1.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA_1.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
        ylabel('Distance travelled (km)');
        xlabel('Time (24 hour time)');
        hold off
        %cd /Users/nathansmac/Desktop/Wheel/Figures/
        %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
        %cd /Users/nathansmac/Dropbox/RunningWheel/
        %saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    end
end
%}
clear n ax1 ax2 x1 x2


clear m n x_date x_hour x_date_feedtime x_date_feedtime1 x_date_feedtime3 x_date_postfeed1 x_date_postfeed3 x_date_prefeedtime

x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;

%% 7. Creating tables that I can put into prism

% Daily Distance Travelled
Control_dailydistance = [];
for n = 1:4
    Control_dailydistance = [Control_dailydistance [WheelData(Control_index(n)).Daily_distance.sum]'];
end

Restricted_dailydistance = [];
for n = 1:4
    Restricted_dailydistance = [Restricted_dailydistance [WheelData(Restricted_index(n)).Daily_distance.sum]'];
end

WheelData(1).Tables(1).dailydistance = array2table([Control_dailydistance Restricted_dailydistance]);

WheelData(1).Tables(1).dailydistance.Properties.VariableNames = Groups_variables;

clear n Control_dailydistance Restricted_dailydistance


% Prefeeding Distance Travelled
Control_prefeeddistance = [];
for n = 1:4
    Control_prefeeddistance = [Control_prefeeddistance [WheelData(Control_index(n)).Prefeed_distance.sum]'];
end

Restricted_prefeeddistance = [];
for n = 1:4
    Restricted_prefeeddistance = [Restricted_prefeeddistance [WheelData(Restricted_index(n)).Prefeed_distance.sum]'];
end

WheelData(1).Tables(1).prefeeddistance = array2table([Control_prefeeddistance Restricted_prefeeddistance]);

WheelData(1).Tables(1).prefeeddistance.Properties.VariableNames = Groups_variables;

clear n Control_prefeeddistance Restricted_prefeeddistance


% Feeding Distance Travelled
Control_feeddistance = [];
for n = 1:4
    Control_feeddistance = [Control_feeddistance [WheelData(Control_index(n)).Durfeed_distance.sum]'];
end

Restricted_feeddistance = [];
for n = 1:4
    Restricted_feeddistance = [Restricted_feeddistance [WheelData(Restricted_index(n)).Durfeed_distance.sum]'];
end

WheelData(1).Tables(1).feeddistance = array2table([Control_feeddistance Restricted_feeddistance]);

WheelData(1).Tables(1).feeddistance.Properties.VariableNames = Groups_variables;

clear n Control_feeddistance Restricted_feeddistance


% Postfeeding Distance Travelled
Control_postfeeddistance = [];
for n = 1:4
    Control_postfeeddistance = [Control_postfeeddistance [WheelData(Control_index(n)).Postfeed_distance.sum]'];
end

Restricted_postfeeddistance = [];
for n = 1:4
    Restricted_postfeeddistance = [Restricted_postfeeddistance [WheelData(Restricted_index(n)).Postfeed_distance.sum]'];
end

WheelData(1).Tables(1).postfeeddistance = array2table([Control_postfeeddistance Restricted_postfeeddistance]);

WheelData(1).Tables(1).postfeeddistance.Properties.VariableNames = Groups_variables;

clear n Control_postfeeddistance Restricted_postfeeddistance

% Postfeeding Distance Travelled
for m = 1:length(WheelData(1).Daily_distance)
    Control_hourlybin = [];
    Restricted_hourlybin = [];
    for n = 1:4
        Control_hourlybin = [Control_hourlybin [WheelData(Control_index(n)).Daily_distance(m).hourly.sum]'];
        Restricted_hourlybin = [Restricted_hourlybin [WheelData(Restricted_index(n)).Daily_distance(m).hourly.sum]'];
    end
    WheelData(1).Tables(m).hourlybin = array2table([Control_hourlybin Restricted_hourlybin]);
    WheelData(1).Tables(m).hourlybin.Properties.VariableNames = Groups_variables;
end

clear n m Control_hourlybin Restricted_hourlybin

% Daily Velocity
Control_dailyvelocity = [];
for n = 1:4
    Control_dailyvelocity = [Control_dailyvelocity [WheelData(Control_index(n)).Daily_velocity.mean]'];
end

Restricted_dailyvelocity = [];
for n = 1:4
    Restricted_dailyvelocity = [Restricted_dailyvelocity [WheelData(Restricted_index(n)).Daily_velocity.mean]'];
end

WheelData(1).Tables(1).dailyvelocity = array2table([Control_dailyvelocity Restricted_dailyvelocity]);

WheelData(1).Tables(1).dailyvelocity.Properties.VariableNames = Groups_variables;

clear n Control_dailyvelocity Restricted_dailyvelocity

% Prefeeding Velocity
Control_prefeedvelocity = [];
for n = 1:4
    Control_prefeedvelocity = [Control_prefeedvelocity [WheelData(Control_index(n)).Prefeed_velocity.mean]'];
end

Restricted_prefeedvelocity = [];
for n = 1:4
    Restricted_prefeedvelocity = [Restricted_prefeedvelocity [WheelData(Restricted_index(n)).Prefeed_velocity.mean]'];
end

WheelData(1).Tables(1).prefeedvelocity = array2table([Control_prefeedvelocity Restricted_prefeedvelocity]);

WheelData(1).Tables(1).prefeedvelocity.Properties.VariableNames = Groups_variables;

clear n Control_prefeedvelocity Restricted_prefeedvelocity

% Feeding Velocity
Control_feedvelocity = [];
for n = 1:4
    Control_feedvelocity = [Control_feedvelocity [WheelData(Control_index(n)).Durfeed_velocity.mean]'];
end

Restricted_feedvelocity = [];
for n = 1:4
    Restricted_feedvelocity = [Restricted_feedvelocity [WheelData(Restricted_index(n)).Durfeed_velocity.mean]'];
end

WheelData(1).Tables(1).feedvelocity = array2table([Control_feedvelocity Restricted_feedvelocity]);

WheelData(1).Tables(1).feedvelocity.Properties.VariableNames = Groups_variables;

clear n Control_feedvelocity Restricted_feedvelocity

% Postfeeding Velocity
Control_postfeedvelocity = [];
for n = 1:4
    Control_postfeedvelocity = [Control_postfeedvelocity [WheelData(Control_index(n)).Postfeed_velocity.mean]'];
end

Restricted_postfeedvelocity = [];
for n = 1:4
    Restricted_postfeedvelocity = [Restricted_postfeedvelocity [WheelData(Restricted_index(n)).Postfeed_velocity.mean]'];
end

WheelData(1).Tables(1).postfeedvelocity = array2table([Control_postfeedvelocity Restricted_postfeedvelocity]);

WheelData(1).Tables(1).postfeedvelocity.Properties.VariableNames = Groups_variables;

clear n Control_postfeedvelocity Restricted_postfeedvelocity

%% 8. Creating tables of the direction that the wheel was spinning for daily distance and daily velocity

% Clockwise (CW)

x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;
[year_index,month_index,day_index] = ymd(x_date);

for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data;
        CW_index = WheelData(n).Alldata.Left_greater == logical(1);
        CW_index = CW_index(date_index);
        WheelData(n).Daily_distance(m).CWday_km = WheelData(n).Alldata.Distance_km(date_index);
        WheelData(n).Daily_distance(m).CWday_km = WheelData(n).Daily_distance(m).CWday_km(CW_index);
        WheelData(n).Daily_distance(m).CWday_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Daily_distance(m).CWday_time = WheelData(n).Daily_distance(m).CWday_time(CW_index);        
        WheelData(n).Daily_velocity(m).CWday_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);        
        WheelData(n).Daily_velocity(m).CWday_kmh = WheelData(n).Daily_velocity(m).CWday_kmh(CW_index);        
        WheelData(n).Daily_velocity(m).CWday_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Daily_velocity(m).CWday_time = WheelData(n).Daily_velocity(m).CWday_time(CW_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date CW_index

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_distance)
        if length(WheelData(n).Daily_distance(m).CWday_km) > 0
            WheelData(n).Daily_distance(m).CWsum = (length(WheelData(n).Daily_distance(m).CWday_km) .* third_circ) ./ 1000;
        else
            WheelData(n).Daily_distance(m).CWsum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_velocity)
        WheelData(n).Daily_velocity(m).CWmean = mean(WheelData(n).Daily_velocity(m).CWday_kmh);
    end
end

clear n m

% Counter-Clockwise (CCW)

x_date = [Acclimation_day1 : Restriction_final]';
x_date.TimeZone = timezone;
[year_index,month_index,day_index] = ymd(x_date);

for n = 1:length(WheelDirectory) - 1
    [year_data,month_data,day_data] = ymd(WheelData(n).Alldata.Date);
    for m = 1:length(x_date)
        date_index = year_index(m) == year_data & month_index(m) == month_data & day_index(m) == day_data;
        CCW_index = WheelData(n).Alldata.Right_greater == logical(1);
        CCW_index = CCW_index(date_index);
        WheelData(n).Daily_distance(m).CCWday_km = WheelData(n).Alldata.Distance_km(date_index);
        WheelData(n).Daily_distance(m).CCWday_km = WheelData(n).Daily_distance(m).CCWday_km(CCW_index);
        WheelData(n).Daily_distance(m).CCWday_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Daily_distance(m).CCWday_time = WheelData(n).Daily_distance(m).CCWday_time(CCW_index);
        WheelData(n).Daily_velocity(m).CCWday_kmh = WheelData(n).Alldata.Velocity_km_h(date_index);
        WheelData(n).Daily_velocity(m).CCWday_kmh = WheelData(n).Daily_velocity(m).CCWday_kmh(CCW_index);
        WheelData(n).Daily_velocity(m).CCWday_time = WheelData(n).Alldata.Date(date_index);
        WheelData(n).Daily_velocity(m).CCWday_time = WheelData(n).Daily_velocity(m).CCWday_time(CCW_index);
    end
end
clear n m year_data month_data day_data date_index year_index month_index day_index x_date CCW_index

% Get the sum of distance and average velocity
for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_distance)
        if length(WheelData(n).Daily_distance(m).CCWday_km) > 0
            WheelData(n).Daily_distance(m).CCWsum = (length(WheelData(n).Daily_distance(m).CCWday_km) .* third_circ) ./ 1000;
        else
            WheelData(n).Daily_distance(m).CCWsum = 0;
        end
    end
end

for n = 1:length(WheelDirectory) - 1
    for m = 1:length(WheelData(n).Daily_velocity)
        WheelData(n).Daily_velocity(m).CCWmean = mean(WheelData(n).Daily_velocity(m).CCWday_kmh);
    end
end

clear n m

% Daily Distance Travelled (Clock-wise)
Control_CW_dailydistance = [];
for n = 1:4
    Control_CW_dailydistance = [Control_CW_dailydistance [WheelData(Control_index(n)).Daily_distance.CWsum]'];
end

Restricted_CW_dailydistance = [];
for n = 1:4
    Restricted_CW_dailydistance = [Restricted_CW_dailydistance [WheelData(Restricted_index(n)).Daily_distance.CWsum]'];
end

WheelData(1).Tables(1).dailydistance_CW = array2table([Control_CW_dailydistance Restricted_CW_dailydistance]);

WheelData(1).Tables(1).dailydistance_CW.Properties.VariableNames = Groups_variables;

clear n Control_CW_dailydistance Restricted_CW_dailydistance

% Daily Distance Travelled (Counter-Clock-wise)
Control_CCW_dailydistance = [];
for n = 1:4
    Control_CCW_dailydistance = [Control_CCW_dailydistance [WheelData(Control_index(n)).Daily_distance.CCWsum]'];
end

Restricted_CCW_dailydistance = [];
for n = 1:4
    Restricted_CCW_dailydistance = [Restricted_CCW_dailydistance [WheelData(Restricted_index(n)).Daily_distance.CCWsum]'];
end

WheelData(1).Tables(1).dailydistance_CCW = array2table([Control_CCW_dailydistance Restricted_CCW_dailydistance]);

WheelData(1).Tables(1).dailydistance_CCW.Properties.VariableNames = Groups_variables;

clear n Control_CCW_dailydistance Control_index Restricted_CCW_dailydistance Restricted_index

%% 9. Cleaning tables

% The first two rows and the last row should all be removed from the tables.

% daily distance
WheelData(1).Tables(1).dailydistance(1:2,:) = [];
WheelData(1).Tables(1).dailydistance(end,:) = [];

% prefeeding distance
WheelData(1).Tables(1).prefeeddistance(1:2,:) = [];
WheelData(1).Tables(1).prefeeddistance(end,:) = [];

% feeding distance
WheelData(1).Tables(1).feeddistance(1:2,:) = [];
WheelData(1).Tables(1).feeddistance(end,:) = [];

% post-feeding distance
WheelData(1).Tables(1).postfeeddistance(1:2,:) = [];
WheelData(1).Tables(1).postfeeddistance(end,:) = [];

% daily velocity
WheelData(1).Tables(1).dailyvelocity(1:2,:) = [];
WheelData(1).Tables(1).dailyvelocity(end,:) = [];

% prefeeding velocity
WheelData(1).Tables(1).prefeedvelocity(1:2,:) = [];
WheelData(1).Tables(1).prefeedvelocity(end,:) = [];

% feeding velocity
WheelData(1).Tables(1).feedvelocity(1:2,:) = [];
WheelData(1).Tables(1).feedvelocity(end,:) = [];

% post-feeding velocity
WheelData(1).Tables(1).postfeedvelocity(1:2,:) = [];
WheelData(1).Tables(1).postfeedvelocity(end,:) = [];

% daily distance (CW)
WheelData(1).Tables(1).dailydistance_CW(1:2,:) = [];
WheelData(1).Tables(1).dailydistance_CW(end,:) = [];

% daily distance (CCW)
WheelData(1).Tables(1).dailydistance_CCW(1:2,:) = [];
WheelData(1).Tables(1).dailydistance_CCW(end,:) = [];

% hourly bins
[WheelData(1).Tables(1:2).hourlybin] = deal([]);
WheelData(1).Tables(20) = [];

%% 10. Write tables to excel
cd(PATH);

% Writing the distance travelled tables
writetable(WheelData(1).Tables(1).dailydistance,Main_table,'Sheet','daily','Range','A1');
writetable(WheelData(1).Tables(1).prefeeddistance,Main_table,'Sheet','prefeed','Range','A1');
writetable(WheelData(1).Tables(1).feeddistance,Main_table,'Sheet','feed','Range','A1');
writetable(WheelData(1).Tables(1).postfeeddistance,Main_table,'Sheet','postfeed','Range','A1');

% Writing the velocity tables
writetable(WheelData(1).Tables(1).dailyvelocity,Main_table,'Sheet','dailyvelocity','Range','A1');
writetable(WheelData(1).Tables(1).prefeedvelocity,Main_table,'Sheet','prefeedvelocity','Range','A1');
writetable(WheelData(1).Tables(1).feedvelocity,Main_table,'Sheet','feedvelocity','Range','A1');
writetable(WheelData(1).Tables(1).postfeedvelocity,Main_table,'Sheet','postfeedvelocity','Range','A1');

% Writing the direction of wheel tables
writetable(WheelData(1).Tables(1).dailydistance_CW,Main_table,'Sheet','CW','Range','A1');
writetable(WheelData(1).Tables(1).dailydistance_CCW,Main_table,'Sheet','CCW','Range','A1');


% Writing the hourly data for each day
for n = 3:length(WheelData(1).Tables)
    writetable(WheelData(1).Tables(n).hourlybin,Hourly_table,'Sheet',['hourly_day_' num2str(n-2)],'Range','A1');
end
clear n

%% Saving Structure

save (Structure, '-v7.3')




