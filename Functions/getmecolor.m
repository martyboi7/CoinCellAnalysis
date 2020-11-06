%--------------------------------------------------------------------------
% Title:    Color Palate
% Author:   A.Marinov
% Date:     2nd Feb 2020
% Version:  A1
% Status:   Developing

% Note:   
%                               color to check, number of inputs
function my_color = getmecolor(color_input,num_entries)
    if (isempty(color_input))
        % No color was assigned 
        my_color = rand(length(filepath_sample),3); %setting the color scheme - can be changed to fixed ones 

    elseif(length(color_input) < num_entries)
        % some colors specified
        for k=length(color_input)+1:num_entries
            my_color(k,:) = rand(1,3); % assign random colors to the remainder of entries
        end
    else 
        my_color = color_input;
    end