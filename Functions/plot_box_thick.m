%--------------------------------------------------------------------------
% Title:    Fig - BOX thickness

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function plot_box_thick()
    
    box on

    % Plot thickness
    myfont_size = 14; % legend, and axis 
    myplot_axis = 2.5; % the outter border of the plot
    
    % make figure thick
    polarisation = gca;
    set(polarisation,'linewidth',myplot_axis)

    % control axis number appearance
    polarisation.FontWeight = 'bold';
    polarisation.FontSize = myfont_size;
    polarisation.LabelFontSizeMultiplier = 1.2;

end % function - master 