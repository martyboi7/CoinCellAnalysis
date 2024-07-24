%--------------------------------------------------------------------------
% Title:    Colour - validation 

% Author:   A.Marinov
% Date:     27th Oct 2022
% Version:  A1
% Status:   Working

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function output_color = mycolor_validate(plot_mode,my_color_input,cycles,num_entries)

    disp('       mycolor_validate')
    
    [plot_mode_switch,plot_mode_code] = switch_plot_mode(plot_mode);
    my_color_size = size(my_color_input);
    my_color_length = my_color_size(1);
    cycles_length = length(cycles);

    switch plot_mode_switch
        %------------------------------
        case{1,2,7} % SINGLECells - colours for each CYCLE
        %------------------------------
        % these plot modes are based on MULTIPLE cycles for SINGLE
        % cell (separate fig. for each CELL
        switch plot_mode_code % CC, dqdV, CV, and EIS have different colour schemes now (26/10/2023)
            case {12,22} % dQdV
                mycolor = getme_cycle_colour(2);
            case {14,24} % CV
                mycolor = getme_cycle_colour(3);
            case {13,23} % EIS
                mycolor = getme_cycle_colour(4);
            otherwise
                mycolor = getme_cycle_colour(1); % assigns my decided colors palate from other function
        end % switch - plot_mode_code

            % my_polarisation_profile - new edition
            if(cycles(1) > my_color_length && cycles_length == 1 || isempty(my_color_input) && cycles_length == 1)
            % ALL [] OR END [200] - need be if-statement because
            % plot_mode_switch categories can be both [END] and [Selection].
                output_color = getmecolor(mycolor,cycles(1)); % specific cycles
            elseif(cycles_length > my_color_length)  % [SELECTION]              
                output_color = getmecolor(mycolor,cycles_length); % all the cycles 
            elseif(cycles_length < size(mycolor,1))
                output_color = mycolor; % cycles
            else % if enough colors for the number of cycles present
                output_color = my_color_input;
            end % if-statement 
        %------------------------------
        otherwise % MULTICell - colours for each Cell
        %------------------------------
        % my_capacity_fade
        if(isempty(my_color_input) || num_entries > my_color_length)
            switch plot_mode_switch
                case {3,4,5,6} % MULTICell - comparison of one cycle amongst cells 
                    output_color = getmecolor(my_color_input,num_entries);
                otherwise
                    disp('              Error: mycolor_validate - not enough colors assigned!')
            end % switch - plot_mode_swtich
        else 
            output_color = my_color_input;
        end % if statement

    end % switch - plot_mode_switch
end % function - master