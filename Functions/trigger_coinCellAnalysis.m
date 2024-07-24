%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     6th Feb 2021
% Version:  A1
% Status:   Works

% Note: Lazy Call to coinCellAnalysis.m

%--------------------------------------------------------------------------
% Input Handling
%--------------------------------------------------------------------------
function [polarization,capacity_fade,eis_profile,additional_figure,cell_data]=trigger_coinCellAnalysis(plot_mode,pc_choice,data_choice,my_selection,cycles,CV_edge_limit,my_title,legend_location,auto_numbering_string,dQdV_conditions,print_loop_singleCELLS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high)

disp('-------------------------')
disp('trigger_coinCellAnalysis')
disp('-------------------------')

% Insert FIXED Values for Input Handling
my_selection_fixed = [];
cycles_fixed = [];
CV_edge_limit_fixed = 0;
my_title_fixed = "My Cells ";
legend_location_fixed = 'Northeast';
auto_numbering_string_fixed = 'Cycle ';
dQdV_conditions_fixed = {2e3,10}; %taken from CC Template
print_loop_singleCELLS_fixed = false;
mygraph_linewidth_fixed = 1;
mycv_voltagelimit_low_fixed = [];
mycv_voltagelimit_high_fixed = [3.00];

% Input Handling - needs to be updated (06/07/2022)
switch nargin
    case{0,1,2} % NO: plot_mode, pc_choice, data_choice - return
        
        disp('Error - trigger_coinCellAnalysis: NO plot_mode, pc_choice, OR data_choice SELECTED')
        return
        
    case 3  % Key components selected: plot_mode, pc_choice, data_choice
            my_selection = my_selection_fixed;
            cycles = cycles_fixed;
            CV_edge_limit = CV_edge_limit_fixed;
            my_title = my_title_fixed;
            Tian2019_input = Tian2019_input_fixed;
            legend_location = legend_location_fixed;
            auto_numbering_string = auto_numbering_string_fixed;
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 4  % cycles            
            cycles = cycles_fixed;
            CV_edge_limit = CV_edge_limit_fixed;
            my_title = my_title_fixed;
            Tian2019_input = Tian2019_input_fixed;
            legend_location = legend_location_fixed;
            auto_numbering_string = auto_numbering_string_fixed;
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 5  % CV_edge_limit           
            CV_edge_limit = CV_edge_limit_fixed;
            my_title = my_title_fixed;
            Tian2019_input = Tian2019_input_fixed;
            legend_location = legend_location_fixed;
            auto_numbering_string = auto_numbering_string_fixed;
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 6  % my_title
            my_title = my_title_fixed;
            Tian2019_input = Tian2019_input_fixed;
            legend_location = legend_location_fixed;
            auto_numbering_string = auto_numbering_string_fixed;
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 7  % legend_location
            if(isempty(legend_location))
                legend_location = legend_location_fixed;
            end
            auto_numbering_string = auto_numbering_string_fixed;
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 8  % auto_numbering_string
            if(isempty(auto_numbering_string))
               auto_numbering_string = auto_numbering_string_fixed;
            end
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 9  % dQdV_conditions
            dQdV_conditions = dQdV_conditions_fixed;
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 10  % print_loop_singleCELLS
            print_loop_singleCELLS = print_loop_singleCELLS_fixed;
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 11  % mygraph_linewidth
            mygraph_linewidth = mygraph_linewidth_fixed;
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 12 % mycv_voltagelimit_low
            mycv_voltagelimit_low = mycv_voltagelimit_low_fixed;
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
    case 13 % mycv_voltagelimit_high
            mycv_voltagelimit_high = mycv_voltagelimit_high_fixed;
end % input-handling

%--------------------------------------------------------------------------
% Data Filepath and Details Access 
%--------------------------------------------------------------------------
        switch pc_choice
        % Gaming PC or UCL Laptop
            case {1,2} 
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = switch_mydatachoice(data_choice,pc_choice);
            otherwise
                disp('Error - trigger_coinCellAnalysis.m: this pc_choice is not supported')
                return
        end % Switch choices 

%--------------------------------------------------------------------------
% trigger_CoinCellAnalysis_PINBALL (input handling - for CoinCellAnalysis
%--------------------------------------------------------------------------
    [polarization,capacity_fade,eis_profile,additional_figure,cell_data] = trigger_CoinCellAnalysis_PinBALL(filepath_sample,mass_active,sample_diameter,plot_mode,cycles,CV_edge_limit,my_legend,my_title,legend_location,auto_numbering_string,my_color,dQdV_conditions,my_selection,print_loop_singleCELLS,sample_per_CYCLE_EIS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high); % calls to function - which does all the input handling

end % function - master

% Function for the switch statment for the data choice (picks where to draw
% data from - CC, EX or CV)
function [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = switch_mydatachoice(data_choice,data_location)

    switch data_choice
            case 1 % CC - CC1-9, R1-4, HR1
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = Cell_Details_20210914(data_location);
            case 4 % CC10 - QMU 
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = Cell_Details_CC_20231027(data_location);   
            case 5 % EIS
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = Cell_Details_EIS_20220930(data_location); % developing
            case 2 % EX-Series 
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = Cell_Details_Exsitu_231009(data_location);
            case 3 % CV
                [filepath_sample,mass_active,sample_diameter,sample_per_CYCLE_EIS,my_color,my_legend] = Cell_Details_CV_20220303(data_location);
            otherwise 
                disp('Error - trigger_coinCellAnalysis: No such choice for data_choice. Try CC (1), EX (2), or CV (3)')
   end 

end