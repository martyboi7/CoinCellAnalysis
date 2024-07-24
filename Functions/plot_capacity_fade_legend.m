%--------------------------------------------------------------------------
% Title:    Degradation - Legend (switch)

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Legend - Degradation

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function plot_capacity_fade_legend(plot_mode,my_legend,legend_location,filepath_sample,auto_numbering_string)

[plot_mode_switch,~] = switch_plot_mode(plot_mode);

switch plot_mode_switch
    case {1,5,6,9} % DEGRADATION
        if(length(my_legend) < 1)
            my_legend = print_runs(filepath_sample,auto_numbering_string);        
        end % if statement 

        switch plot_mode
            case {5,11,24,44,48} % only for discharge/charge mode
                my_legend2 = my_legend; % for for loop
                clear my_legend 
                    for x = 2:2:2*length(my_legend2)
                        k = round(x/2);    % dummy variable to get the correct entry
                        my_legend{1,x-1} = my_legend2{1,k};
                        my_legend{1,x} = my_legend2{1,k};
                    end % 
        end % switch - plot_mode
end % switch - plot_mode_switch
%--------------------------------------------------------------------------
        % EXECUTE
%         legend(my_legend,'Interpreter','latex','Location',legend_location);
            % Thesis Style
            legend(my_legend,'Location',legend_location);

end % function - master 