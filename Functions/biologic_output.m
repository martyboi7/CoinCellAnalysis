%--------------------------------------------------------------------------
% Title:    Biologic - output cell DATA
% Author:   A.Marinov
% Date:     02/10/2022
% Version:  A1
% Status:   Developing
% Note: 

% OUTPUT: Voltage (V), halfcycle, Discharge (mAh/g), Charge (mAh/g), time (s), Current (mA/g), dQdV (mAh/g/V) OR EIS
%--------------------------------------------------------------------------
function output = biologic_output(var_index,mydata,active_mass,sample_diameter,variable_counter,my_selection_criticial,plot_mode)

% CRITICAL VALUE:
cycle_cut_length = 100; % currently (12/12/2022) cyuts out cycles which have small datasets (designed for 220831_CC9_M1_P1 EIS prelim - due top problematic first halfcycle distinction)
cycle_cut_halfcycle = 20; % 13/12/2022 used in combo with the above - to prevent cutting of end cycles (e.g. long term CC with degradation where final discharges are poor!)

    % Re-order the table to have always the same column order
            desired_order = variable_counter(var_index); 
            [~, varOrder] = ismember(mydata.Properties.VariableNames, desired_order); 
            [~, resortOrder] = sort(varOrder); 
            t = mydata(:,resortOrder);
            
            %-----------------------------
            % Output - decision on which type of data we have!
            t_size = length(var_index); % size of the variable exported 
            t2 = table2array(t);
            % Voltage (V), half cycle, cycle number, Capacity D(-)/C (mAh), time (s), Current (mA), dQdV or EIS)

%--------------------------------------------------------------------------
% Data - for ease of understanding 
%--------------------------------------------------------------------------

        voltage = t2(:,1);
        capacity_raw = t2(:,4); % Biologic - column 4
        capacity = capacity_final_format(capacity_raw,plot_mode,active_mass,sample_diameter); % call to ONE function
        total_time = t2(:,5); % (s)
        current_density = t2(:,6)/active_mass; % normalise the current density (mA/g)
            
        % INDEXING
        halfcycle = t2(:,2);

%--------------------------------------------------------------------------
% OUTPUT - 15/12/2022
%--------------------------------------------------------------------------
    % Different OUTPUT options 
            if(t_size > my_selection_criticial) % EIS (Biologic)
                output = [voltage,total_time,capacity,current_density,halfcycle,t2(:,7:end)];
                % Output: Voltage, Time(s), Capacity(mAh/g), Current Density (mA/g), HALFCYCLE, EIS(7-11)

            elseif(t_size == my_selection_criticial) % dQdV (Biologic)
                dQdV = t2(:,my_selection_criticial)/active_mass; % normalise the dQdV (mAh/g/V)

                % Output
                output = [voltage,total_time,capacity,current_density,halfcycle,dQdV];
                % BIOLOGIC: Voltage (V), halfcycle, Discharge (mAh/g), Charge (mAh/g), time (s), Current (mA/g), dQdV (mAh/g/V)

            else % Normal CC or CV data
                % Output
                output = [voltage,total_time,capacity,current_density,halfcycle];
                % Output: Voltage, Time(s), Capacity(mAh/g), Current
                % Density (mA/g), HALFCYCLE
            end % if-statement 
end % function - master 