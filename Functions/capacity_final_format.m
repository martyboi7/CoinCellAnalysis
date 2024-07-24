%--------------------------------------------------------------------------
% Title:    Cell - adjust capacity (mAh) to Gravimetric or Areal
% Author:   A.Marinov
% Date:     01/02/2024
% Version:  A1
% Status:   Developing

% Sample:   CoinCells NEWARE + BIOLOGIC
%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function processed_capacity = capacity_final_format(capacity_raw,plot_mode,active_mass,sample_diameter)

        switch plot_mode % type of capacity (Areal or Gravimetric)
            case 46 % mAh/cm2
                electrode_radius = (sample_diameter*10)/2; % radius (convert mm to cm)
                electrode_area = pi()*electrode_radius^2; % cm2
                processed_capacity = capacity_raw/electrode_area; % normalise capacity. D/C includes both. (mAh/cm2) - sample diameter is provided in mm
            case {47,57} % mAh/mm
                electrode_radius = (sample_diameter)/2; % radius (mm)
                electrode_area = pi()*electrode_radius^2; % mm2
                processed_capacity = capacity_raw/electrode_area; % normalise capacity. D/C includes both. (mAh/mm2) - sample diameter is provided in mm
            otherwise % mAh/g
                processed_capacity = capacity_raw/active_mass; % normalise capacity. D/C includes both. (mAh/g)
        end % switch - plot_mode

end % function - master