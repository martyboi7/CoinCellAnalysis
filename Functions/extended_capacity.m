%--------------------------------------------------------------------------
% Title:    Cycle D and C capacity

% Author:   A.Marinov
% Date:     14th Dec 2022
% Version:  A1
% Status:   Developing

% Note: Makes sure there is no empty [] entries in a cell array

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [cycle_data,cycle_voltage,discharge_capacity] = extended_capacity(data_discharge,data_charge,plot_mode,cycles,cycles_charge_length)

%** NEED to add section identifying between NEWARE and BIOLOGIC 14/12/2022
% to address NEWARE total time bug. 

[column_voltage,column_total_time,column_capacity,~,~,~,~,~] = getmy_celldata_columns(1);

        discharge_cycle = data_discharge{1,cycles}; % Discharge cycles

        switch plot_mode % cycles definition
            case 20 % SINGLE CYCLE
                if(cycles_charge_length < 1)
                    charge_cycle = [NaN,NaN,NaN,NaN]; % If only have discharge present (Dx) and charge (Cx) is empty)
                elseif(cycles_charge_length < cycles)
                    charge_cycle = [NaN,NaN,NaN,NaN]; % Charge cycle - emtpy for particular cycle
                else
                    charge_cycle = data_charge{1,cycles}; % Charge cycle 
                end 
            case 19 % All CYCLES
                if(cycles_charge_length < 1)
                    charge_cycle = [NaN,NaN,NaN,NaN]; % If only have discharge present (Dx) and charge (Cx) is empty)
                elseif(cycles_charge_length < cycles)
                    charge_cycle = data_charge{1,cycles_charge_length}; % Charge cycles - load only the ones available
                else
                    charge_cycle = data_charge{1,1:cycles}; % Charge cycles 
                end 
        end % switch - plot_mode 
        
        cycle_voltage = [discharge_cycle(:,column_voltage);charge_cycle(:,column_voltage)]; % append
        
        % Append the data together 
        switch plot_mode % switch 5 - plot_mode
           case 20
                index_zero_discharge = find(discharge_cycle(:,column_capacity)); % discharge capacity find 
                discharge_cycle_nonzero = abs(discharge_cycle(index_zero_discharge,column_capacity)); % discharge data
                index_zero_charge = find(charge_cycle(:,column_capacity)); % charge capacity
                charge_cycle_nonzero = charge_cycle(index_zero_charge,column_capacity); % charge data
                
                cycle_data = [discharge_cycle_nonzero;(charge_cycle_nonzero + discharge_cycle_nonzero(end))]; % append capacity (mAh/g)
                index_voltage = [index_zero_discharge; (index_zero_charge + index_zero_discharge(end))];
                
                cycle_voltage = cycle_voltage(index_voltage);

                discharge_capacity = discharge_cycle(end,column_capacity); % export value 

            case 19
                % *SECTION UNDER DEVELOPMENT* (<10/2022)
        
                % USE the change in architecture from 12/12/2022 to change this
                % whole section!
                
                cycle_end = 0; % used to add on the capacity CYCLE after CYCLE
                data_charge_size = length(data_charge);
                
                for j = 1:cycles
                    
                    % DISCHARGE (always will be atleast initiated)
                    cycle_discharge = data_discharge{1,j}; %D
                    index_zero_discharge = find(cycle_discharge(:,column_capacity)); % find non-zero elements in discharge dataset (capacity)
                    voltage_nonzero_discharge = cycle_discharge(index_zero_discharge,column_voltage); %voltage
                    cycle_discharge_nonzero = abs(cycle_discharge(index_zero_discharge,column_capacity)); %capacity
                    
                    % CHARGE - might not always be present
                    if(j <= data_charge_size) % used to find where CHARGE was achieved
                        cycle_charge = data_charge{1,j}; %C
                        index_zero_charge = find(cycle_charge(:,column_capacity)); % find non-zero elements in charge dataset (eliminates rest from capacity)
                        voltage_nonzero_charge = cycle_charge(index_zero_charge,column_voltage);
                        cycle_charge_nonzero = cycle_charge(index_zero_charge,column_capacity); 
                    else % no CHARGE for this CYCLE - maybe cell was interupted 
                        voltage_nonzero_charge = nan; % empty voltage - if cycle not present
                        cycle_charge_nonzero = 0; % null added capacity
                    end % if-statement 
                    
                    if(j==1)
                        cycle_voltage = [voltage_nonzero_discharge;voltage_nonzero_charge]; % append
                        cycle_data = [cycle_discharge_nonzero + cycle_end;cycle_charge_nonzero + cycle_discharge_nonzero(end) + cycle_end]; % append capacity            
                        cycle_end = cycle_discharge_nonzero(end) + cycle_charge_nonzero(end) + cycle_end; % increase cycle_end counter
                    else
                        cycle_voltage = [cycle_voltage;voltage_nonzero_discharge;voltage_nonzero_charge]; % append
                        cycle_data = [cycle_data;cycle_discharge_nonzero + cycle_end;cycle_charge_nonzero + cycle_discharge_nonzero(end) + cycle_end]; % append capacity            
                        cycle_end = cycle_discharge_nonzero(end) + cycle_charge_nonzero(end) + cycle_end; % increase cycle_end counter
                    end % if-statement


                    % plot the figure
%                     plot(cycle_data,cycle_voltage,'color',data_colors,'LineWidth',2.0)
%                     hold on
                   
                    discharge_capacity(j,:) = [j,cycle_discharge_nonzero(end)]; % export the values 

                    clear cycle_charge cycle discharge index_zero_charge index_zero_discharge voltage_nonzero_charge voltage_nonzero_discharge cycle_discharge_nonzero cycle_charge_nonzero  
                        
                end % for loop - j
        end % % switch 5 - plot_mode
end % function - master 