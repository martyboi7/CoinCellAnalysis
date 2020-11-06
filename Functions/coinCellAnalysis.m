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

% TO BE COMPLETED


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
    Polarization = figure; 
    for t=1:length(filepath_sample)

    mydata = cell_data{t};
    mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
    % data for this batch 
    discharge = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
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
    
%--------------------------------------------------------------------------
% 2. Plot - Individual Cycles 
%--------------------------------------------------------------------------
            case {2,3,4,5,6} 

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
                    case 2 % Only discharge # plots
                        discharge_capacity = getmeadischarge(mydata_trimmed,cycles);

                    case 3 % Only charge # plots
                        charge_capacity = getmeacharge(mydata_trimmed,cycles);

                    case 4 % Only discharge - all
                        discharge_capacity = getmeadischarge(mydata_trimmed);

                    case 5 % Only charge - all
                        charge_capacity = getmeacharge(mydata_trimmed);

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
                        discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles);
                        charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles);

                       % Export the discharge and charge capacities 
                            cell_data{2,t} = discharge_capacity;
                            cell_data{3,t} = charge_capacity;

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

        %--------------------------------------------------------------------------
        % 3. Plot - Cycling Capacity Fade 
        %--------------------------------------------------------------------------
        capacity_fade = figure;
        switch plot_mode %switch 4
            case {2,4}
                % get rid of zero values - which are because we skipped entries
                index_zero_capacity = find(discharge_capacity(:,2));
                discharge_capacity = discharge_capacity(index_zero_capacity,:);
                plot(discharge_capacity(:,1),discharge_capacity(:,2),':o','color','b')
                legend('Discharge','location','northeast')
            case {3,5}
%                 capacity_fade = figure;
                % same thing here
                index_zero_capacity = find(charge_capacity(:,2));
                charge_capacity = charge_capacity(index_zero_capacity,:);
                plot(charge_capacity(:,1),charge_capacity(:,2),'--s','color','r')
                legend('Charge','location','northeast')
            case 6
%                 capacity_fade = figure;
                % same thing for both
                index_zero_capacity_dis = find(discharge_capacity(:,2));
                discharge_capacity = discharge_capacity(index_zero_capacity_dis,:);
                index_zero_capacity_cha = find(charge_capacity(:,2));
                charge_capacity = charge_capacity(index_zero_capacity_cha,:);

                plot(discharge_capacity(:,1),discharge_capacity(:,2),':o','color','b')
                hold on
                plot(charge_capacity(:,1),charge_capacity(:,2),'-s','color','r')
                hold off
                legend('Discharge','Charge','location','northeast')

        end % switch 4
            
        title(my_title_fade,'Interpreter','latex');
        xlabel(data_xlabel_fade,'Interpreter','latex')
        ylabel(data_ylabel_fade,'Interpreter','latex')
        %legend (definied inside cases of switch 4)
        grid on
        
otherwise %switch 1
        disp('Option not available');
end 


end