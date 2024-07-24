%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     4th April 2020
% Version:  A1
% Status:   Broken - due to change of plot_mode numbers

% Note: Generic Battery Function - Body of Functions 

function coinCellAnalysisTile(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color)
%--------------------------------------------------------------------------
% Input Handling
%--------------------------------------------------------------------------

% Completed - 06/02/2021
switch nargin
    case 0
        disp('Error: No filepath!')
        return
    case 1
        disp('Error: No Active Mass!')
        return
    case 2
        plot_mode = 1;  %plots only the discharges
        cycles = [];    %plots alls the cycles avaialble
        my_legend = {}; %automatic legend goes to runs
        my_title = {};
        legend_location = 'north';
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 3
        cycles = [];    %plots alls the cycles avaialble
        my_legend = {}; %automatic legend goes to runs
        my_title = {};
        legend_location = 'north';
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 4
        my_legend = {}; %automatic legend goes to runs
        my_title = {};
        legend_location = 'north';
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 5
        my_title = {};
        legend_location = 'north';
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 6
        legend_location = 'north';
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 7
        auto_numbering_string = 'Run '; % for the legend automatisation
        my_color = []; %not sure this is right!
    case 8
        my_color = []; %not sure this is right!
end 


%--------------------------------------------------------------------------
% Constants
%--------------------------------------------------------------------------
% Graph Stuff
% i. Polarisation
data_xlabel = 'Capacity (mAh/g)';
data_ylabel = 'Voltage (V)';

% ii. Capacity fade
my_title_fade = strcat(my_title," Capacity Fade");
data_xlabel_fade = 'Cycle';
data_ylabel_fade = 'Capacity (mAh/g)';
my_color_cycles = my_color;

%--------------------------------------------------------------------------
% Operations
%--------------------------------------------------------------------------
% Import the data
num_entries = length(filepath_sample); % the number of data sets used in the analysis

    for i = 1: length(filepath_sample)

        cell_data{i} = import_cell_data_cycle(filepath_sample(i),mass_active(i));

    end

%--------------------------------------------------------------------------
% PLOTS
%--------------------------------------------------------------------------
switch plot_mode %switch 1
%--------------------------------------------------------------------------
% Plot - Polarization (Comparison)
%--------------------------------------------------------------------------
    case 1
    
    % i. Color selection
    my_color = getmecolor(my_color,num_entries);
    my_counter = 1; % this is only for the comparison of charges between cells 
    % ii. Plotting 
    for t=1:length(filepath_sample)

    mydata = cell_data{t};
    mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
    % data for this batch 
    getmeadischarge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
    end

    hold off
    title(my_title,'Interpreter','latex');
    xlabel(data_xlabel,'Interpreter','latex')
    ylabel(data_ylabel,'Interpreter','latex')
    grid on

    if(length(my_legend) < 1)
    [~, hobj, ~, ~] = legend(print_runs(filepath_sample,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
    else
    [~, hobj, ~, ~] = legend(my_legend, 'Interpreter','latex', 'Location', legend_location);
    end

    % Makes the lines in legend thicker
    legend_line_width = findobj(hobj,'type','line');
    set(legend_line_width,'LineWidth',3);
    
%--------------------------------------------------------------------------
% 2. Plot - Individual Cycles 
%--------------------------------------------------------------------------
            case {2,3,4,5,6} 

%             Polarization = figure;    

            for t=1:length(filepath_sample)
            % Send to function to get us the right data to plot
            mydata = cell_data{t};
            mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge

            if(isempty(cycles))
                mydata_trimmed_size = size(mydata_trimmed);
                cycles = round(mydata_trimmed_size(2)/2);
            end %if statement
            end %for statement 

                switch plot_mode %switch 2
                    %----------------------------------------------------------------------    
                    case 2 % Only discharge # plots
                        getmeadischarge(mydata_trimmed,cycles);

                    case 3 % Only charge # plots
                        getmeacharge(mydata_trimmed,cycles);

                    case 4 % Only discharge - all
                        getmeadischarge(mydata_trimmed);

                    case 5 % Only charge - all
                        getmeacharge(mydata_trimmed);

                    case 6 % Both - selection 
                        % i. Color selection
                        num_cycles = length(cycles);
                        if num_cycles == 1
                            color_cycles = cycles;
                        elseif num_cycles > 1
                            color_cycles = num_cycles;
                        else
                            %if the length of cycles you set is 0 (empty) then it sets it
                            %to 1
                            color_cycles = 1;
                        end % if statement
                        my_color_cycles = getmecolor(my_color_cycles,color_cycles);
                        % ii. Plotting
                        getmeadischarge(mydata_trimmed,cycles,my_color_cycles);
                        getmeacharge(mydata_trimmed,cycles,my_color_cycles);

                end %switch statement 2
            %----------------------------------------------------------------------
        %     end %for loop
            hold off
            title(my_title,'Interpreter','latex');
            xlabel(data_xlabel,'Interpreter','latex')
            ylabel(data_ylabel,'Interpreter','latex')
            grid on

                    switch plot_mode % switch 3
                        case {2,3,6}
                            %legend
                            [~, hobj, ~, ~] = legend(print_runs(cycles,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
                             % Makes the lines in legend thicker
                            legend_line_width = findobj(hobj,'type','line');
                            set(legend_line_width,'LineWidth',3);
                        otherwise
                            % no legend as too many entries 
                    end %switch 3


end