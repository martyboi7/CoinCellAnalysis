%--------------------------------------------------------------------------
% Title:    Polarisation - Legend (switch)

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Legend - Polarisation/CV/dQdV

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function my_polarisation_legend(plot_mode,my_legend,cycles,auto_numbering_string,legend_location,mydata_trimmed_size,Polarization)

% NEW method 
[~,~,plot_mode_multi] = switch_plot_mode(plot_mode);

switch plot_mode
    case 56 % Y1,Y2 plot
        cycles = [cycles,cycles]; % double get repetitive entires for capacity and current
end 

    switch plot_mode_multi % switch 5 - POLARIZATION fig. Legend  
        case 1 % SINGLECell - legend: cycles
            %legend
%             [~, hobj, ~, ~] = legend(print_runs(cycles,auto_numbering_string,plot_mode), 'Interpreter','latex', 'Location', legend_location);
            [~, hobj, ~, ~] = legend(print_runs(cycles,auto_numbering_string,plot_mode),'Location', legend_location); % Thesis - Style
             % Makes the lines in legend thicker
            legend_line_width = findobj(hobj,'type','line');
            set(legend_line_width,'LineWidth',3);
        case 2 % MULTICell - legend: cells 
%             if(plot_mode == 19)
%                 mydata_trimmed_cumsum_size = flip(cumsum(mydata_trimmed_size));
%                 my_legendentries = Polarization.findobj('type','line');
%                 [~, hobj, ~, ~] = legend(my_legendentries(mydata_trimmed_cumsum_size),my_legend, 'Interpreter','latex', 'Location', legend_location);
            if(length(my_legend) < 1)
%                 [~, hobj, ~, ~] = legend(print_runs(filepath_sample,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
                [~, hobj, ~, ~] = legend(print_runs(filepath_sample,auto_numbering_string),'Location', legend_location); % Thesis - Style
            else
%                 [~, hobj, ~, ~] = legend(my_legend, 'Interpreter','latex', 'Location', legend_location);
                [~, hobj, ~, ~] = legend(my_legend,'Location', legend_location); % Thesis - style
            end
            
            legend_line_width = findobj(hobj,'type','line');
            set(legend_line_width,'LineWidth',3);
            
        % otherwise
        % no legend as too many entries - plot mode 3,4                    
    end %switch 5 - POLARIZATION fig. Legend

end % function - master 