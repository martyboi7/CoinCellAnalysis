%--------------------------------------------------------------------------
% Title:    dQdV Analysis - using the Biologic dQdV (removing
%           positive/negative from discharge/charge)
% Author:   A.Marinov
% Date:     24th Nov 2021
% Version:  A1
% Status:   Developing 

% Note:     


function getmedVdQ_Biologic(mydata_trimmed,column_dqdv,cycles,my_color)
% INPUT: 
% 1. odddata(voltage (V), Q (mAh/g), q (mA/g), time (s), dQdV (mAh/g/V), ) - cell all
%    dataset discharge
% 2. evendata(voltage (V), Q (mAh/g), q (mA/g), time (s), dQdV (mAh/g/V), ) - cell all
%    dataset charge
% 3. column_dqdv - the column where the dqdv data is in the entry data set
% 4. cycles - the cycles to plot 
% 5. my_colour - colours to use 
%--------------------------------------------------------------------------
% Input-Handling

    % Discharge CYCLE - 13/12/2022
    [odddata,~,~] = cellarray_emptycheck(mydata_trimmed(2,:));
    % use function to get non-empty data for charge 

    % Ccharge CYCLE - 13/12/2022
    [evendata,~,~] = cellarray_emptycheck(mydata_trimmed(1,:));
    % use function to get non-empty data for charge 

    % make sure there is BIOLOGIC dQdV data
    test_data = odddata{1,1}; 
    odddata_size = size(test_data);
    
    if(odddata_size(2) < 5)
        disp('Error: getmedVdQ_Biologic - you are trying to process the wrong type of Biologic data file. It does not contain dVdQ data. Either process your .mpt file or use plot_mode 14')
        Polarization = 0;
        capacity_fade = 0;
        return
    end


%--------------------------------------------------------------------------
%     k = 1; %dummy variable

    for i = cycles
        % Discharge 
        dqdv_discharge = odddata{i};
        rowsToDelete_discharge = dqdv_discharge(:,column_dqdv) > 0;  
        dqdv_discharge(rowsToDelete_discharge,column_dqdv) = NaN;
        dqdv_discharge_noNaN = rmmissing(dqdv_discharge);
        
        % Charge 
        dqdv_charge = evendata{i};
        rowsToDelete_charge = dqdv_charge(:,column_dqdv) < 0 | dqdv_charge(:,column_dqdv) > 1e10;  
        dqdv_charge(rowsToDelete_charge,column_dqdv) = NaN;
        dqdv_charge_noNaN = rmmissing(dqdv_charge);

        % Put the two together
        dqdv_final = [dqdv_discharge_noNaN;dqdv_charge_noNaN];
%         capacity_fade{1,k} = dqdv_final;
%         my_newlegend{k} = num2str(cycles(k)); %build legend   

        plot(dqdv_final(:,1),dqdv_final(:,column_dqdv),'Color',my_color(i,:))
        clear dqdv_discharge rowsToDelete_discharge dqdv_discharge_noNaN
        clear dqdv_charge rowsToDelete_charge dqdv_charge_noNaN
        clear dqdv_final
        hold on
        
%         k = k + 1; % dummy variable
    end

end
