%--------------------------------------------------------------------------
% Title:    CC TIME (BIOLOGIC + NEWARE)
% Author:   A.Marinov
% Date:     5th May 2023
% Version:  A1
% Status:   Developing 

% Note:   
%--------------------------------------------------------------------------

function polarization_time(data_discharge,data_charge,cycles_limit,plot_mode,my_source,data_colors,mygraph_linewidth)

% Data Labelling - ignoring special cases up above
    [column_voltage,column_total_time,column_capacity,~,~,~,~,~] = getmy_celldata_columns(1); % for first 4 columns - CYCLER choice does not matter!

switch my_source 
    case 1 % BIOLOGIC

        [total_time,voltage,current_density,capacity] = biologic_total_time(data_discharge,data_charge,cycles_limit,plot_mode);

    case 2 % NEWARE
                    
        [total_time,voltage,current_density,capacity] = neware_total_time(data_discharge,data_charge,cycles_limit,plot_mode);
        % use function to get neware total time 

end % switch - my_source

switch plot_mode
    case 53 % Current/TIME
        plot(total_time/3600,current_density,'color',data_colors,'LineWidth',mygraph_linewidth)
        hold on
    case 55 % Capacity/Time
        plot(total_time/3600,capacity,'color',data_colors,'LineWidth',mygraph_linewidth)
        hold on    
    case 56 % Capacity/Time + Current/Time
        yyaxis('left') % LHS - Capacity/Time
        plot(total_time/3600,capacity,'color','b','LineWidth',mygraph_linewidth)
        hold on  

        yyaxis('right') % RHS - Current/Time
        plot(total_time/3600,current_density,'color','r','LineWidth',mygraph_linewidth)
        hold on  
    case {16,18,50} % Voltage/TIME
        plot(total_time/3600,voltage,'color',data_colors,'LineWidth',mygraph_linewidth)
        hold on
    otherwise
        disp('polarization_time: plot_mode not ACCEPTED')
end % switch - plot_mode

end % function - master 
