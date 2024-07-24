%--------------------------------------------------------------------------
% Title:    Degradation - Axis (switch)

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Axis - Degradation

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function plot_capacity_fade_axis(plot_mode,my_title,tile_number,capacity_fade_fig)

handle_plot_mode = 1;
handle_title = "Add a title";
handle_tile_number = 1;

% input-handling
switch nargin
    case 0
        plot_mode = handle_plot_mode;
        my_title = handle_title;
        tile_number = handle_tile_number;
    case 1
        my_title = handle_title;
        tile_number = handle_tile_number;
    case 2
        tile_number = handle_tile_number;
end 


% Extras 
grid on
my_title_fade = strcat(my_title," Capacity Fade");
data_xlabel_fade = 'Cycle';

% Thickness of Fig 
plot_box_thick();

    %----------------------------------------------------------------------
    % plot_mode (Degradation Ratios)
    %----------------------------------------------------------------------

    % Title & Axis 
        switch plot_mode
            case 27
                my_title_fade = strcat(my_title_fade," Ci/Di"); % Ci/Di
                data_ylabel_fade = "Normalised Capacity (-)";
            case 28
                my_title_fade = strcat(my_title_fade," Di/Ci"); % Di/Ci
                data_ylabel_fade = "Normalised Capacity (-)";
            case 29
                my_title_fade = strcat(my_title_fade," Di/D(i=1)"); % Di/D1
                data_ylabel_fade = "Normalised Capacity (-)";
            case 31
                my_title_fade = strcat(my_title_fade," Di/Dmax"); % Di/Dmax
                data_ylabel_fade = "Normalised Capacity (-)";
            case 30
                my_title_fade = strcat(my_title_fade," Ci/C(i=1)"); % Ci/C1
                data_ylabel_fade = "Normalised Capacity (-)";
            case 32
                my_title_fade = strcat(my_title_fade," Ci/Cmax"); % Ci/Cmax
                data_ylabel_fade = "Normalised Capacity (-)";
            case 46 % AREAL Capacity (mAh/cm2)
                data_ylabel_fade = 'Capacity (mAh/cm^{2})';
            case {47,57} % AREAL Capacity (mAh/mm2)
                data_ylabel_fade = 'Capacity (mAh/mm^{2})';
            case {48,49} 
                data_ylabel_fade = 'Time (hr)';
            otherwise 
                data_ylabel_fade = 'Capacity (mAh/g)';
        end % switch plot_mode - Degradation Ratios Title and Axis

    %----------------------------------------------------------------------
    % Execute 
    %----------------------------------------------------------------------

    % Tiled plot
    if(tile_number > 1)
        xlabel(capacity_fade_fig,'Cycle','FontSize',15,'FontWeight','bold');
    else
    % Single TILE
        % Title 
%         title(my_title_fade,'Interpreter','latex'); % commented out for Thesis 
        % Axis 
    %     xlabel(data_xlabel_fade,'Interpreter','latex')
    %     ylabel(data_ylabel_fade,'Interpreter','latex')
        
            % Thesis - Style
            xlabel(data_xlabel_fade) % commented out for thesis
            ylabel(data_ylabel_fade)
    end 
end % function - master 