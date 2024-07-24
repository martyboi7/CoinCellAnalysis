%--------------------------------------------------------------------------
% Title:    Cycles

% Author:   A.Marinov
% Date:     12th Oct 2022
% Version:  A1
% Status:   Developing

% Note: Decides what to do if no cycles were provided. Does not function
% for CV cycles!!! Those need to be looped externaly!!!

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
% Export - plot_mode_switch (if empty)
    % 3 - cycle 1
    % 2 - last cycle
    % 1,4,5,6,7 - last cycle

function cycles = my_cycles(import_cycles,plot_mode,mydata_trimmed) 

    [plot_mode_switch,plot_mode_code] = switch_plot_mode(plot_mode);

    % For the plot_mode that need to do ALL the CYCLES force open
    switch plot_mode_switch 
        case{4,7}
            import_cycles = []; % needs to plot all the cycles 
    end 

    if(isempty(import_cycles)) % cycles = []
        mydata_trimmed_size = size(mydata_trimmed);
        switch plot_mode_switch
            case 3 % single cycle comparison
                cycles = 1; % fix to first cycle if comaprison CYCLE not provided
            case 6 % RANGE
                cycles = [1,round(mydata_trimmed_size(2)/2),mydata_trimmed_size(2)]; % [1,1/2,END]
            otherwise 
                switch plot_mode_code
                    % case 13 - CV (not included as separate - cannot be used to stop capacity fade plot from being plotted)
                    case 22 % Calculates: cycles = range (start:FINAL) dQdV
                        cycles_length = mydata_trimmed_size(2);
                        cycles = 1:cycles_length; % Calculates: cycles = all cycles up to single_number (total)
                
                    otherwise % Calculates: cycles = single_number (FINAL)
                        cycles = 1:mydata_trimmed_size(2); 
                end % switch - plot_mode_cod
        end % switch - plot_mode_switch
        
    else %if cycle provided 
        cycles = import_cycles;
    end % if-statement

end % function - master 