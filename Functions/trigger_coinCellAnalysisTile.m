%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     6th Feb 2021
% Version:  A1
% Status:   Works

% Note: Lazy Call to coinCellAnalysis.m

%--------------------------------------------------------------------------
% Input Handling
%--------------------------------------------------------------------------
function trigger_coinCellAnalysisTile(filepath_sample,mass_active,plot_mode,my_selection,cycles,my_color,my_title,my_legend,legend_location,auto_numbering_string)
% Input Handling - to be completed
switch nargin
    case{0,1,2,3,4,5,6,7}
        my_legend = {};
        legend_location = 'North';
        auto_numbering_string = 'Run ';
    case 8
            % For now fixing somethings empty
            if(isempty(my_legend))
                my_legend = {};
            end
            legend_location = 'North';
            auto_numbering_string = 'Run ';
            
    case 9
            if(isempty(legend_location))
                legend_location = 'North';
            end
            auto_numbering_string = 'Run ';
    case 10
            if(isempty(auto_numbering_string))
               auto_numbering_string = 'Run ';    % what to call the entries on the graph if no legend entry provided
            end
end

% Call to the OG Function
    if(isempty(my_selection))
        coinCellAnalysisTile(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color);
    elseif(length(my_selection) > length(my_color) || plot_mode ~= 1)
        coinCellAnalysisTile(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color);
    elseif(isempty(my_legend) || length(my_selection) > length(my_legend))
        coinCellAnalysisTile(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color(my_selection,:));
    else% Runs the function - body of functions design
        coinCellAnalysisTile(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles,my_legend(my_selection),my_title,legend_location,auto_numbering_string,my_color(my_selection,:));
    end
end