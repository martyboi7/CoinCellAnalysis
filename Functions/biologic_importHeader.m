%--------------------------------------------------------------------------
% Title:    Biologic - import pulls column NAMES
% Author:   A.Marinov
% Date:     02/10/2022
% Version:  A1
% Status:   Developing
% Note: 
%--------------------------------------------------------------------------
function [variable_list_string,my_dataLines] = biologic_importHeader(filename)
    % Input handling - updated on 1/11/2020
            f = fopen(filename); % matlab stuff
            first_line_of_file = textscan(f,'%s',10); % the 8th entry is always the line number where the data starts. 
    % If code fails here with: 
    % Error using textscan
    % Invalid file identifier. Use
    % fopen to generate a valid file
    % identifier.
    % This means that your filepath is wrong - CHECK IT!
            line_comment_end = str2double(first_line_of_file{1,1}{8,1}); % this is the last line of comments in the file
            my_dataLines = [line_comment_end + 1, Inf]; % start the data from what information was given in the header.
            fclose(f); % close the file so it don't bug the next scan
    
            g = fopen(filename); % matlab stuff 
            many_lines = textscan(g,'%s',line_comment_end,'delimiter','\n'); % scans with every line
            fclose(g); % matlab stuff 
    
            % Import Variable Settings
            % Automatically find all the variables in the file 
            variable_list_delimited = many_lines{1,1}{line_comment_end,1}; % this should be text line of all the variables 
            variable_list = textscan(variable_list_delimited,'%s','delimiter','\t');
            variable_list_string_1 = string(variable_list{1}); %converts to a string array
            variable_list_string = erase(variable_list_string_1'," "); % transposes the variable list 
    %         size_variable_list_string = size(variable_list_string);
end % function - master 