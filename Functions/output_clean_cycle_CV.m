%--------------------------------------------------------------------------
% Title:    Cell data - removes all the Zero elements (clean discharge & charge data for plots
% Author:   A.Marinov
% Date:     22nd May 2024
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function output = output_clean_cycle_CV(data_input,my_source)

[row_raw_data,row_cycles,row_cycles_clean,row_discharge_capacity,row_charge_capacity,row_CV_data,row_CV_Size,row_cycles_CV] = getmy_celldata_rows();

% Data Selection
    cell_data = data_input{1,1}; % data is in CV format - but includes both CV cycles and CC cycles. C and D are merged together!
    cycles_CV = data_input{1,3};
    cycles_CC = data_input{1,4};

% Calc. 
    number_cycle = length(cell_data); % cycles  - include D and then C glued in directly 

    % Get data columns - universal storage order
    [column_voltage,column_total_time,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(my_source);

    % Discharge
    if(number_cycle >= 1)
        for i = 1:number_cycle
    
            if(~isempty(cell_data))
                cell_data_nonempty_currentdensity = find(cell_data(:,column_current_density)); % find where current density is NOT ZERO
        
                clean_cell_data = cell_data(cell_data_nonempty_currentdensity,column_voltage:column_current_density); % select only those columns (eliminate rests)
        
                output{2,i} = clean_cell_data; % output - as if discharge
            else
                output{2,i} = []; % assign empty - as if discharge 
            end
    
        end % for loop
    else 
        disp('Developing output_clean_cycle_CV - Error: there are no available cycles to use')
        output{2,1} = []; % assign empty - as if discharge 
    end % if-statement

end % function - master