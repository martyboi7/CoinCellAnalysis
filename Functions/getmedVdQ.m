%--------------------------------------------------------------------------
% Title:    dVdQ Analysis + Plotting 
% Author:   A.Marinov
% Date:     29th Oct 2021
% Version:  A1
% Status:   Developing 

% Note:     Processes the introduced dVdQ data and generates the plot 


function [thedataexportdQdV,my_newlegend] = getmedVdQ(mydata,cycles,oddeven,dQdV_conditions)
% INPUT: 
% 1. mydata(voltage (V), dQdV (mAh/g/V), Q (mAh/g)) - data to process
% 2. cycles - the cycles to plot 
% 3. oddeven - logical. 1 if discharge cycles, 0 if charge. Used to remove
%              reverse values. 
% 4. Logical - if to smooth or not. Polynomial and framelength for sgolygit

smoothme = dQdV_conditions{1}; 
cond = dQdV_conditions{2};

% If selection of cycles e.g [1,2,4,5] or [1:5]
        k = 1; %dummy variable
        for i = cycles

            thedata = mydata{1,i}; % take out the cell matching the cycle being processed 
            
            thedatadQdV_raw(:,1) = thedata(:,1); %voltage 
            thedatadQdV_raw(1,2) = NaN; % make the first dQdV index unavailable 
            
            thedatadQdV_clean(:,1) = thedata(:,1); %voltage 
            thedatadQdV_clean(1,2) = NaN; % make the first dQdV index unavailable 
            
%             thedatadQdV(:,k) = thedata(2:end,1); %voltage 
%             thedatadQdV(1,k+1) = 0; % dummy as cannot have dVdQ or 
            
            % cycle to do dQ/dV (mAh/V)
            for j = 2:length(thedata)
                % raw data only
                dV(j,1) = thedata(j,1) - thedata(j-1,1);
                
                % dQdV
                thedatadQdV_raw(j,2) = (thedata(j,2) - thedata(j-1,2)) / (thedata(j,1) - thedata(j-1,1));
                
                % dVdQ
%                 thedatadQdV_raw(j,2) = (thedata(j,1) - thedata(j-1,1)) / (thedata(j,2) - thedata(j-1,2));
            end 
                
            % New Selection Method - removes opposite Q fluctuations 
            for y = 2:length(thedatadQdV_raw)

                % OddEven
                %------------------
                if(oddeven == true) % if Q is zero do not consider - as rest step
                    if(thedatadQdV_raw(y,2) > 0)
                        thedatadQdV_clean(y,2) = NaN;
                    else 
                        thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
                    end 
                else
                    if(thedatadQdV_raw(y,2) < 0)
                        thedatadQdV_clean(y,2) = NaN;
                    else 
                        thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
                    end
                end
                %------------------
                
                
            end
            
            % Old Selection Method - filters  
%             for y = 2:length(thedatadQdV_raw)   
             % Data Filtering 
                % Remove Zeros 
                %------------------
%                 if(thedata(y,2) == 0) % if Q is zero do not consider - as rest step
%                     thedatadQdV_clean(y,2) = NaN;
                %------------------
                    
                % Selector i 
                % Selector i - dQ/dV < num.
                %------------------
%                 if(abs(thedatadQdV_raw(y)) < 4e4) %only consider if dV larger than 10 mV (0.010 V) - 0.0025, 0.001
%                     thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
                %------------------
               
                
                % Selector ii - V diff. > num.
                %------------------
%                 elseif(abs(thedata(y,1) - thedata(y-1,1)) > 0.00133) %only consider if dV larger than 10 mV (0.010 V) - 0.0016
%                         thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
                %------------------
                    
                % Selector i & ii    
                % Selector i - dQ/dV < num.
                % Selector ii - V diff. > num.
                %------------------
%                 elseif(abs(thedatadQdV_raw(y,2) < 1e5) %only consider if dV larger than 10 mV (0.010 V) - 0.0025, 0.001
%                     if(abs(thedata(y,1) - thedata(y-1,1)) > 0.001) %only consider if dV larger than 10 mV (0.010 V) - 0.0016
%                         thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
%                     end
                %------------------
                
                % Break Point 
%                 if(y == 199)
%                     disp('Stop to analyse dQdV'); %use this to jam the debugger on the first error 
%                 end 
                
                
                % Selector i and iii
                % Selector i - dQ/dV < num.
                % Selector iii - if V decrease dQdV only can be negative. If V increase dQdV can only be positive.
                %------------------
%                 if(abs(thedatadQdV_raw(y)) < 4e4) %only consider if dV larger than 10 mV (0.010 V) - 0.0025, 0.001
%                     if(thedata(y,1) - thedata(y-1,1) > 0 && thedatadQdV_raw(y,2) >= 0)
%                         thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
%                     elseif(thedata(y,1) - thedata(y-1,1) < 0 && thedatadQdV_raw(y,2) <= 0)
%                         thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
%                     end
                %------------------                

                % End of If-Statement
%                 else % if dQdV exceeds the above filters 
%                     thedatadQdV_clean(y,2) = NaN; 
%                 end
                
                
                % Only remove zero Qs because rest step 
                %------------------
%                 if(thedata(y,2) == 0) % if Q is zero do not consider - as rest step
%                     thedatadQdV_clean(y,2) = NaN;
%                 else
%                     thedatadQdV_clean(y,2) = thedatadQdV_raw(y,2);
%                 end 
                %------------------
%           end
            
            if(smoothme == true)
                thedatadQdV_clean(:,2) = sgolayfilt(thedatadQdV_clean(:,2),cond(1),cond(2));
            end 

            
            export_me = [thedatadQdV_clean,thedata(:,2)];
            thedataexportdQdV{k} = export_me; % Voltage (V), dQdV (mAh/V/g), Capacity (mAh/g)
            
            clear thedatadQdV_clean thedatadQdV_raw export_me
            
            my_newlegend{k} = num2str(cycles(k)); %build legend 
            
            k = k + 1; %increase so that k = 1 is i(1), k = 2 is i(2) etc.
            
        end 
        
        
end 