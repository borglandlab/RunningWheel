function MouseWeight_Analysis()

%{
This script is used to import the measurements recorded in the excel file each
day. These measurements include mouse, food, and water weight. It is meant
to be used with the protocol used in this publication and the the data
collection sheets provided. This includes a 2 day acclimation period (only
one sheet for acclimation), 7 day baseline, 3 day 6 hour food access
restriction, and 8 day 3 hour food access restriction (8th day is not
really a full day but allows us to get the full measurements for day 7).

The directory is on the last page of the excel sheet and can be created
using a python function that is provided, called mouseweight_directory.py.

This script is divided into sections, including:
1. assigning variables
2. updating the MATLAB directory with the information from the excel sheet
directory
3. Getting the mouse, food, and water data sorted to each mouse in the MATLAB structure
4. Calculating the change in weight for mouse, food, and water
5. Finding the weight of mouse on last baseline day - this is used to
determine when the mouse has reduced in weight to less than 75% of initial
weight
6. Calculating the Cut off (below 75% of body weight)
7. Saving the structures as MATLAB files
8. Plotting figures

This analysis should be done on a daily basis to keep track of the mouse
weight. Obviously, the excel sheet for that day must be filled out before
the analysis can be done. Also, You will be unable to calculate the 75%
weight of baseline until after you've entered in the last day of baseline,
so avoid 6 and 7 until that point or you will get an error.

However, each time this analysis is done it will create a brand new
structure, and when it is saved it will replace the pre-existing structure.
This seems to work fine, because this structure never gets too big.
%}

%% Assigning variables

addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB')    
addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB/RunningWheel')
mouse_savedData2 = '/Users/<USERNAME>/Dropbox/RunningWheel/';    %This is where the excel file is being stored where we are entering in the data (Dropbox for us).
% It is also the secondary location where I am saving my running wheel data.
mouse_savedData1 = '/Users/<USERNAME>/Desktop/RunningWheel/Wheel_Data/'; %This is the primary location on my computer where I am saving my running wheel data.

Excel_file = 'ABA.xlsx';
Structure = 'ABA_weight.mat';

Acclimation_day1 = '12-Jun-2021';   % This should be the first day of the acclimation phase
Baseline_day1 = datetime('14-Jun-2021');    % This should be the first day of the baseline phase
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

%% 2. Update the directory first
%Since the directory isn't that big, I import it from scratch every time.
%However, this first section is a bit slow.

ABA.Directory = importDirectory_weights(Excel_file, "Directory"); %Change this to be the name of the file and the sheet name.

ABA.Directory(20:end,:) = [];

for n = 1:length(ABA.Directory.TabNumber)
    ABA.Grouped(n).DATE = ABA.Directory.Date(n);
    TF = isspace(ABA.Directory.Experimental_Day(n));
    linearIndices = find(TF==1);
    m = linearIndices(1) - 1;
    Day = char(ABA.Directory.Experimental_Day(n));
    ABA.Grouped(n).DAY = Day(1:m);
    ABA.Grouped(n).TABLE = importWeights(Excel_file, n);  %Change this to be the name of the file.
end
clear n m Day TF linearIndices

%% 3. Getting mouse data sorted to mice in MATLAB structure

% Naming Mice
ABA.Mouse(1).Name = 'Mouse 1';
ABA.Mouse(2).Name = 'Mouse 2';
ABA.Mouse(3).Name = 'Mouse 3';
ABA.Mouse(4).Name = 'Mouse 4';
ABA.Mouse(5).Name = 'Mouse 5';
ABA.Mouse(6).Name = 'Mouse 6';
ABA.Mouse(7).Name = 'Mouse 7';
ABA.Mouse(8).Name = 'Mouse 8';
ABA.Mouse(9).Name = 'Mouse 9';
ABA.Mouse(10).Name = 'Mouse 10';
ABA.Mouse(11).Name = 'Mouse 11';
ABA.Mouse(12).Name = 'Mouse 12';
ABA.Mouse(13).Name = 'Mouse 13';
ABA.Mouse(14).Name = 'Mouse 14';
ABA.Mouse(15).Name = 'Mouse 15';
ABA.Mouse(16).Name = 'Mouse 16';

%Getting the mouse weight for each day
for n = 1:number_mice
    ABA.Mouse(n).MouseWeight = nan(length(ABA.Grouped),1);
    for m = 1:length(ABA.Grouped)
        ABA.Mouse(n).MouseWeight(m) = ABA.Grouped(m).TABLE.MouseWeightg930AM(n);
    end
end

%Getting the old food weight for adlib fed mice for each day (food that wasn't consumed and
%weighed in the morning).
for n = AdLib
    ABA.Mouse(n).OldFood = nan(length(ABA.Grouped),1);
    for m = 1:length(ABA.Grouped)
        ABA.Mouse(n).OldFood(m) = ABA.Grouped(m).TABLE.OldFoodWeightg930AM(n);
    end
end
clear n m

%Getting the old food weight for food restricted mice for each day (food
%that wasn't consumed and weighed at either 3:30PM or 12:30PM). The
%leftover food weighed at 12:30PM goes in the same column as 3:30PM.
for n = Restricted
    ABA.Mouse(n).OldFood = nan(length(ABA.Grouped),1);
    for m = 1:length(ABA.Grouped)
        if ABA.Grouped(m).DAY == "Acclimation" | ABA.Grouped(m).DAY == "Baseline"
            ABA.Mouse(n).OldFood(m) = ABA.Grouped(m).TABLE.OldFoodWeightg930AM(n);
        else
            if ABA.Grouped(m).DAY == "Restriction" & ABA.Grouped(m-1).DAY == "Baseline"
                ABA.Mouse(n).OldFood(m) = ABA.Grouped(m).TABLE.OldFoodWeightg930AM(n);
            else
                %This is done in a way to make the calculations easier. For
                %restricted mice the old food weight is actually the 3:30PM
                %or 12:30PM food weight from the day before. However, if I
                %do it like this then the math will be the same going
                %forward no matter what group I'm working with.
                ABA.Mouse(n).OldFood(m) = ABA.Grouped(m-1).TABLE.PostFoodWeightg330PM(n);
            end
        end
    end
end
clear n m

%Getting the new food weight for both adlib and food restricted mice for
%each day (food weighed and placed in the cage in the morning).
for n = 1:number_mice
    ABA.Mouse(n).NewFood = nan(length(ABA.Grouped),1);
    for m = 1:length(ABA.Grouped)
        ABA.Mouse(n).NewFood(m) = ABA.Grouped(m).TABLE.NewFoodWeightg930AM(n);
    end
end
clear n m

%Getting the water weight for both adlib and food restricted mice for each
%day (water in bottle weighed in the morning).
for n = 1:number_mice
    ABA.Mouse(n).Water = nan(length(ABA.Grouped),1);
    for m = 1:length(ABA.Grouped)
        ABA.Mouse(n).Water(m) = ABA.Grouped(m).TABLE.WaterWeightg930AM(n);
    end
end
clear n m

clear number_mice AdLib Restricted
%% 4. Change in weight

%Calulating the change in mouse weight for each day by subtracting the day
%before mouse weight from the current mouse weight.
for n = 1:length(ABA.Mouse)
    ABA.Mouse(n).MouseChange(1) = nan;
    for m = 2:length(ABA.Grouped)
        ABA.Mouse(n).MouseChange(m) = ABA.Mouse(n).MouseWeight(m) - ABA.Mouse(n).MouseWeight(m-1);
    end
end

%Calculating the food consumed for each day by subtracting the new food
%weight from the day before from the current old food weight.
for n = 1:length(ABA.Mouse)
    ABA.Mouse(n).FoodConsumed(1) = nan;
    for m = 2:length(ABA.Grouped)
        ABA.Mouse(n).FoodConsumed(m) = abs(ABA.Mouse(n).OldFood(m) - ABA.Mouse(n).NewFood(m-1));
    end
end
    
%Calculating the water consumed for each day by subtracting the day before
%water weight from the current day water weight.
for n = 1:length(ABA.Mouse)
    ABA.Mouse(n).WaterConsumed(1) = nan;
    for m = 2:length(ABA.Grouped)
        ABA.Mouse(n).WaterConsumed(m) = abs(ABA.Mouse(n).Water(m) - ABA.Mouse(n).Water(m-1));
    end
end

clear m n

%% 5. Finding the weight of mouse on last baseline day
% This can only be run once the mice have completed their last day of
% baseline.
if Today_date >= Restriction_day1
    for n = 1:length(ABA.Mouse)
        ABA.Mouse(n).endBaseline = ABA.Mouse(n).MouseWeight(9);
    end
    clear n
    %% 6. Calculating the Cut off (below 75% of body weight)
    %The cut off is calculated as 75% of the body weight of the mouse on the
    %last day of baseline.
    for n = 1:length(ABA.Mouse)
        ABA.Mouse(n).cutoff = ABA.Mouse(n).endBaseline * 0.75;
    end
    clear n
end
%% 7. Saving the structures as MATLAB files

cd(mouse_savedData1)
save(Structure);

cd(mouse_savedData2)
save(Structure);

%% 8. Plotting figures
cd(mouse_savedData1)
load(Structure);

% Mouse Weight, and Food Consumed
for n = 1:length(ABA.Mouse)
    figure;
    ax1 = subplot(2,1,1); hold on;
    plot([ABA.Grouped.DATE], ABA.Mouse(n).MouseWeight','b*');
    plot([ABA.Grouped.DATE], ABA.Mouse(n).MouseWeight', 'k-');
    if Today_date >= Restriction_day1
        plot([ABA.Grouped.DATE], (ones(1,length(ABA.Grouped)).* ABA.Mouse(n).cutoff), 'r-');
    end
    x1 = datetime(Acclimation_day1);
    x2 = datetime(Restriction_final);
    ylim([12 20]);
    xlim([x1,x2]);
    title(['Mouse weight over days of experiment of Mouse #' num2str(n) newline 'Final Baseline Weight of Mouse: ' num2str(ABA.Mouse(n).endBaseline) 'g' newline 'Cut Off is: ' num2str(ABA.Mouse(n).cutoff) 'g']);    ylabel('Mouse weight (g)');
    xlabel('Date');
    hold off
    ax2 = subplot(2,1,2); hold on;
    plot([ABA.Grouped.DATE], ABA.Mouse(n).FoodConsumed','b*');
    plot([ABA.Grouped.DATE], ABA.Mouse(n).FoodConsumed', 'k-');
    ylim([0 10]);
    title(['Food consumed over days of experiment of Mouse #' num2str(n)]);
    ylabel('Food consumed (g)');
    xlabel('Date');
    linkaxes([ax1, ax2], 'x');
    hold off
    
    %Saving figures
    cd(mouse_savedData1);
    saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
    cd(mouse_savedData2);
    saveas(gcf,['Mouse_' num2str(n) '_Weights.tif'])
end

clear n ax1 ax2 x1 x2
