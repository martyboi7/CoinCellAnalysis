%--------------------------------------------------------------------------
% Title:    
% Author:   A.Marinov
% Date:     3rd March 2022
% Version:  A1
% Status:   Developing

% Note:    
%           

function getmeaCV(data,cycles_CV,my_color_cycles,plot_mode,CV_edge_limit,mygraph_linewidth)
%--------------------------------------------------------------------------
% Input Handling 
% fill out 

switch nargin
    case 0
        disp('       Error - getmeaCV: no data passed on to function')
        return
end

if(isempty(data))
        disp('       Error - getmeaCV: Empty data variable (data) passed on to function')
        return
end

% Fixed values 
cycles_fixed = [];
my_color_cycles_fixed = getme_cycle_colour(3); % get CV colours
plot_mode_fixed = 17;
CV_edge_limit_fixed = 0;
mygraph_linewidth_fixed = 1;

switch nargin 
    case 1
        cycles_CV = cycles_fixed;
        my_color_cycles = my_color_cycles_fixed; % get CV colours
        plot_mode = plot_mode_fixed;
        CV_edge_limit = CV_edge_limit_fixed; 
        mygraph_linewidth = mygraph_linewidth_fixed;
    case 2
        my_color_cycles = my_color_cycles_fixed; % get CV colours
        plot_mode = plot_mode_fixed;
        CV_edge_limit = CV_edge_limit_fixed; 
        mygraph_linewidth = mygraph_linewidth_fixed;
    case 3
        plot_mode = plot_mode_fixed;
        CV_edge_limit = CV_edge_limit_fixed; 
        mygraph_linewidth = mygraph_linewidth_fixed;
    case 4
        CV_edge_limit = CV_edge_limit_fixed; 
        mygraph_linewidth = mygraph_linewidth_fixed;
    case 5 
        mygraph_linewidth = mygraph_linewidth_fixed;
end % switch - input handling

% Parameter - SET
% CV_edge_limit = 100; % removes the first and last X points in the CV scan to avoid high rise tails in currents (11/06/2024)

disp('       getmeaCV')
disp(['       CV edge limit: ',num2str(CV_edge_limit)])

%--------------------------------------------------------------------------
% Plotting
%--------------------------------------------------------------------------

k = 1; % dummy variable
% for the CV cycles 
            for i = cycles_CV
                thedata = data{1,i}; % [Voltage (V), Discharge Capacity (mAh/g), Charge Capacity (mAh/g), Current Density (mA/g), Biologic dQdV (mAh/g/V)]
                plot(thedata(CV_edge_limit:end-CV_edge_limit,1),thedata(CV_edge_limit:end-CV_edge_limit,4),'Color',my_color_cycles(k,:),LineWidth=mygraph_linewidth)
                k = k + 1;
                hold on
            end % for loop
            
            switch plot_mode
                case{17,24,25}
                    hold off
            end % switch 
                    
% for the CC cycles 
        
end 