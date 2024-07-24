%--------------------------------------------------------------------------
% Title:    BIOLOGIC only - finds the CV cycles from CV trimmed data
% Author:   A.Marinov
% Date:     18th Jan 2023
% Version:  A1
% Status:   Developing

% Note:     not perfect!
%--------------------------------------------------------------------------
function [cycles_CV,data_CV_size_i,data_CV_intermediate] = getmeCVcycles(data_CV_intermediate,cut_length)

%cut_length = 200; 
% cycles with length of data less than this are false (e.g there is a spike in voltage at the start of cycle - and thus removed). 

% Number of cycles in the CV data inputted 
    data_CV_size = size(data_CV_intermediate); % [1,size]

% Get the size of each CV cycle (Max volt - Min volt)
    for f = 1:data_CV_size(2)
        data_CV_test_me = data_CV_intermediate{1,f}; % open cell array
        data_CV_size_i(f,:) = size(data_CV_test_me); % find the size of the specific cell array (CV data for cycle)
        clear data_CV_test_me
    end
    
    % find cycles with size ~ 154 and eliminate from dataset cell and index counter
    cycles_microcycle = find(data_CV_size_i(:,1) < cut_length); % index - of CV cycles where dataset is tiny (Biologic fluctuation in voltage)
    data_CV_intermediate(cycles_microcycle) = []; % eliminate micro cycles
    data_CV_size_i(cycles_microcycle,:) = []; % eliminate micro cycles

%--------------------------------------------------------------------------
% USE sorting, median, and max values to find the size of CV cycles
% relative to CC cycles (it is more of an art that science)

    % NEW code 18/01/2023 ** 
    data_CV_size_i_sort = sort(data_CV_size_i(:,1),"ascend"); % order size increasing (smallest -> largest)
    data_CV_size_i_sort_length = length(data_CV_size_i_sort); % get size of sorted size
    data_CV_size_i_median_low = median(data_CV_size_i_sort(1:round(data_CV_size_i_sort_length/2))); % find median of smaller half of cycles
    %data_CV_size_i_median = median(data_CV_size_i_sort); % median size of cell entries (cycles)    
    data_CV_size_i_max_sort = mean(data_CV_size_i_sort(data_CV_size_i_sort_length-10:end-1)); % mean of top 10 sizes (max excluded - as can be excessive if accidently cycles are compressed together)  
    data_CV_size_i_threshold = data_CV_size_i_max_sort - data_CV_size_i_median_low; % use difference between mean of top 10 sizes and median of lower half, to find the distance between the sizes (e.g. 2,000 or 10,000)
    cycles_CV = find(data_CV_size_i(:,1) > data_CV_size_i_threshold); % CV cycles where the size of dataset matches threshold requirement!
    
end % master - function