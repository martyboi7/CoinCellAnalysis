%--------------------------------------------------------------------------
% Title:    Degradation (ONLY)

% Author:   A.Marinov
% Date:     22nd Aug 2022
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [capacity_fade,cell_data] = my_capacity_fade(plot_mode,cell_data,num_entries,my_source,cycles_input,my_color,my_title,my_legend,filepath_sample,auto_numbering_string,legend_location)

disp('-----------------------')
disp('my_capacity_fade')
disp('-----------------------')
%----------------------------------------------------------
% Setting up
%----------------------------------------------------------
        my_color = mycolor_validate(plot_mode,my_color,cycles_input,num_entries);
        [plot_mode_switch,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode); % get plot_mode numbers
        [row_raw_data,row_cycles,row_cycles_clean,row_discharge_capacity,row_charge_capacity,row_CV_data,row_CV_Size,row_cycles_CV] = getmy_celldata_rows(); % get unified data storage rows 

        % Tiled plot or Normal
        [capacity_fade,cycles_input,cycles1,tile_number] = get_capacity_fade_1(plot_mode_code,cycles_input); % setup figure (TILES or NOT)
%----------------------------------------------------------
%----------------------------------------------------------       
        for t=1:num_entries % number of CELLS 
            % Send to function to get us the right data to plot
           
            % OUTPUT: Voltage(V),Time(s),Capacity(mAh/g),Current Density(mA/g), Halfcycle/Other,dQdV/EIS 
            mydata_trimmed = cell_data{row_cycles_clean,t};
            %----------------------------------------------------------
            % Cycles 
            %----------------------------------------------------------
            cycles = my_cycles(cycles_input,plot_mode,mydata_trimmed);
            [~,~,~,column_current_density,~,~,~,~] = getmy_celldata_columns(my_source(t)); % my_source is not a scalar - but can use as column_current_density is the same for both CYCLERs

            [current_density_cell{t},discharge_capacity_cell{t}] = get_capacity_fade_2(plot_mode,my_source(t),mydata_trimmed,cycles1,my_color(t,:)); % setup figure (TILES or NOT)

            % find the capacity values (all cycles selected) for all the
            % cells (my_selection)
            discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),1,plot_mode);
            charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color(t,:),1,plot_mode);
            
                % Export the discharge and charge capacities 
                cell_data{row_discharge_capacity,t} = discharge_capacity;
                cell_data{row_charge_capacity,t} = charge_capacity;
            %----------------------------------------------------------
            switch plot_mode % switch 7 - plot_mode. MULTICell: DEGRADATION. Plot fig.
            %----------------------------------------------------------
                case {8,9,36,37,42,46,47,57} %discharge capacity fade - comparison
                    plot_capacity_fade(plot_mode,discharge_capacity,0,my_color(t,:));
                case 10 %charge capacity fade - comparison
                    plot_capacity_fade(plot_mode,0,charge_capacity,my_color(t,:));
                case {11,27,28,29,30,31,32} %discharge and charge capacity fade - comparison & ratios
                    plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity,my_color(t,:));
                case{48,49} % TIME - based fade
                    plot_time_fade(plot_mode,discharge_capacity,charge_capacity,my_color(t,:));
                case 53 % current/capacity
                    plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity,my_color(t,:));
            end % switch 7 - plot_mode. MULTICell: DEGRADATION. Plot fig.
            
            clear mydata_trimmed discharge_capacity charge_capacity cycle_identifier cycles 
        end %for loop - t (num_entries)

        % AXIS
        plot_capacity_fade_axis(plot_mode,my_title,tile_number,capacity_fade)        

        % Legend
        plot_capacity_fade_legend(plot_mode,my_legend,legend_location,filepath_sample,auto_numbering_string)

%--------------------------------------------------------------------------
% % Tiled Plots
%--------------------------------------------------------------------------
get_capacity_fade_3(plot_mode,num_entries,current_density_cell,discharge_capacity_cell,my_color,my_title,tile_number,capacity_fade) 
tile_number = tile_number + 1; % increase counter
end % function - master