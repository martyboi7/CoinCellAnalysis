%--------------------------------------------------------------------------
% Title:    Break the plot - Biologic CC Data Split
% Author:   A.Marinov
% Date:     04/10/2022
% Version:  A1
% Status:   Developing
% Note: 

% OUTPUT: X
%--------------------------------------------------------------------------
function [voltage,total_time,capacity,current_density,halfcycle,halfcycle_unique,dqdv,column_dqdv] = breaktheplot_BiologicSplit(mydata,my_source)

% BIOLOGIC (CC): Voltage (V), Time (s), Capacity (+/- mAh/g), Current Density (+/- mA/g), HALFCYCLE, dQdV

      mydata_size = size(mydata); 
      [column_voltage,column_total_time,column_capacity,column_current_density,column_halfcycle,~,~,column_dqdv] = getmy_celldata_columns(my_source); % get the column number for each of the info

      % DATA
      voltage = mydata(:,column_voltage); % (V)
      total_time = mydata(:,column_total_time); %(s)
      capacity = mydata(:,column_capacity); % +/- mAh/g
      current_density = mydata(:,column_current_density); % (+/- mA/g)

      % INDEXING
      halfcycle = mydata(:,column_halfcycle);
      halfcycle_unique = unique(halfcycle); %find all the unique possible values of the halfcycle index
     
      if(mydata_size(2) == column_dqdv)
        dqdv = mydata(:,column_dqdv); % (mAh/g/V) - Biologic dQdV
      else 
        dqdv = 0; % dummy 
      end

end % function - master 