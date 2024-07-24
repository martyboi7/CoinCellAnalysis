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
function output = output_clean_cycle(data_input,my_source)

    number_discharge = length(data_input(2,:)); % will give the larger one (so maybe 1 more D than C)
    number_charge = length(data_input(1,:)); 



    % Get data columns - universal storage order
    [column_voltage,column_total_time,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(my_source);

    % Discharge
    if(number_discharge >= 1 && ~isempty(data_input{2,1}))
        for i = 1:number_discharge
    
            raw_discharge = data_input{2,i}; % open data


            if(~isempty(raw_discharge))
                discharge_nonempty_currentdensity = find(raw_discharge(:,column_current_density)); % find where current density is NOT ZERO
        
                clean_discharge = raw_discharge(discharge_nonempty_currentdensity,column_voltage:column_current_density); % select only those columns (eliminate rests)
        
                output{2,i} = clean_discharge; % output
            else
                output{2,i} = []; % assign empty
            end
    
        end % for loop
    else 
            output{2,1} = [];
    end % if-statement


    % Charge
    if(number_charge >= 1 && ~isempty(data_input{1,1}))
        for i = 1:number_charge
    
            raw_charge = data_input{1,i}; % open data

            if(~isempty(raw_charge))
                charge_nonempty_currentdensity = find(raw_charge(:,column_current_density)); % find where current density is NOT ZERO
        
                clean_charge = raw_charge(charge_nonempty_currentdensity,column_voltage:column_current_density); % select only those columns (eliminate rests)
        
                output{1,i} = clean_charge; % output
            else 
                output{1,i} = []; % assign empty if there is not charge
            end % if statement
        end % for loop
    else
        output{1,1} = [];
    end % if statement 

end % function - master