%--------------------------------------------------------------------------
% Title:    Print the legend (for cells)
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Finished

% Note:     

% i. Automatic Labelling of legend of multi-plot
function print_the_legend = print_runs(runs,auto_numbering_string,plot_mode)

[plot_mode_switch,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode); % get codes

if(isstring(runs) == 1) % If entry is labelled (string) e.g "hello","cell 3"
    for k = 1:length(runs)
        print_the_legend{k} = [auto_numbering_string,num2str(k)];
    end
elseif(length(runs) > 1) % If multiple entries, e.g runs = [1,5,10]
    for k = 1:length(runs)
        print_the_legend{k} = [auto_numbering_string,num2str(runs(k))];
    end    
else % If END number provided only, e.g. runs == 1, runs == 50 ...etc
%     switch plot_mode_code  
%         case {24,25,27,28} % only s (??? originally plot_mode = 51,53,55). changed 28/03/2024
            g = 1; % legend counter
            for k = runs
                print_the_legend{g} = [auto_numbering_string,num2str(k)];
                g = g+1; % increase counter
            end
%         otherwise
%             for k = 1:runs
%                 print_the_legend{k} = [auto_numbering_string,num2str(k)];
%             end
%     end % switch - plot_mode
end