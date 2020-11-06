%--------------------------------------------------------------------------
% Title:    
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Working

% Note:     

function discharge_capacity = getmeadischarge(data,cycles,data_colors,plot_mode)

% Basic checks
% 1. If did not specific cycles makes sure you can print cycles (half of
% the data set because data is discharge - charge)
if nargin < 2
    cycles = length(data)/2;
    plot_mode = 2; %this means nothing here - just has to be more than 1
elseif nargin < 4
    plot_mode = 3; %this means nothing here - just has to be more than 1
end

% 2. If you did specify cycles, but told it to print too many, it corrects
% you. 
if (2*max(cycles) > length(data) && 2*min(cycles) ~= 2)
    disp('There are less cycles in your dataset that you have requested to print!')
    cycles = round(length(data)/2) - 1;
end

% 3. FOR FORMATION CHARGE COMPARISON ONLY
% plot_mode == 1 and only one cycle is specified 
if(plot_mode == 1 && length(cycles) == 1)
    
    oddcolumns = 1:2:length(data);
    odddata = data(1,oddcolumns); %get all the discharge datasets
    thedata = odddata{1,cycles};
    
    discharge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(discharge));
        if(~isempty(index_zero))
            new_discharge = discharge(index_zero);

            voltage = thedata(index_zero,1); % voltage (V)

            plot(new_discharge,voltage,'color',data_colors(1,:))
            hold on

            final_actual_value = nonzeros(new_discharge);

            discharge_capacity(cycles,:) = [cycles,final_actual_value(end)];
        else
           disp('Empty cycle')
           discharge_capacity(k,:) = NaN;
        end 
% -------------------------------------------------------------------------
% 4. If number of cycles e.g [5]
elseif(length(cycles) == 1)
    for i = 1:2:2*cycles
   
    k = round(i/2);    % dummy variable to get the correct cycle
    
    thedata = data{1,i}; %get all the discharge datasets
    
    discharge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(discharge));
    
        if(~isempty(index_zero))
        new_discharge = discharge(index_zero);

        voltage = thedata(index_zero,1); % voltage (V)

            if nargin < 3
                plot(new_discharge,voltage)
                hold on
            elseif nargin == 3 
                plot(new_discharge,voltage,'color',data_colors(k,:))
                hold on
            end

        final_actual_value = nonzeros(new_discharge);

        discharge_capacity(k,:) = [k,final_actual_value(end)];

        else
           disp('Empty cycle')
           discharge_capacity(k,:) = NaN;
        end
    end 
elseif(length(cycles) > 1)
%  ------------------------------------------------------------------------    
% 5. If selection of cycles e.g [1,2,4,5] or [1:5]
    for i = cycles
    
    oddcolumns = 1:2:length(data);
    odddata = data(1,oddcolumns); %get all the discharge datasets
    thedata = odddata{1,i};
    
    discharge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(discharge));
        if(~isempty(index_zero))

            new_discharge = discharge(index_zero);

            voltage = thedata(index_zero,1); % voltage (V)

            k = find(i == cycles);  % dummy variable for color scheme

            if nargin < 3
                plot(new_discharge,voltage)
                hold on
            elseif nargin == 3 
                plot(new_discharge,voltage,'color',data_colors(k,:))
                hold on
            end

            final_actual_value = nonzeros(new_discharge);

            discharge_capacity(i,:) = [i,final_actual_value(end)];
        else
            disp('Empty cycle')
           discharge_capacity(k,:) = NaN;
        end
    end
end
end