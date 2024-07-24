%--------------------------------------------------------------------------
% Title:    Polarisation - Axis (switch)

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Axis - Polarisation/CV/dQdV

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function my_polarisation_axis(plot_mode)

% EXTRAS
hold off
grid on

% Thickness of Fig 
plot_box_thick();

% Get plot_mode_code
[~,plot_mode_code] = switch_plot_mode(plot_mode);

%--------------------------------------------------------------------------
% AXIS
%--------------------------------------------------------------------------
% Pol/CV/dQdV/EIS
    switch plot_mode_code
        case {13,24,35} % CV vs E(t)
%             my_xlabel = 'E Cell (V)';
            my_xlabel = 'Potential (V vs. Li/Li+)'; % thesis style
            my_ylabel = 'Current Density (mA/g)';
        case 28 % Capacity/Time
            switch plot_mode
                case 56 % Y1,Y2 plot
                    yyaxis left
                    my_xlabel = 'Time (hr)';
                    my_ylabel = 'Capacity (mAh/g)';                   
                    my_ylabel2 = 'Current Density (mA/g)';
                otherwise
                    my_ylabel = 'Capacity (mAh/g)';
                    my_xlabel = 'Time (hr)';
            end % switch - plot_mode
        case {32,42,25} % Polarisation - E(t) vs. time
            my_xlabel = 'Time (hr)';
%             my_ylabel = 'E Cell (V)';
            my_ylabel = 'Potential (V vs. Li/Li+)'; % thesis style
        case {12,22,33} % dQdV vs. E(t)
%             my_xlabel = 'Potential (V)';
            my_xlabel = 'Potential (V vs. Li/Li+)'; % thesis style
            my_ylabel = 'dQ/dV (mAh/g/V)';
        case 26 % current/capacity
            my_xlabel = 'Capacity (mAh/g)';
            my_ylabel = 'Current Density (mA/g)';
        case 27 % current/time
           my_xlabel = 'Time (hr)';
           my_ylabel = 'Current Density (mA/g)';
%         case {12,34} % EIS
%             xlabel('Z (Re)','Interpreter','latex')
%             ylabel('Z (Im)','Interpreter','latex')
        otherwise % Polarisation - E(t) vs Capacity (mAh/g)
            my_xlabel = 'Capacity (mAh/g)';
%             my_ylabel = 'Voltage (V)';
            my_ylabel = 'Potential (V vs. Li/Li+)'; % thesis style
    end % switch - plot_mode_code

%--------------------------------------------------------------------------
% Plot Labels
%--------------------------------------------------------------------------

% % IMPORTANT: removed >    ,'Interpreter','latex')
% from below - for the Thesis Plots
switch plot_mode_code
    case 28 % Capacity/Time
            switch plot_mode
                case 56 % Y1,Y2 plot
                    yyaxis left
                    xlabel(my_xlabel)
                    ylabel(my_ylabel)            
        
                    yyaxis right
                    ylabel(my_ylabel2)
                otherwise
                    xlabel(my_xlabel)
                    ylabel(my_ylabel)  
            end % switch - plot_mode
    otherwise 
        
        % Normal
        xlabel(my_xlabel)
        ylabel(my_ylabel)

        % LaTEX
%         xlabel(my_xlabel,'Interpreter','latex')
%         ylabel(my_ylabel,'Interpreter','latex')
end % switch - plot_mode_code 2


end % function - master