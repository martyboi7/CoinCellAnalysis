%--------------------------------------------------------------------------
% Title:    Data Analysis for Coin Cells on BioLogic
% Author:   A.Marinov
% Date:     4th April 2020
% Version:  A1
% Status:   Works

% Note: Generic Battery Function - Body of Functions 

function [Polarization, capacity_fade, cell_data] = coinCellAnalysis2(filepath_sample,mass_active,plot_mode,cycles,my_legend,my_title,legend_location,auto_numbering_string,my_color,Tian2019_input,dQdV_conditions)
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
    
    % Switch 1 - Single Cell (1-5) + MultiCell Single Cycle Comparison (6,7) [Line: 97] vs. Multi Cell (8-11) [Line: 218]
        % Case {1-7}
            % Switch 2 - MultiCell Single Cycle Comparison: polarization fig (6,7) [Line: 124-131]
            % Switch 3 - Single Cell: polarization fig (1-5) [Line: 136-174]
            % Switch 4 - polarization fig. legends (1-7)[Line: 182-203]
        % Case {8-11}
            % Switch 5 - sets Degradation fig [Line: 229-235]
            % Switch 6 - Discharge and Charge [Line: 253-260]
        

%--------------------------------------------------------------------------
% Plots - Decision Hierarchy
%--------------------------------------------------------------------------
switch plot_mode %switch 1 (master)
    
    
    %------------------------------------------------------------------
    % 1. Polarization + Capacity Fade (Optional)
    %------------------------------------------------------------------
    case {1,2,3,4,5,6,7} % all the ones that use a polarisation curve
    Polarization = figure;    

            for t=1:length(filepath_sample)
            % Send to function to get us the right data to plot
            % [Voltage (V), halfcycle, Discharge (mAh), Charge (mAh)]
            mydata = cell_data{t};
            mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge

            if (plot_mode < 6 && isempty(cycles))
                    % for single cells only (1-5)
                        mydata_trimmed_size = size(mydata_trimmed);
                        cycles = round(mydata_trimmed_size(2)/2);
            elseif (plot_mode > 5 && plot_mode < 8) % colors for plot_mode 6,7
                my_color = getmecolor(my_color,num_entries);
            end %if statement
                    
            %--------------------------------------------------------------
            % 1.1 Multi-Cell - Single Cycle - Polarization Comparison
            %--------------------------------------------------------------
                switch plot_mode % switch 2
                    case 6
                        discharge = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
                    case 7
                        charge = getmeacharge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
                end % switch 2
            end %for statement 

            %--------------------------------------------------------------
            % 1.2 Single Cell - Muti-Cycle - Polarization 
            %--------------------------------------------------------------
                switch plot_mode %switch 3
                            %----------------------------------------------------------------------    
                            case {1} % Only discharge # plots
                                discharge_capacity = getmeadischarge(mydata_trimmed,cycles);
                                charge_capacity = 0; % eliminates this var
                                
                            case {2} % Only charge # plots
                                discharge_capacity = 0; % eliminates this var
                                charge_capacity = getmeacharge(mydata_trimmed,cycles); 

                            case {3} % Only discharge - all
                                discharge_capacity = getmeadischarge(mydata_trimmed); 
                                charge_capacity = 0; % eliminates this var
                                
                            case {4} % Only charge - all
                                discharge_capacity = 0; % eliminates this var
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
                end  %switch 3

                hold off
                if(plot_mode <= 5)
                    title(strcat(my_legend,my_title),'Interpreter','latex');
                else
                    title(my_title,'Interpreter','latex');
                end
                xlabel(data_xlabel,'Interpreter','latex')
                ylabel(data_ylabel,'Interpreter','latex')
                grid on
                
                switch plot_mode % switch 4 (polarization plot - legend)
                                case {1,2,5}
                                    %legend
                                    [~, hobj, ~, ~] = legend(print_runs(cycles,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
                                     % Makes the lines in legend thicker
                                    legend_line_width = findobj(hobj,'type','line');
                                    set(legend_line_width,'LineWidth',3);
                                case {6,7}
                                    if(length(my_legend) < 1)
                                        [~, hobj, ~, ~] = legend(print_runs(filepath_sample,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
                                        else
                                        [~, hobj, ~, ~] = legend(my_legend, 'Interpreter','latex', 'Location', legend_location);
                                    end
                                    
                                    legend_line_width = findobj(hobj,'type','line');
                                    set(legend_line_width,'LineWidth',3);
                                    
                                    capacity_fade = "No Capacity fade figure for this Mode.";
                                    return % skips all next code - so does not try to draw a figure for capacity fade
                                otherwise
                                    % no legend as too many entries - plot mode 3,4
                end %switch 4

                %----------------------------------------------------------
                % 1.3 Single Cell - Capacity Fade
                %----------------------------------------------------------
                % This comes alongside a polarization curve
                capacity_fade = figure;
                plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity)

                title(my_title_fade,'Interpreter','latex');
                xlabel(data_xlabel_fade,'Interpreter','latex')
                ylabel(data_ylabel_fade,'Interpreter','latex')
                %legend (definied inside cases of switch 4)
                grid on

                % end - switch 1 case (1,2,3,4,5,6,7)      

    case{8,9,10,11} %capacity fade - MULTI-CELL comparison (direct comparison)
        
        %----------------------------------------------------------
        % 1.4 MULTI-CELL - Capacity Fade
        %----------------------------------------------------------
        switch plot_mode % switch 5
            case{8,10,11} % discharge, charge and discharge/charge LSV - no current density to display
                capacity_fade = figure;
            case 9 % discharge LSV with current density as separate tile 
                capacity_fade = tiledlayout(1,2,'TileSpacing','compact','Padding','compact'); % Requires R2019b or later
                nexttile
        end % switch 5
        
        for t=1:length(filepath_sample)
            % Send to function to get us the right data to plot
            % [Voltage (V), halfcycle, Charge (mAh), Discharge (mAh), time (s), Current (mA/g), dQ (mA.h)]
            mydata = cell_data{t};
            mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge

            if(isempty(my_color))
            my_color = getmecolor(my_color,num_entries);
            end % if statement
        
            % find the capacity values (all cycles selected) for all the
            % cells (my_selection)
            discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
            charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color(t,:),plot_mode);
            
            switch plot_mode % switch 6
                case {8,9} %discharge capacity fade - comparison
                plot_capacity_fade(plot_mode,discharge_capacity,0,my_color(t,:));
                case 10 %charge capacity fade - comparison
                plot_capacity_fade(plot_mode,0,charge_capacity,my_color(t,:));
                case 11 %discharge and charge capacity fade - comparison
                plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity,my_color(t,:));
            end % switch 6
            
            xlabel(data_xlabel_fade,'Interpreter','latex')
            ylabel(data_ylabel_fade,'Interpreter','latex')
        end %for statement
        
        
        title(my_title_fade,'Interpreter','latex');
        xlabel(data_xlabel_fade,'Interpreter','latex')
        ylabel(data_ylabel_fade,'Interpreter','latex')
        %legend (definied inside cases of switch 4)
        if(length(my_legend) < 1)
            legend(print_runs(filepath_sample,auto_numbering_string), 'Interpreter','latex', 'Location', legend_location);
        elseif (plot_mode == 11) % only for discharge/charge mode
        
            for x = 2:2:2*length(my_legend)
                k = round(x/2);    % dummy variable to get the correct entry
                my_legend2{1,x-1} = my_legend{1,k};
                my_legend2{1,x} = my_legend{1,k};
            end
            legend(my_legend2, 'Interpreter','latex', 'Location', legend_location);
        else
            legend(my_legend, 'Interpreter','latex', 'Location', legend_location);
        end
%         legend_line_width = findobj(hobj,'type','line');
%         set(legend_line_width,'LineWidth',3);
        grid on
        
        % Current Densities - only for plot_mode 9 
        if(plot_mode == 9)
        nexttile
            %-----------------------------------
            % WORKING HERE - 29/07/2021 
            % Extraction of I/M (mA/g) for each cycle 
            %-----------------------------------
            for t=1:length(filepath_sample)
            % Send to function to get us the right data to plot
            % [Voltage (V), halfcycle, Charge (mAh), Discharge (mAh), time (s), Current (mA/g), dQ (mA.h)]
            mydata = cell_data{t};
            mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
            % Current density at beginning and end of cycle are 0. Cannot
            % use those. 
            for f = 1:length(mydata_trimmed)
                intermediate_var = mydata_trimmed{1,f};
                current_density_cycle(f,1) = max(abs(intermediate_var(:,3)));
            end 
                plot(current_density_cycle(1:2:end),':o','color',my_color(t,:))
                clear current_density_cycle %otherwise it overlays current densities between different cells
                hold on
            end
            hold off
            
        title(my_title_fade,'Interpreter','latex');
        xlabel(data_xlabel_fade,'Interpreter','latex')
        ylabel('Current Density (mA/g)','Interpreter','latex')   
        end
            %-----------------------------------
        
        Polarization = 0; % makes empty dummy fig. 
   
    case{12} %Tian2019b style regression
        
        Polarization = 0; % makes empty dummy fig.
        
        % Send to function to get us the right data to plot
        % [Voltage (V), halfcycle, Discharge (mAh), Charge (mAh)]
        mydata = cell_data{1};
        mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
        
        if (isempty(cycles))
            % for single cells only (1-5)
            mydata_trimmed_size = size(mydata_trimmed);
            cycles = round(mydata_trimmed_size(2)/2);
        end
        
        discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color(1,:),plot_mode);
        
         % Current density at beginning and end of cycle are 0. Cannot
         % use those. Use the max value to overcome (as high A/g tests have
         % many zero values and median cannot combat this.
            for f = 1:length(mydata_trimmed)
                intermediate_var = mydata_trimmed{1,f};
                current_density_cycle(f,1) = mean(nonzeros(abs(intermediate_var(:,3))));
            end 
        
        %Tian2019b Model fig
        capacity_fade = cycling_data_processing(Tian2019_input,current_density_cycle(1:2:end),discharge_capacity);

    case{13} %dQ/dV analysis - single cell
        
        % Send to function to get us the right data to plot
        % Voltage (V), halfcycle, Discharge (mAh), Charge (mAh), time (s), Current (mA/g), dQ (mA.h)
        mydata = cell_data{1};
        mydata_trimmed = breaktheplot(mydata); % odd cells are discharge, even cells are charge
        
         oddcolumns = 1:2:length(mydata_trimmed);
         evencolumns = 2:2:length(mydata_trimmed);
         odddata = mydata_trimmed(1,oddcolumns); %get all the discharge datasets
         evendata = mydata_trimmed(1,evencolumns); %get all the charge datasets
        
        
        % Need to have the function call right here 
        [thedataexportdQdV_discharge,my_newlegend] = getmedVdQ(odddata,cycles,1,dQdV_conditions);
        [thedataexportdQdV_charge,~] = getmedVdQ(evendata,cycles,0,dQdV_conditions);
        
        Polarization = figure;
        % Discharge
        for l = 1:length(thedataexportdQdV_discharge)
        
           dQdV_discharge = thedataexportdQdV_discharge{l};
           plot(dQdV_discharge(:,1),dQdV_discharge(:,2),'color',my_color(l,:)) %dQdV vs V
                    
%            plot(dQdV(:,1),1/dQdV(:,2)) %dVdQ vs V
%            plot(dQdV(:,1),dQdV(:,3)) %Q vs V
%            plot(dQdV(:,3),dQdV(:,1)) %V vs Q
%            plot(dQdV(:,3),dQdV(:,2)) %dVdQ vs Q  
           
           hold on           
        end
        % Charge 
        for l = 1:length(thedataexportdQdV_charge)
        
           dQdV_charge = thedataexportdQdV_charge{l};
           plot(dQdV_charge(:,1),dQdV_charge(:,2),'color',my_color(l,:)) %dQdV vs V
           hold on           
        end
        
        hold off
        title(strcat(my_legend,my_title),'Interpreter','latex');
        legend(my_newlegend, 'Interpreter','latex', 'Location', legend_location);
        xlabel('Potential (V)','Interpreter','latex')
        ylabel('dQ/dV (mAh/g/V)','Interpreter','latex')
        grid on
        
%         capacity_fade = "No Capacity fade figure for this Mode."; % dummy empty so that function works without errors
        capacity_fade{1,:} = thedataexportdQdV_discharge; %export only for testing purposes 
        capacity_fade{2,:} = thedataexportdQdV_charge; %export only for testing purposes 
        
    otherwise %switch 1
        disp('Option not available');
        Polarization = false;
        capacity_fade = false; 
        cell_data = 1;
        return
end %switch 1  
        
end % funtion (master)


function real_Capacity = skipZeroCapacityCycles(capacity)
    % getmedischarge and getmecharge will fill the discharge_capacity and
    % charge_capacity variables with zeros if we do not use all the cycles.
    % In that case, this function removes the zeros, so a significant plot
    % can be made. 
    
    % get rid of zero values - which are because we skipped entries
    index_zero_capacity = find(capacity(:,2));
    real_Capacity = capacity(index_zero_capacity,:);    
end

function plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity,my_color)
    % Plots the capacitz fade figure 

        switch plot_mode %switch X
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
            case {8,9} % discharge
                % mutli-cell comparison of capacity fade
                real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity);               
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:))
                hold on
            case 10 % charge
                % mutli-cell comparison of capacity fade
                real_charge_capacity = skipZeroCapacityCycles(charge_capacity);         
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold on              
            case 11 % discharge and charge
                % mutli-cell comparison of capacity fade
                real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity);
                real_charge_capacity = skipZeroCapacityCycles(charge_capacity);
                
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:))
                hold on
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold on      
        end % switch X

end

