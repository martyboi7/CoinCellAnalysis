%--------------------------------------------------------------------------
% Title:    Print the legend (for cells)
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Finished

% Note:     

% i. Automatic Labelling of legend of multi-plot
function print_the_legend = print_runs(runs,auto_numbering_string)

if(isstring(runs) == 1)
    for k = 1:length(runs)
        print_the_legend{k} = [auto_numbering_string,num2str(k)];
    end
elseif(length(runs) > 1)
    for k = 1:length(runs)
        print_the_legend{k} = [auto_numbering_string,num2str(runs(k))];
    end
    
else
    for k = 1:runs
        print_the_legend{k} = [auto_numbering_string,num2str(k)];
    end
end