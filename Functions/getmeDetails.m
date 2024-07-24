%--------------------------------------------------------------------------
% Title:    Allows any Details File to be completed (colors & legend) to
% prevent errors happening 
% Author:   A.Marinov
% Date:     7th August 2023
% Version:  A1
% Status:   Working
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [my_colors,my_legend] = getmeDetails(filepaths,my_colors,my_legend)

my_colors_size = size(my_colors); % size 

    if(my_colors_size(1) < length(filepaths))
        my_colors = getmecolor(my_colors,length(filepaths)); % assign colors - automatic
    end 

    if(length(my_legend) < length(filepaths))
        for i = length(my_legend)+1:length(filepaths)
            my_legend{i} = strcat("Sample: ", num2str(i));
        end 
    end 

end % function - master 