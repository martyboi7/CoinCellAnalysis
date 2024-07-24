

% this is the old function - saved on GitHub

function output = import_cell_data_old(filename, active_mass, dataLines)
% Date: 31/01/2020

% Input handling

% If dataLines is not specified, define defaults
if nargin < 3
    dataLines = [101, Inf];
end

%Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 32);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["mode", "oxred", "error", "controlchanges", "Nschanges", "counterinc", "Ns", "IRange", "times", "controlmA", "EcellV", "ImA", "dqmAh", "QQomAh", "EnergyWh", "QchargedischargemAh", "halfcycle", "x", "cyclenumber", "QchargemAh", "QdischargemAh", "EnergychargeWh", "EnergydischargeWh", "cycletimes", "steptimes", "chargetimes", "dischargetimes", "dQQodEmAhV", "CapacitymAh", "Efficiency", "PW", "ROhm"];
opts.SelectedVariableNames = ["EcellV", "halfcycle",  "cyclenumber", "QchargedischargemAh", "QchargemAh", "QdischargemAh"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Convert the data
mydata = table2array(readtable(filename, opts));
voltage = mydata(:,1); 
halfcycle = mydata(:,2); %charging or discharging
discharge = mydata(:,6)/active_mass; % normalise the discharge capacity
charge = mydata(:,5)/active_mass; % normalise the charge capacity

% Output
output = [voltage,halfcycle,discharge,charge];

end