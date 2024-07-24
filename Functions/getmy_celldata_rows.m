%--------------------------------------------------------------------------
% Title:    Row numbers for the unified data approach

% Author:   A.Marinov
% Date:     22nd May 2024
% Version:  A1
% Status:   Developing

% Note: 
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
  % for the BIOLOGIC and NEWARE post import sequence and output processing 
function [row_raw_data,row_cycles,row_cycles_clean,row_discharge_capacity,row_charge_capacity,row_CV_data,row_CV_Size,row_cycles_CV] = getmy_celldata_rows()

% data_output = {RAW Data;D/C Cycles;D/C Cycles - no Zeroes}

    % PROSESSING
    row_raw_data = 1; % data
    row_cycles = 2; 
    row_cycles_clean = 3;
%     column_current_density = 4;

    % EXPORT
    row_discharge_capacity = 4;
    row_charge_capacity = 5;
    row_CV_data = 6;
    row_CV_Size = 7;
    row_cycles_CV = 8;

end % function - master