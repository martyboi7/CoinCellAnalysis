%--------------------------------------------------------------------------
% Title:    
% Author:   A.Marinov
% Date:     31th Jan 2020
% Version:  A1
% Status:   Working

% Note:     

function charge_capacity = getmeacharge(data,cycles,data_colors)

if nargin < 2
    cycles = length(data)/2;
end

if (2*max(cycles) > length(data) && 2*min(cycles) ~= 2)
    disp('There are less cycles in your dataset that you have requested to print!')
    cycles = round(length(data)/2) - 1;
end

if(length(cycles) == 1)
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