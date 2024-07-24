%--------------------------------------------------------------------------
% Title:    trigger_CoinCellAnalysis_PinBALL

% Author:   A.Marinov
% Date:     9th Feb 2023
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [polarization,capacity_fade,eis_profile,additional_figure,cell_data] = trigger_CoinCellAnalysis_PinBALL(filepath_sample,mass_active,sample_diameter,plot_mode,cycles,import_data,CV_edge_limit,my_legend,my_title,legend_location,auto_numbering_string,my_color,Tian2019_input,dQdV_conditions,my_selection,print_loop_singleCELLS,sample_per_CYCLE_EIS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high)

disp('trigger_CoinCellAnalysis_PinBALL')

%--------------------------------------------------------------------------
% Switch plot_mode - so do not need to update triggers every TIME introduce
% new plot_mode option
%--------------------------------------------------------------------------
    [plot_mode_switch,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode);

disp(['Multi: ',num2str(plot_mode_multi)])
disp(['Switch: ',num2str(plot_mode_switch)])
disp(['Code: ',num2str(plot_mode_code)])
disp(['plot_mode: ',num2str(plot_mode)])
disp('--------------------- ')

%--------------------------------------------------------------------------
% Pinball for CoinCellAnalysis trigger 
%--------------------------------------------------------------------------
% IF-statement to make sure that plot_mode is active - and process empty slots:
% (my_selection, my_color, my_legend)
        %------------------------------------------------------------------
        % Input - Handling (my_selection, my_color, my_legend) 
        %------------------------------------------------------------------
        % ** does not consider if cycle colours less than cycles!
        if(isempty(my_selection)) 
            % NO my_selection provided - plots all the filepath_samples
                final_filepath_sample = filepath_sample;
                final_mass_active = mass_active;
                final_sample_diamter = sample_diameter;
                final_my_legend = my_legend;
                final_my_color = my_color;
                final_sample_per_CYCLE_EIS = sample_per_CYCLE_EIS;

        else % my_selection provided
                final_filepath_sample = filepath_sample(my_selection);
                final_mass_active = mass_active(my_selection);
                final_sample_diamter = sample_diameter(my_selection);
                final_my_legend = my_legend(my_selection);
                final_my_color = my_color(my_selection,:);
                final_sample_per_CYCLE_EIS = sample_per_CYCLE_EIS(my_selection);
 
        end % if statement - my_selection EMPTY
%------------------------------------------------------------------
%             filepath_sample(my_selection)
%             mass_active(my_selection)
%             sample_diameter(my_selection)
%             plot_mode
%             cycles
%             my_legend(my_selection)
%             my_title
%             legend_location
%             auto_numbering_string
%             my_color
%             Tian2019_input
%             dQdV_conditions
%             sample_per_CYCLE_EIS(my_selection)
%             mygraph_linewidth
%             mycv_voltagelimit_low
%             mycv_voltagelimit_high

%------------------------------------------------------------------
        % not sure what this is used for - 10/06/2024
        %------------------------------------------------------------------   
            if(print_loop_singleCELLS == true)
                my_selection_entries = length(my_selection); % the number of data sets used in the analysis
            else
                my_selection_entries = 1; % print only the first entry of my_selection
            end 
        %------------------------------------------------------------------

%--------------------------------------------------------------------------
% Important Call to FUNCTION
%--------------------------------------------------------------------------        
            switch plot_mode_multi % switch 1 - plot_mode_multi
            % Call to the OG Function - coinCellAnalysis2()
                %----------------------------------------------------------
                % SINGLECell
                %----------------------------------------------------------
                % SINGLECell 
                case 1
                    
                    % trigger function
                    [polarization,capacity_fade,eis_profile,additional_figure,cell_data] = coinCellAnalysis2(final_filepath_sample,final_mass_active,final_sample_diamter,plot_mode,cycles,import_data,CV_edge_limit,final_my_legend,my_title,legend_location,auto_numbering_string,final_my_color,Tian2019_input,dQdV_conditions,final_sample_per_CYCLE_EIS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high);
                    
                %----------------------------------------------------------
                % MULTICell (DEG or POL) 
                %----------------------------------------------------------
                case {2,3} % Use END CYCLE for DEGRADATION

                    % trigger function
                    [polarization,capacity_fade,eis_profile,additional_figure,cell_data] = coinCellAnalysis2(final_filepath_sample,final_mass_active,final_sample_diamter,plot_mode,cycles,import_data,CV_edge_limit,final_my_legend,my_title,legend_location,auto_numbering_string,final_my_color,Tian2019_input,dQdV_conditions,final_sample_per_CYCLE_EIS,mygraph_linewidth,mycv_voltagelimit_low,mycv_voltagelimit_high);
                    
                %----------------------------------------------------------
                otherwise %switch 1 - plot_mode_multi
                    disp(['Error! trigger_coinCellAnalysis_PINBALL - plot_mode:',num2str(plot_mode),'. Option not available.']);
                    polarization = false;
                    capacity_fade = false; 
                    additional_figure = false;
                    cell_data = 1;
                    return    
            end % switch 1 - plot_mode_switch
        %------------------------------------------------------------------    
end % function - master 