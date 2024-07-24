%--------------------------------------------------------------------------
% Title:    BIOLOGIC only - CC data from CV full cycle stack
% Author:   A.Marinov
% Date:     18th Jan 2023
% Version:  A1
% Status:   Developing

% Note:     
%--------------------------------------------------------------------------
function output = cutCVfullcycle_intoCC(mydata,volt_max_cutindex,volt_min_cutindex,my_source)

% Data from import_cell_data_cycle - passed down in this manner 
% BIOLOGIC:  Voltage, Time(s), Capacity(mAh/g), Current Density (mA/g), HALFCYCLE, dQdV/EIS(7-11)
[column_voltage,column_total_time,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(my_source);

volt_index_rough = sort([volt_max_cutindex;volt_min_cutindex]); % orders the cutting INDECES (for MAX and MIN) - so that they are sequential. Cut top, cut bottom...etc etc

% Approach 1 / 2 - not working as well as intended (identified 14/12/2022)
    for i = 1:length(volt_index_rough)

        % Testing 11/01/2023
        ii = round(i/2);

        % Issue here is that the capacity passed through is NEGATIVE - whereas for other CC datasets it is positive
        if(i==1)
            if(ismember(volt_index_rough(i),volt_min_cutindex)) % DISCHARGE
                output{2,ii} = mydata(1:volt_index_rough(i),[column_voltage column_total_time column_capacity column_current_density]);
            else % CHARGE
                output{1,ii} = mydata(1:volt_index_rough(i),[column_voltage column_total_time column_capacity column_current_density]);
            end
        elseif(ismember(volt_index_rough(i),volt_min_cutindex)) % DISCHARGE
            output{2,ii} = mydata(volt_index_rough(i-1):volt_index_rough(i),[column_voltage column_total_time column_capacity column_current_density]);
        else % CHARGE (is member of volt_max_cutindex)
            output{1,ii} = mydata(volt_index_rough(i-1):volt_index_rough(i),[column_voltage column_total_time column_capacity column_current_density]);
        end %if statement
    end % for loop 

end % master - function