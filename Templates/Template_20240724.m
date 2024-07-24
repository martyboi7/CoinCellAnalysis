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
% clear all
% close all

% Fast Loop
my_selection_previous = [];
clearvars -except my_selection_previous cell_data % keep these (because importing is most time consuming)
% close all

addpath ../../Functions ../../Functions/Tian2019bRegression_20210707/ ../../Cell_Details/
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

%----------------------
% 2. Cell Number Selection
%----------------------
% NEW ADDITIONS
% my_selection = [21:25]; % CC9 P3 0.8V 21:25
% my_selection = [54:56,69:71]; % 230311_BaseP_MoS2 single spacer vs. double (24/07/2023)
% my_selection = [69:71]; % CC14 (18/08/2023) - base line 
% my_selection = [72:74]; % CC15 (18/08/2023) - double spacer
% my_selection = [75:81]; % CC16 (25/09/2023) - EPD
% my_selection = [76]; % CC16 (25/09/2023) - EPD (Thesis Order) [76,78,77,79:81]
% my_selection = [82:84]; % CC17 (25/09/2023) - CMC
% my_selection = [82:84,76:81]; % CC16 (25/09/2023) - EPD

% PROTOCOL P1
% my_selection = [1:3,10:12]; % CC10 - P1 0.80 V and 0.01 V
% my_selection = [1:12]; % CC10 - P1 all 
% my_selection = [1:3]; % CC10 - P1 0.01 V
% my_selection = [10:12]; % CC10 - P1 0.8 V
% my_selection = [4:6]; % CC10 - P1 0.4 V
% my_selection = [63:65,51:53,57:58]; % P1 0.8 V (CC13) 63:65,51:53,57:58,61
% my_selection = [67:68,54:56,59:60,62]; % P1 0.01 V (CC13) 66:68,54:56,59:60,62
% my_selection = [63:65]; % 0.8V  CC13
% my_selection = [67,68]; % 0.01V CC13
% my_selection = [85:90]; % CC18 - Formation 10 mA/g
% my_selection = [88:90]; % CC18 - Formation 10 mA/g (0.8V) 51:53,88:90
% my_selection = [87]; % CC18 - Formation 10 mA/g (0.01V) 54:56,85:87

% ACTIVATION P2
% my_selection = [13:18]; % Paper - P2 (01/03/2023) 1:3,10:18
% my_selection = [1:3,10:18]; % Paper - P2 (01/03/2023) 1:3,10:18
% my_selection = [1,3,10:12,13,15:18]; % P1 and P2 comparison
% my_selection = [1,3,13,15:18]; % P1 and P2 comparison
% my_selection = [1:18]; % ALL CC10
% my_selection = [1:3,13:18];
% my_selection = [13]; % P2 0.8V [13,15]
% my_selection = [16:18]; % P2 1.5 V

% VOLTAGE HOLD P3
% 220722_BaseP_MoS2 (25um)
% my_selection = [21:24]; % CC9-P3 (11/10/2022)
% my_selection = [22,24]; % CC9-P3 (11/10/2022)
% my_selection = [21:25]; % CC9-P3 (23/10/2023)
% my_selection = [34,22,21,24,23,25]; % CC9-P3 (23/10/2023)
% my_selection = [11,24,23,25]; % CC9-P3 (23/10/2023) 0.8 V
% my_selection = [29,51:53,24,23,25];  % CC13 0.8 V vs Voltage hold 0.8 V
% my_selection = [51:52,29,24,23,25]; % CC13 0.8 V vs Voltage hold
% my_selection = [54,56,22,21]; % CC13 0.01 V vs Voltage hold 0.01 V
% 201216_BaseP_MoS2 (20wt%)
% my_selection = [26,27];
% 220815_BaseP_MoS2 (25um)
% my_selection = [28:32]; % CC12-P3 (23/10/2023)
% my_selection = [29,32]; % CC12-P3 (23/10/2023)
% my_selection = [32]; % CC12-P3 (23/10/2023)
% 2230301_BaseP_MoS2 (36 um)
% my_selection = [54:56,71,51:53,69,70]; % CC13 vs. CC14
% my_selection = [51,69,70]; % CC13 vs. CC14 0.8 V [51:53,69,70]
% my_selection = [54:56,71]; % CC13 vs. CC14 0.01 V
% my_selection = [69:71]; % CC14 - P3 all
% my_selection = [51,69,70]; % CC14 - 0.8 V
% ALL
% my_selection = [21,22,31,71]; % 0.01 V P3
% my_selection = [23:25,32,69,70]; % 0.8 V P3
% my_selection = [24,25,23,69,70]; % 0.8 V P3
% Thesis - selection
% my_selection = [34,22,21]; % CC5 - 0.01 V 
% my_selection = [24,23,25]; % CC5 - 0.80 V 

% LOW VOLTAGE P4
% my_selection = [40,46,30]; % CC9 - 1.80 V
% my_selection = [91:93]; % CC22 - 1.80 V [54:56,91:93]

% THICKNESS
% my_selection = [33:38]; % CC11 A1 (11/10/2022)
% my_selection = [39:43]; % CC11 - A2 (3.0-0.01V) [39:44];
% my_selection = [45:49]; % CC11 - A3 (3.0-0.8V)
% my_selection = [51:56]; % CC13 - A1 (25 um)
% my_selection = [57:62]; % CC13 - A2 (50 um)
% my_selection = [63:68]; % CC13 - A3 ( 10 um)
% my_selection = [63:65,51:53,57:58,61]; % CC13 - 0.8 V mA/mg
% my_selection = [66:68,54:56,59:60,62]; % CC13 - 0.01 V mA/mg

% Pressure Cells 
% my_selection = [54:56,72:74]; % CC15 vs CC13
% my_selection = [72:74]; % CC15

% CMC Electrodes
% my_selection = [82:84]; % CC17 (25/09/2023) - CMC
% my_selection = [54:56,82:84]; % CC17 (25/09/2023) - CMC


% TESTING
% my_selection = [31,25]; % for testing 
% my_selection = [34];
% my_selection = [21,1,13,26]; % BIO incomplete, NEWARE, NEWARE P2, BIO,  - for testing 
%need a file with UNfinished C data as well (e.g only D done and no C for
%final cycle) 1,4, - 21,1,13,26
% my_selection = [32];
% my_selection = [85:90];
% my_selection = [54,56,22,21]; % CC13 0.01 V vs Voltage hold
% my_selection = [51:52,24,23,25]; % CC13 0.8 V vs Voltage hold
% my_selection = [69,70]; 


% testing 
% my_selection = [34,35];
% my_selection = [1];
% my_selection = [39]; % CC11-A1 10 um

%----------------------
% 3. Cycle Number Selection
%----------------------
%the number of cycles to plot. first cycles [2], specific numbers [1,2,4,5], sequence [1:5]

% Formation / dQdV
% cycles = [1:10];
% cycles = [1:30];
% cycles = [1:50];
% cycles = [1:10,20:10:100];
% cycles = [1:10,20:10:100,200:100:500]; % polarisation (Paper Edition - shorter)
% cycles = [1,10,20,30,50,100:100:500]; % dQdV
% cycles = [1:10,20,30,50,100:100:500]; % dQdV - extended 
% cycles = [1,50,100:10:300]; % CV 0.8 V D100-D300
% cycles = [1:50,60:10:100,200:100:500]; % CV D1-D50
% cycles = [2:50,60:10:100,200:100:500]; % CV D2-D50
% cycles = [1:5,10,50,100];

% Special Cases
% cycles = [466:468]; % Special case
% cycles = [466:478]; % Special case
% cycles = [460:470]; % Special case
% cycles = [100,200,300,400,450,460,466,478,500];
% cycles = [350,400,410,420,430,440,450,460,470,480];
% cycles = [50,100,250:300]; % dQdV - spacer cells
% cycles = [50,100,400:450]; % dQdV - spacer cells
% cycles = [1,2,5,10];
% cycles = [26,27,40,50]; % 1,5,10,20,30,31,40,50
% cycles = [5,20:35];

% CC Degradation Cycles
% cycles = []; % all
% cycles = 100;
% cycles = 400;
% cycles = [1,50,100,200,250,300,350,400,450,500];
% cycles = [100,500];
% cycles = [1,100,500];
% cycles = [1,50,500];

% dQdV 
% cycles = 1;
% cycles = 2;
% cycles = 3;
% cycles = 5;
% cycles = 8;
% cycles = 10;
% cycles = 11;
% cycles = 15;
% cycles = 20;
% cycles = 21;

% CC Degradation Tiled Plot
% cycles = [1,100,500];
% cycles = [100:500];

% Code Testing - uniform process 
% cycles = [1,5,10];
% cycles = 1:20;
% cycles = 97;
% cycles = [];
% cycles = 100;
% cycles = 150;
% cycles = 500;

%----------------------
% 4. * Tian2019 Regression *
%----------------------
Tian2019_input = Tian_regression_parameters(my_title);

%----------------------
% 5. * dQdV Analysis*
%----------------------
% dQdV_conditions = {2e3,25}; % 2e3,25
% what these settings mean: 
% 1. ACTIVE - alex_factor - compression limit for dQdV peaks (upper limit
% to values)
% 2. ACTIVE - y - space factor. Used in the calculation of dQ(n) = Q(n) -
% Q(n-y). Same for dV. OG value = 100

%--------------------------------------------------------------------------
% Call to Function
%--------------------------------------------------------------------------
% Runs the function - body of functions design
[polarization,capacity_fade,eis_profile,additional_figure,cell_data,my_selection_previous] = trigger_coinCellAnalysis(plot_mode,pc_choice,data_choice,my_selection,my_selection_previous,cycles,CV_edge_limit,my_title,Tian2019_input,legend_location,auto_numbering_string,dQdV_conditions,print_loop_singleCELLS,mygraph_linewidth);
