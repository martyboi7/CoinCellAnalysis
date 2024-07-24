%--------------------------------------------------------------------------
% Title:    Switch - for the different types of plot_mode (so I do not have
%           to update the entire chain of command every time)
% Author:   A.Marinov
% Date:     22nd Aug 2022
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Switch - plot_mode
%--------------------------------------------------------------------------

function [plot_mode_switch,plot_mode_code,plot_mode_multi] = switch_plot_mode(plot_mode)

    switch plot_mode
    %---------------------------
    % SINGLECell
    %---------------------------
        % Pol/CV/dQdV/EIS + DEG  
        %-----------------------
        case{1,2,5} % CC
            plot_mode_unique = 111;
        % Missing:
            % dQdV
            % EIS
            % CV
        case{43,44}
            plot_mode_unique = 114;
        %-----------------------
        % Pol/CV/dQdV/EIS
        %-----------------------
        case{33,34,35} % CC
            plot_mode_unique = 121;
        case{13,14,15} % dQdV
            plot_mode_unique = 122;
        case {39,41,42} % EIS
            plot_mode_unique = 123;
        case{17,24,25} % CV
            plot_mode_unique = 124;
        case{50} % CC - TIME
            plot_mode_unique = 125;
        case {51,52} % CC - Current/Capacity
            plot_mode_unique = 126;
        case 53 % CC - current/time
            plot_mode_unique = 127;
        case {55,56} % CC - capacity/time
            plot_mode_unique = 128;
        % ALL CYCLES
        case{3,4}
            plot_mode_unique = 171;
    %---------------------------
    % MULTICell
    %---------------------------
        % Pol/CV/dQdV/EIS 
        %-----------------------
        case{6,7,20} % POL - capacity
            plot_mode_unique = 231;
        case 18 % POL - Time
            plot_mode_unique = 232;
        case 23 % dQdV
            plot_mode_unique = 233;
        case 26 % CV
            plot_mode_unique = 235;
        %case X %EIS
            %plot_mode_unique = 234;
        %-----------------------
        % Pol/CV/dQdV/EIS 
        %-----------------------
        case 19 % ALL cycles POLARISATION - capacity
            plot_mode_unique = 241;
        case 16 % Pol - time
            plot_mode_unique = 242;
        %-----------------------
        % DEG  
        %-----------------------
        case{8,29,31,10,30,32,11,27,28} % [END]
            plot_mode_unique = 351;
        case{9} % [END] (Tiled Plot - current density)
            plot_mode_unique = 352;
        case{46,47} % [END] AREAL Capacity 
            plot_mode_unique = 353;
        case{36,12} % RANGE [1,200,500]
            plot_mode_unique = 361;
        case{37,57} % Tiled Plot
            plot_mode_unique = 362;
        case{48,49} % TIME - fade
            plot_mode_unique = 391;
        case 54 % current/capacity
            plot_mode_unique = 392; 
        case 45 % DEG - CC from EIS (needs to use the EIS separation)
            plot_mode_unique = 381;
        otherwise
            disp(['Error - switch_plot_mode: plot_mode:',num2str(plot_mode),'. Option not supported.'])
            plot_mode_unique = 1000;
            return
    end % switch - plot_mode: plot_mode_code ASSIGNMENT

%--------------------------------------------------------------------------
% plot_mode_swtich ASSIGN
%--------------------------------------------------------------------------
    plot_mode_code_string = num2str(plot_mode_unique);

    % OUTPUT
    plot_mode_code = str2double(plot_mode_code_string(2:3)); % take just the second and third digit
    plot_mode_switch = str2double(plot_mode_code_string(2)); % take just the second digit
    plot_mode_multi = str2double(plot_mode_code_string(1)); % take just the first digit

end % function - master 