%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     4th April 2020
% Version:  A1
% Status:   Works

% Note: Generic Battery Function - Body of Functions 

function [Polarization, capacity_fade, cell_data] = coinCellAnalysis(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color)
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
        plot_mode = 6;  %plots only the discharges
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
        % [Voltage (V), halfcycle, Discharge (mAh), Charge (mAh)]
        cell_data{i} = import_cell_data_cycle(filepath_sample(i),mass_active(i));

    end

%--------------------------------------------------------------------------
% PLOTS
%--------------------------------------------------------------------------
    % Notes - order of switch statements
    
    % Switch 1 - Decides between plot mode multi cell options (6,7) and single cell options (1,2,3,4,5)
        % Case (6,7)
            % Switch 5 - decides between plot mode (6,7)
        % Case (1,2,3,4,5)
            % Switch 2 - decides between formation plot mode (1,2,3,4,5)
            % Switch 3 - prints legend for formation (1,2,5)
            % Switch 4 - capacity fade plot
        



switch plot_mode %switch 1
    % Decided between 
%--------------------------------------------------------------------------
% 1. Plot - Polarization Multi-Cell(Comparison) 
%--------------------------------------------------------------------------
    case {6,7} %comparison of single formation between multiple cells
               % (6) - discharge, (7) charge
    % i. Color selection
    my_color = getmecolor(my_color,num_entries);
    my_counter = 1; % this is only for the comparison of charges between cells 
    % ii. Plotting
    Polarization = figure; 
    for t=1:length(filepath_sample)
    % [Voltage (V), halfcycle, Discharge (mAh), Charge (mAh)]
    mydata = cell_data{t};
    mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
    % data for this batch 
    
        switch plot_mode %switch 5
            case 6
                discharge = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
            case 7
                charge = getmeacharge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
        end %switch 5 end
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
    
    capacity_fade = "No Capacity fade figure for this Mode.";
     % end - switch 1 case (6,7)
    
%--------------------------------------------------------------------------
% 2. Plot - Single Cell (Formation + Cell Fade)
%--------------------------------------------------------------------------
        %------------------------------------------------------------------
        % i. Polarization
        %------------------------------------------------------------------
            case {1,2,3,4,5} %switch 1 case  

            Polarization = figure;    

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
                    case 1 % Only discharge # plots
                        discharge_capacity = getmeadischarge(mydata_trimmed,cycles);

                    case 2 % Only charge # plots
                        charge_capacity = getmeacharge(mydata_trimmed,cycles);

                    case 3 % Only discharge - all
                        discharge_capacity = getmeadischarge(mydata_trimmed);

                    case 4 % Only charge - all
                        charge_capacity = getmeacharge(mydata_trimmed);

                    case 5 % Single cell. Both discharge and charge - selection 
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
                        discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles);
                        charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles);

                       % Export the discharge and charge capacities 
                            cell_data{2,t} = discharge_capacity;
                            cell_data{3,t} = charge_capacity;

                end %switch statement 2
            %----------------------------------------------------------------------
            hold off
            title(my_title,'Interpreter','latex');
            xlabel(data_xlabel,'Interpreter','latex')
            ylabel(data_ylabel,'Interpreter','latex')
            grid on

                    switch plot_mode % switch 3
                        case {1,2,5}
                            %legend
                            [~, hobj, ~, ~] = legend(print_runs(cycles,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
                             % Makes the lines in legend thicker
                            legend_line_width = findobj(hobj,'type','line');
                            set(legend_line_width,'LineWidth',3);
                        otherwise
                            % no legend as too many entries - plot mode 3,4
                    end %switch 3

        %--------------------------------------------------------------------------
        % ii. Cycling Capacity Fade (Single Cell)
        %--------------------------------------------------------------------------
        capacity_fade = figure;
        switch plot_mode %switch 4
            case {1,3}
                real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity);
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color','b')
                legend('Discharge','location','northeast')
            case {2,4}
                % same thing here
                real_charge_capacity = skipZeroCapacityCycles(charge_capacity);
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color','r')
                legend('Charge','location','northeast')
            case 5
                % same thing for both
                real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity);
                real_charge_capacity = skipZeroCapacityCycles(charge_capacity);
                
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color','b')
                hold on
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color','r')
                hold off
                legend('Discharge','Charge','location','northeast')

        end % switch 4

        plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity)
            
        title(my_title_fade,'Interpreter','latex');
        xlabel(data_xlabel_fade,'Interpreter','latex')
        ylabel(data_ylabel_fade,'Interpreter','latex')
        %legend (definied inside cases of switch 4)
        grid on
        
        % end - switch 1 case (1,2,3,4,5)
        
otherwise %switch 1
        disp('Option not available');
        Polarization = false;
        capacity_fade = false; 
        cell_data = 1;
        return
end 


end


function real_Capacity = skipZeroCapacityCycles(capacity)
    % getmedischarge and getmecharge will fill the discharge_capacity and
    % charge_capacity variables with zeros if we do not use all the cycles.
    % In that case, this function removes the zeros, so a significant plot
    % can be made. 
    
    % get rid of zero values - which are because we skipped entries
    index_zero_capacity = find(capacity(:,2));
    real_Capacity = capacity(index_zero_capacity,:);    
end

