%--------------------------------------------------------------------------
% Title:    CellDetails Export Function - one central function
% Author:   A.Marinov
% Date:     7th July 2022
% Version:  A1
% Status:   Working 
% Latest Update: 

% Note:     Allows all Cell_Details Export options to be controlled from a
%           single location
%--------------------------------------------------------------------------

function filepath_samples = CellDetails_filepath_trajectory(pc_choice,sample_path)
%--------------------------------------------------------------------------
% filepath
%--------------------------------------------------------------------------
    switch pc_choice % switch 2 - trajectory path
            case 1 % Gaming PC
                trajectory = "D:\OneDrive\";
            case 2 % UCL Laptop
                trajectory = "C:\Users\Alexander\";
            case 3 % Dad PC - INACTIVE
                trajectory = "E:\Alex\Work\OneDrive\";
        otherwise
            disp('Error: CellDetails_filepath_trajectory - no such file folder! Options are: laptop, PC, or dad.')
            return
    end % switch 1 - pc_choice

    filepath_samples = strcat(trajectory,sample_path);
end % master function 