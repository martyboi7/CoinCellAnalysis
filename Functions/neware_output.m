%--------------------------------------------------------------------------
% Title:    NEWARE - output cell DATA
% Author:   A.Marinov
% Date:     02/10/2022
% Version:  A1
% Status:   Developing
% Note: 
%--------------------------------------------------------------------------
function output = neware_output(mydata,active_mass,sample_diameter,plot_mode)

    t2 = table2array(mydata(:,[1,2,5,6,7,8,9,10])); % the final cut table 
    % [Cycle Number, Step Index, Voltage (V), Current (mA), Capacity (mAh), Energy (Wh), Power (W), dQdV (mAh/V)]        

    %--------------------------------------------------------------
    % Processing the specific capacities - relative to active mass
    %--------------------------------------------------------------
    voltage = t2(:,3);
    capacity_raw = t2(:,5); % NEWARE is 5 column
    capacity = capacity_final_format(capacity_raw,plot_mode,active_mass,sample_diameter); % call to ONE function    
    current_density = t2(:,4)/active_mass; % normalise the current density (mA/g)
    dQdV = t2(:,8)/active_mass; % normalise the dQdV (mAh/g/V)

    % INDEXING
    cycle_number = t2(:,1);
    step_index = t2(:,2);

    % neglected 
    energy = t2(:,6)/active_mass; % normalise the energy (Wh/g)
    power = t2(:,7)/active_mass; % normalise the power (W/g)

    %--------------------------------------------------------------
    % Create an indicator for: Rest, Discharge, Charge 
    %--------------------------------------------------------------
    step_type_cycle = string(table2array(mydata(:,3)));
      % Cycle Steps
      cycle_index_rest = find(step_type_cycle == "Rest"); % for cycle i - step type (== Rest)
      cycle_index_discharge = find(step_type_cycle == "CC DChg"); % for cycle i - step type (== CC DChg)
      cycle_index_charge = find(step_type_cycle == "CC Chg"); % for cycle i - step type (== CC Chg)

      % Create indicator
      t3(cycle_index_rest) = 1; % rest
      t3(cycle_index_discharge) = 2; % discharge
      t3(cycle_index_charge) = 3; % charge

    %--------------------------------------------------------------
    % Time 
    %--------------------------------------------------------------
    time_duration = table2array(mydata(:,4)); % time (duration) type
    time = seconds(time_duration - time_duration(1)); % converting time (duration) to seconds 
    
    %--------------------------------------------------------------
    % OUTPUT
    %--------------------------------------------------------------
    output = [voltage,time,capacity,current_density,cycle_number,step_index,t3',dQdV];
    % NEWARE: Voltage, Time, Capacity (mAh/g), Current Density (mA/g), Cycle Number, Step Index, Step Type, dQdV
end % finction - master 