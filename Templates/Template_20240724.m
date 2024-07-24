%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     7th June 2022
% Version:  A1
% Status:   Working 

% Note:     
% Sample:   See CellDetails Excel

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
%----------------------
% 1. Plot Mode
%----------------------
plot_mode = 8; % see below details of plot modes 
% Main ones: 1 V discharge, 2 V charge, 14 dQdV, 23 dQdV MultiCELL, 17 CV, 26 CV MultiCELL, 8 CAPACITY, 37 tiled
% Capacity, 47 Areal Capacity, 57 tiled Areal Capacity, 16 Time (all cells), 

% Testing 
% cycles = [];
% cycles = 1;
% cycles = 5;
% cycles = [1,2,5];
% cycles = [1:10]; % testing
% cycles = [1:100];
cycles = [1:500];
% cycles = [1,100,500];
% cycles = [1:100];
% cycles = [1:10,20:10:100];
% cycles = [1:10,20:10:100,200:100:500]; % D1-D10 1:10,200:100:500
% cycles = [2:10,20:10:100,200:100:500]; % D2-D10
% cycles = [1,10,20,30,50,100:100:500]; % D1-D10 1.80 V
% cycles = [20,30:35]; % CC5
% cycles = [20,26:31]; % CC5

% Depth of discharge CC1
% my_selection = [1]; % [1,13,39]
% my_selection = [1:12]; % CC1 - PR1 all
% my_selection = [1:3]; % CC1 - PR1 0.01 V
% my_selection = [10:12]; % CC1 - PR1 0.80 V

% Thickness Set CC2
% my_selection = [39:43]; % CC11-A2 0.01 V 
% my_selection = [45:49]; % CC11-A3 0.80 V 

% Thickness (12, 36, 87) CC2
% my_selection = [57:58,61]; % CC13 - 0.8 V mA/mg [63:65,51:53,57:58,61];
% my_selection = [63:65,51:53,57:58,61]; % CC13 - 0.8 V mA/mg [63:65,51:53,57:58,61];
% my_selection = [67:68,54:56,59:60,62]; % CC13 - 0.01 V mA/mg [66:68,54:56,59:60,62];
% my_selection = [40]; % 39:41

% Capacitance
% my_selection = [91:93]; % CC22 - 1.80 V [54:56,91:93]

% Activation CC4 PR2
% my_selection = [1,3,16:18,13,15]; % CC1-PR2 [1:3,10:12,16:18,13:15]
% my_selection = [16:18,13:15]; % CC1-PR2 [16:18,13:15]

% Alternative Cycling Protocols
% my_selection = [85:87]; % Formation CC5 [85:87,88:90]
% my_selection = [54:56,72:74]; % Double spacer
% my_selection = [54:56,82:84]; % CMC
% my_selection = [22,21]; % Voltage Hold CC6 - 0.01 V [34,22,21]
% my_selection = [24,23,25]; % Voltage Hold CC6 - 0.80 V 
% my_selection = [54]; % Voltage Hold CC6 54
% my_selection = [51,23]; % Voltage Hold CC6 0.8 V [51,24,23,25]
% my_selection = [69,70]; % Voltage Hold CC6

% EPD
% my_selection = [76]; % CC16 (25/09/2023) - EPD (Thesis Order) [76,78,77,79:81]
% my_selection = [82:84]; % CC17 (25/09/2023) - CMC
% my_selection = [82:84,76,78,77,79:81];

% Other
% my_selection = [67:68,54:56];
my_selection = [40];

% TESTING
% my_selection = [13]; % for testing 
% my_selection = [21,13]; % P3
% my_selection = [21,1,13,26]; % BIO incomplete, NEWARE, NEWARE P2, BIO,  - for testing 
%need a file with UNfinished C data as well (e.g only D done and no C for
%final cycle) 1,4, - 21,1,13,26

%--------------------------------------------------------------------------
% dQdV Conditions
% dQdV_conditions = {Current density limit (mA/g) for y axis, backwards
% derivative number of points taken, edge number of points removed, edge - voltage amount removed}
dQdV_conditions = {2e3,25,0,0.0}; % for thesis methods 
% dQdV_conditions = {2e3,25,0,0.01}; % 2e3,25 % for 0.8 V
% dQdV_conditions = {2e3,100,0,0.01}; % 2e3,100 % for 0.01 V

data_choice = 4; % 1 - CC/R, 2 - EX, 3 - CV, 4 - QMU CC10, 5 - EIS
pc_choice = 1; % PCs: 1 - Gaming, 2 - UCL Laptop, 3 - Dad PC (does not work)
print_loop_singleCELLS = true; % SINGLECells - whether to loop all options in my_selection into separate figures
% my_title = "Date: 11/01/2023 Code DEVELOPMENT ";
my_title = ""; % 11/03/2024 
legend_location = 'Northeast';
auto_numbering_string = 'Cycle ';
mygraph_linewidth = 1.0;

% CV Settings
mycv_voltagelimit_low = []; % if empty - take min
mycv_voltagelimit_high = [3.00]; % if empty - take max
CV_edge_limit = 100; % cuts the ends of by X to avoid trailing edges

%--------------------------------------------------------------------------
% Call to Function
%--------------------------------------------------------------------------
% Runs the function - body of functions design
[polarization,capacity_fade,eis_profile,additional_figure,cell_data] = trigger_coinCellAnalysis(plot_mode,pc_choice,data_choice,my_selection,cycles,CV_edge_limit,my_title,legend_location,auto_numbering_string,dQdV_conditions,print_loop_singleCELLS,mygraph_linewidth);
