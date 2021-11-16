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
function [polarization,capacity_fade,cell_data]=trigger_coinCellAnalysis(filepath_sample,mass_active,plot_mode,my_selection,cycles,my_color,my_title,my_legend,Tian2019_input,legend_location,auto_numbering_string,dQdV_conditions)
% Input Handling - to be completed
switch nargin
    case{0,1,2,3,4,5,6,7}
        my_legend = {};
        legend_location = 'Northeast';
        auto_numbering_string = 'Run ';
        dQdV_conditions = {true,[4,23]};
    case 8
            % For now fixing something empty
            if(isempty(my_legend))
                my_legend = {};
            end
            legend_location = 'Northeast';
            auto_numbering_string = 'Run ';
            dQdV_conditions = {true,[4,23]};
    case 9
            legend_location = 'Northeast';
            auto_numbering_string = 'Run ';
            dQdV_conditions = {true,[4,23]};
    case 10
            if(isempty(legend_location))
                legend_location = 'Northeast';
            end
            auto_numbering_string = 'Run ';
            dQdV_conditions = {true,[4,23]};
    case 11
            if(isempty(auto_numbering_string))
               auto_numbering_string = 'Run ';    % what to call the entries on the graph if no legend entry provided
            end
            dQdV_conditions = {true,[4,23]};
end

% switch to make sure that plot_mode is active
switch plot_mode % switch 1
        case {1,2,3,4,5,6,7,8,9,10,11,12,13}
            % Call to the OG Function
        if(isempty(my_selection)) 
            % plots everything - no initial selection made
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color);
        elseif(length(my_selection) > length(my_color))
            % not enough colours provided - auto assigns colours
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles,my_legend(my_selection),my_title,legend_location,auto_numbering_string,my_color);
        elseif(plot_mode < 6)
            % SINGLE CELLS
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection(1)),mass_active(my_selection(1)),plot_mode,cycles,my_legend(my_selection(1)),my_title,legend_location,auto_numbering_string,my_color);
        elseif(plot_mode == 13)
            % dQ/dV
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection(1)),mass_active(my_selection(1)),plot_mode,cycles,my_legend(my_selection(1)),my_title,legend_location,auto_numbering_string,my_color,1,dQdV_conditions);
        elseif(isempty(my_legend) || length(my_selection) > length(my_legend))
            % MULTI-CELLS
            % Legend issues - empty legend OR selection includes more numbers than available in legend
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color(my_selection,:));
        elseif(length(my_selection) == length(my_color))
            % MULTI-CELLS
            % Pre-set colours (same as the section below otherwise -> else)
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles(1),my_legend(my_selection),my_title,legend_location,auto_numbering_string,my_color,Tian2019_input);
        else
            % MULTI-CELLS
            % Base Run - if all selections made properly runs body of functions
            [polarization,capacity_fade,cell_data] = coinCellAnalysis2(filepath_sample(my_selection),mass_active(my_selection),plot_mode,cycles(1),my_legend(my_selection),my_title,legend_location,auto_numbering_string,my_color(my_selection,:),Tian2019_input);
        end
    otherwise %switch 1
        disp('Error! plot_mode: Option not available. trigger_coinCellAnalysis.mat Line 64');
        polarization = false;
        capacity_fade = false; 
        cell_data = 1;
        return
end % switch 1

end