%--------------------------------------------------------------------------
% Title:    Biologic and Neware import sequence for Cell data 
% Author:   A.Marinov
% Date:     Summer 2022
% Version:  A1
% Status:   Working Developing
% Note: 
%--------------------------------------------------------------------------
function [output,my_source] = import_cell_data_cycle(filename,active_mass,sample_diameter,plot_mode)
    % Date: 31/01/2020

    if nargin < 1
        disp('Error: filepath not provided for your sample. Cheers')
        return
    elseif nargin < 2
        disp('Error: no active mass for the samples provided')
        return
    end 

%-------------------------------------
% Data File SOURCE (Biologic or NEWARE)
%-------------------------------------
    % My SOURCE Meaning:
        % my_source == 1 - .mpt (Biologic data)
        % my_source == 2 - .txt (NEWARE data)
    
    % Reader - check if filename (Biologic - 1, NEWARE - 2, other - CRASH)
    filename_char = char(filename);
    filename_ending = filename_char(end-2:end);
    
        if(strcmp(filename_ending,'mpt'))
            my_source = 1; % BIOLOGIC
        elseif(strcmp(filename_ending,'txt')) % if file type .txt (QMU Neware) 
            my_source = 2;
        else
            my_source = 100; % dummy
        end % if statmenet 
    
%--------------------------------------------------------------------------
%-------------------------------------
% Import Sequence - BIOLOGIC .mpt
%-------------------------------------
    switch my_source
        case 1 % BIOLOGIC
        % Biologic - import HEADER (get all the columns available in data file 
        [variable_list_string,my_dataLines] = biologic_importHeader(filename);
        % Biologic - get the correct column SELECTION (EIS, dQdV, new order, old order)
        [jimmy,my_selection,my_selection_criticial] = biologic_importSelection(variable_list_string);

        % Create the var names for the file to read
        for i=1:length(variable_list_string)
            variable_counter(i) = strcat("Var",num2str(i));
            variable_type(i) = "double";
        end 

       

        %  Import Options (.opt)
        %  Allows for the final table/array order to always be the same

        t = 1; % counter variable

        for o = 1:length(my_selection)
            var_index_test = ismember(variable_list_string,my_selection(o)); % logical test
            if(any(var_index_test)) % checks if ANY not zero
                var_index(t) = find(ismember(variable_list_string,my_selection(o)));
                t = t+1; % increase counter
            end % if-statement
            clear var_index_test
        end % for-statement

    %-------------- BIOLOGIC END

%-------------------------------------
% Import Sequence - NEWARE .txt
%-------------------------------------
        case 2 % my_source 
            f = fopen(filename); % open the text file
            first_line_of_file = textscan(f,'%s',26,'delimiter','\t'); % the 1st Line is the column headings in NEWARE (45 headers - last 3 entries are one column)
            variable_list_string = string(first_line_of_file{1,1}'); % string

            my_selection = ["Cycle Index","Step Index","Step Type","Time","Voltage(V)","Current(mA)","Capacity(mAh)","Energy(Wh)","Power(W)","dQ/dV(mAh/V)"]; % Column Titles 
            jimmy = find(ismember(variable_list_string,my_selection)); % find where the correct names are
            my_dataLines = [2, Inf]; % dataLines for NEWARE are fixed 

        %------------------ NEWARE END

        otherwise
            disp(['Error: import_cell_data_cycle. Filepath is inccorect type for CYCLE. my_source:',num2str(my_source)])
            return
    
    end % switch - my_source
    
%--------------------------------------------------------------------------
%-------------------------------------
% .opts - BIOLOGIC
%-------------------------------------
switch my_source
    case 1 % Biologic .mpt

        size_variable_list_string = length(variable_list_string);
        % 06/11/2020 Worked on the bioLogic Bug

        %Setup the Import Options - this line needs to be first for .opts!!!
            opts = delimitedTextImportOptions("NumVariables", size_variable_list_string);

        % Specify range and delimiter
            opts.DataLines = my_dataLines;
            opts.Delimiter = "\t";
            opts.VariableNames = variable_counter;
            opts.SelectedVariableNames = variable_counter(jimmy);

            opts.VariableTypes = variable_type;
            opts.ExtraColumnsRule = "ignore";
            opts.EmptyLineRule = "read";
            
%-------------------------------------
% .opts - NEWARE
%-------------------------------------
    case 2 % NEWARE
            
            opts = detectImportOptions(filename);
            opts.VariableNames = variable_list_string;
            opts.SelectedVariableNames = my_selection;
            opts.VariableNamingRule = 'preserve';
end  % switch - my_source 

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%  Import Data
%--------------------------------------------------------------------------
% Convert the data
h = fopen(filename); % matlab stuff 
mydata = readtable(filename, opts);
fclose(h); % matlab stuff

%--------------------------------------------------------------------------
%  OUTPUT Sequence 
%--------------------------------------------------------------------------
% BIOLOGIC:  time(s), voltage (V), current (mA), dq (mAh), Qcharge/Qdischarge (mAh), halfcycle, cyclenumber, Qcharge (mAh), Qdischarge (mAh)
% NEWARE: Cycle, Step, time (duration), Voltage (V), Current (mA), Capacity (mAh), Energy (Wh), Power (W), dQdV (mAh/V)

%-------------------------------------
% OUTPUT - Biologic
%-------------------------------------
    switch my_source 
        case 1 % Biologic 
            % Biologic Output function
            output = biologic_output(var_index,mydata,active_mass,sample_diameter,variable_counter,my_selection_criticial,plot_mode);  % 09/02/2023 - added sample diameter 
            disp('       output_processing: Biologic')
            % BIOLOGIC:  Voltage, Time(s), Capacity(mAh/g), Current Density (mA/g), HALFCYCLE, dQdV/EIS(7-11)
%-------------------------------------
% OUTPUT - NEWARE
%-------------------------------------
        case 2 % NEWARE
            output = neware_output(mydata,active_mass,sample_diameter,plot_mode); % 09/02/2023 - added sample diameter 
            disp('       output_processing: NEWARE')
            % NEWARE: Voltage, Time, Capacity (mAh/g), Current Density (mA/g), Cycle Number, Step Index, Step Type, dQdV
            
    end  % switch - my_source EXPORT

end % function - master 