%--------------------------------------------------------------------------
% Title:    Column numbers for the unified data approach

% Author:   A.Marinov
% Date:     15th Dec 2022
% Version:  A1
% Status:   Developing

% Note: 
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
  % for the BIOLOGIC and NEWARE post import sequence and output
  % processing 
function [column_voltage,column_total_time,column_capacity,column_current_density,column_halfcycle,column_step_index,column_step_type,column_dqdv] = getmy_celldata_columns(my_source)

% UNIVERSAL
column_voltage = 1; % data
column_total_time = 2; 
column_capacity = 3;
column_current_density = 4;

% Different Meanings
column_halfcycle = 5; % BIOLOGIC - Halfcycle / NEWARE - Cycle number

% NEWARE
column_step_index = 6; % step index
column_step_type = 7; % step type 

    switch my_source
        case 1 % BIOLOGIC
        % BIOLOGIC (CC): Voltage (V), Time (s), Capacity (+/- mAh/g), Current Density (+/- mA/g), HALFCYCLE, dQdV        
             column_dqdv = 6; % BIOLOGIC ONLY
    
        case 2 % NEWARE
        % NEWARE: Voltage, Time, Capacity (+/- mAh/g), Current Density (+/- mA/g), Cycle Number, Step Index, Step Type, dQdV
            column_dqdv = 8;
    end % switch - my_source
end % function - master