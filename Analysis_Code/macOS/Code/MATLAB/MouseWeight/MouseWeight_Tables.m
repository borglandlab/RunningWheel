%{
This script should be run at the end of the experiment to get tables that
can be copied into graphpad prism for statisical analysis.

1. Opening Structure that contains mouse data
2. Creating a table for the Daily weight of mouse.
3. Creating a table for the Daily Food Consumption
4. Creating a table for the Daily Water Consumption
5. Creating percent of baseline weights tables (of the last day of baseline)
6. Getting the food and water consumed in g/kg of mouse weight
7. Writing tables to excel

The first row on the mouse weight table should not be included, as this is
the weight on day one of acclimation. The last day of the experiment should
also not be included as that is day 8 of the 3 hour food access
restriction, and the experiment only includes 7 days. This is not a problem
for food and water consumption. I have not removed these days in the code,
so you will need to manually do this afterwards.
%}

%% 1. Opening Structure that contains mouse data

addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB')    
addpath('/Users/<USERNAME>/Documents/MATLAB/MATLAB/RunningWheel')
mouse_savedData2 = '/Users/<USERNAME>/Dropbox/RunningWheel/';    %This is where the excel file is being stored where we are entering in the data (Dropbox for us).
% It is also the secondary location where I am saving my running wheel data.
mouse_savedData1 = '/Users/<USERNAME>/Desktop/RunningWheel/Wheel_Data/'; 

Structure = 'ABA_weight.mat';
Main_table = 'RunningWheel_tables.xlsx';

cd(mouse_savedData2)
load(Structure)

%This will determine how the data is sorted into tables:
AdLibWheel_index = [1 5 9 13];    %ControlWheel are mice with ad libitum chow and a running wheel
AdLibDummy_index = [2 6 10 14];   %Mice with ad libitum chow and a dummy wheel
RestrictedWheel_index = [3 7 11 15];    %Mice that are food restricted and a running wheel
RestrictedDummy_index = [4 8 12 16];    %Mice that are food restricted and a dummy wheel

%% 2. Creating a table for the Daily weight of mouse.
%Start by creating matrices for the each group, and then combine matrices to create a table.

AdLibDummy_mouseweight = [];
for n = 1:4
    AdLibDummy_mouseweight = [AdLibDummy_mouseweight [ABA.Mouse(AdLibDummy_index(n)).MouseWeight]];
end

AdLibWheel_mouseweight = [];
for n = 1:4
    AdLibWheel_mouseweight = [AdLibWheel_mouseweight [ABA.Mouse(AdLibWheel_index(n)).MouseWeight]];
end

RestrictedDummy_mouseweight = [];
for n = 1:4
    RestrictedDummy_mouseweight = [RestrictedDummy_mouseweight [ABA.Mouse(RestrictedDummy_index(n)).MouseWeight]];
end

RestrictedWheel_mouseweight = [];
for n = 1:4
    RestrictedWheel_mouseweight = [RestrictedWheel_mouseweight [ABA.Mouse(RestrictedWheel_index(n)).MouseWeight]];
end

%Combining matrices to make one table
ABA(1).Tables.mouseweight = array2table([AdLibWheel_mouseweight AdLibDummy_mouseweight RestrictedWheel_mouseweight RestrictedDummy_mouseweight]);

%Adding variable names to the tables
ABA(1).Tables.mouseweight.Properties.VariableNames = Groups_variables;

%Clearing variables that I no long need
clear n AdLibWheel_mouseweight RestrictedWheel_mouseweight
clear AdLibDummy_mouseweight RestrictedDummy_mouseweight

%% 3. Creating a table for the Daily Food Consumption

AdLibDummy_foodconsumed = [];
for n = 1:4
    AdLibDummy_foodconsumed = [AdLibDummy_foodconsumed [ABA.Mouse(AdLibDummy_index(n)).FoodConsumed]'];
end

AdLibWheel_foodconsumed = [];
for n = 1:4
    AdLibWheel_foodconsumed = [AdLibWheel_foodconsumed [ABA.Mouse(AdLibWheel_index(n)).FoodConsumed]'];
end

RestrictedDummy_foodconsumed = [];
for n = 1:4
    RestrictedDummy_foodconsumed = [RestrictedDummy_foodconsumed [ABA.Mouse(RestrictedDummy_index(n)).FoodConsumed]'];
end

RestrictedWheel_foodconsumed = [];
for n = 1:4
    RestrictedWheel_foodconsumed = [RestrictedWheel_foodconsumed [ABA.Mouse(RestrictedWheel_index(n)).FoodConsumed]'];
end

ABA(1).Tables.foodconsumed = array2table([AdLibWheel_foodconsumed AdLibDummy_foodconsumed RestrictedWheel_foodconsumed RestrictedDummy_foodconsumed]);

ABA(1).Tables.foodconsumed.Properties.VariableNames = Groups_variables;

clear n AdLibABA_foodconsumed RestrictedABA_foodconsumed
clear AdLibDummy_foodconsumed RestrictedDummy_foodconsumed

%% 4. Creating a table for the Daily Water Consumption

AdLibDummy_waterconsumed = [];
for n = 1:4
    AdLibDummy_waterconsumed = [AdLibDummy_waterconsumed [ABA.Mouse(AdLibDummy_index(n)).WaterConsumed]'];
end

AdLibWheel_waterconsumed = [];
for n = 1:4
    AdLibWheel_waterconsumed = [AdLibWheel_waterconsumed [ABA.Mouse(AdLibWheel_index(n)).WaterConsumed]'];
end

RestrictedDummy_waterconsumed = [];
for n = 1:4
    RestrictedDummy_waterconsumed = [RestrictedDummy_waterconsumed [ABA.Mouse(RestrictedDummy_index(n)).WaterConsumed]'];
end

RestrictedWheel_waterconsumed = [];
for n = 1:4
    RestrictedWheel_waterconsumed = [RestrictedWheel_waterconsumed [ABA.Mouse(RestrictedWheel_index(n)).WaterConsumed]'];
end

ABA(1).Tables.waterconsumed = array2table([AdLibWheel_waterconsumed AdLibDummy_waterconsumed RestrictedWheel_waterconsumed RestrictedDummy_waterconsumed]);

ABA(1).Tables.waterconsumed.Properties.VariableNames = Groups_variables;

clear n AdLibWheel_waterconsumed RestrictedWheel_waterconsumed
clear AdLibDummy_waterconsumed RestrictedDummy_waterconsumed

%Saving new structures with tables as matlab files
cd(mouse_savedData1)
save(Structure);
cd(mouse_savedData2)
save(Structure)

%% 5. Creating percent of baseline weights tables (of the last day of baseline)

% The last day of baseline is the 8th day on the table, since the first day
% is actually the acclimation period.

% Normalized mouse weight
Normalized = nan(height(ABA.Tables.mouseweight), width(ABA.Tables.mouseweight));

for n = 1 : width(ABA.Tables.mouseweight)
    normalized = (table2array(ABA.Tables.mouseweight(:,n)) / table2array(ABA.Tables.mouseweight(8,n))) .* 100;
    Normalized(:,n) = normalized;
end

ABA(1).Tables.mouseweight_normalized = array2table(Normalized);
ABA(1).Tables.mouseweight_normalized.Properties.VariableNames = Groups_variables;

clear n normalized Normalized

% Normalized food consumption
Normalized = nan(height(ABA.Tables.foodconsumed), width(ABA.Tables.foodconsumed));

for n = 1 : width(ABA.Tables.foodconsumed)
    normalized = (table2array(ABA.Tables.foodconsumed(:,n)) / table2array(ABA.Tables.foodconsumed(9,n))) .* 100;
    Normalized(:,n) = normalized;
end

ABA(1).Tables.foodconsumed_normalized = array2table(Normalized);
ABA(1).Tables.foodconsumed_normalized.Properties.VariableNames = Groups_variables;

clear n normalized Normalized

% Normalized water consumption
Normalized = nan(height(ABA.Tables.waterconsumed), width(ABA.Tables.waterconsumed));

for n = 1 : width(ABA.Tables.waterconsumed)
    normalized = (table2array(ABA.Tables.waterconsumed(:,n)) / table2array(ABA.Tables.waterconsumed(9,n))) .* 100;
    Normalized(:,n) = normalized;
end

ABA(1).Tables.waterconsumed_normalized = array2table(Normalized);
ABA(1).Tables.waterconsumed_normalized.Properties.VariableNames = Groups_variables;

clear n normalized Normalized

%Saving new structures with tables as matlab files
cd(mouse_savedData1)
save(Structure);
cd(mouse_savedData2)
save(Structure)

%% 6. Getting the food and water consumed in g/kg of mouse weight

% Food consumption (g/kg of mouse weight)
food_g_kg = nan(height(ABA.Tables.foodconsumed)-2, width(ABA.Tables.foodconsumed));

for n = 1 : width(ABA.Tables.foodconsumed)
    g_kg = (table2array(ABA.Tables.foodconsumed(3:19,n))) ./ (table2array(ABA.Tables.mouseweight(2:18,n)) ./ 1000);
    food_g_kg(:,n) = g_kg;
end

ABA(1).Tables.foodconsumed_g_kg = array2table(food_g_kg);
ABA(1).Tables.foodconsumed_g_kg.Properties.VariableNames = Groups_variables;

clear n g_kg food_g_kg


% Water consumption (g/kg of mouse weight)
water_g_kg = nan(height(ABA.Tables.waterconsumed)-2, width(ABA.Tables.waterconsumed));

for n = 1 : width(ABA.Tables.waterconsumed)
    g_kg = (table2array(ABA.Tables.waterconsumed(3:19,n))) ./ (table2array(ABA.Tables.mouseweight(2:18,n)) ./ 1000);
    water_g_kg(:,n) = g_kg;
end

ABA(1).Tables.waterconsumed_g_kg = array2table(water_g_kg);
ABA(1).Tables.waterconsumed_g_kg.Properties.VariableNames = Groups_variables;

clear n g_kg water_g_kg

%Saving new structures with tables as matlab files
cd(mouse_savedData1)
save(Structure);
cd(mouse_savedData2)
save(Structure)
%% 7. Writing tables to excel
cd(mouse_savedData1)    %Selecting my primary location.

%Writing tables to excel sheets
writetable(ABA(1).Tables.mouseweight,Main_table,'Sheet','mouseweight','Range','A1');
writetable(ABA(1).Tables.foodconsumed,Main_table,'Sheet','foodconsumed','Range','A1');
writetable(ABA(1).Tables.waterconsumed,Main_table,'Sheet','waterconsumed','Range','A1');
writetable(ABA(1).Tables.mouseweight_normalized,Main_table,'Sheet','mouseweight_normalized','Range','A1');
writetable(ABA(1).Tables.foodconsumed_normalized,Main_table,'Sheet','foodconsumed_normalized','Range','A1');
writetable(ABA(1).Tables.waterconsumed_normalized,Main_table,'Sheet','waterconsumed_normalized','Range','A1');
writetable(ABA(1).Tables.foodconsumed_g_kg,Main_table,'Sheet','foodconsumed_g_kg','Range','A1');
writetable(ABA(1).Tables.waterconsumed_g_kg,Main_table,'Sheet','waterconsumed_g_kg','Range','A1');