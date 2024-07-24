%--------------------------------------------------------------------------
% Title:    Polarisation - Title (switch)

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Title - Polarisation/CV/dQdV 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function my_polarisation_title(plot_mode,my_legend,my_title,cycles)

[plot_mode_switch,~,plot_mode_multi] = switch_plot_mode(plot_mode);
    
    switch plot_mode_multi
        case 1 % SINGLECell - Multi CYCLE
%         case{1,2,3,4,5,17,13,14,15,33,34,35,24,39} % SINGLECell - Multi CYCLE
            title(strcat(my_legend,my_title),'Interpreter','latex');
%         case{6,7,16,18,19,23,26} % MULTICell - Single CYCLE Comparison
        case 2 % MULTICell - Single CYCLE Comparison
            switch plot_mode_switch
                case 4
                    title((my_title),'Interpreter','latex'); % where cycle label does not make sense (all time or all capacity)
                otherwise
                    title(strcat('Cycle: ',num2str(cycles),my_title),'Interpreter','latex');
            end % switch - plot_mode_switch 
        otherwise % MULTICell
        title(my_title,'Interpreter','latex');
    end

end % function - master 
