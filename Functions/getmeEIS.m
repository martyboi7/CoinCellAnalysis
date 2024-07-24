%--------------------------------------------------------------------------
% Title:    Plot EIS (Biologic)
% Author:   A.Marinov
% Date:     06/10/2022
% Version:  A1
% Status:   Developing
% Note: 

% OUTPUT: A cell of figures!
%--------------------------------------------------------------------------
function EIS_figure = getmeEIS(mydata_eis,mydata_eis_voltage,cycles_input,plot_mode,my_legend,my_title,my_color_cycles)
% Import the DATA
mydata_eis_size = size(mydata_eis);

% Plot Type decision
if(isempty(cycles_input)) % e.g cycles = []
    % 1. Plots ALL
    cycles = 1:mydata_eis_size(2);
elseif(length(cycles_input)==1) % e.g cycles = 5
    % 2. Plots up to CYCLE
    cycles = 1:cycles_input;
elseif(length(cycles_input)>1) % e.g cycles = [1,5,10] or cycles = [100:120]
    % 3. Plot SELECTION
    cycles = cycles_input; % [1,2,5,10]
end % if-statement

mylimit_b = mydata_eis_size(1); % Always plot all the section for D or C

%--------------------------------------------------------------------------
% Plotting 
%--------------------------------------------------------------------------
%-----------------------
% NEW Code - 02/02/2023
%-----------------------
switch plot_mode % how to run the for loops - based on plot_mode decision
    case 39 % Plots EQUAL LOCATIONS for all CYCLES - all 0.8 V D scans are on a SINGLE plot
        % b - number of EIS scans per cycle
            A1 = 1:mylimit_b;
        % g - number of cycles
            A2 = cycles;

    case {41,42} % Plots all LOCATIONS for a SINGLE CYCLE on the same plot - D1...D2...
            my_color_eis = getme_eis_colour();
            % need to change this to auto update colors
            my_color_cycles = mycolor_validate(plot_mode,my_color_eis,mylimit_b,1);

        % b - number of cycles
            A1 = cycles;
        % g - number of EIS scans per cycle
            A2 = 1:mylimit_b;
end % switch - plot_mode

%-----------------------
% NEW Code - 20/01/2023
%-----------------------
d = 1; % dummy counter - for cycle label
im_z_addition = 0; % empty for assignment
im_z_add = 100; % amount added every time

    for b = A1
        EIS_figure{b} = figure;
        c = 1; % dummy counter - for color  
        im_z_max_for_axis = 0; % empty for assignment 
        re_z_max_for_axis = 0;
        for g = A2
                
                switch plot_mode % for opening the correct data
                    case 39 % LOCATION - equal
                        open_data = mydata_eis{b,g}; % open specific EIS set 
                    case {41,42} % all LOCATIONS per CYCLE
                        open_data = mydata_eis{g,b}; % open specific EIS set 
                end % switch - plot_mode
    
                if(~isempty(open_data)) % make sure data not []
                    re_z = open_data(:,7);
                    im_z = open_data(:,8);   

                    % plotting 
                    switch plot_mode
                        case{39,41} % no offset
                            plot(re_z,im_z,'o',Color=my_color_cycles(c,:)) % plot
                        case 42 % offset
                            plot(re_z,(im_z + im_z_addition),'o',Color=my_color_cycles(c,:)) % plot                            
                    end % switch - plot_mode
                    hold on
    
                    % OFFSETTING
                    im_z_addition = im_z_addition + im_z_add;

                    % AXIS - limit
                    if(max(im_z) > im_z_max_for_axis)
                        im_z_max_for_axis = max(im_z); % assignment
                    end
                    if(max(re_z) > re_z_max_for_axis)
                        re_z_max_for_axis = max(re_z); % assignment
                    end

                    clear open_data re_z im_z voltage 
                    c = c + 1; % increase color counter
                end % if-statement (empty)
        end % for loop - g
        hold off % close figure

        switch plot_mode % plot legend 
            case 39
                eis_location = mean(mydata_eis_voltage(b,:)); % voltage_average
            case{41,42}
                eis_location = mydata_eis_voltage(:,b); % voltage_average_export
        end
        clear voltage_average % clear for next location (plt_mode == 39)
        im_z_addition = 0; % clear for next figure (cycle)

        % SETUP all the labelling for the Figure here - 20/01/2023
        my_eis_title(plot_mode,my_legend,my_title,cycles,d,eis_location)
        d = d+1; % increase dummy counter (cycle number)

        % Plot axis
        xlabel('Re(z)','Interpreter','latex')
        ylabel('-Im(z)','Interpreter','latex')


        switch plot_mode 
            case{39,41} % no OFFSET for the plots 
                % AXIS
                axis_limit = 200; % 08/02/2023 - dummy fix
                axis([0 axis_limit 0 axis_limit])
                clear im_z_max_for_axis re_z_max_for_axis axis_limit% clear for next plot
        end
    
    end % for loop - b
end % function - master 