%--------------------------------------------------------------------------
% Title:    Finds the cycle number of CC cycles embedded in a CV technique
%           (Biologic ONLY)
% Author:   A.Marinov
% Date:     23rd August 2022
% Version:  A1
% Status:   Developing

% Note:     

% REWORK this function to take part in the break the plot CV function (have
% changed the way things are done there!!!
%--------------------------------------------------------------------------

function [cycles_CC,data_CC_output] = getmeCCcycles_CV(data_CC_intermediate,cycles_CV)


%--------------------------------------------------------------------------
% OLD Code < 11/01/2023
    
%     cycles_CC = 1:1:length(mydata_CC)/2; %dummy set
%     
%     % Eliminates CV cycles from dummy set
%     % (all cycles)
%         for g = 1:length(cycles_CC)
%             for j = 1:length(cycles_CV)
%                 if(cycles_CC(g) == cycles_CV(j))
%                     cycles_CC(g) = NaN; % puts empty value where CV cycle is
%                 end 
%             end 
%         end
%     cycles_CC = cycles_CC(~isnan(cycles_CC)); % CC cycles only
%--------------------------------------------------------------------------
% NEW Code 11/01/2023

    [data_CC_discharge,~] = cellarray_emptycheck(data_CC_intermediate(2,:)); % trying!
    [data_CC_charge,~] = cellarray_emptycheck(data_CC_intermediate(1,:)); % trying!

    cycles_CC_raw = 1:length(data_CC_discharge); % need to do for charge too? 11/01/2023
    cycles_match = find(ismember(cycles_CC_raw,cycles_CV)); % this is a long approach but guarantees match
    cycles_match_not = find(~ismember(cycles_CC_raw,cycles_CV)); % this is a long approach but guarantees match

    cycles_CC = cycles_CC_raw(cycles_match_not); % export CC cycles
    cycles_CC_length = length(cycles_CC); % the number of CC cycles

    % Discharge
    if(cycles_CC_length <= length(data_CC_discharge))
        data_CC_output(2,cycles_match_not) = data_CC_discharge(cycles_CC); % discharge
    else
        data_CC_output = nan; % empty
    end 

    % Charge 
    if(cycles_CC_length <= length(data_CC_charge))
        data_CC_output(1,cycles_match_not) = data_CC_charge(cycles_CC); % charge
    end 
end % function - master 