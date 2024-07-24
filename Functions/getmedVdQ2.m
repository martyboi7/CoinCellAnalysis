%--------------------------------------------------------------------------
% Title:    dVdQ Analysis + Plotting 
% Author:   A.Marinov
% Date:     29th Oct 2021
% Version:  A1
% Status:   Developing 

% Note:     Processes the introduced dVdQ data and generates the plot 


function getmedVdQ2(mydata_trimmed,cycles_input,plot_mode,dQdV_conditions,my_color,mygraph_linewidth)
%--------------------------------------------------------------------------
% INPUT Handling

    % Discharge CYCLE - 13/12/2022
    [odddata,~,~] = cellarray_emptycheck(mydata_trimmed(2,:));
    % use function to get non-empty data for charge 

    % Ccharge CYCLE - 13/12/2022
    [evendata,cycles_charge_length,~] = cellarray_emptycheck(mydata_trimmed(1,:));
    % use function to get non-empty data for charge 

    if(cycles_charge_length == 0) % D1 only (e.g EX cells)
        charge_missing = true; % conditional
    else
        charge_missing = false;
    end

    disp('       getmedVdQ2')

% switched to using charge - as more likely to have empty cycles!
if(cycles_charge_length == 0)
    if(cycles_input == 1) % D1 only (e.g EX cells)
        cycles = cycles_input;
    else
       disp('       Error - getmedVdQ2: No charge cycles PRESENT.') 
    end
elseif(max(cycles_input)>cycles_charge_length)
    disp('       Error - getmedVdQ2: Cycle set outside of file bounds. Select smaller selection of cycles.')    
    % Set new cycles 
    if(length(cycles_input) == 1) % e.g. [100]
        cycles = cycles_input(1):cycles_charge_length; % use the one extracted from the function above (input-handling)
    elseif(length(cycles_input) > 1) % e.g. [1,10,500]
        cycles_new = find(cycles_input < cycles_charge_length); % find where cycles are within the range
        cycles = cycles_input(cycles_new);
    end
    my_color = mycolor_validate(plot_mode,my_color,cycles,1); % getcolors
elseif(isempty(cycles_input))
    disp('       Error - getmedVdQ2: Cannot plot without defined cycles')
    % Set new cycles 
    cycles = 1:cycles_charge_length; % use the one extracted from the function above (input-handling)
    my_color = mycolor_validate(plot_mode,my_color,cycles,1); % getcolors
elseif(cycles_charge_length > length(my_color))
    my_color = mycolor_validate(plot_mode,my_color,cycles_input,1); % getcolors
    cycles = cycles_input; % assignment
else 
    cycles = cycles_input; % assignment 
end


% Color Assignment for CV - profile that brings in dQdV plot_mode == 25
switch plot_mode
    case 25
        plot_mode = 14;
        cycles = 1:cycles_charge_length;
        my_color = mycolor_validate(plot_mode,my_color,cycles,1);
end



%--------------------------------------------------------------------------
% INPUT PARAMETERS - from main menu
    y_axis_limit = dQdV_conditions{1}; % ACTIVE. Upper limit dQdV is allowed to take (avoid noise)
    y = dQdV_conditions{2}; % ACTIVE. Taken from Yang2019d paper to smoothen dQdV data. OG value 100 (tested on: 210827_M1). Backwards derivative difference - spacing (number of points back)
    edge_limit_points = dQdV_conditions{3}; % ACTIVE. Remove the last x points
    edge_limit_voltage = dQdV_conditions{4}; % ACTIVE. Remove the last ? points based on the voltage difference from the edge
%--------------------------------------------------------------------------
% DILEMA
% alex_factor = 2e3; %compression factor
% the above alex factor is a bit of a data analysis dilema. It removes any big outliers (acts as current density restriction!). 
% Hence the peaks are more compressed (but also miss segments over y mAh/g/V)
% without major spikes (although still rough). However, no idea if this is
% the right number to use and whether it can be applied to all cells. 
%--------------------------------------------------------------------------
% If selection of cycles e.g [1,2,4,5] or [1:5]
%         k = 1; %dummy variable for counter (only used for SINGLECell). Counts which colour to use correctly. 

[column_voltage,~,column_capacity,~,~,~,~,~] = getmy_celldata_columns(1);
k = 1; % color counter 
        
        for i = cycles %specified by the user
            %--------------------------------------------------------------
            % Discharge
            %--------------------------------------------------------------
            thedata_discharge = odddata{1,i}; % take out the cell-array index matching the cycle being processed 
            
            % data to be stored in format dQdV_raw = [voltage, dQdV]
            thedata_discharge_dQdVraw(:,1) = thedata_discharge(:,column_voltage); % voltage (V)
            thedata_discharge_dQdVraw(1,2) = NaN; % make the first dQdV index unavailable 
            
            % Calculate dQ/dV (mAh/g/V) for the discharge cycle 
            for j = y+1:length(thedata_discharge) % start from 2 as need toi be able to do difference (j-1)
                % dV - calculation
%                 dV_discharge(j,1) = thedata_discharge(j,column_voltage) - thedata_discharge(j-y,column_voltage); % dV (V)
                

                if((thedata_discharge(j,column_voltage) - thedata_discharge(j-1,column_voltage)) < 0) % removes section of discharge (when discharge hits target) and VOLTAGE starts climbing again
                    % dQdV - calculation. (mAh V/g)
                    thedata_discharge_dQdVraw(j,2) = (abs(thedata_discharge(j,column_capacity)) - abs(thedata_discharge(j-y,column_capacity))) / (thedata_discharge(j,column_voltage) - thedata_discharge(j-y,column_voltage));
                end
                
                % dVdQ
%                 thedatadQdV_raw(j,2) = (thedata(j,1) - thedata(j-1,1)) / (thedata(j,2) - thedata(j-1,2));
            end %  for loop - j
            
            % Data smoothing
            rowsToDelete_discharge = thedata_discharge_dQdVraw(:,2) >= 0 | thedata_discharge_dQdVraw(:,2) < - y_axis_limit; 
                % find values to remove. As cathodic scan the values to keep should be ZERO or smaller. Trim off the min set. 
                % Hence remove positive values and smaller than - max
            thedata_discharge_dQdVclean = thedata_discharge_dQdVraw; % replicate the data
            thedata_discharge_dQdVclean(rowsToDelete_discharge,2) = NaN; % remove the positive values from the anodic scan (negative ONLY)
            dqdv_discharge_noNaN = rmmissing(thedata_discharge_dQdVclean); % remove the missing entries (which we just introduced)

            %--------------------------------------------------------------
            % Charge
            %--------------------------------------------------------------
            if(charge_missing == true)
                if(edge_limit_points == 0)
                    dqdv_final = dqdv_discharge_noNaN; % final dQdV for cycle - merged together from discharge and charge 
                else
                    dqdv_final = dqdv_discharge_noNaN(edge_limit_points:end-edge_limit_points,:); % final dQdV for cycle - merged together from discharge and charge
                end % if-statement
                dqdv_final = dqdv_discharge_noNaN; % assign
            else % assign the charge data)
                thedata_charge = evendata{1,i}; % take out the cell-array index matching the cycle being processed 
                
                % data to be stored in format dQdV_raw = [voltage, dQdV]
                thedata_charge_dQdVraw(:,1) = thedata_charge(:,1); % voltage (V) 
                thedata_charge_dQdVraw(1,2) = NaN; % make the first dQdV index unavailable 
                
                % Calculate dQ/dV (mAh/g/V) for the charge cycle 
                for f = y+1:length(thedata_charge) % start from 2 as need toi be able to do difference (f-1)
                    % dV - calculation
    %                 dV_charge(f,1) = thedata_charge(f,column_voltage) - thedata_charge(f-y,column_voltage);
                    
                    if((thedata_charge(f,column_voltage) - thedata_charge(f-1,column_voltage)) > 0) % removes section of charge (when charge hits target) and VOLTAGE starts falling again
                        % dQdV - calculation. (mAh V/g)
                        thedata_charge_dQdVraw(f,2) = (thedata_charge(f,column_capacity) - thedata_charge(f-y,column_capacity)) / (thedata_charge(f,column_voltage) - thedata_charge(f-y,column_voltage));
                    end
                end % for loop - f
                
                % Data smoothing
                rowsToDelete_charge = thedata_charge_dQdVraw(:,2) <= 0 | thedata_charge_dQdVraw(:,2) > y_axis_limit;  
                    % find where values are negative or higher than max (REMOVE them) 
                    % as ANODIC scan - should be ONLY positive or ZERO
                thedata_charge_dQdVclean = thedata_charge_dQdVraw; % replicate the data
                thedata_charge_dQdVclean(rowsToDelete_charge,2) = NaN; % remove the negative values from the cathoodic scan (positive ONLY)
                dqdv_charge_noNaN = rmmissing(thedata_charge_dQdVclean); % remove the missing entries (which we just introduced)           
    
                
            %--------------------------------------------------------------
            % Merge
            %--------------------------------------------------------------
                if(edge_limit_points == 0)
                    dqdv_final = [dqdv_discharge_noNaN;[nan,nan];dqdv_charge_noNaN]; % final dQdV for cycle - meged together from discharge and charge
        %             capacity_fade{1,k} = dqdv_final; % exporting data under wrong name - for testing purposes 
        %             my_newlegend{k} = num2str(cycles(k)); %build legend   
                else
                    dqdv_final = [dqdv_discharge_noNaN(edge_limit_points:end-edge_limit_points,:);[nan,nan];dqdv_charge_noNaN(edge_limit_points:end-edge_limit_points,:)]; % final dQdV for cycle - merged together from discharge and charge       
                end % if-statement
            end % if-statement 
            
            %--------------------------------------------------------------
            % Plot - dQdV fig
            %--------------------------------------------------------------
            
            switch plot_mode
                case{14,23}
                    plot(dqdv_final(:,1),dqdv_final(:,2),'Color',my_color(k,:),'LineWidth',mygraph_linewidth) % line plot
                case{15}
                    plot(dqdv_final(:,1),dqdv_final(:,2),'o','Color',my_color(k,:)) % scatter plot
            end % switch - plot_mode line plot or scatter plot
            hold on

            k = k + 1; % dummy variable increase counter 
            
            %--------------------------------------------------------------
            % Clear
            %--------------------------------------------------------------
            clear thedata_discharge thedata_discharge_dQdVraw dV_discharge rowsToDelete_discharge dqdv_discharge_noNaN
            clear thedata_charge thedata_charge_dQdVraw dV_charge rowsToDelete_charge dqdv_charge_noNaN
            clear dqdv_final
            
            
        end % for loop - i (cycles) 
        
end 