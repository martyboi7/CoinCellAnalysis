%--------------------------------------------------------------------------
% Title:    Plot TIME fade per cycle 

% Author:   A.Marinov
% Date:     23rd March 2023
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function plot_time_fade(plot_mode,discharge_capacity,charge_capacity,my_color)

% Extract the time 
switch plot_mode 
    case 48 % TIME - fade
        plot(discharge_capacity,':o','color',my_color(1,:))
        hold on
        plot(charge_capacity,'--s','color',my_color(1,:))
        hold on
    case 49
        plot(charge_capacity,':o','color',my_color(1,:))
        hold on
    otherwise
        disp('ERROR: plot_time_fade - the plot_mode is not accepted!')
        return

end % switch 

end % master - function