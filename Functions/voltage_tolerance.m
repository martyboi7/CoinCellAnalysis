%--------------------------------------------------------------------------
% Title:    

% Author:   A.Marinov
% Date:     18th Jan 2023
% Version:  A1
% Status:   Developing

% Note: ** Function NEEDS a lot of work to make it well functional

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [volt_cutindex,volt_cut] = voltage_tolerance(voltage,voltage_goal,mytolerance,space_threshold,min_max)
% ** last reworked 18/01/2023
    volt_findthreshold = []; % start empty
    number_iterations = 5; 
    number_iterations_whileloop = number_iterations; %used to make the while loop below iterate this many times.
    % This leads to the max or min goal being decreased - so that more and
    % more matches are found. 
    e = 1; % dummy variable 
    d = 0; % dummy variable - used to track how many times we have continued once we got first values for volt_findthreshold

%--------------------------------------------------------------------------
    while(e <= number_iterations_whileloop) % makes it spin x times more after some values are already found
    
        % for e == 1, voltage_goal is not changed, otherwise decrease the
        % goal to facilitate finding a match
        if(e > 1)
            switch min_max 
                case 1 % MAX
                    voltage_goal = voltage_goal - 0.1; % decrease the voltage allowed (as its subtracted)
                case 2 % MIN
                    voltage_goal = voltage_goal + 0.1; % increase the voltage allowed (as its subtracted)
            end
        end % if-statement 
%-------------------------------------------------------------------------- 
        % Approach 2 - use tolerance to slice
        volt_find = find(abs(voltage-voltage_goal)<mytolerance); %index - find all voltage VALUES near voltage-goal (3.00, is set above) by tolerance (0.5, is set above)
%--------------------------------------------------------------------------
        for i=1:length(volt_find) - 1 % starts at 1 so that can do (i+1)
            volt_test(i,1) = volt_find(i+1) - volt_find(i); % the difference between consequtive indeces (which have already satisfied the tolerance)
        end 
    
        clear i        
        % +1 needed so find correct index and not the previous one!
        volt_findmeone = find(volt_test > 1) + 1; %index of the indeces (where space is more than 1 - does not guarantee a cycle)
        volt_findthreshold = find(volt_test > space_threshold) + 1; %index of the indeces (where space is more than THRESHOLD - does not guarantee a cycle)
        volt_findthreshold_test = voltage(volt_find(volt_findthreshold)); % test to see values
    %----------------------------------------------------------------------
    % if-statement on e (loop counter)
        if(e <= (number_iterations_whileloop-1))
                clear volt_find volt_test volt_findmeone 
                if(~isempty(volt_findthreshold))
                    d = d + 1; % tracker - for how many times beyond a match we have gone
                end % if-statement 
                volt_findthreshold = 1;                
    %-------------------------------------------     
    % if-statment on volt_findthreshold (output)
        elseif(isempty(volt_findthreshold))
            number_iterations_whileloop = number_iterations_whileloop + number_iterations; %increase the number of iterations - until a match is found
        end % if-statement
        e = e + 1; % increase dummy variable
    end % while loop
%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------

% Prepare the cut indeces for EXPORT

    for p = 1:length(volt_findthreshold) - 1 % for the INDICES which are at the start of their respective peaks (match TOLERANCE)
        volt_range = volt_find(volt_findthreshold(p):volt_findthreshold(p+1)-1); % select INDICES range for neighbourhood
        
        switch min_max % if finding max or min peaks 
            case 1 % MAX
                [volt_range_pick(p),volt_range_index(p)] = max(voltage(volt_range)); % find INDEX of max INDEX in neighbourhood
            case 2 % MIN
                [volt_range_pick(p),volt_range_index(p)] = min(voltage(volt_range)); % find INDEX of min INDEX in neighbourhood
        end
        
        volt_findthreshold_EDITED(p) = volt_findthreshold(p) + volt_range_index(p); % create new INDEX by adding the INDEX value of the max to the start INDEX (of the neighbourhood)
        
        clear volt_range
        
    end % for loop - p
%--------------------------------------------------------------------------    
% OUTPUT
    % Cut Options - Max Indices
    volt_cutindex = volt_find(volt_findthreshold_EDITED); % INDECES - of the max peaks
    volt_cut = voltage(volt_cutindex); % export voltage values for cut

end 