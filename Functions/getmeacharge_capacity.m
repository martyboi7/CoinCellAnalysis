%--------------------------------------------------------------------------
% Title:    Capacity Based Polarization - Get me a Charge 
% Author:   A.Marinov
% Date:     4th May 2023
% Version:  A1
% Status:   Developing 

% Note:   
%--------------------------------------------------------------------------

function charge_capacity = getmeacharge_capacity(data_charge,cycles_input,data_colors,mygraph_linewidth,plot_mode)
%--------------------------------------------------------------------------
% Capacity Based Plots 
%--------------------------------------------------------------------------
 [~,plot_mode_code,~] = switch_plot_mode(plot_mode); %new plot_mode function

% Data Labelling - ignoring special cases up above
    [column_voltage,~,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(1); % for first 4 columns - CYCLER choice does not matter!

%--------------------------------------------------------------------------
        % switcher_a - defined. Needed for Switch 1
        if(plot_mode == 7 && length(cycles_input) == 1)
        % 7 - MULTICell: POLARIZATION Comparison - single CHARGE. Select CYCLE.
            i_unified = cycles_input; % only one cycle 
            switcher_a = 1; % for switch 1
        elseif(length(cycles_input) == 1) % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
            i_unified = cycles_input; % changed 28/03/2024  1:cycles_input; 
            switcher_a = 2; % for switch 1
        elseif(length(cycles_input) > 1) % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
            i_unified = cycles_input; 
            switcher_a = 3; % for switch 1
        else
            disp('Error: getmeacharge - i_unified not assigned')
            return
        end % if statment - decision of plot 
    
        % Unified code 
        for i = i_unified

            if(i > length(data_charge)) % if less charge cycles than discharge
                index_zero = []; % empty
            else
                thedata = data_charge{1,i}; % import charge for cycles -> i
                charge = thedata(:,column_capacity);   % import capacity (mAh/g)
                index_zero = find(charge); % find non-zero elements in charge dataset
            end
    
            switch switcher_a % switch 1 - dummy variable k.
                case {1,2} % plot_mode == 7 (MULTICell: POLARIZATION Comparison - single CHARGE. Select CYCLE.)
                    k = 1; % dummy variable - empty
%                 case 2 % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
%                     k = i; % dummy variable to get the correct cycle
                case 3 % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
                    k = find(i == cycles_input);
            end % switch 1 - switcher_a. dummy variable k.
    
            if(~isempty(index_zero))
                    new_charge = charge(index_zero); % charge - without zero values
                    current_density = thedata(index_zero,column_current_density); % current ensity (mA/g)
                    voltage = thedata(index_zero,column_voltage); % voltage (V) - without discharge zero values 
    
            %------------------------------------------------------------------
            % POLARISATION Plot
            %------------------------------------------------------------------
            % plot_mode == | 2,4,5 | 7 | 
            % | SINGLECell (Polarization) | MULTICell (Polarization) |
            switch plot_mode % switch 2 - plot_mode
                case{2,4,5,7}
                    if nargin < 3 % if no colours provided
                            plot(new_charge,voltage,'--','LineWidth',mygraph_linewidth)
                            hold on
                    elseif(nargin >= 3) % if colours provided 
                            plot(new_charge,voltage,'--','color',data_colors(k,:),'LineWidth',mygraph_linewidth)
                            hold on
                    end % if statement 

                case 51 % current/capacity
                    plot(new_charge,current_density,'color',data_colors(k,:),'LineWidth',mygraph_linewidth)
                    hold on
            end  % switch 2 - plot_mode
            
            %------------------------------------------------------------------
            % CHARGE Capacity
            %------------------------------------------------------------------
                % All plot_modes use: | 2,4,5 | 7 | 10,11 |
                    switch switcher_a % switch 3 - assignment of charge_capacity
                        case {1,3}
                            charge_capacity(i,:) = [i,new_charge(end)];
                        case 2
                            charge_capacity(k,:) = [k,new_charge(end)];
                    end % switch 3 - switcher_a. assignment of charge_capacity
            else
                   disp('Empty cycle')
                   switch switcher_a % switch 4 - empty charge_capacity
                       case 2
                            charge_capacity(k,:) = NaN;
                       case {1,3}
                            charge_capacity(i,:) = NaN;
                   end % switch 4 - empty charge_capacity
            end % if statement - empty index_zero
        end % for loop - i = i_unified
end % function - master