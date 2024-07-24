%--------------------------------------------------------------------------
% Title:    
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Working

% Note:     

function charge_capacity = getmeacharge(data,cycles_input,data_colors,mygraph_linewidth,plot_mode)

% INPUT Handling 
    if nargin < 5 % not plot_mode provided
        plot_mode = 2; % guarantees print of fig. 
    end

[~,plot_mode_code,~] = switch_plot_mode(plot_mode); %new plot_mode function
plot_mode_code_CC = getplot_mode_code_CC(); % CC Data types 

    % Charge CYCLE - 13/12/2022
    [data_charge,cycles_charge_length,~] = cellarray_emptycheck(data(1,:));
    % use function to get non-empty data for charge

    % Discharge CYCLE - 13/12/2022
    [data_discharge,cycles_discharge_length,~] = cellarray_emptycheck(data(2,:));
    % use function to get non-empty data for discharge 

% Basic checks
% 1. If did not specific cycles makes sure you can print cycles (half of
% the data set because data is discharge - charge)
    if nargin < 2
        cycles = cycles_charge_length;
    else
        cycles = cycles_input; % assign input cycles 
    end 

% 2. If you did specify cycles, but told it to print too many, it corrects you. 
    if (max(cycles) > cycles_charge_length && min(cycles) ~= 1)
    %----------------------------------------------- 19/01/2023
        switch plot_mode_code
                case {14} % CV - have empty cells []
                    clear data_charge cycles_charge_length % need to reassign 

                    data_charge = data(1,:);
                otherwise
                    disp('Error: getmeacharge - There are less cycles in your dataset that you have requested to print!')
                    cycles = cycles_charge_length;
        end % switch - plot_mode_code
    elseif(max(cycles) > cycles_charge_length) % if there were uncompleted cycles [] in CC data
        cycles = cycles_charge_length;
    %----------------------------------------------- 19/01/2023
    end

% Data Labelling - ignoring special cases up above
    [column_voltage,~,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(1); % for first 4 column - choice of CYCLER does not matter 

%------------------------------------------------------------------
% Unified Code Approach
%------------------------------------------------------------------

switch plot_mode_code
    case plot_mode_code_CC
        switch plot_mode % some of the special plot_modes are getting repetitive - would be good to have a specific subfunction for each!
            case 48 % TIME CYCLE comparison for single CELL
                    % Developed 23/03/2023
        
                    if(length(cycles) == 1) % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
                        i_unified = 1:cycles; 
                    elseif(length(cycles) > 1) % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
                        i_unified = cycles; 
                    end % if statement
        
                    for o = i_unified % cycles selected in CELL dataset
        
                        % DISCHARGE
                        discharge_cycle = data_discharge{1,o};
                        discharge_previous_time = discharge_cycle(end,2)/3600;
        
                        % CHARGE
                        charge_cycle = data_charge{1,o};  
                        charge_capacity(o,1) = charge_cycle(end,2)/3600 - discharge_previous_time; % converted from s to hr 
        
                        clear discharge_cycle charge_cycle
                    end % for loop - TIME
            case 49 % TIME - per whole CYCLE for MULTICELL
                    if(length(cycles) == 1) % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
                        i_unified = 1:cycles; 
                    elseif(length(cycles) > 1) % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
                        i_unified = cycles; 
                    end % if statement
                    for o = i_unified % cycles selected in CELL dataset
        
                        % CHARGE
                        charge_cycle = data_charge{1,o};  
                        charge_capacity(o,1) = charge_cycle(end,2)/3600; % converted from s to hr 
        
                        clear charge_cycle
                    end % for loop - TIME
        
            otherwise 
                
                if(cycles == 0)
                    charge_capacity = nan; % empty (nor charge cycle)
                else
                    charge_capacity = getmeacharge_capacity(data_charge,cycles_input,data_colors,mygraph_linewidth,plot_mode);        
                end % if-statement
        end % switch - plot_mode 
    otherwise % plot_mode_code
        
        charge_capacity = nan; % empty 

end % switch - plot_mode_code       
end % function - master 