%--------------------------------------------------------------------------
% Title:    Break the Plot
% Author:   A.Marinov
% Date:     6th Feb 2022 
% Version:  A1
% Status:   Developing

% Note:     For any dataset including a mix of CC and CV data the standard
% breaktheplot() function I have used thus far is unable to operate. The
% reason is that with CVs, the halfcycle indicator fails to separate out
% cycles. It considers them all the same. So, if there are several
% consequitive CVs it lumps them all together. Not only that but also the
% fact that it sometimes randomly throws CC data into that mix too. The
% halfcycle number is completely and utterly broken. 

% Goal: Need to figure out how to automatically sift data by voltage,
% because I might run the same script on cells cycles in different voltage
% ranges. I do not want to have to set the voltage range. 


% mydata = [Voltage (V), halfcycle, Discharge (mAh/g), Charge (mAh/g), time (s),
           % Current (mA/g), dQ (mA.h), dQdV (mAh/g/V)]

function output = breaktheplotCV(mydata,my_source,mycv_voltagelimit_low,mycv_voltagelimit_high)
%--------------------------------------------------------------------------
% FIXED PARAMETERS
    mytolerance = 0.5; % V
    % space_threshold = 100; % used for the space between two indexes in order to cut the data 
    space_threshold = 10; % used for the space between two indexes in order to cut the data 
    cut_length = 200; % cycles with length of data less than this are false (e.g there is a spike in voltage at the start of cycle - and thus removed). 
%--------------------------------------------------------------------------
% Data from import_cell_data_cycle - passed down in this manner 
% BIOLOGIC:  Voltage, Time(s), Capacity(mAh/g), Current Density (mA/g), HALFCYCLE, dQdV/EIS(7-11)
    [column_voltage,column_total_time,column_capacity,column_current_density,~,~,~,~] = getmy_celldata_columns(my_source);

%--------------------------------------------------------------------------
% OPEN the dataset (voltage) - mydata is the dataset passed into the fuction as a cell   
% Open the Data into its components 
    voltage = mydata(:,column_voltage); % (V)

%--------------------------------------------------------------------------
% Find the MAX and MIN voltages for the CV cutting algorithm  
    % MAX
    true_volt_max = max(voltage);
    if(isempty(mycv_voltagelimit_high))
        % voltage_goal = 3.00; % V - this is the assumed OCV (used for the cut of the data) 
        voltage_goal = true_volt_max;
    elseif (mycv_voltagelimit_high < true_volt_max)        
        voltage_goal = mycv_voltagelimit_high;
    else 
        voltage_goal = true_volt_max;
    end 


    [volt_max_cutindex,volt_max_cut] = voltage_tolerance(voltage,voltage_goal,mytolerance,space_threshold,1);
    

    % MIN
    volt_min_true = min(voltage);
    if(isempty(mycv_voltagelimit_low))        
        volt_min = volt_min_true;
    elseif(mycv_voltagelimit_low > volt_min_true)
        volt_min = mycv_voltagelimit_low;
    else
        volt_min = volt_min_true;
    end


    [volt_min_cutindex,~] = voltage_tolerance(voltage,volt_min,mytolerance,space_threshold,2);
  
        %Testing - 14/12/2022 (** issues with cuts)
%         voltage_test_max = [volt_max_cutindex,voltage(volt_max_cutindex)]; 
%         voltage_test_min = [volt_min_cutindex,voltage(volt_min_cutindex)];
%--------------------------------------------------------------------------
% Cutting the data - based on MAX voltage cutoff
%--------------------------------------------------------------------------
% Approach 2
% Uses the MAX voltage only to cut full cycles 
    for i = 1:length(volt_max_cutindex) % so can do forwards step (i-1) 
        if(i==1) % 1
            data_CV_intermediate{i} = mydata(1:volt_max_cutindex(i),[column_voltage column_total_time column_capacity column_current_density]); % what are these indices????
        else % 2-end
            data_CV_intermediate{i} = mydata(volt_max_cutindex(i-1)+1:volt_max_cutindex(i),[column_voltage column_total_time column_capacity column_current_density]);
        end % if statement 
    end % for loop
%--------------------------------------------------------------------------
% CV Cycles 
%--------------------------------------------------------------------------   
% Uses median, mean, and sorting to establish which cycles are CV, based on
% the data size of each full cycle. CV cycles have much larger data (but
% this varies from cell to cell!
[cycles_CV,data_CV_size_i,data_CV_intermediate] = getmeCVcycles(data_CV_intermediate,cut_length);

%--------------------------------------------------------------------------
% Cutting the CC Cycles - based on Max and Min Voltage
%--------------------------------------------------------------------------
% Uses Max and Min voltages to cut the full dataset - and order the data in
% the generic architecture for CC data so that all other processes can be
% applied 
data_CC_intermediate = cutCVfullcycle_intoCC(mydata,volt_max_cutindex,volt_min_cutindex,my_source);   

%**------------------------------------------------------------------------
% 11/01/2023
% Cuts CC cycle data out of the CV full cycle stack. This allows it to fit
% with the more generic CC data format for degradation...etc
    [cycles_CC,data_CC_output] = getmeCCcycles_CV(data_CC_intermediate,cycles_CV);
%     disp('breaktheplotCV - 18/01/2023')

%--------------------------------------------------------------------------
% OUTPUT
% CV full cycles, CC data processed, CV cycles, CC cycles, cycle size, volt cut index and voltage
output = {data_CV_intermediate,data_CC_output,cycles_CV,cycles_CC,data_CV_size_i,[volt_max_cutindex,volt_max_cut]};   
end %function master 
