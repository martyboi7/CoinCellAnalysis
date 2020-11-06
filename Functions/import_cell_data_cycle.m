function output = import_cell_data_cycle(filename, active_mass)
% Date: 31/01/2020

if nargin < 1
    disp('Error: filepath not provided for your sample. Cheers')
    return
elseif nargin < 2
    disp('Error: no active mass for the samples provided')
    return
end 

% Selection of data for plots 
my_selection = ["Ecell/V","halfcycle","cyclenumber","Qcharge/discharge/mA.h","Qcharge/mA.h","Qdischarge/mA.h"];

% Input handling - updated on 1/11/2020
f = fopen(filename); % matlab stuff
first_line_of_file = textscan(f,'%s',10); % the 8th entry is always the line number where the data starts. 
line_comment_end = str2double(first_line_of_file{1,1}{8,1}); % this is the last line of comments in the file
my_dataLines = [line_comment_end + 1, Inf]; % start the data from what information was given in the header.
fclose(f); % close the file so it don't bug the next scan

g = fopen(filename); % matlab stuff 
many_lines = textscan(g,'%s',line_comment_end,'delimiter','\n'); % scans with every line
fclose(g); % matlab stuff 

% automatically find all the variables in the file 
variable_list_delimited = many_lines{1,1}{line_comment_end,1}; % this should be text line of all the variables 
variable_list = textscan(variable_list_delimited,'%s','delimiter','\t');
variable_list_string_1 = string(variable_list{1}); %converts to a string array
variable_list_string = erase(variable_list_string_1'," "); % transposes the variable list 
size_variable_list_string = size(variable_list_string);

jimmy = find(ismember(variable_list_string,my_selection)); % find where the correct names are 
for i=1:size_variable_list_string(2)
    variable_counter(i) = strcat("Var",num2str(i));
    variable_type(i) = "double";
end 

clear variable_list_delimited variable_list variable_list_string_1 first_line_of_file many_lines
clear ans i
%--------------------------------------------------------------------------
%  Import Options 
%--------------------------------------------------------------------------
%  Allows for the final table/array order to always be the same
for o = 1:length(my_selection)
    var_index(o) = find(ismember(variable_list_string,my_selection(o)));
end

% 06/11/2020 Worked on the bioLogic Bug

%Setup the Import Options - this line needs to be first for .opts!!!
    opts = delimitedTextImportOptions("NumVariables", size_variable_list_string(2));
    
% Specify range and delimiter
    opts.DataLines = my_dataLines;
    opts.Delimiter = "\t";
    opts.VariableNames = variable_counter;
    opts.SelectedVariableNames = variable_counter(jimmy);
%     ["EcellV", "halfcycle",  "cyclenumber", "QchargedischargemAh", "QchargemAh", "QdischargemAh"];
    opts.VariableTypes = variable_type;
%     ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double","double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

% Convert the data
h = fopen(filename); % matlab stuff 
mydata = readtable(filename, opts);
fclose(h); % matlab stuff 

% Re-order the table to have always the same column order
desired_order = variable_counter(var_index); 
[~, varOrder] = ismember(mydata.Properties.VariableNames, desired_order); 
[~, resortOrder] = sort(varOrder); 
t = mydata(:,resortOrder);
t2 = table2array(t(:,[1 2 5 6])); % the final cut table [Voltage (V), halfcycle, Charge (mAh), Discharge (mAh)}

% Processing the specific capacities - relative to active mass 
discharge = t2(:,4)/active_mass; % normalise the discharge capacity
charge = t2(:,3)/active_mass; % normalise the charge capacity

% Output
output = [t2(:,1),t2(:,2),discharge,charge];

end