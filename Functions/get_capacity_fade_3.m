%--------------------------------------------------------------------------
% Title:    Cell Capacity - plot extra TILE (Current DENSITY or Capacity)
% Author:   A.Marinov
% Date:     01/02/2024
% Version:  A1
% Status:   Developing

% Sample:   
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function get_capacity_fade_3(plot_mode,num_entries,current_density_cell,discharge_capacity_cell,my_color,my_title,tile_number,capacity_fade_fig) 

[~,plot_mode_code,~] = switch_plot_mode(plot_mode); % get plot_mode numbers

    switch plot_mode_code
    %--------------------------------------
    % Current Densities - only for plot_mode 9 
    %--------------------------------------
    % ** maybe move one day to subfunction
        case 52 % Current Density TILE
            nexttile
            for t=1:num_entries
                current_density = current_density_cell{1,t}; % open data
                plot(current_density(1:2:end,t),':o','color',my_color(t,:));
                hold on
                clear current_density %make sure no wrong data passed on!
            end % for loop - t
            hold off

        % AXIS
        plot_capacity_fade_axis(plot_mode,my_title)

        xlabel('Cycle','Interpreter','latex')
        ylabel('Current Density (mA/g)','Interpreter','latex') 

        case 62 % Capacity TILE
            nexttile 
            tile_number = tile_number + 1;
                for t=1:num_entries
                    discharge_capacity2 = discharge_capacity_cell{t};
                    plot_capacity_fade(plot_mode,discharge_capacity2,0,my_color(t,:));
                    clear discharge_capacity %make sure no wrong data passed on!
                end
            hold off
            % AXIS
            plot_capacity_fade_axis(plot_mode,my_title,tile_number,capacity_fade_fig)

    end % switch - plot_mode_code 