%--------------------------------------------------------------------------
% Title:    EIS - Title (switch)

% Author:   A.Marinov
% Date:     2nd Feb 2023
% Version:  A1
% Status:   Developing

% Note: Title - EIS

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function my_eis_title(plot_mode,my_legend,my_title,cycles,d,eis_location)

% [~,~,plot_mode_multi] = switch_plot_mode(plot_mode);

%----------------------------------
% TITLE
%----------------------------------
    switch plot_mode % title and similar
        case 39 % EIS per LOCATION over many CYCLES
            title(strcat(my_legend,' - Location: ',num2str(eis_location),' V. ',my_title),'Interpreter','latex');
            legend(print_runs(cycles,'Cycle: '), 'Interpreter','latex', 'Location', 'northeast');
        case {41,42} % EIS per CYCLE over all LOCATIONS
            title(strcat(my_legend,' Cycle: ',num2str(cycles(d)),my_title),'Interpreter','latex');
            legend(print_runs(eis_location,'Voltage: '), 'Interpreter','latex', 'Location', 'northeast');
        otherwise % MULTICell
            title(my_title,'Interpreter','latex');
    end % switch - plot_mode (plot labelling)      
end % function - master 
