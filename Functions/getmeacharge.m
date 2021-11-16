%--------------------------------------------------------------------------
% Title:    
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Working

% Note:     

function charge_capacity = getmeacharge(data,cycles,data_colors,plot_mode)

% Basic checks
% 1. If did not specific cycles makes sure you can print cycles (half of
% the data set because data is discharge - charge)
if nargin < 2
    cycles = length(data)/2;
    plot_mode = 2; %this means nothing here - just not equal 7 (see pt. 3)
elseif nargin < 4
    plot_mode = 3; %this means nothing here - just not equal 7 (see pt. 3)
end

% 2. If you did specify cycles, but told it to print too many, it corrects
% you. 
if (2*max(cycles) > length(data) && 2*min(cycles) ~= 2)
    disp('There are less cycles in your dataset that you have requested to print!')
    cycles = round(length(data)/2) - 1;
end


% 3. FOR FORMATION CHARGE COMPARISON ONLY - plot mode 7
% plot_mode == 7 and only one cycle is specified 
if(plot_mode == 7 && length(cycles) == 1)
    
    evencolumns = 2:2:length(data);
    evendata = data(1,evencolumns); %get all the discharge datasets
    thedata = evendata{1,cycles};
    
    charge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(charge));
        if(~isempty(index_zero))
            new_discharge = charge(index_zero);

            voltage = thedata(index_zero,1); % voltage (V)

            plot(new_discharge,voltage,'color',data_colors(1,:))
            hold on

            final_actual_value = nonzeros(new_discharge);

            charge_capacity(cycles,:) = [cycles,final_actual_value(end)];
        else
           disp('Empty cycle')
           charge_capacity(1,:) = NaN;
        end 

% -------------------------------------------------------------------------
% 4. If number of cycles e.g [5]
elseif(length(cycles) == 1)
    for i = 2:2:2*cycles
    
    k = i/2;    % dummy variable to get the correct cycle    
        
    thedata = data{1,i}; %get all the discharge datasets
    
    charge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(charge));
        
        if(~isempty(index_zero))

            new_charge = charge(index_zero);

            voltage = thedata(index_zero,1); % voltage (V)

            if nargin < 3
                plot(new_charge,voltage,'--')
                hold on
            elseif nargin == 3 
                plot(new_charge,voltage,'--','color',data_colors(k,:))
                hold on
            end

            final_actual_value = nonzeros(new_charge);

            charge_capacity(k,:) = [k,final_actual_value(end)];
            
        else
           disp('Empty cycle')
           charge_capacity(k,:) = NaN;
        end
    end
    
%  ------------------------------------------------------------------------    
% 5. If selection of cycles e.g [1,2,4,5] or [1:5]
elseif(length(cycles) > 1)
    for i = cycles
    
    evencolumns = 2:2:length(data);
    evendata = data(1,evencolumns); %get all the discharge datasets
    thedata = evendata{1,i};
    
    charge = thedata(:,2);   % current (mAh)
    
    index_zero = find(nonzeros(charge));
    
        if(~isempty(index_zero))

            new_charge = charge(index_zero);

            voltage = thedata(index_zero,1); % voltage (V)

            k = find(i == cycles);  % dummy variable for color scheme

            if nargin < 3
                plot(new_charge,voltage,'--')
                hold on
            elseif nargin == 3 
                plot(new_charge,voltage,'--','color',data_colors(k,:))
                hold on
            end

            final_actual_value = nonzeros(new_charge);

            charge_capacity(i,:) = [i,final_actual_value(end)];

        else
            disp('Empty cycle')
            charge_capacity(k,:) = NaN;
        end
    end
end
end