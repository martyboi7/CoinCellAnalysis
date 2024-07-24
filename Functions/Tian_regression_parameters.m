%--------------------------------------------------------------------------
% Title:    Tian Regression - Parameters

% Author:   A.Marinov
% Date:     7th Feb 2023
% Version:  A1
% Status:   Developing

% Note: 

%--------------------------------------------------------------------------
% Function
%--------------------------------------------------------------------------
function Tian2019_input = Tian_regression_parameters(my_title)

    % PARAMETERS
    beta0 = [160, 0.13, 0.34]; % initial guess for model coefficients (OG)
    % beta0 = [1000, 1, 0.9]; % initial guess for model coefficients (Testing)
    step_size = 0.01; % for plotting purpose (OG)
    % step_size = 0.01; % for plotting purpose (Testing)
    log10fit = true; % type of model fit
    % current_densities(1:cycles(1)) = 0.1; % for model fit. A/g
    % OR
    % repeating_unit = 5; % of cycles in each iteration 
    % current_densities = reshape(ones(repeating_unit,1) * current,[],1); % the A/g for the paper

% Tian2019_input = {beta0, step_size, log10fit, current_densities, my_title};
Tian2019_input = {beta0, step_size, log10fit, my_title};

end % function - master