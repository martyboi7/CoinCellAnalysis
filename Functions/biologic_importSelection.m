%--------------------------------------------------------------------------
% Title:    Biologic - import column selection
% Author:   A.Marinov
% Date:     02/10/2022
% Version:  A1
% Status:   Developing
% Note: 
%--------------------------------------------------------------------------

function [jimmy,my_selection,my_selection_critical] = biologic_importSelection(variable_list_string)
        % columns to be imported from the BIOLOGIC .mpt file 
        % BASIC, dQDV, and EIS
        % 12/12/2022 - changed from having "Qcharge/mA.h","Qdischarge/mA.h" to "Q charge/discharge/mA.h"

        % only CC
        my_selection2 = ["Ewe/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA"]; % original?
        my_selection3 = ["Ecell/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA"]; % when the names changed
        % CC + Biologic dQdV
        my_selection4 = ["Ecell/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA","d(Q-Qo)/dE/mA.h/V"]; % dQdV from Biologic
        my_selection5 = ["Ewe/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA","d(Q-Qo)/dE/mA.h/V"]; 

        my_selection_critical = 8; % the length for inbuilt Biologic dQdV
        % EIS 
        my_selection6 = ["Ecell/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA","freq/Hz","|Z|/Ohm","Phase(Z)/deg","zcycle","Re(Z)/Ohm","-Im(Z)/Ohm","Re(Y)/Ohm-1","Im(Y)/Ohm-1","|Y|/Ohm-1","Phase(Y)/deg"]; % EIS developments (02/10/2022)
        my_selection7 = ["Ewe/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","time/s","I/mA","freq/Hz","|Z|/Ohm","Phase(Z)/deg","zcycle","Re(Z)/Ohm","-Im(Z)/Ohm","Re(Y)/Ohm-1","Im(Y)/Ohm-1","|Y|/Ohm-1","Phase(Y)/deg"];
        
        % Variable Selection
        % find where the most matches of column words occur!
        % only CC
        jimmy2 = find(ismember(variable_list_string,my_selection2)); % find where the correct names are
        jimmy3 = find(ismember(variable_list_string,my_selection3)); % find where the correct names are
        % dQdV
        jimmy4 = find(ismember(variable_list_string,my_selection4)); % find where the correct names are
        jimmy5 = find(ismember(variable_list_string,my_selection5));
        % EIS
        jimmy6 = find(ismember(variable_list_string,my_selection6)); % EIS (02/10/2022)
        jimmy7 = find(ismember(variable_list_string,my_selection7)); % EIS (02/10/2022)

            % SECTION BELOW NEEDS FIXING - fixed 22/10/2021 and again
            % 12/12/2022
            %--------------------------------------------------------------
            % Updated 12/12/2022
            if(length(jimmy6)>length(jimmy4) && length(jimmy6)>=length(jimmy7)) % EIS over normal (new)
                my_selection = my_selection6;
                jimmy = jimmy6; 
            elseif(length(jimmy7)>length(jimmy5) && length(jimmy7)>length(jimmy6))
                my_selection = my_selection7;
                jimmy = jimmy7; % EIS
            elseif(length(jimmy4)>length(jimmy3) && length(jimmy4)>length(jimmy5)) % dQdV over normal (new)
                my_selection = my_selection4;
                jimmy = jimmy4;
            elseif(length(jimmy5)>length(jimmy2) && length(jimmy5)>length(jimmy4)) % dQdV over normal (new)
                my_selection = my_selection5;
                jimmy = jimmy5;
            elseif(length(jimmy3)>length(jimmy2)) % normal (new) over normal (old)
                my_selection = my_selection3;
                jimmy = jimmy3;
            elseif(length(jimmy2)>length(jimmy3)) % normal (old) over normal (new)
                my_selection = my_selection2;
                jimmy = jimmy2;
            else
                disp('Error: My Selection cannot identify the variable names. Line 62 biologic_importSelection.m')
                return
            end 
            %--------------------------------------------------------------
%         clear variable_list_delimited variable_list variable_list_string_1 first_line_of_file many_lines
end % function - master