%--------------------------------------------------------------------------
% Title:    50
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Working

% Note:    
%           If you pass getmedischarge(data,cycles,colours) plots the
%           individual cycles (polarization). If you specifiy also the
%           plot_mode getmedischarge(data,cycles == 1,colours,plot_mode) it will
%           only export the capacity fade data
%--------------------------------------------------------------------------

function discharge_capacity = getmeadischarge(data,cycles_input,data_colors,mygraph_linewidth,plot_mode,my_source)

% ISSUE 12/01/2023 - for CV removing the empty holders [] eliminates empty
% cycles - why was the removal of empty cycles introduced?

% INPUT Handling 
    if nargin < 5 % not plot_mode provided
        plot_mode = 1; % guarantees print of fig. 
    end

[~,plot_mode_code,~] = switch_plot_mode(plot_mode); %new plot_mode function

disp(strcat('       getmeadischarge - plot_mode: ',num2str(plot_mode))) % for printout 

    %----------------------------------------------- 12/01/2023   



% this needs to become one unified THING (none of this CELL or DOUBLE) - 05/05/2023 
    if(isa(data,'cell')) % make sure data in correct format (CC, CC from CV)
        % Discharge CYCLE - 13/12/2022
        [data_discharge,cycles_discharge_length,~] = cellarray_emptycheck(data(2,:));
        % use function to get non-empty data - issue is that incomplete datasets have [] in place of a halfcycle  
    
        % Charge CYCLE - 13/12/2022
        [data_charge,cycles_charge_length,~] = cellarray_emptycheck(data(1,:));
        % use function to get non-empty data - issue is that incomplete datasets have [] in place of a halfcycle   
    else 
        disp('       Error - getmeadischarge - unsupported data type entered!')
    end % if statement

    %----------------
    %----------------
    if nargin < 2 % if not enough cycles provided 
        cycles_initial = cycles_discharge_length;
    else
        cycles_initial = cycles_input; % assign input cycles 
    end 

% 2. If you did specify cycles, but told it to print too many, it corrects you. 
    if (max(cycles_initial) > cycles_discharge_length && min(cycles_initial) ~= 1) % the equals not 2 - throws error for plot_mode 42 (EIS)
        switch plot_mode_code 
            case 61 % RANGE Degradation 
                cycles = cycles_initial(1):cycles_discharge_length;
%--------------------------------------------------------------------------
            case 14 % CV - have empty cells [] due to import method
                clear data_discharge data_charge % need var.s cleared for assignment
                data_discharge = data(2,:); % has [] entries
                data_charge = data(1,:); % has [] entries
% 18/01/2023 - resolved
%--------------------------------------------------------------------------
            otherwise 
                disp('       Error: getmeadischarge - There are less cycles in your dataset that you have requested to print!')
                cycles = 1:cycles_discharge_length;
        end % switch - plot_mode_switch
    elseif(max(cycles_initial) > cycles_discharge_length && length(cycles_initial) ~= 1) % list of entries [1,2,5,10...etc]
        max_location = find(cycles_initial <= cycles_discharge_length);
        cycles = cycles_initial(max_location);
    elseif(max(cycles_initial) > cycles_discharge_length) % if there were uncompleted cycles [] in CC data
        cycles = 1:cycles_discharge_length;
    else 
        cycles = cycles_initial; % assign
    end

% Data Labelling - ignoring special cases up above
    [column_voltage,column_total_time,column_capacity,~,~,~,~,~] = getmy_celldata_columns(1); % for first 4 columns - CYCLER choice does not matter!

%--------------------------------------------------------------------------
%** the special plots below need to be moved into subfunctions 12/12/2022


%--------------------------------------------------------------------------
% TIME based Plots 
%--------------------------------------------------------------------------
%-----------------------
% Older Versions
%-----------------------
switch plot_mode % switch 1 - plot_mode. Main switch 
    case {16} % TIME 
        % 16 - MULTICell: E(t) vs t. All Cycles.

        if(cycles_discharge_length > cycles_charge_length) % makes sure incomplete cycles do not mess up and are included
            cycle_limit = cycles_discharge_length;
        else
            cycle_limit = cycles_charge_length;
        end 
        
        polarization_time(data_discharge,data_charge,cycle_limit,plot_mode,my_source,data_colors,mygraph_linewidth);
        discharge_capacity = NaN; % null output

    case {18,50} % TIME - Particular CYCLE
        % 18 - MULTICell: POLARIZATION. E(t) vs t. Select CYCLE.    

        for i = 1:length(cycles)
            polarization_time(data_discharge,data_charge,cycles(i),plot_mode,my_source,data_colors(i,:),mygraph_linewidth);      
        end % for loop - i
        discharge_capacity = NaN; % null output

    case {53,55,56} % TIME - current/time (POLARIZATION)
        g = 1; % color counter
        for i = cycles
            polarization_time(data_discharge,data_charge,i,plot_mode,my_source,data_colors(g,:),mygraph_linewidth);      
            g = g + 1; % increase counter
        end % for loop - i
        discharge_capacity = NaN; % null output
%-----------------------
    case {19,20} % Extended Capacity
        % 19 - MULTICell: POLARIZATION. Mixed Discharge + Charge (Extended capacity). All Cycles. Indeces
        % 20 - MULTICell: POLARIZATION. Mixed Discharge + Charge (Extended capacity). Select CYCLE.
        [cycle_data,cycle_voltage,discharge_capacity] = extended_capacity(data_discharge,data_charge,plot_mode,cycles,cycles_charge_length); %use function 
        plot(cycle_data,cycle_voltage,'color',data_colors,'LineWidth',mygraph_linewidth)
        hold on

%-----------------------       
%--------------------------------------------------------------------------
% New Additions
%--------------------------------------------------------------------------

    case{48,49} % TIME CYCLE (Capacity Fade) comparison for MULTI CELL 
            % Developed 23/03/2023

            if(length(cycles) == 1) % for all the cycles up to the value provide (e.g. [5] -> 1,2,3,4,5)
                i_unified = 1:cycles; 
            elseif(length(cycles) > 1) % for the cycle selection provided (e.g. [1,2,4,5] or [1:5])
                i_unified = cycles; 
            end % if statement

            charge_previous_time = 0; % dummy

            for o = i_unified % cycles selected in CELL dataset

                % DISCHARGE
                discharge_cycle = data_discharge{1,o};
                discharge_capacity(o,1) = discharge_cycle(end,2)/3600 - charge_previous_time; % converted from s to hr 

                charge_cycle = data_charge{1,o};               
                charge_previous_time = charge_cycle(end,2)/3600;

                clear discharge_cycle charge_cycle
            end % for loop - TIME

      case 54 % developing 22/05/2023
            % current/capacity - CAPACITY Fade style
    
            disp('       Developing - not sure what I am plotting')
%--------------------------------------------------------------------------
% Capacity based Plots 
%--------------------------------------------------------------------------

    % ---------------------------------------------------------------------
    otherwise % Capacity based DATA and PLOTS
        discharge_capacity = getmeadischarge_capacity(data_discharge,cycles,data_colors,mygraph_linewidth,plot_mode); % use function
        
        %------------------------------------------------------------------
end % switch 1 - plot_mode. Main switch
end % master function 