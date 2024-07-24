%--------------------------------------------------------------------------
% Title:    Cell Capacity - get extra data (Current Density or Capacity)
%           for TILED PLOT
% Author:   A.Marinov
% Date:     01/02/2024
% Version:  A1
% Status:   Developing

% Sample:   
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function  [current_density_cell,discharge_capacity_cell] = get_capacity_fade_2(plot_mode,my_source,mydata_trimmed,cycles1,my_color) 

[~,plot_mode_code,~] = switch_plot_mode(plot_mode); % get plot_mode numbers

[column_voltage,column_total_time,column_capacity,column_current_density,column_halfcycle,column_step_index,column_step_type,column_dqdv] = getmy_celldata_columns(my_source);

mygraph_linewidth = 1.0; % need to implement further up at some point!!! DUCT TAPE 06/06/2024

    %----------------------------------------------------------
    switch plot_mode_code % EXTRA TILE
    %----------------------------------------------------------
    case 52 % tile with current densities 
        for f = 1:length(mydata_trimmed)
            intermediate_var = mydata_trimmed{1,f};
            current_density_cycle(f) = max(abs(intermediate_var(:,column_current_density))); % different cycle size proof!
        end
        current_density_cell = current_density_cycle;
        discharge_capacity_cell = nan; % empty
        clear current_density_cycle
    case 62 % tile (split the capacity fade)
        discharge_capacity_cell = getmeadischarge(mydata_trimmed,cycles1,my_color,mygraph_linewidth,plot_mode); 
        % breaks if not enough cycles - e.g: 220902_CC11_M5
        current_density_cell = nan; % empty
    otherwise 
        discharge_capacity_cell = nan; % empty
        current_density_cell = nan; % empty
    end % switch - plot_mode_code
    %----------------------------------------------------------
    %----------------------------------------------------------
end % function - master 