%--------------------------------------------------------------------------
% Title:    Break the plot - Neware CC
% Author:   A.Marinov
% Date:     04/10/2022
% Version:  A1
% Status:   Developing

% Note:     The way protocol 2 is activated (for P2 testing) is seriously
% questionable. It only activates if there are 10 (EXACTLY) steps in the
% protocol. This is really problematic, if other steps are to be added in
% to the protocol. 

% ISSUE: total-time is not processed for P2 protocol first cycle!

% OUTPUT: X
%--------------------------------------------------------------------------


function data = breaktheplotCC_Neware(mydata,plot_mode,my_source)

% ** 13/12/2022 designing to fit new architecture - data format (cell array
% C | D)


%----------------------------------------
% Import Data 
%----------------------------------------  

[column_voltage,column_total_time,column_capacity,column_current_density,column_halfcycle,column_step_index,column_step_type,column_dqdv] = getmy_celldata_columns(my_source);

% NEWARE: Voltage, Time, Capacity (mAh/g), Current Density (mA/g), Cycle Number, Step Index, Step Type, dQdV
         % DATA
         voltage = mydata(:,column_voltage); % (V)
         total_time = mydata(:,column_total_time); % (s)
         capacity = mydata(:,column_capacity); % (mAh/g)
         current_density = mydata(:,column_current_density); % (mA/g)
         dqdv = mydata(:,column_dqdv); % (mAh/g/V) - NEWARE

         % INDEXING
         cycle_number = mydata(:,column_halfcycle); % for NEWARE - use column_halfcycle to mark FULL CYCLE
         step_index = mydata(:,column_step_index); 
         step_type = mydata(:,column_step_type); % step type (string) - changed to a number to represent a string 
         % REST == 1, DISCHARGE == 2, CHARGE == 3

         % REMOVED
         %energy = mydata(:,8); % (Wh/g)
         %power = mydata(:,9); % (W/g)
        
         %------------------------
         % Neware - plot_mode switch 
         %------------------------
         % * NEWARE - has an issue with how it exports time. Have developed
         % code from my_protocol = 2 to deal with this but is extremely
         % slow. Any plot_mode that does not need the time should use the
         % following switch statement assignment to skip the slow code.
%**------------------------------------------------------------------------
         switch plot_mode 
             case{16,18,48} % plot_mode which use TIME
                my_protocol = 2; 
             case{13,39,17,24,25,26,42} % plot_modes not accepted for NEWARE (CV - 17,24,25,26. dQdV - 13,39)
                disp(['Error - breaktheplotCC_Neware: NEWARE software does not allow for plot_mode:',num2str(plot_mode)]);
                return
             otherwise % plot_mode which do not use TIME
                my_protocol = 1; 
         end 
%**------------------------------------------------------------------------



%----------------------------------------
% Processing Steps 
%----------------------------------------
          cycle_number_unique = unique(cycle_number); % find the cycles
          step_index_unique = unique(step_index); % find unique step_index - if 1-5 (P1), if 1-10 (P2)
          number_cycles = length(cycle_number_unique); % cycles recognised by NEWARE software - might not be the actual number of cycles done! (happens in the case of P2 protocol)

%------------------------------------------------------------
% Total Time v2
%------------------------------------------------------------
          total_time_index_zero = find(total_time == 0); % where are the 0s in the TIME
          total_time_diff = diff(total_time);
          total_time_diff_median = median(total_time_diff); % median difference
          total_time_v2 = [0:total_time_diff_median:((length(total_time)-1) * total_time_diff_median)]';

          
          total_time_discharge = 0; % define empty dummy var. (s)
          total_time_charge = 0; % define empty dummy var. (s)
          k = 1; % dummy var. cycle - for P2 (my_protocol == 2)
          
          %--------------------------------
          for i = 1:number_cycles
          %--------------------------------
%%          VERY PROBLEMATIC SECTION - 16/01/2023
% Can result in a severe mess if P2 does not have exactly 10 steps in the
% process!!!

              cycle_index = find(cycle_number == cycle_number_unique(i)); % INDECES for the CYCLE (we are currently in) i
              step_type_cycle = step_type(cycle_index); % step types in CYCLE 
              cycle_step_index_unique = unique(step_index(cycle_index)); % check what cycle steps occur in current CYCLE

              if(length(cycle_step_index_unique) == 10) % P2 protocol needs to be reverted to long code (to split the first cycle as NEWARE does not separate them)
                my_protocol = 2;
              end 
%%
              %------------------------------------------------------------
              % Switch
              %------------------------------------------------------------
              switch my_protocol
              %------------------------------------------------------------
              % Cycle Steps
              %------------------------------------------------------------
                  case 1 % when no REST step types in cycle   
                      cycle_index_discharge = find(step_type_cycle == 2); % for cycle i - step type (== CC DChg)
                      cycle_index_charge = find(step_type_cycle == 3); % for cycle i - step type (== CC Chg)

                      % find halfcycle data - for cycle i
                      if(i == 1)
                        index_discharge = cycle_index(1:min(cycle_index_charge)-1); % index of indices for DISCHARGE
                        % NOTE: might not work if only D1!
                      else
                        index_discharge = cycle_index(1:max(cycle_index_discharge)); % index of indieces for DISCHARGE      
                      end % if-statement


%                       index_discharge = cycle_index(cycle_index_discharge); % index of indieces for DISCHARGE 
                      index_charge = cycle_index(min(cycle_index_charge):end); % index of indieces for CHARGE

%                       %------------------------------------------------------------
%                       % Discharge - OLD Version
%                       %------------------------------------------------------------
%                       data{2,i} = [voltage(index_discharge),total_time(index_discharge) + total_time_charge,-capacity(index_discharge),current_density(index_discharge),dqdv(index_discharge)];
%         
%                       if(isempty(index_discharge))
%                         total_time_discharge = total_time_charge; % Prelim data can be cut on rest step of cycle (eliminates cycle)
%                       else % normal data
%                         total_time_discharge = total_time_charge + total_time(index_discharge(end)); % adds the last discharge time every iteration of loop
%                       end
%         
%                       % Charge 
%                       if isempty(index_charge) % Preliminary Data might be cut during discharge! This breaks code otherwise.
%                           data{i} = NaN;
%                           total_time_charge = NaN; 
%                       else 
%                           data{1,i} = [voltage(index_charge),total_time(index_charge) + total_time_discharge,capacity(index_charge),current_density(index_charge),dqdv(index_charge)];
%                           total_time_charge = total_time_discharge + total_time(index_charge(end)); % adds the last charge time every iteration of loop
%                       end 
%                       % NEWARE: Voltage, Capacity, Current Density, Time, dQdV, Energy
% 
% %                       k = k + 2; % dummy variable
%                       clear cycle_index_discharge cycle_index_charge index_discharge index_charge % clean arrays for next loop 

                      %------------------------------------------------------------
                      % Discharge - v2 (17/04/2024)
                      %------------------------------------------------------------
                      data{2,i} = [voltage(index_discharge),total_time_v2(index_discharge),-capacity(index_discharge),current_density(index_discharge),dqdv(index_discharge)];
                
                      % Charge 
                      if isempty(index_charge) % Preliminary Data might be cut during discharge! This breaks code otherwise.
                          data{i} = NaN;                          
                      else 
                          data{1,i} = [voltage(index_charge),total_time_v2(index_charge),capacity(index_charge),current_density(index_charge),dqdv(index_charge)];                          
                      end 
                      % NEWARE: Voltage, Capacity, Current Density, Time, dQdV, Energy

%                       k = k + 2; % dummy variable
                      clear cycle_index_discharge cycle_index_charge index_discharge index_charge % clean arrays for next loop 
                      
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
                  case 2 % When there are 10 cycle steps in the prtocol (P2 cycling protocol)
                      cycle_index_rest = find(step_type_cycle == 1); % for cycle i - step type (== Rest)
              
                      % find the step-ups in REST index
                      index_rest = cycle_index(cycle_index_rest); % index of indieces for REST
                      index_rest_ischange = ischange(index_rest,'linear','threshold',2);
                      [index_rest_index_prelim,~] = find(index_rest_ischange); 
                      
                      index_rest_index = cycle_index_rest(index_rest_index_prelim); % Exact index of change for REST

                      % Loop defines INDEX where to split D and C
                      
                      for j = 1:length(index_rest_index)
                            if(j == 1)
                                index_cycle_steps(j,:) = [cycle_index(j),cycle_index(index_rest_index(j) - 1)]; % INDEX start 
                            elseif(j==length(index_rest_index))
                                index_cycle_steps(j,:) = [cycle_index(index_rest_index(j-1)),cycle_index(end)]; % INDEX end
                            else
                                index_cycle_steps(j,:) = [cycle_index(index_rest_index(j-1)),cycle_index(index_rest_index(j))]; % INDEX all others
                            end 
                      end 
                                   
                      if(i==number_cycles && length(cycle_step_index_unique) <= 3) % Last cycle - check has enough entries 
                                                                                   % only REST if == 1 - fill with NaN both D and C
                          end_cycle = 1; % switch counter - fill data (k) and (k-1) with NaN
                      else 
                          end_cycle = 2; % switch counter - fill data (k) and (k-1) with values. There might be no C (for k)
                      end

                      switch end_cycle
                          case 1 % only REST in cycle (prelim data or other issue)
                              data{1,i} = NaN; % charge
                              data{2,i} = NaN; % discharge

                          case 2 % at least D data (maybe C too)

                              index_cycle_steps_size = size(index_cycle_steps);
                              extra_cycles_k = length(index_cycle_steps)/2; % the number of additional cycles (accidentally put in the same cycle!)

                          for n = 1:extra_cycles_k
            
                              if(n==1)
                                  index_discharge = transpose(index_cycle_steps(n,1):index_cycle_steps(n,2)); 
                              elseif(n>1)
                                  index_discharge = transpose(index_cycle_steps(2*n-1,1):index_cycle_steps(2*n-1,2)); 
                              end

                              %-----------------------------
                              % Assignment (CYCLE == k)
                              %-----------------------------
                                  if(i==number_cycles && index_cycle_steps_size(1) == 1)
                                     data{1,k} = NaN; % Charge - empty
                                  else % Charge - present
                                     index_charge = transpose(index_cycle_steps(2*n,1):index_cycle_steps(2*n,2)); 
                                     % Charge 
%                                      data{1,k} = [voltage(index_charge),total_time(index_charge) + total_time_discharge,capacity(index_charge),current_density(index_charge)];
                                     data{1,k} = [voltage(index_charge),total_time_v2(index_charge),capacity(index_charge),current_density(index_charge)];
                                  end
                    
                                  % Discharge 
%                                   data{2,k} = [voltage(index_discharge),total_time(index_discharge) + total_time_charge,-capacity(index_discharge),current_density(index_discharge)];
                                  data{2,k} = [voltage(index_discharge),total_time_v2(index_discharge),-capacity(index_discharge),current_density(index_discharge)];
                                  k = k + 1; % increase CYCLE counter
            
                              clear index_discharge index_charge % clean indeces
                          end % for loop - n - defines cutting index array

                      clear index_cycle_steps index_rest index_rest_index_prelim

                      end % switch - end_cycle

              end % switch - my_protocol 
             
              clear cycle_index step_type_cycle               
              
          end % for loop - i (NEWARE - number cycles)
end % function - master 