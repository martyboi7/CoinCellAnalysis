%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     6th Nov 2020
% Version:  A1
% Status:   Working 

% Note:     
% Sample:   

%--------------------------------------------------------------------------
% Generic
%--------------------------------------------------------------------------

clear all
close all
addpath ../Functions

%--------------------------------------------------------------------------
% Control Panel
%--------------------------------------------------------------------------
% KEY THINGS TO CHANGE:
mass_active = [0.00141]; %active mass of sample (g) - MAKE SURE IS correct and there is the right number of them
cycles = [52]; %the number of cycles to plot. first cycles [2], specific numbers [1,2,4,5], sequence [1:5]
%  1,10,20,30,40,50
my_title = "Testing";
plot_mode = 6; % see below details of plot modes 
my_legend = {}; % use the 'entry_1', 'entry_2' notation

filepath_sample = ["C:\myfile.mpt"
                   ];

% Plot Modes: 
% 1 - Comparison of multiple formation charges.
% 2 - Discharge cycles of a single cell. Select how many cycles.
% 3 - Charge cycles of a single cell. Select how many cycles.
% 4 - Discharge cycles of a single cell. All the cycles.
% 5 - Charge cycles of a single cell. All the cycles.

% 6 - Mixed Discharge and Charge of a single cell. Select how many cycles.

%--------------------------------------
% Polarisation curve
legend_location = 'Northeast';
auto_numbering_string = 'Run ';    % what to call the entries on the graph if no legend entry provided

% Colors for comparison of different cells
my_color = [1.0, 0.0, 0.0;  %red
            1.0, 0.5, 0.1;  %orange
            0.0, 0.0, 1.0;  %blue
            0.5, 0.5, 0.1;
            0.1, 0.5, 0.1;   %dark green
            0.0, 0.0, 0.0   %black
            ];

% Capacity fade
my_title_fade = strcat(my_title, " Capacity Fade");

%--------------------------------------------------------------------------
% Execution
%--------------------------------------------------------------------------
% Runs the function - body of functions design
[polarization,capacity_fade,cell_data] = coinCellAnalysis(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color);

clear auto_numbering_string cycles dataLines filepath_sample legend_location my_legend my_title plot_mode
clear my_color
