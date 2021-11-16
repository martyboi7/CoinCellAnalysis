%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov (please Cite)
% Date:     16th Nov 2021 
% Version:  A1
% Status:   Working 

% Note:     
% Sample:   

%--------------------------------------------------------------------------
% Plot Modes: 
%--------------------------------------------------------------------------
% Single Cell (Polarization and Degradation)

% 1 - Discharge cycles of a single cell. Select how many cycles.
% 2 - Charge cycles of a single cell. Select how many cycles.
% 3 - Discharge cycles of a single cell. All the cycles.
% 4 - Charge cycles of a single cell. All the cycles.
% 5 - Mixed Discharge and Charge of a single cell. Select how many cycles.

% Multi Cell - Polarization
% 6 - Comparison of multiple cells - single discharge.
% 7 - Comparison of multiple cells - single charge.

% Multi-Cell - Degradation
% 8. Degradation Comparison Discharge (LSV)
% 9. Degaradation Comparison Discharge (LSV) - Tiled plot with current
% densities 
% 10. Degradation Comparison Charge
% 11. Degradation Comparison Discharge/Charge

% Single Cell - Rate Data (CURRENTLY NOT FUNCTIONAL)
% 12. Tian2019 Regression
% 13. dQ/dV

%--------------------------------------------------------------------------
% Generic
%--------------------------------------------------------------------------

clear all
close all
addpath ../Functions
%--------------------------------------------------------------------------
% Control Panel
%--------------------------------------------------------------------------
% KEY ANALYSIS PARAMETERS:
plot_mode = 13; % see above what the different plot modes do ^
mass_active = [0.001846257,0.00134249]; %active mass of sample (g) - MAKE SURE there is equal number of active masses as filepaths 
my_selection = [1,2]; % pick which filepaths to plot
% cycles = [1,2,5,10,50]; %the number of cycles to plot. first cycles [2], specific numbers [1,2,4,5], sequence [1:5]
cycles = 100;

% Figure Accessories 
my_title = {'Testing 1'};
my_legend = {'cell-1','cell-2'}; % use the 'entry_1', 'entry_2' notation
legend_location = 'Northeast';
auto_numbering_string = 'Run ';    % what to call the entries on the graph if no legend entry provide
my_title_fade = strcat(my_title, " Capacity Fade");

% Filepaths 
filepath_sample = ["D:\OneDrive\mycell1.mpt"
                   "D:\OneDrive\mycell2.mpt"
                   ];

%--------------------------------------
% Colors for comparison of different cells
my_color = [1.0, 0.0, 0.0;  %red
            1.0, 0.5, 0.1;  %orange
            0.0, 0.0, 1.0;  %blue
            0.5, 0.5, 0.1;
            0.1, 0.5, 0.1;   %dark green
            0.0, 0.0, 0.0   %black
            ];
%--------------------------------------------------------------------------
% Execution
%--------------------------------------------------------------------------
% Runs the function - body of functions design
[polarization,capacity_fade,cell_data] = trigger_coinCellAnalysis(filepath_sample,mass_active,plot_mode,my_selection,cycles,my_color,my_title,my_legend,0,legend_location,auto_numbering_string,0);

clear auto_numbering_string cycles dataLines filepath_sample legend_location my_legend my_title plot_mode
clear my_color
