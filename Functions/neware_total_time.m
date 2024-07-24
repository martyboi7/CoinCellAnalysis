%--------------------------------------------------------------------------
% Title:    

% Author:   A.Marinov
% Date:     13th Dec 2022
% Version:  A1
% Status:   Developing

% Note: Makes sure there is no empty [] entries in a cell array

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [output_time,output_voltage,output_current,output_capacity] = neware_total_time(data_discharge,data_charge,cycles_limit,plot_mode)
% Input: CELL of data C|D from NEWARE cycler 

    [column_voltage,column_total_time,column_capacity,column_current_density,~,~] = getmy_celldata_columns(2); % calls neware details 
    output_voltage = []; % dummy var
    output_time = []; % dummy var
    output_current = []; % empty var.
    output_capacity = []; % empty var. 
    time_cum = 0; % dummy var

    % plot_mode
    switch plot_mode
        case 16 % plot all cycles
            ii = 1:cycles_limit;
        case {18,50,53,55,56} % plot selected cycle 
            ii = cycles_limit;

            if(ii ==1)
                ii_prev_cycle_time = 0; % empty for cycle 1
            else
                prev_cycle = data_charge{1,ii-1};% open the cell array  
                ii_prev_cycle_time = prev_cycle(end,column_total_time); %time END of previous cycle
            end
    end % switch - plot_mode 


    

    
    for i = ii
        
        % DISCHARGE
        my_data_discharge = data_discharge{1,i};% open the cell array 
        
        if(isnan(my_data_discharge)) % remove empty charge cycle at END - for preliminary data 
            output_time = [output_time;NaN]; % empty append
            output_voltage = [output_voltage;NaN]; % empty append
            output_current = [output_current;NaN]; % empty append 
            output_capacity = [output_capacity;NaN]; % empty append 
        else
            output_voltage = [output_voltage;my_data_discharge(:,column_voltage)]; % voltage append 
%             output_time = [output_time;my_data_discharge(:,column_total_time) + time_cum]; % time append
            output_time = [output_time;my_data_discharge(:,column_total_time) - ii_prev_cycle_time]; % time append
            output_current = [output_current;my_data_discharge(:,column_current_density)]; % current append 
            output_capacity = [output_capacity;my_data_discharge(:,column_capacity)]; % capacity append
            time_cum = my_data_discharge(end,column_total_time) + time_cum; % loop the time
        end 
        
        % CHARGE
        my_data_charge = data_charge{1,i};% open the cell array 
        
        if(isnan(my_data_charge)) % remove empty charge cycle at END - for preliminary data 
            output_time = [output_time;NaN]; % empty append
            output_voltage = [output_voltage;NaN]; % empty append
            output_current = [output_current;NaN]; % empty append 
            output_capacity = [output_capacity;NaN]; % empty append 
        else
            output_voltage = [output_voltage;my_data_charge(:,column_voltage)]; % voltage append 
%             output_time = [output_time;my_data_charge(:,column_total_time) + time_cum]; % time append
            output_time = [output_time;my_data_charge(:,column_total_time) - ii_prev_cycle_time]; % time append
            output_current = [output_current;my_data_charge(:,column_current_density)]; % current append 
            output_capacity = [output_capacity;my_data_charge(:,column_capacity)]; % capacity append
            time_cum = my_data_charge(end,column_total_time) + time_cum; % loop the time
        end 

        clear my_data_discharge my_data_charge % empty the storage array
    end 

end % function - master