%--------------------------------------------------------------------------
% Title:    Capacity Based Polarization - Get me a Dsicahrge 
% Author:   A.Marinov
% Date:     4th May 2023
% Version:  A1
% Status:   Developing 

% Note:   
%--------------------------------------------------------------------------

function discharge_capacity = getmeadischarge_capacity(data_discharge,cycles_input,data_colors,mygraph_linewidth,plot_mode)
%--------------------------------------------------------------------------
% Capacity Based Plots 
%--------------------------------------------------------------------------
    % ---------------------------------------------------------------------
    % switch 1 - plot_mode: | 1,3,5 | 12,17 | 6 | 8,9,11 | 
       % | SINGLECell (Polarization) | SINGLECell (Special) | MULTICell (Polarization) | MULTICell (Degradation) | 
        %------------------------------------------------------------------
        % Unified Code Approach
        %------------------------------------------------------------------

    [~,plot_mode_code,~] = switch_plot_mode(plot_mode); %new plot_mode function

% Data Labelling - ignoring special cases up above
    [column_voltage,~,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(1); % for first 4 columns - CYCLER choice does not matter!

%------------------------------------------------------------------
% ** Worth changing to accomodate a generic cycle function 20/10/2022

        if(plot_mode == 6 && length(cycles_input) == 1)
        % 6 - MULTICell: POLARIZATION Comparison - single DISCHARGE. Select CYCLE.
            i_unified = cycles_input; % only one cycle 
            switcher_a = 1; % for switch 2
        elseif(length(cycles_input) == 1) % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
            i_unified = cycles_input; % modified 28/03/2024 - before 1:cycles_input;
            switcher_a = 2; % for switch 2column
        elseif(length(cycles_input) > 1) % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
            i_unified = cycles_input; 
            switcher_a = 3; % for switch 2
        else
            disp('Error: getmeadischarge_capacity - i_unified not assigned')
            return
        end % if statment - decision of plot 

%------------------------------------------------------------------




        
        % Unified code 
        for i = i_unified
            thedata = data_discharge{1,i}; % import discharge for cycles -> i

            discharge = abs(thedata(:,column_capacity));   % import capacity (mAh/g) - make POSITIVE (all discharge capacity is negative)
            index_zero = find(discharge); % find non-zero elements in discharge dataset
            
            switch switcher_a % switch 2 - dummy variable k.
                case {1,2}
                    k = 1; % dummy variable - empty
%                 case 2
%                     k = i; % dummy variable - match cycle / removed
%                     28/03/2024
                case 3 
                    k = find(i == cycles_input);
            end % switch 2 - switcher_a. dummy variable k.
            
            if(~isempty(index_zero))
                new_discharge = discharge(index_zero); % discharge - without zero values                
                current_density = thedata(index_zero,column_current_density); % current ensity (mA/g)
                voltage = thedata(index_zero,column_voltage); % voltage (V) - without discharge zero values 
                
            %--------------------------------------------------------------
            % POLARISATION Plot
            %--------------------------------------------------------------
            % | SINGLECell (Polarization) | SINGLECell (Special) | MULTICell (Polarization) |
            switch plot_mode_code % switch 6 - plot_mode
                case{11,21,31,71} %plot_mode: POLARIZATION
                    if nargin < 3 % if no colours provided
                            plot(new_discharge,voltage,'LineWidth',mygraph_linewidth)
                            hold on
                    elseif(nargin >= 3) % if colours provided 
                            plot(new_discharge,voltage,'color',data_colors(k,:),'LineWidth',mygraph_linewidth)
                            hold on
                    end % if statement 
                case 26 % current/capacity
                    plot(new_discharge,current_density,'color',data_colors(k,:),'LineWidth',mygraph_linewidth)
                    hold on
            end  % switch 6 - plot_mode
                
                final_actual_value = nonzeros(new_discharge); % not sure why I have a second processing step to remove zeros??? (04/05/2022)
            
            %--------------------------------------------------------------
            % DISCHARGE Capacity
            %--------------------------------------------------------------
                switch switcher_a % switch 3 - assignment of discharge_capacity

%--------------------------------------------------------------------------
                    case {1,3}
                        discharge_capacity(i,:) = [i,final_actual_value(end)];

                        
% isolated as problem for CV 18/01/2023
%--------------------------------------------------------------------------
                    case 2
                        discharge_capacity(k,:) = [k,final_actual_value(end)];
                end % switch 3 - switcher_a. assignment of discharge_capacity
            else
               disp('Empty cycle')
               switch switcher_a % switch 4 - empty discharge_capacity
                   case 2
                        discharge_capacity(k,:) = NaN;
                   case {1,3}
                        discharge_capacity(i,:) = NaN;
               end % switch 4 - empty discharge_capacity
            end % if statement - empty index_zero
        end % for loop - i (unified code)
end % function - master 
