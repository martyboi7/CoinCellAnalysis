%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     4th April 2020
% Version:  A1
% Status:   Works

% Note: Generic Battery Function - Body of Functions 

%--------------------------------------------------------------------------
% Architecture - outdated!
%--------------------------------------------------------------------------
    % Input Handling - Switch nargin
        
    % Import data - cell_data (Cell ARRAY)
    

            
%--------------------------------------------------------------------------
% Function 
%--------------------------------------------------------------------------
function [Polarization,capacity_fade,eis_profile,additional_figure,cell_data] = coinCellAnalysis2(filepath_sample,mass_active,sample_diameter,plot_mode,cycles,import_data,CV_edge_limit,my_legend,my_title,legend_location,auto_numbering_string,my_color,Tian2019_input,dQdV_conditions,sample_per_CYCLE_EIS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high)
%--------------------------------------
% Input Handling
%--------------------------------------
% filepath_sample,
% mass_active,
% sample_diameter,
% plot_mode,
% cycles,
% import_data
% CV_edge_limit
% my_legend,
% my_title,
% legend_location,
% auto_numbering_string,
% my_color,
Tian2019_input_fixed = Tian_regression_parameters(my_title);
dQdV_conditions_fixed = {2e3,10};
sample_per_CYCLE_EIS_fixed = [];
mygraph_linewidth_fixed = 1;
mycv_voltagelimit_low_fixed = [];
mycv_voltagelimit_high_fixed = [3.00];

switch nargin
    case {1,2,3,4,5,6,7,8,9,10,11,12}
        disp('Error - coinCellAnalysis2: insufficient input parameters!')
        return
    case 13
        Tian2019_input = Tian2019_input_fixed;
        dQdV_conditions = dQdV_conditions_fixed;
        sample_per_CYCLE_EIS = sample_per_CYCLE_EIS_fixed;
        mygraph_linewidth = mygraph_linewidth_fixed;
        mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 14 
        dQdV_conditions = dQdV_conditions_fixed;
        sample_per_CYCLE_EIS = sample_per_CYCLE_EIS_fixed;
        mygraph_linewidth = mygraph_linewidth_fixed;
        mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 15        
        sample_per_CYCLE_EIS = sample_per_CYCLE_EIS_fixed;
        mygraph_linewidth = mygraph_linewidth_fixed;
        mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 16
        mygraph_linewidth = mygraph_linewidth_fixed;  
        mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 17
        mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 18
        mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
end % switch - input handling (nargin)

%--------------------------------------
    % New Split System
%--------------------------------------

    [~,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode);

%--------------------------------------------------------------------------
% Operations
%--------------------------------------------------------------------------
    %--------------------------------------
    % Import the data
    %--------------------------------------
    % Just gets the data - no processing or splitting happening!!!
    num_entries = length(filepath_sample); % the number of data sets used in the analysis
    disp('coinCellAnalysis2')
    disp('---------------------')
    disp('       -----------------------')
    disp('       IMPORTED DATA')
    disp('       -----------------------')

    [row_raw_data,row_cycles,row_cycles_clean] = getmy_celldata_rows();

if(import_data == 1)
    for i = 1:num_entries
        % RAW Data: Voltage(V),Time(s),Capacity(mAh/g),Current Density(mA/g), Halfcycle/Other,dQdV/EIS 
        [cell_data{row_raw_data,i},my_source(1,i)] = import_cell_data_cycle(filepath_sample(i),mass_active(i),sample_diameter(i),plot_mode); % developing 09/02/2023
%         disp('import_cell_data_cycle')
        % CYCLE by CYCLE split data (includes Zero capacity, rest, and voltage bounce back)
        cell_data{row_cycles,i} = output_processing(cell_data{1,i},my_source(1,i),plot_mode,sample_per_CYCLE_EIS,mycv_voltagelimit_low,mycv_voltagelimit_high); % DEVELOPING 15/12/2022

        switch plot_mode_code 
            case {14,24,35} % CV
                cell_data{row_cycles_clean,i} = output_clean_cycle_CV(cell_data{2,i},my_source(1,i));
            otherwise % cannot be applied to CV data
                % Only Capacity (remove all the Zero current density spots)
                cell_data{row_cycles_clean,i} = output_clean_cycle(cell_data{2,i},my_source(1,i));
        end % switch statement - plot_mode_code

    end % for loop - i (num_entries)
    
    disp(strcat('       number of entries: ',num2str(num_entries)))
    disp('       -----------------------')
    %--------------------------------------
else % assign old data
    cell_data = cell_data_old;
    my_source = my_source_old;

end % import - data


%     % test - for CV (the number fo halfcycles actually present)
%     data_test = cell_data{1,1};
%     halfcycle_data_test = data_test(:,5);
%     halfcycle_data_test_unique = unique(halfcycle_data_test);
%     halfcycle_data_test_unique_count = length(halfcycle_data_test_unique)
    
    %--------------------------------------
    % Data Processing - to be eleminated (once Case 12 built within
    % framework)
    %--------------------------------------
    % Testing 
    switch plot_mode % switch 9 - plot_mode. mydata, mydata_trimmed 
        case{12} % SINGLECells 
                % Send to function to get us the right data to plot
                
                mydata = cell_data{1,1};
    end % switch 9 - plot_mode. mydata, mydata_trimmed 

%--------------------------------------------------------------------------
% Plots - Decision Hierarchy
%--------------------------------------------------------------------------
%----------------------------------------------------------
switch plot_mode_multi %  switch 1 - plot_mode (master)
%----------------------------------------------------------
    case {1,2} % SINGLE Cells or MULTICELL Polarization
    %--------------------------------------
        [Polarization,eis_profile,additional_figure,cell_data] = my_polarisation_profile(cell_data,num_entries,plot_mode,my_source,cycles,CV_edge_limit,my_color,my_title,my_legend,auto_numbering_string,legend_location,dQdV_conditions,mygraph_linewidth);
        capacity_fade = 0; % makes empty dummy fig.
    %--------------------------------------
    case 3 % MULTICell: DEGRADATION only
    %--------------------------------------
         Polarization = 0; % makes empty dummy fig. 
         eis_profile = 0; % makes empty dummy fig. 
         additional_figure = 0; % makes empty dummy fig. 
         [capacity_fade,cell_data] = my_capacity_fade(plot_mode,cell_data,num_entries,my_source,cycles,my_color,my_title,my_legend,filepath_sample,auto_numbering_string,legend_location);

     % ** MOVE Into FRAMEWORK
%     %--------------------------------------
%     case{12} %Tian2019b style regression
%     %--------------------------------------
%         
%         Polarization = 0; % makes empty dummy fig.
%         discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color(1,:),plot_mode);
%         
%          % Current density at beginning and end of cycle are 0. Cannot
%          % use those. Use the max value to overcome (as high A/g tests have
%          % many zero values and median cannot combat this.
%             for f = 1:length(mydata_trimmed)
%                 intermediate_var = mydata_trimmed{1,f};
%                 current_density_cycle(f,1) = mean(nonzeros(abs(intermediate_var(:,3))));
%             end 
%         
%         %Tian2019b Model fig
%         capacity_fade = cycling_data_processing(Tian2019_input,current_density_cycle(1:2:end),discharge_capacity);
    %--------------------------------------
    otherwise %switch 1 - plot_mode
    %--------------------------------------
        disp(['Error: coinCellAnalysis2 (swtich 1 - otherwise) - Option not available. plot_mode: ', num2str(plot_mode)]);
        Polarization = false;
        capacity_fade = false; 
        cell_data = 1;
        return

end %switch 1 - plot_mode_switch 
        
end % funtion (master)
