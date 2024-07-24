%--------------------------------------------------------------------------
% Title:    |Cell Capacity - figure setup
% Author:   A.Marinov
% Date:     01/02/2024
% Version:  A1
% Status:   Developing

% Sample:   
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function  [capacity_fade,cycles_output,cycles1,tile_number] = get_capacity_fade_1(plot_mode_code,cycles_input)
    %----------------------------------------------------------
    switch plot_mode_code % plot_mode_code. MULTICell: DEGRADATION. Fig. type select. (TILED PLOT)
    %----------------------------------------------------------   
        case 52 % Tiled Plots (9 - current density, 37 - Capacity)
            capacity_fade = tiledlayout(1,2,'TileSpacing','compact','Padding','compact'); % Requires R2019b or later
            nexttile

            cycles_output = cycles_input;
            cycles1 = nan;
        case 62
            capacity_fade = tiledlayout(1,2,'TileSpacing','compact','Padding','compact'); % Requires R2019b or later
            nexttile
    
            % ** WORKING HERE ???
            cycles2 = cycles_input;
    
            cycles_output = 1:cycles2(2);
            cycles1 = cycles2(2):cycles2(end);
            disp('my_capacity_fade_1 - TILED Capacity')
        otherwise
            capacity_fade = figure;
            cycles_output = cycles_input;
            cycles1 = nan;
    end % switch 6 - plot_mode_code. MULTICell: DEGRADATION. Fig. type select.

    tile_number = 1; % set counter (first tile) - it only considers the second degree (there is no way to make this consider 4x4 tile only 1x4 tile)
    %----------------------------------------------------------
    %----------------------------------------------------------
end % function - master 