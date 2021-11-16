%--------------------------------------------------------------------------
% Title:    Break the Plot
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Finished

% Note:     Splits the massive data set into individual cells of charge or
% dischare cycles. It works based on the halfcycle number. The halfcycle
% starts at 0 (discharge), and jumps to 2 at the first charge. It then
% stays even for charges and odd for discharges. 


function data = breaktheplot(mydata)
% mydata is the dataset passed into the fuction as a cell

% Data Science 
  halfcycle_unique = unique(mydata(:,2)); %find all the unique possible values of the halfcycle index
%   halfcycle_unique(1,1) = 1; % matlab does not like zeros so make the first 0 a 1
  
  voltage = mydata(:,1); % (V)
  discharge = mydata(:,3); % (mAh/h)
  charge = mydata(:,4); % (mAh/g)
  
  total_time = mydata(:,5); %(s)
  current_density = mydata(:,6); % (mA/g)
  dq = mydata(:,7); % (mAh)
  
  for i = 1:length(halfcycle_unique)
      
      k = halfcycle_unique(i);    %dummy variable
      
      if i == 1 % so that I can do any operation
          k = 0;    % making sure I get the data from the 0 halfcycle
      end
      
      index = find(mydata(:,2) == k);
      
      if mod(i,2) == 0 
        data{i} = [voltage(index),charge(index),current_density(index)];
      else
        data{i} = [voltage(index),discharge(index),current_density(index)];
      end

  end
  
end