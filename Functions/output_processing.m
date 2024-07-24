%--------------------------------------------------------------------------
% Title:    Removes the clunky part of the OLD import_cell_data_cycle and
% moves it into a plot_mode oriented import data processing plus breaking
% of the plot data. 

% Author:   A.Marinov
% Date:     15th Dec 2022
% Version:  A1
% Status:   Developing

% Note: 
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function output = output_processing(cell_data,my_source,plot_mode,sample_per_CYCLE_EIS,mycv_voltagelimit_low,mycv_voltagelimit_high)

% OUTPUT: Voltage(V),Time(s),Capacity(mAh/g),Current Density(mA/g), Halfcycle/Other,dQdV/EIS 

    [~,plot_mode_code,~] = switch_plot_mode(plot_mode); % plot OPTIONS
    plot_mode_code_CC = getplot_mode_code_CC();

    switch plot_mode_code
        case {13,23,34} % BIOLOGIC EIS or CC from EIS
            output = breaktheplotEIS(cell_data,my_source,plot_mode,sample_per_CYCLE_EIS); % UNDER DEVELOPMENT - 19/01/2023
            disp(strcat('       output_processing - EIS Data: ',num2str(my_source)))           
        case {14,24,35} % BIOLOGIC CV
            disp(strcat('       output_processing - CV Data:   ',num2str(my_source)))
            output = breaktheplotCV(cell_data,my_source,mycv_voltagelimit_low,mycv_voltagelimit_high); % last developed 18/01/2023                   
        case plot_mode_code_CC % BIOLOGIC CC Data (includes: POL,CC,dQdV) or NEWARE
%             disp(strcat('       output_processing - CC Data:   ',num2str(my_source)))
            output = breaktheplot(cell_data,my_source,plot_mode); % odd cells are discharge, even cells are charge
        otherwise 
            disp(['       Error - output_processing: unrecognised plot_mode:',num2str(plot_mode)])
    end % switch - plot_mode_code BIOLOGIC 
   
end % function - master 