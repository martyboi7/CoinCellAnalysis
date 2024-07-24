%--------------------------------------------------------------------------
% Title:    Break the plot - Biologic CC
% Author:   A.Marinov
% Date:     04/10/2022
% Version:  A1
% Status:   Developing
% Note: 

% OUTPUT: X
%--------------------------------------------------------------------------
function data = breaktheplotCC_BiologicData(mydata,my_source)
[voltage,total_time,capacity,current_density,halfcycle,halfcycle_unique,dqdv,dqdv_position] = breaktheplot_BiologicSplit(mydata,my_source);
% BIOLOGIC (CC): Voltage (V), Time (s), Capacity (+/- mAh/g), Current Density (+/- mA/g), HALFCYCLE, dQdV

% BIOLOGIC: halfcycle_identifier - layout: HALFCYCLE, D(2)/C(1), CYCLE 
% the second columns allows us to identify which halfcycle corresponds to
% discharge or charge. This is based on CC capacity values!!!


% -------------------------------------------------------------------------
% WORKIN HERE 12/12/2022
% changed the way that biologic_output works - therefore the halfcycles no
% longer match according to odd and even!!!


% ** need to check if EVERY cycle is charge or discharge - because
% algorithm eliminates low count cycles - so might have a double
% charge...etc

halfcycle_identifier = halfcycle_unique; % dummy var.
mydata_size = size(mydata); % used to figure out of dQdV (column 6) is present in dataset

    % Export order: voltage, discharge/charge, current density, total time (s), dqdv (mAh/g/V)
    for i = 1:length(halfcycle_unique)

        k = round(i/2); % dummy variable - to make the output cell consistent
    
        index = find(halfcycle == halfcycle_unique(i)); % halfcycle
        
        % INDEX - median
        index_median = round(median(index)); % index of median within the halfcycle - as the edge cases might included rest, or capacity from other halfcycles!
            if(capacity(index_median) == 0) % cycle might have a long rest (e.g. 10 hr pause then discharge)
                index_nonzero = find(capacity(index)); % find non-zeros within HALFCYCLE
                index_median = round(median(index_nonzero)); % find the Median of the part that has non-zero values
            end % if-statement added 10/02/2023
    
        if(capacity(index_median) > 0) % starts on charge
            halfcycle_identifier(i,2) = 1; % CHARGE
            halfcycle_identifier(i,3) = k; % identifies CYCLE
                if(mydata_size(2) == dqdv_position) % dQdV data provided 
                    data{1,k} = [voltage(index),total_time(index),capacity(index),current_density(index),dqdv(index)];
                else
                    data{1,k} = [voltage(index),total_time(index),capacity(index),current_density(index)];
                end % if statement - dQdV
        elseif(capacity(index_median) < 0) % starts on discharge 
                halfcycle_identifier(i,2) = 2; % DISCHARGE
                halfcycle_identifier(i,3) = k; % identifies CYCLE
                 if(mydata_size(2) == dqdv_position) % dQdV data provided 
                    data{2,k} = [voltage(index),total_time(index),capacity(index),current_density(index),dqdv(index)];
                else
                    data{2,k} = [voltage(index),total_time(index),capacity(index),current_density(index)];
                end % if statement - dQdV

        else % capacity(index(index_median)) == 0
            disp(['Error - breaktheplotCC_BiologicData: the capacity median INDEX for halfcycle:',num2str(i),' is 0. Neither negative (D) nor positve (C).'])
            % can happen if there is an extremely long pause in the protocol for cycling the cell
            % but it should be accounted for by the code prior to this if
            % statement 
        end % if statement 
    
         % BIOLOGIC: Voltage, Capacity, Current Density, Time, dQdV
        clear index k index_median index_nonzero
    end % for loop i 

end % function - master 