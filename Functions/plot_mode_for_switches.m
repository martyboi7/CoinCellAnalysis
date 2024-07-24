%--------------------------------------------------------------------------
% Title:    Plot Modes for Switches

% Author:   A.Marinov
% Date:     11th Jan 2023
% Version:  A1
% Status:   Developing

% Note: DELETE generic switch already accounts for MULTI vs SINGLE 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function [plot_mode_SINGLE_Cell,plot_mode_MULTI_Cell] = plot_mode_for_switches()

    plot_mode_SINGLE_Cell = {1,2,3,4,5,17,13,14,15,33,34,35,24,39}; % SINGLE Cells
    plot_mode_MULTI_Cell = {6,7,16,18,19,20,23,26}; % MULTI Cell

end 