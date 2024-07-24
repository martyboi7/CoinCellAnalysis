%--------------------------------------------------------------------------
% Title:    Polarisation:
%           1. E(t) - Capacity
%           2. E(t) - Time
%           3. dQdV
%           4. CV

% Author:   A.Marinov
% Date:     22nd Aug 2022
% Version:  A1
% Status:   Developing

% Note: Main Function for Plot: POLARIZATION

% Layout (Switch):
% 1. input - capacity fig. (yes or no)
% 2. input - eis fig. (yes or no)
% 3. import data - CV or EIS or CC
% 4. cycles - SINGLECell (if empty)
% 5. plot_mode_multi
    % 6. plot - MULTICell (comparison) plot_mode: 6;7;16;18,19,20;23;26
    % 7. plot - SINGLECell plot_mode: 1,3,33,39;2,4,34;5,35;13;14,15;17,24
% 8. legend - POLARISATION (because plot_mode 19 problematic)

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------

function [Polarization,eis_profile,additional_figure,cell_data] = my_polarisation_profile(cell_data,num_entries,plot_mode,my_source,cycles_input,CV_edge_limit,my_color,my_title,my_legend,auto_numbering_string,legend_location,dQdV_conditions,mygraph_linewidth)

disp('-------------------')
disp('my_polarisation_profile')
disp('-------------------')

%--------------------------------------------------------------------------
% Input Handling
%--------------------------------------------------------------------------
[plot_mode_switch,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode);
my_color_cycles = []; % empty to fight bug
% my_color_cycles = my_color; %direct entry assignment (why is this here 05/05/2023). 
% I'm sure either CV or EIS depends somehow on this. But it creates a very unique bug. 
% If less cycles are chosen [1,4,7] for a normall CC plot - than cells are
% input then the cells colors are used for the Polarization plots!

[row_raw_data,row_cycles,row_cycles_clean,row_discharge_capacity,row_charge_capacity,row_CV_data,row_CV_Size,row_cycles_CV] = getmy_celldata_rows(); % get the unified data output rows 

%--------------------------------------------------------------
% Additional FIGURES
%--------------------------------------------------------------
        % EIS Profiles
        % Switch 2 
        switch plot_mode_code % indicator for EIS plot 
            case{13,23,34} % EIS
                eis_profile_fig = true;
                cycles_eis = cycles_input; 
            otherwise 
                eis_profile_fig = false; 
                eis_profile = 0; % dummy to export 
        end % switch 2 - plot_mode_code

        % Other
        switch plot_mode
            case 25 % dQdV from CV
                additional_profile_fig = true;
            otherwise 
                additional_profile_fig = false;
                additional_figure = 0; %dummy to export
        end % switch - plot_mode
        
%-------------------------------------------------------------- 
% MAIN Algorithm
%--------------------------------------------------------------
            switch plot_mode_switch
                case{3,4} % MULTICell on SINGLE Fig.
                    Polarization = figure;   
            end % switch plot_mode_switch

            %--------------------------------------------------------------
            % 1.1 Multi-Cell - Single Cycle - Polarization Comparison
            %--------------------------------------------------------------
    for t = 1:num_entries %for loop - t (num_entries) master POLARISATION
                % num_entrie - filespaths entered 
                % Send to function to get us the right data to plot

                switch plot_mode_switch
                    case{1,2,7} % Fig. for every CELL
                        Polarization{t} = figure;   
                end 
                

                %--------------------------------------
                % Trim Data - Sort (mydata_trimmed)
                %--------------------------------------
                switch plot_mode_code % switch 3 - plot_mode
                    case {14,24,35} % CV data 
                        
                        mydata_CV_open = cell_data{row_cycles_clean,t}; % Clean CV data without REST steps. CV data from breaktheplotCV - CV cycles in CV-CC stack have been made [] : new code 11/06/2024
                        mydata_CV = mydata_CV_open(2,:); % CC data from breaktheplotCV - CV cycles in CV-CC stack have been made [] : new code 11/06/2024
                        
                        output_processing_CV = cell_data{row_cycles,t}; % open full dataset CV
    
                        %mydata_CV = output_processing_CV{1}; % CV data from breaktheplotCV - includes all cycles CV and CC : old code before 11/06/2024
                        mydata_trimmed = output_processing_CV{2}; % CC data from breaktheplotCV - CV cycles in CV-CC stack have been made [] 
                        cycles_CV1 = output_processing_CV{3}; % CV cycles from breaktheplotCV
                        cycles_CC1 = output_processing_CV{4}; % CC cycles from breaktheplotCV
                        mydata_CV_size_i = output_processing_CV{5}; % size of the uncut CV data from breaktheplotCV - used if manual validation is needed 

                        if(isempty(cycles_input)) % Need to fill CC cycles if empty
                            cycles_CV = cycles_CV1'; % flip the cycles
                        elseif(max(cycles_input) > max(cycles_CV1)) % if requested too large a cycle number
                            cycles_CV_find = find(cycles_input <= max(cycles_CV1)); % find cycles within range
                            cycles_CV = cycles_input(cycles_CV_find);
                        else 
                            cycles_CV = cycles_input; % these are the ones fed from the TEMPLATE                           
                        end % if statement

                        % get the CC cycles for CV data cell
                        cycles = cycles_CC1; % passed down from breaktheplotCV

%--------------------------------------
                    case {13,23,34} % EIS 
                        output_processing_EIS = cell_data{2,t};

                        mydata_eis = output_processing_EIS{1}; % eis data (in pretrimmed format)
                        mydata_trimmed = output_processing_EIS{2}; % CC data from EIS
                        mydata_eis_voltage = output_processing_EIS{3}; % voltage where the EIS scan takes place
                        cycles = cycles_input; % assignment 
                    otherwise % all other plot_modes CC
                        %15/12/2022
                        % BIOLOGIC/NEWARE: Voltage(V),Time(s),Capacity(mAh/g),Current Density(mA/g), | Halfcycle/Other | ,dQdV/EIS
                        mydata = cell_data{row_raw_data,t};
                        mydata_trimmed_time = cell_data{row_cycles,t}; % includes REST
                        mydata_trimmed = cell_data{row_cycles_clean,t}; % no REST steps
                        cycles = cycles_input; % assignment
                end % switch 3 - plot_mode_code

%--------------------------------------
% ** WORKING HERE 13/10/2022

                %--------------------------------------
                % Colors
                %--------------------------------------

                % NEW Switch - 21/10/2022
                %--------------------------------------
                % Cycles & Colours - ALL
                %--------------------------------------
                cycles = my_cycles(cycles,plot_mode,mydata_trimmed); % does not do anything if cycles provided - else assigns
                cycles_multiple = cycles; % assigment for figure title 
        
                % Colours (my_color_cycles)
                switch plot_mode_code
                    case{14,24,35} % CV - plot_mode: 17,24,26,43,44
                        if(length(cycles_CV) > length(my_color_cycles) || cycles_CV(1) > length(my_color_cycles))
                            my_color_cycles = mycolor_validate(plot_mode,my_color_cycles,cycles_CV,num_entries);
                        end % if-statement 
                    case{13,23,34} % EIS
                            my_color_EIS_location = getme_cycle_colour(); % assign colours for EIS locations!
                            my_color_cycles = mycolor_validate(plot_mode,my_color,cycles,num_entries); % assign OR fill colors for CYCLES (Polarization plot)
                    otherwise % Polarisation, dQdV
                        
                        size_my_color = size(my_color_cycles);

                        if(isempty(my_color_cycles) || length(cycles) > size_my_color(1) || cycles(1) > size_my_color(1))
                            my_color_cycles = mycolor_validate(plot_mode,my_color_cycles,cycles,num_entries);
                        end
                end % switch - plot_mode_code


%--------------------------------------
                switch plot_mode_multi
                    case 2 % MULTI - comparison on single plot
                                %----------------------------------------------------------
                                switch plot_mode % switch 5 - MULTICell Polarisation Fig. (dQdV or CV too)
                                %----------------------------------------------------------
                                    case 6 % MULTICell: POLARIZATION Comparison - single DISCHARGE. Select CYCLE.
                                        discharge = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),mygraph_linewidth,plot_mode);
                                    case 7 % MULTICell: POLARIZATION Comparison - single CHARGE. Select CYCLE.
                                        charge = getmeacharge(mydata_trimmed,cycles,my_color(t,:),mygraph_linewidth,plot_mode);
                                    case {16,18} % TIME
                                        % 16 - MULTICell: E(t) vs t. All Cycles. 
                                        % 18 - MULTICell: E(t) vs t. Select CYCLE.
                                        mydata_trimmed_time_size(t) = length(mydata_trimmed_time); % for legend of plot_mode == 19
                                        discharge = getmeadischarge(mydata_trimmed_time,cycles,my_color(t,:),mygraph_linewidth,plot_mode,my_source(t));                                        
                                    case {19,20} % Extended CAPACITY
                                        % 19 - MULTICell: E(t) vs Capacity. All Cycles.
                                        % 20 - MULTICell: E(t) vs Capacity. Select CYCLE.
                                        mydata_trimmed_size(t) = length(mydata_trimmed); % for legend of plot_mode == 19
                                        discharge = getmeadischarge(mydata_trimmed,cycles,my_color(t,:),mygraph_linewidth,plot_mode,my_source(t));
                                    case 23 % 23 - MULTICell: dQ/dV. Select CYCLE. Data calc. by Matlab (require normal .mpt). Line plot.
                                        getmedVdQ2(mydata_trimmed,cycles,plot_mode,dQdV_conditions,my_color(t,:),mygraph_linewidth);
                                    case 26 % MULTICell: CV comparison for Select CYCLE.
                                        getmeaCV(mydata_CV,cycles_CV(1),my_color(t,:),plot_mode,mygraph_linewidth); %my_col

                                        clear cycles_multiple
                                        cycles_multiple = cycles_CV(1); % for title 
                                end % switch 5 - plot_mode. POLARIZATION Plot
            
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
                otherwise 
                        %--------------------------------------------------------------
                        % 1.2 Single Cell - Muti-Cycle - Polarization 
                        %--------------------------------------------------------------
                            
                            %----------------------------------------------------------
                            switch plot_mode %switch 6 - SINGLECell Polarisation (CV or dQdV)
                            %----------------------------------------------------------
                                %------------------------------------------
                                % CC
                                %------------------------------------------
                                case {1,3,33} % Only discharge # plots
                                    discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth);
                                    charge_capacity = 0; % eliminates this var
                                    
                                case {2,4,34} % Only charge # plots
                                    discharge_capacity = 0; % eliminates this var
                                    charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth); 
            
                                case {5,35,39,41,42} % Single cell. Both discharge and charge - selection 
                                    % ii. Plotting
                                    discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth);
                                    charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth);

                                %------------------------------------------
                                % Current
                                %------------------------------------------
                                case {51,52} % Current/Capacity
                                    discharge_capacity = getmeadischarge(mydata_trimmed_time,cycles,my_color_cycles,mygraph_linewidth,plot_mode);
                                    charge_capacity = getmeacharge(mydata_trimmed_time,cycles,my_color_cycles,mygraph_linewidth,plot_mode);

                                case {53} % Current/TIME
                                    discharge_capacity = getmeadischarge(mydata_trimmed_time,cycles,my_color_cycles,mygraph_linewidth,plot_mode,my_source(t));
                                    charge_capacity = NaN;
                                %------------------------------------------
                                % TIME
                                %------------------------------------------
                                case {50,55,56} % TIME (single CELL - different CYCLES)
                                    discharge_capacity = getmeadischarge(mydata_trimmed_time,cycles,my_color_cycles,mygraph_linewidth,plot_mode,my_source(t)); % 10/03/2023
                                    charge_capacity = NaN;
                                case 48 % TIME (single CELL - different CYCLES) 
                                    discharge_capacity = getmeadischarge(mydata_trimmed_time,cycles,my_color_cycles,mygraph_linewidth,plot_mode); % 10/03/2023
                                    charge_capacity = NaN;
%----------------------------------------------------
% Add section for EIS - that plots dots on where 
% the EIS is conducted??? (How to do as many cycles can be included?)
% 03/02/2023


%----------------------------------------------------  
                                %------------------------------------------
                                % dQdV
                                %------------------------------------------
                                case{13} % 13. SINGLECell: dQ/dV. Select cycles. Data as calc. by Biologic Software (needs expanded output file)
                                    % Call to function - access Biologic dQdV Data 
                                    getmedVdQ_Biologic(mydata_trimmed,5,cycles,my_color_cycles,mygraph_linewidth);
                                case{14,15} 
                                % 14. SINGLECell: dQ/dV. Select cycles. Data calc. by Matlab (require normal .mpt). Line plot.
                                % 15. SINGLECell: dQ/dV. Select cycles. Data calc. by Matlab (require normal .mpt). Scatter plot.
                                    % Call to function - calculate the dQdV (Alex)
                                    getmedVdQ2(mydata_trimmed,cycles,plot_mode,dQdV_conditions,my_color_cycles,mygraph_linewidth);
            
                                    discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth,plot_mode);
                                    charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth,plot_mode);
            
                                %------------------------------------------
                                % CV
                                %------------------------------------------
                                case {17,24,43,44,25} % CV plots 
                
                                        disp(['       Max available CV cycle: ' ,num2str(max(cycles_CV))])
                                        getmeaCV(mydata_CV,cycles_CV,my_color_cycles,plot_mode,CV_edge_limit,mygraph_linewidth);
                                        discharge_capacity = getmeadischarge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth,plot_mode); 
                                        
                                        switch plot_mode
                                            case {17,24,43,25} % Need empty Charge for protocol
                                                charge_capacity = 0;
                                            case 44 % Plot Discharge and Charge CC
                                                charge_capacity = getmeacharge(mydata_trimmed,cycles,my_color_cycles,mygraph_linewidth,plot_mode); 
                                                % plot_mode == 10 - so that use already defined CHARGE setting for DEGRADATION plot
                                        end 
                                        
                                        clear cycles % need to change for the legend of CV plot (was CC cycles otherwise)
                                        cycles = cycles_CV;
            
                                        % export values of interest for CV
                                        %cell_data{2,1} = discharge_capacity; % discharge capacity (mAh/g)
                                        cell_data{row_CV_data,t} = mydata_CV; % for testing purpose only - entrie cell array of CV cycles 
                                        cell_data{row_CV_Size,t} = mydata_CV_size_i; % for testing purpose only - size of CV cycles 
                                        cell_data{row_cycles_CV,t} = cycles_CV; % for testing purposes - CV cycles numbers (based on the above size) 
            
                                        clear cycles_CV % needs to be emptied for the next filepath
                            %----------------------------------------------------------                           
                            end  %switch 6 - plot_mode. POLARIZATION Plot 
                            %----------------------------------------------------------
                            
                            % EXPORT Capacity Data - discharge and charge capacities 
                            cell_data{row_discharge_capacity,t} = discharge_capacity;
                            cell_data{row_charge_capacity,t} = charge_capacity;
            
                end % switch - plot_mode_multi

%--------------------------------------------------------------------------
% SINGLE Cell per POLARISATION Fig
%--------------------------------------------------------------------------
                switch plot_mode_switch
                    case{1,2,7}
                    %----------------------------------------------------------
                    % Axis - Polarisation/CV/dQdV
                    %----------------------------------------------------------
                    my_polarisation_axis(plot_mode);
                    %----------------------------------------------------------
                    % Title - Polarisation/CV/dQdV 
                    %----------------------------------------------------------
                    my_polarisation_title(plot_mode,my_legend(t),my_title,cycles);
                    %----------------------------------------------------------
                    % Legend - Polarisation/CV/dQdV
                    %----------------------------------------------------------
                    my_polarisation_legend(plot_mode,my_legend,cycles,auto_numbering_string,legend_location);
                end % switch - plot_mode_switch

                clear cycles % needs to be clean for next filepath

    % Additional dQdV Figures
        if(additional_profile_fig == 1) % 07/02/2023
            additional_figure{t} = figure;
            getmedVdQ2(mydata_trimmed,cycles_CC1,plot_mode,dQdV_conditions,my_color_cycles,mygraph_linewidth); % dQdV plot function 
            % Axis - Polarisation/CV/dQdV
            my_polarisation_axis(plot_mode);
            % Title - Polarisation/CV/dQdV 
            my_polarisation_title(plot_mode,my_legend(t),my_title,cycles_CC1);
            % Legend - Polarisation/CV/dQdV
            my_polarisation_legend(plot_mode,my_legend,cycles_CC1,auto_numbering_string,legend_location);
        end % if statment - additional_profile_fig 

    end %for loop - t (num_entries) master POLARISATION

% num_entries FOR LOOP ended 

%--------------------------------------------------------------------------
% MULTIPLE Cell per POLARISATION Fig
%--------------------------------------------------------------------------
    switch plot_mode_switch
        case{3,4}
        %----------------------------------------------------------
        % Axis - Polarisation/CV/dQdV
        %----------------------------------------------------------
        my_polarisation_axis(plot_mode);
        %----------------------------------------------------------
        % Title - Polarisation/CV/dQdV 
        %----------------------------------------------------------
        my_polarisation_title(plot_mode,my_legend(t),my_title,cycles_multiple);
        %----------------------------------------------------------
        % Legend - Polarisation/CV/dQdV
        %----------------------------------------------------------
        switch plot_mode % switch 7. Stupid way to fix
            case 19
                my_polarisation_legend(plot_mode,my_legend,cycles_multiple,auto_numbering_string,legend_location,mydata_trimmed_size,Polarization);
            otherwise
                my_polarisation_legend(plot_mode,my_legend,cycles_multiple,auto_numbering_string,legend_location);
        end % switch - plot_mode
    end % switch - plot_mode_switch

%--------------------------------------------------------------------------
% 1.3 Single Cell - Capacity Fade
%--------------------------------------------------------------------------
% NEW CODE 11/01/2023
% adapted to the new framework

    % comes alongside a polarization curve 
    switch plot_mode_switch 
        case 1 % only the first plot_mode_switch have a DEGRADATION - see EXCEL
            Polarization{t+1} = figure; % using the POLARIZATION Cell array of figures 
    
            for k = 1:num_entries
                plot_capacity_fade(plot_mode,cell_data{row_discharge_capacity,k},cell_data{row_charge_capacity,k},my_color(k,:));
                hold on
                % plot_mode, discharge_capacity, charge_capacity   
            end 
    
            hold off
            % Title - Capacity Fade
            plot_capacity_fade_axis(plot_mode,my_title); 
            % Legend - Capacity Fade
            plot_capacity_fade_legend(plot_mode,my_legend,legend_location,1,auto_numbering_string)
    end % SWITCH plot_mode_switch 

%--------------------------------------------------------------------------
% 1.4 Single Cell - EIS Profiles
%--------------------------------------------------------------------------
    if(eis_profile_fig == 1)
        switch plot_mode
            case 39 % CYCLES for LOCATION
                eis_profile = getmeEIS(mydata_eis,mydata_eis_voltage,cycles_eis,plot_mode,my_legend,my_title,my_color_cycles);% use function to create figures
            otherwise % Locations for CYCLE
                eis_profile = getmeEIS(mydata_eis,mydata_eis_voltage,cycles_eis,plot_mode,my_legend,my_title,my_color_EIS_location);% use function to create figures
        end % switch - plot_mode

    end % if statement - eis_profile_fig positive
end % function - master 