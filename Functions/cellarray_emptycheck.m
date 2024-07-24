%--------------------------------------------------------------------------
% Title:    

% Author:   A.Marinov
% Date:     13th Dec 2022
% Version:  A1
% Status:   Developing

% Note: Makes sure there is no empty [] entries in a cell array

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [output_data,output_length,output_cycle] = cellarray_emptycheck(input)

    input_length = length(input);
    input_index = cellfun(@isempty,input) == 0; % find index of non [] cells 

    output_data = input(input_index);
    output_length = length(output_data); % END cycle (active)

    cycle_array = 1:input_length;
    output_cycle = cycle_array(input_index);
%     output_cycles = 1:output_length; % All active CYCLES 

end % master function 