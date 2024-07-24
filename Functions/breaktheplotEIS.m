%--------------------------------------------------------------------------
% Title:    Break the plot - EIS (Biologic)
% Author:   A.Marinov
% Date:     04/10/2022
% Version:  A1
% Status:   Developing
% Note: 

% OUTPUT: 
%--------------------------------------------------------------------------
function output = breaktheplotEIS(cell_data,my_source,plot_mode,sample_per_CYCLE_EIS)

disp('breaktheplotEIS')
halfcycle_eis2_bug_tester_threshold = 300; % used in if statements!

% BIOLOGIC: Voltage (V), halfcycle, Discharge (mAh/g), Charge (mAh/g), time (s), Current (mA/g), dQdV (mAh/g/V) OR EIS
%     [voltage,halfcycle_unique,discharge,charge,total_time,current_density,dqdv,mydata_size,dqdv_position] = breaktheplot_BiologicSplit(mydata);

% get the switchers 
% [plot_mode_switch,plot_mode_code] = switch_plot_mode(plot_mode);

[column_voltage,column_total_time,column_capacity,column_current_density,column_halfcycle,~,~,column_dqdv] = getmy_celldata_columns(my_source);
mydata_CC = breaktheplotCC_BiologicData(cell_data(:,column_voltage:column_halfcycle),my_source); % use the structure to get the data split for CC

mydata_size = size(cell_data); % need for below if statement
mydata_CC_size = length(mydata_CC); % number of cycles 

% CC parameters - EIS 2 test
halfcycle = cell_data(:,column_halfcycle); % halfcycle - column 5
halfcycle_unique = unique(halfcycle);

halfcycle_unique_length = length(halfcycle_unique);
halfcycle_eis2_bug_tester = mydata_size(1)/(halfcycle_unique_length-1); % if smaller than 300 (causes EIS 2 issues)
%--------------------------------------------------------------------------
% Sequence - EIS - to be turned into a function at some point!
% Open the EIS data 
      if(mydata_size(2) == column_dqdv+9)
      %------------------------------------------
            voltage = cell_data(:,column_voltage); % voltage
            capacity = cell_data(:,column_capacity); % capacity (mAh/g)
    
            % EIS 
            freq = cell_data(:,column_dqdv); % column 6
            z = cell_data(:,column_dqdv+1);
            phase_z = cell_data(:,column_dqdv+2);
            zcycle = cell_data(:,column_dqdv+3); 
            re_z = cell_data(:,column_dqdv+4);
            im_z = cell_data(:,column_dqdv+5);
            re_y = cell_data(:,column_dqdv+6);
            im_y = cell_data(:,column_dqdv+7);
            y = cell_data(:,column_dqdv+8); % column 14
            phase_y = cell_data(:,column_dqdv+9); % column 15
    
          myarray_eis = [voltage,capacity,freq,z,phase_z,zcycle,re_z,im_z,re_y,im_y,y,phase_y]; % testing

      elseif(mydata_size(2) < column_dqdv+9) % most likely z_cycle missisng 13/04/2023

                      voltage = cell_data(:,column_voltage); % voltage
            capacity = cell_data(:,column_capacity); % capacity (mAh/g)
    
            % EIS 
            freq = cell_data(:,column_dqdv); % column 6
            z = cell_data(:,column_dqdv+1);
            phase_z = cell_data(:,column_dqdv+2);
            %zcycle = ; 
            re_z = cell_data(:,column_dqdv+3);
            im_z = cell_data(:,column_dqdv+4);
            re_y = cell_data(:,column_dqdv+5);
            im_y = cell_data(:,column_dqdv+6);
            y = cell_data(:,column_dqdv+7); % column 13
            phase_y = cell_data(:,column_dqdv+8); % column 14

            disp('breaktheplotEIS: zcycle - missing from entry')
            z_size = size(z);
            zcycle = ones(z_size(1),z_size(2)); % dummy to fill array
    
            myarray_eis = [voltage,capacity,freq,z,phase_z,zcycle,re_z,im_z,re_y,im_y,y,phase_y]; % testing
      else
        disp('Error - breaktheplotEIS: EIS data not present in your file!')
        return
      end % if-statement assignment 

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% NEW CODE - 19/01/2023
% operates on the whole dataset in ONE step
% (14/04/2023) sequence is always run - as voltage method needs the number_EIS calculation
    index_z = find(z); %find all the z indices that are nonZERO
    index_z_ischange = ischange(index_z,'linear','threshold',2); % find the increase skips in the sequence of indeces (as space between them is removed)
    index_z_ischange_indexA = find(index_z_ischange==1); % get the index of EIS data - for halfcycle
    index_z_ischange_indexB = index_z_ischange_indexA - 1; % the index before (is the end of each EIS step)
    
    % Execution
    % index_z_final = index_z([1;index_z_ischange_indexA;length(index_z)]);
    index_z_start = index_z([1;index_z_ischange_indexA]);
    index_z_end = index_z([index_z_ischange_indexB;length(index_z)]);
    
    index_z_final = [index_z_start,index_z_end]; % START EIS index - END EIS index
    index_z_test_me = index_z_end - index_z_start; % difference between the start and end of the EIS scan (should all be the same)
    
    number_EIS = length(index_z_final); % counts of EIS
    number_EIS_per_CYCLE = number_EIS/mydata_CC_size; % testing 19/01/2023
    number_EIS_per_CYCLE_round = round(number_EIS_per_CYCLE); % round up
    %-------------------------------------
if(halfcycle_eis2_bug_tester > halfcycle_eis2_bug_tester_threshold)
    p_counter = mydata_CC_size-1; % number of cycles (might be incomplete)
    %** using the -2 (to guarantee is a complete set of data - as have not
    %designed the cell check below yet - new unified approach should
    %counter? Have not tested 29/03/2023 

    u_counter = number_EIS_per_CYCLE_round; % trying to save all the EIS entries

    % developing - 29/03/2023
    halfcycle_changes = ischange(halfcycle); % find where the changes happen
    halfcycle_change_index = find(halfcycle_changes); % find the indexes
    index_end = max(find(voltage == voltage(end)));
    eis_switch = 1; % data normal - halfcycles used to cut

    index_test = [halfcycle_change_index(2:2:end);index_end]; %needs to be based on the p-counter (second of halfcycle unique)

elseif(halfcycle_eis2_bug_tester <= halfcycle_eis2_bug_tester_threshold) % halfcycles cannot be trusted - therefore using this metric instead (which is number of data per unique halfcycle)
    %----------------------------------------------------------------------
    % VOLTAGE method - developing 29/03/2023
    %----------------------------------------------------------------------
    % use the capacity column - where it switches between NEGATIVE and POSITIVE
    halfcycle_eis2_valueswitch = find(capacity(1:end-1)>0 & capacity(2:end) < 0);
    halfcycle_eis2_valueswitch_length = length(halfcycle_eis2_valueswitch);
    halfcycle_eis2_cycles = halfcycle_eis2_valueswitch_length/2;

    % FIXED PARAMETERS
    mytolerance = 0.5; % V
    voltage_goal = 3.00; % V - this is the assumed OCV (used for the cut of the data)  
    space_threshold = 10; % used for the space between two indexes in order to cut the data    
    
    %--------------------------------------------------------------------------
    % Find the MAX and MIN voltages for the CV cutting algorithm  
        % MAX
        [volt_max_cutindex,volt_max_cut] = voltage_tolerance(voltage,voltage_goal,mytolerance,space_threshold,1);
        
        % MIN
        volt_min = min(voltage);
        [volt_min_cutindex,volt_min_cut] = voltage_tolerance(voltage,volt_min,mytolerance,space_threshold,2);      

        index_end = find(voltage == voltage(end));
        volt_max_cutindex_2 = [volt_max_cutindex;index_end]; % append last avaialble index

        number_cycles = length(volt_max_cutindex_2); % number NEW cycles (this is a correction for unfinished DATA) 
        number_EIS_per_CYCLE = number_EIS/number_cycles; 
        number_EIS_per_CYCLE_round = round(number_EIS_per_CYCLE); % EIS per cycle: ,"TieBreaker","plusinf"

        if(number_EIS_per_CYCLE_round > sample_per_CYCLE_EIS)
            number_EIS_per_CYCLE_final = number_EIS_per_CYCLE_round;
        else
            number_EIS_per_CYCLE_final = sample_per_CYCLE_EIS;
        end

        % Exports for Unified approach
         p_counter = number_cycles; %
         u_counter = number_EIS_per_CYCLE_final; % EIS scans per cycle - user input
         index_test = volt_max_cutindex_2; % all matches for 3.00 V and added END 
         eis_switch = 2; % when data is problematic - needed voltage to cut instead of halfcycles
else
    disp('Error - breaktheplotEIS: EIS data could not be assinged. Either cell does not contain EIS data, or there are too few complete EIS cycles!')
    returN % BREAKS CODE
end % if statment - output


%--------------------------------------
% Unified Approach
%--------------------------------------

j = 1; % dummy var - index for index_z_start
eis_voltage_test_difference = 0.5*ones(u_counter,1); % dummy var

for p = 1:p_counter % CYCLE

    switch eis_switch
        case 2
            if(p==2)
                for y = 2:length(eis_voltage)
                    eis_voltage_diff(y-1,1) = abs(eis_voltage(y) - eis_voltage(y-1)); % diff = y - (y-1)                    
                end % for loop - y        
                eis_voltage_diff_mean = mean(eis_voltage_diff);
                eis_voltage_test_difference = [eis_voltage_diff;eis_voltage_diff(end)]; %extedn - copy the last one a second time - so there is a marker for each!
            end % if-statement
    end % switch - eis_switch



    for u = 1:u_counter % EIS scans per CYCLE

        % For debugging purposes only!
%         if(p==10)
%             disp('hello')
%         end


        if(j > length(index_z_start))  % if not enough EIS scans to fill matrix
            mydata_eis{u,p} = []; % empty
        elseif(index_z_start(j) <= index_test(p)) % need to make sure above some index too? NEEDS a switch

            switch eis_switch % halfcycle (1) or voltage (2) used to cut
                case 2 % voltage - when halcycle WRONG
                    % 30/03/2023 - sorting out voltage storage 
                    if(p == 1) % first CYCLE only
                        eis_voltage(u,1) = mean(myarray_eis(index_z_start(j):index_z_end(j),1)); % average voltage                
                    end % if-statement p
        
                        eis_voltage_test(u,1) = mean(myarray_eis(index_z_start(j):index_z_end(j),1)); % average voltage      
        
        %-------------------------------
        % introduce a conditional which makes sure that the voltage and voltage
        % test align in some manner before saving (this would not work for time at
        % all!)
        
        % IDEAS is sort of working! But not quite right - there are doublets
        % sometimes!
        
        %-------------------------------
        eis_conditional = abs(eis_voltage_test(u,1) - eis_voltage(u,1));
                    if(eis_conditional <= eis_voltage_test_difference(u) || eis_conditional <= 0.1) % testing 
                        mydata_eis{u,p} = myarray_eis(index_z_start(j):index_z_end(j),:);
                        mydata_eis_test(u,p) = mean(myarray_eis(index_z_start(j):index_z_end(j),1)); % average voltage for - validation
                        j = j+1; % increase the counter 
                    else
                        mydata_eis{u,p} = []; % empty
                    end % is-statement
                otherwise % halfcycle
                        mydata_eis{u,p} = myarray_eis(index_z_start(j):index_z_end(j),:);
                        mydata_eis_test(u,p) = mean(myarray_eis(index_z_start(j):index_z_end(j),1)); % average voltage for - validation
                        j = j+1; % increase the counter 
            end % switch - eis_switch
                    

        else 
            mydata_eis{u,p} = []; % empty
        end % if-statement 
    end % for loop - u

    clear eis_voltage_test
end % for loop - p



%--------------------------------------------------------------------------
% EXPORT DATA
%--------------------------------------------------------------------------
% EXPORT - var.s 
    output = {mydata_eis,mydata_CC,mydata_eis_test}; % output the desired data
% CC data in format for architecture (voltage,time,capacity,current density)
% EIS data: Voltage, Frequency, Z, Phase Z, Z cycle, Re Z, Im Z, Re Y, Im Y, Y, Phase Y 

end % function - master 