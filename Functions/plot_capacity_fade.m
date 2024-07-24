%--------------------------------------------------------------------------
% Title:    All the capacity fade options available
% Author:   A.Marinov
% Date:     04/10/2022
% Version:  A1
% Status:   Developing
% Note:     ** need to put some sort of input handling which catches stray
% plot_modes which are not part of any of the switch statements

% OUTPUT: 

% plot_modes: 1,3,5,17,24,39;8,9,11,36;27,28,29,31;2,4;10;30,32
%--------------------------------------------------------------------------
function plot_capacity_fade(plot_mode,discharge_capacity,charge_capacity,my_color)
    % Plots the capacity fade figure 
        test_zero_discharge = any(discharge_capacity(:,1)); %check if any of the cycle numbers are non-zero
        test_zero_charge = any(charge_capacity(:,1)); %check if any of the cycle numbers are non-zero
        
        % assings real_discharge_capacity & real_charge_capacity if they
        % have actual values (not entirly zero). Plus skips the zeros. 
        if (test_zero_discharge == 1 && test_zero_charge == 1)
            real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity); % remove empty discharge cycles
            real_charge_capacity = skipZeroCapacityCycles(charge_capacity); % remove empty charge cycles 
        elseif(test_zero_discharge == 1)
            real_discharge_capacity = skipZeroCapacityCycles(discharge_capacity); % remove empty discharge cycles
        elseif(test_zero_charge == 1)
            real_charge_capacity = skipZeroCapacityCycles(charge_capacity); % remove empty charge cycles 
        else 
            disp('Error - coinCellAnalysis: discharge and charge capacities for degradation plot are EMPTY')
        end 

    % Input Handling - plot_mode

    [plot_mode_switch,~] = switch_plot_mode(plot_mode);

    switch plot_mode_switch
        case{1,7,5,6,8} %plot_mode: 1,3,5,2,4,17,24,39,8,9,10,11,27,28,29,31,30,32,36
%--------------------------------------------------------------------------
% Sequence of SWITCH plot_mode
%--------------------------------------------------------------------------
        %------------------------------------------------------------------
        % Ratios
        %------------------------------------------------------------------
        switch plot_mode
            case 27
                ratio = real_charge_capacity(:,2)./real_discharge_capacity(:,2); % Ci/Di
            case 28
                ratio = real_discharge_capacity(:,2)./real_charge_capacity(:,2); % Di/Ci
            case 29
                ratio = real_discharge_capacity(:,2)./real_discharge_capacity(1,2); % Di/D(1)
            case 31
                ratio = real_discharge_capacity(:,2)./max(real_discharge_capacity(:,2)); % Di/Dmax
            case 30 
                ratio = real_charge_capacity(:,2)./real_charge_capacity(1,2); % Ci/C(1)
            case 32
                ratio = real_charge_capacity(:,2)./max(real_charge_capacity(:,2)); % Ci/Cmax
        end % switch - plot_mode D/C ratios
        %------------------------------------------------------------------
        % Discharge & Charge
        %------------------------------------------------------------------
        switch plot_mode
            %--------------------
            % Discharge ONLY
            %--------------------
            case {1,3,17,39,43,8,9,42,46,47,36,37,57} 
                % SINGLECells - which use Discharge Degradation
                % MULTICells - which use Discharge 
%                 plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:))    
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:),'MarkerFaceColor',my_color(1,:)) % Thesis Colour Scheme
                hold on
            case {27,28,29,31} % MULTICells - which use Discharge or Charge Ratios
%                 plot(real_discharge_capacity(:,1),ratio,':o','color',my_color(1,:))
                plot(real_discharge_capacity(:,1),ratio,':o','color',my_color(1,:),'MarkerFaceColor',my_color(1,:)) % Thesis Colour Scheme
                hold on       
            %--------------------
            % Charge ONLY
            %--------------------
            case {2,4} % SINGLECells - which use Charge Degradation
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold off
            case {10} % MULTICells - which use Charge 
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold on 
            case {30,32} % MULTICells - which use Charge Ratios
                plot(real_charge_capacity(:,1),ratio,'--s','color',my_color(1,:))
                hold on
            %--------------------
            % Discharge & Charge 
            %--------------------
            case {5,24}
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:))
                hold on
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold off
            case {11,44}
                plot(real_discharge_capacity(:,1),real_discharge_capacity(:,2),':o','color',my_color(1,:))
                hold on
                plot(real_charge_capacity(:,1),real_charge_capacity(:,2),'--s','color',my_color(1,:))
                hold on
            otherwise
                disp(['Error! plot_capacity_fade - plot_mode:',num2str(plot_mode),'. Option not available.']); % added 09/02/2023 to speed up error handling (ideally this should not be here)
        end % switch - plot_mode charge

        otherwise 
            disp(['Error: plot_capacity_fade - not a valid plot_mode selection. plot_mode selected: ',num2str(plot_mode)])
    end % switch - plot_mode input handling 
end % function - plot_capacity_fade