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
%--------------------------------------------------------------------------
function data = breaktheplot(mydata,my_source,plot_mode)  

% BIOLOGIC: halfcycle_identifier -> used only within the breaktheplotCC

  switch my_source
      %--------------------------------------------------------------------
      case 1 % BIOLOGIC
      %--------------------------------------------------------------------
          data = breaktheplotCC_BiologicData(mydata,my_source); % call to function
      %--------------------------------------------------------------------  
      case 2 % NEWARE
          % does not currently have halfcycle_identifier
      %--------------------------------------------------------------------
          data = breaktheplotCC_Neware(mydata,plot_mode,my_source); % call to function
  end % switch - my_source data cutting 
  
end % Master - function
