%--------------------------------------------------------------------------
% Title:    Contains all the Filepaths and Active Masses for my Coin Cells
%           (THESIS EDITION)
% Author:   A.Marinov
% Date:     27/10/2023
% Version:  A1
% Status:   Working 
% Latest Update: 27/10/2023

% Note:     Allows to quickly call the filepaths of all my coin cells
%           (regardless of the comp. working on) 
% Sample:   Only CC, R and HR cells. All BaseLines, and EPD. 


function [filepath_samples,sample_mass,sample_diameter,sample_per_CYCLE_EIS,sample_color,sample_legend] = Cell_Details_CC_20231027(pc_choice)
% Input Handling
switch nargin
    case 0
        disp('Error Cell_Details_CC10_20220712: Cannot access Cell Details')
end 


%--------------------------------------------------------------------------
% 1. Masses
%--------------------------------------------------------------------------
% CC
sample_mass_CC10 = [0.002538559,0.003470436,0.004450512,0.003092865,0.004554947,0.004667415,0.004378212,0.004474613,0.004217543,0.004771849,0.004354111,0.004747749,0.004498713,0.004466579,0.004603147,0.004080975,0.004354111,0.004803983];
sample_mass_CC9 = [0.009055142,0.008191986,0.008935259,0.009590618,0.005906222,0.004635465,0.006433706,0.001790097,0.001888377];
Sample_mass_CC12 = [0.005308285,0.007818528,0.005747977,0.005795943,0.007434796];
sample_mass_CC11 = [0.001558475,0.009135064,0.017646737,0.026142426,0.022833663,0.065128288,0.001598881,0.004165085,0.015349257,0.024255023,0.034463878,0.046495456,0.001926651,0.005979815,0.0144299,0.022320377,0.034152096,0.045000503];
sample_mass_CC13_A = [0.006014435,0.005934028,0.006480795,0.00595815,0.006569242,0.006159167]; % 25um
sample_mass_CC13_B = [0.014741682,0.014453883,0.014693715,0.014693715,0.014086141,0.014493855]; % 50 um
sample_mass_CC13_C = [0.001334694,0.001862178,0.001854186,0.001358671,0.002333717,0.002853209]; % 10 um
sample_mass_CC14 = [0.006046598,0.006665731,0.005330976];
sample_mass_CC15 = [0.005652604,0.005684767,0.003425333]; % 25 um - double spacer
sample_mass_CC16 = [0.00018,0.00014,0.00196,0.00067,0.00237,0.00239,0.00123];
sample_mass_CC17 = [0.005801161,0.005497519,0.005673312];
sample_mass_CC18 = [0.003063502,0.005934028,0.005861662,0.005097796,0.00607072,0.006167208];
sample_mass_CC22 = [0.002782078,0.005773214,0.005097796]; 

sample_mass = [sample_mass_CC10,sample_mass_CC9,Sample_mass_CC12,sample_mass_CC11,sample_mass_CC13_A,sample_mass_CC13_B,sample_mass_CC13_C,sample_mass_CC14,sample_mass_CC15,sample_mass_CC16,sample_mass_CC17,sample_mass_CC18,sample_mass_CC22]; %append all together
%--------------------------------------------------------------------------
% 2. Diameter of Electrode 
%--------------------------------------------------------------------------
sample_diameter_CC10 = [11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11];
sample_diameter_CC9 = [15,15,15,15,15,15,15,11,11];
sample_diameter_CC12 = [15,15,15,15,15];
sample_diameter_CC11 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15];
sample_diameter_CC13_A = [15,15,15,15,15,15]; % 25 um
sample_diameter_CC13_B = [15,15,15,15,15,15]; % 50 um
sample_diameter_CC13_C = [15,15,15,15,15,15]; % 10 um
sample_diameter_CC14 = [15,15,15]; % P3
sample_diameter_CC15 = [15,15,15]; % 25 um - double spacer
sample_diameter_CC16 = [15,15,15,15,15,15,15];
sample_diameter_CC17 = [15,15,15];
sample_diameter_CC18 = [15,15,15,15,15,15];
sample_diameter_CC22 = [15,15,15];

sample_diameter = [sample_diameter_CC10,sample_diameter_CC9,sample_diameter_CC12,sample_diameter_CC11,sample_diameter_CC13_A,sample_diameter_CC13_B,sample_diameter_CC13_C,sample_diameter_CC14,sample_diameter_CC15,sample_diameter_CC16,sample_diameter_CC17,sample_diameter_CC18,sample_diameter_CC22]; % append all together
sample_per_CYCLE_EIS = zeros(1,length(sample_diameter)); % empty set
%--------------------------------------------------------------------------
% 3. Filenames (OneDrive)
%--------------------------------------------------------------------------
sample_filepath = [
    %----------------------------------------------------------------------
    % CC10 - Voltage CutOFFs - QMU (12/07/2022) 
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220121_BaseP_MoS2 
            %--------------------------------------------------------------
                    %--------------------
                    % 3.0-0.01 V
                    %--------------------
                    % 20220621_CC10_M1 (3.0-0.01V)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_001V\220621_CC10_M1.txt"
                    % M2
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_001V\220601_CC10_M2.txt"
                    % M3
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_001V\220621_CC10_M3.txt"                    
                    %--------------------
                    % 3.0 - 0.4 V
                    %--------------------
                    % 20220621_CC10_M4 (3.0-0.4V)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_04V\220621_CC10_M4.txt"
                    % M5
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_04V\220621_CC10_M5.txt"
                    % M6
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_04V\220621_CC10_M6.txt"                    
                    %--------------------
                    % 3.0 - 0.6 V
                    %--------------------
                    % 20220621_CC10_M7
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_06V\220621_CC10_M7.txt"
                    % M8
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_06V\220621_CC10_M8.txt"
                    % M9
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_06V\220621_CC10_M9.txt"                    
                    %--------------------
                    % 3.0 - 0.8 V
                    %--------------------
                    % 20220621_CC10_M10
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_08V\220621_CC10_M10.txt"
                    % M11
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_08V\220621_CC10_M11.txt"
                    % M12
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P1\P1_08V\220621_CC10_M12.txt"                  
                    %--------------------
                    % 3.0 - 0.8 V P2
                    %--------------------
                    % 220726_CC10_M1_P2
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_08V\220726_CC10_M1_P2.txt"
                    % M2_P2 Prelim
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_08V\220726_CC10_M2_P2.txt"
                    % M3_P2 Prelim
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_08V\220726_CC10_M3_P2.txt"
                    %--------------------
                    % 3.0 - 1.5 V P2
                    %--------------------
                    % 220726_CC10_M4_P2
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_150V\220726_CC10_M4_P2.txt"
                    % M5_P2
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_150V\220726_CC10_M5_P2.txt"
                    % M6_P2
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC10_P2\P2_150V\220726_CC10_M6_P2.txt"
    %----------------------------------------------------------------------
    % CC9 - P1
    %----------------------------------------------------------------------
                    %--------------------
                    % 3.5 - 0.01 V
                    %--------------------
                    % 220831_CC9_M5
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9\220831_CC9_M5_CE3.mpt"
                    % 220831_CC9_M6
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9\220831_CC9_M6_CE8.mpt"
    %----------------------------------------------------------------------
    % CC9 - P3 
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 (10wt% - 25um) B
            %--------------------------------------------------------------
                    %--------------------
                    % 3.0 - 0.01 V
                    %--------------------
                    % 220812_CC9_M7 (P3 - Hold every D/C 6 hr)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\220812_CC9_ALX_M7_CE4.mpt"
                    % 220812_CC9_M8 (P3 - Hold D1/C1 24 hr)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\220812_CC9_ALX_M8_CE5.mpt"
                    %--------------------
                    % 3.0 - 0.8 V
                    %--------------------
                    % 220812_CC9_M9 (P3 - Hold every D/C 6 hr)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\220812_CC9_ALX_M9_CE6.mpt"
                    % 220812_CC9_M10 (P3 - Hold D1/C1 24 hr)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\220812_CC9_ALX_M10_CE7.mpt"

                    % 230112_CC9_P3
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\230113_ALX_CC9_M1_P3_CA1.mpt"
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\230113_ALX_CC9_M2_P3_CA2.mpt"
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC9_P3\230113_ALX_CC9_M3_P3_CA3.mpt"
    %----------------------------------------------------------------------
    % CC12  
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 (10wt% - 25um)
            %--------------------------------------------------------------
            % 230208_CC9_M1
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC12\230108_CC12\230208_ALX_CC9_M1_P1_CF7.mpt"
            % 230208_CC9_M2
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC12\230108_CC12\230208_ALX_CC9_M2_P1_CF8.mpt"
            % 230208_CC9_M3
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC12\230108_CC12\230208_ALX_CC9_M3_P2_v2_CC3.mpt"
            % 230208_CC9_M4
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC12\230108_CC12\230208_ALX_CC9_M4_P3_CC7.mpt"
            % 230208_CC9_M5
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC12\230108_CC12\230208_ALX_CC9_M5_P3_v2_CC8.mpt"

%--------------------------------------------------------------------------
% THICKNESS TESTING
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC11 - Thickness Testing 
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 - A1 (3.0 - 0.01V)
            %--------------------------------------------------------------
                    % PRELIMINARY
                    % 10um (9.1 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M1_CF1.mpt"
                    % 25um (52.1 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M2_CF2.mpt"
                    % 50um (108.9 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M3_CF3.mpt"
                    % 75um (167.9 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M4_CF4.mpt"
                    % 100um (172.9 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M5_CF5.mpt"
                    % 150 um (616.2 um)
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A1\220812_CC11_ALX_M6_CF6.mpt"
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 - A2 (3.0 - 0.01V)
            %--------------------------------------------------------------
                    % 10um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M1_CF3.mpt"
                    % 25um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M2_CF4.mpt"
                    % 50um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M3_CF5.mpt"
                    % 75um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M4_CF6.mpt"
                    % 100um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M5_CF7.mpt"
                    % 150um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A2\220902_ALX_CC11_M6_CF8.mpt"
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 - CC11 - A3 (3.0-0.8V)
            %--------------------------------------------------------------
                    % 10 um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M1_CE6.mpt"
                    % 25 um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M2_CE7.mpt"
                    % 50 um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M3_CE8.mpt"
                    % 75 um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M4_CF3.mpt"
                    % 100 um
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M5_CF5.mpt"
                    % 150 um - did not work!
                    "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC11_A3\230117_ALX_CC11_A3_M6_v2_CF6.mpt"

    %----------------------------------------------------------------------
    % CC13 - thickness testing for paper (25um, 50um, 10um)
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 230311_BaseP_MoS2 B (10wt%, 25um) - A (3.0 - 0.01V)
            %--------------------------------------------------------------
            % Finished 19/05/2023
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M1_CE1.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M2_CE2.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M3_CE3.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M4_CE4.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M5_CE5.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_A_25um\230331_ALX_CC13_M6_CE6.mpt"
            

            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 (10wt% - 50um) - B (3.0 - 0.01V)
            %--------------------------------------------------------------
            % COMPLETE results - 21/04/2023
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230331_ALX_CC13_M7_CD1.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230331_ALX_CC13_M8_CD2.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230331_ALX_CC13_M9_CD3.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230331_ALX_CC13_M10_CD4.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230403_ALX_CC13_M7_CD5.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_B_50um\230403_ALX_CC13_M8_CD6.mpt"

            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 (10wt% - 10um) - C (3.0 - 0.01V)
            %--------------------------------------------------------------
            % Finished
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M1_CB1.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M2_CB2.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M3_CB3.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M4_v2_CB4.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M5_CB5.mpt"
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230126_MoS2Paper\CC13\CC13_C_10um\230403_ALX_CC13_M6_CB6.mpt"

%--------------------------------------------------------------------------
% P3 Testing 
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC14 - P3 230311_BaseP_MoS2 B (10wt%, 25um)
    %----------------------------------------------------------------------
        % 230531_CC14_M3 (D1/C1 (30hr), D1/C1+ (2hr)); 3.0 - 0.8
        "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC14\230531_ALX_CC14_M3_CB3.mpt"      
        % 230531_CC14_M4 (D1/C1 (30hr), D1/C1+ (0.4hr)); 3.0 - 0.8
        "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC14\230531_ALX_CC14_M4_CB4.mpt"   
        % 230531_CC14_M5 (D1 (24hr), C1 (2hr), D1/C1+ (2hr)); 3.0 - 0.01
        "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC14\230531_ALX_CC14_M5_CB5.mpt"

%--------------------------------------------------------------------------
% Pressure TESTING
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC15 - double spacer (1.0 mm) 230311_BaseP_MoS2 B (10wt%, 25um)
    %----------------------------------------------------------------------
            "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC15\230707_ALX_CC15_M1_CD2.mpt"
            "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC15\230707_ALX_CC15_M2_CD5.mpt"
            "OneDrive - University College London\PhD Research\Data Final\CoinCells\20230126_MoS2Paper\CC\CC15\230707_ALX_CC15_M3_CC5.mpt"


%--------------------------------------------------------------------------
% EPD - Water Testing
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC16 - EPD 
    %----------------------------------------------------------------------
            % 230719_EPD2_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230719EPD2CE_M1_CE1.mpt"
            % 230719_EPD3_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230719EPD3CE_M2_CE2.mpt"
            % 230804_EPD3_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230804EPD3CE_M3_CE3.mpt"
            % 230815_EPD4_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230815EPD4CE_M7_CE4.mpt"
            % 230814_EPD1_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230814EPD1CE_M4_CF2.mpt"
            % 230814_EPD3_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230814EPD3CE_M5_CF3.mpt"
            % 230815_EPD1_CE
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC16_EPD\230817_ALX_230815EPD1CE_M6_CF4.mpt"

%--------------------------------------------------------------------------
% CMC Water - SC
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC17 - CMC/SC
    %----------------------------------------------------------------------
            % 230817_CMCP_M1
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC17\230817_ALX_CMCP_M1_CF5.mpt"
            % 230817_CMCP_M2
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC17\230817_ALX_CMCP_M2_CF6.mpt"
            % 230817_CMCP_M3
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20230922_CC16_17_Prelim\230817_CC17\230817_ALX_CMCP_M3_CF7.mpt"

%--------------------------------------------------------------------------
% Base P - Final CC for Thesis 22/01/2024
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC18 - Formation
    %----------------------------------------------------------------------
            % 231101_CC18_M1
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M1_CC3.mpt"            
            % 231101_CC18_M2
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M2_CC4.mpt"
            % 231101_CC18_M3
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M3_CC5.mpt"
            % 231101_CC18_M4
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M4_CC6.mpt"
            % 231101_CC18_M5
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M5_CC7.mpt"
            % 231101_CC18_M6
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC18\20240313_Finished\231101_ALX_CC18_M6_CC8.mpt"
    %----------------------------------------------------------------------
    % CC22 - 1.80 V
    %----------------------------------------------------------------------
            % 231101_CC22_M1
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC22\20240122_Prelim\231101_ALX_CC22_M1_CA1.mpt"
            % 231101_CC22_M2
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC22\20240122_Prelim\231101_ALX_CC22_M2_CA2.mpt"
            % 231101_CC22_M3
            "OneDrive - University College London\PhD Research\Raw Data\CoinCells\20231101_CC22\20240122_Prelim\231101_ALX_CC22_M3_CA8.mpt"

                    ];
%--------------------------------------------------------------------------
% 4. Legends
%--------------------------------------------------------------------------                
% CC - according to proper sample codes                 
% sample_legend_CC10 = {'20220621_CC10_M1 (3.0-0.01V)','20220621_CC10_M2 (3.0-0.01V)','20220621_CC10_M3 (3.0-0.01V)','20220621_CC10_M4 (3.0-0.4V)','20220621_CC10_M5 (3.0-0.4V)','20220621_CC10_M6 (3.0-0.4V)','20220621_CC10_M7 (3.0-0.6V)','20220621_CC10_M8 (3.0-0.6V)','20220621_CC10_M9 (3.0-0.6V)','20220621_CC10_M10 (3.0-0.8V)','20220621_CC10_M11 (3.0-0.8V)','20220621_CC10_M12 (3.0-0.8V)','20220726_CC10_M1_P2 (3.0-0.8V)','20220726_CC10_M2_P2 (3.0-0.8V)','20220726_CC10_M3_P2 (3.0-0.8V)','20220726_CC10_M4_P2 (3.0-1.5V)','20220726_CC10_M5_P2 (3.0-1.5V)','20220726_CC10_M6_P2 (3.0-1.5V)'}; 
% sample_legend_CC9 = {'220831_CC9_M5 (3.5-0.01V)','220831_CC9_M6 (3.5-0.01V)','220812_CC9_M7 P3 (3.0-0.01V) D/C 6hr','220812_CC9_M8 P3 (3.0-0.01V) D1/C1 24hr','220812_CC9_M9 P3 (3.0-0.8V) D/C 6hr','220812_CC9_M10 P3 (3.0-0.8V) D1/C1 24hr','230113_CC9_M1 P3 D1-D10 (3.0-0.8V)','230113_CC9_M2 P3 0.8V D1 (3.0-0.01V)','230113_CC9_M3 P3 D1 0.8V P2 (3.0-0.8V)'};
sample_legend_CC12 = {'230208_CC12_M1 (3.0-0.01V)','230208_CC12_M2 (3.0-0.8V)','230208_CC12_M3 P2 (0.01-1.80V)','230208_CC12_M4 P3 D1 0.8V (P1 3.0-0.01V)','230208_CC12_M5 P3 D1 0.8V (P2 3.0-0.8V)'};
% sample_legend_CC11 = {'220812_CC11_M1 (3.0-0.01V)','220812_CC11_M2 (3.0-0.01V)','220812_CC11_M3 (3.0-0.01V)','220812_CC11_M4 (3.0-0.01V)','220812_CC11_M5 (3.0-0.01V)','220812_CC11_M6 (3.0-0.01V)','220902_CC11_M1 (10um 3.0-0.01V)','220902_CC11_M2 (25um 3.0-0.01V)','220902_CC11_M3 (50um 3.0-0.01V)','220902_CC11_M4 (75um 3.0-0.01V)','220902_CC11_M5 (100um 3.0-0.01V)','220902_CC11_M6 (150um 3.0-0.01V)','230117_CC11_A3_M1 (10um 3.0-0.8V)','230117_CC11_A3_M2 (25um 3.0-0.8V)','230117_CC11_A3_M3 (50um 3.0-0.8V)','230117_CC11_A3_M4 (75um 3.0-0.8V)','230117_CC11_A3_M5 (100um 3.0-0.8V)','230117_CC11_A3_M6 (150um 3.0-0.8V)'};
% sample_legend_CC13_A = {'230331_CC13_M1 (3.0-0.8V) 25um','230331_CC13_M2 (3.0-0.8V) 25um','230331_CC13_M3 (3.0-0.8V) 25um','230331_CC13_M4 (3.0-0.01V) 25um','230331_CC13_M5 (3.0-0.01V) 25um','230331_CC13_M6 (3.0-0.01V) 25um'}; % 25um
% sample_legend_CC13_B = {'230331_CC13_M7 (3.0-0.8V) 50um','230331_CC13_M8 (3.0-0.8V) 50um','230331_CC13_M9 (3.0-0.01V) 50um','230331_CC13_M10 (3.0-0.01V) 50um','230403_CC13_M7 (3.0-0.8V) 50um','230403_CC13_M8 (3.0-0.01V) 50um'}; % 50um
% sample_legend_CC13_C = {'230403_CC13_M1 (3.0-0.8V) 10um','230403_CC13_M2 (3.0-0.8V) 10um','230403_CC13_M3 (3.0-0.8V) 10um','230403_CC13_M4 (3.0-0.01V) 10um','230403_CC13_M5 (3.0-0.01V) 10um','230403_CC13_M6 (3.0-0.01V) 10um'}; % 10um
% sample_legend_CC14 = {'230531_CC14_M3 (3.0 - 0.8) 25um (P3 - D1/C1 (30hr), D1/C1+ (2hr))','230531_CC14_M4 (3.0 - 0.8) 25um (P3 D1/C1 (30hr), D1/C1+ (0.4hr))','230531_CC14_M5 (3.0 - 0.01) 25um (P3 D1 (24hr), C1 (2hr), D1/C1+(2hr))'};
% sample_legend_CC15 = {'230707_CC15_M1 (3.00-0.01V 25um - spac.x2)','230707_CC15_M2 (3.00-0.01V 25um - spac.x2)','230707_CC15_M3 (3.00-0.01V 25um - spac.x2)'};
% sample_legend_CC16 = {'230719_EPD2_CE','230719_EPD3_CE','230804_EPD3_CE','230815_EPD4_CE','230814_EPD1_CE','230814_EPD3_CE','230815_EPD1_CE'};
% sample_legend_CC17 = {'230817_CMCP_M1','230817_CMCP_M2','230817_CMCP_M3'};
% sample_legend_CC18 = {'231101_CC18_M1 (3.00 - 0.01V) Formation 10 mA/g','231101_CC18_M2 (3.00 - 0.01V) Formation 10 mA/g','231101_CC18_M3 (3.00 - 0.01V) Formation 10 mA/g','231101_CC18_M4 (3.00 - 0.80V) Formation 10 mA/g','231101_CC18_M5 (3.00 - 0.80V) Formation 10 mA/g','231101_CC18_M6 (3.00 - 0.80V) Formation 10 mA/g'};
% sample_legend_CC22 = {'231101_CC22_M1 (3.00 - 1.80 V)','231101_CC22_M2 (3.00 - 1.80 V)','231101_CC22_M3 (3.00 - 1.80 V)'};

% LEGEND - THESIS format
% PR1
sample_legend_CC10 = {'CC1-M1 (3.0-0.01V)','CC1-M2 (3.0-0.01V)','CC1-M3 (3.0-0.01V)','CC1-M4 (3.0-0.4V)','CC1-M5 (3.0-0.4V)','CC1-M6 (3.0-0.4V)','CC1-M7 (3.0-0.6V)','CC1-M8 (3.0-0.6V)','CC1-M9 (3.0-0.6V)','CC1-M10 (3.0-0.8V)','CC1-M11 (3.0-0.8V)','CC1-M12 (3.0-0.8V)'};
sample_legend_CC10_PR2 = {'CC4-M4 (PR3 3.0-0.8V)','CC4-M5 (PR3 3.0-0.8V)','CC4-M6 (PR3 3.0-0.8V)','CC4-M1 (PR3 3.0-1.5V)','CC4-M2 (PR3 3.0-1.5V)','CC4-M3 (PR3 3.0-1.5V)'}; 
% Thickness Sets
sample_legend_CC11_A1 = {'220812_CC11_M1 (3.0-0.01 V)','CC6-M1 Control','220812_CC11_M3 (3.0-0.01 V)','220812_CC11_M4 (3.0-0.01 V)','220812_CC11_M5 (3.0-0.01 V)','220812_CC11_M6 (3.0-0.01 V)'};
sample_legend_CC11_A2 = {'CC2-001-M1 (9 \mum)','CC2-001-M2 (23 \mum)','CC2-001-M3 (95 \mum)','CC2-001-M4 (149 \mum)','CC2-001-M5 (204 \mum)','CC2-001-M6 (260 \mum)'};
sample_legend_CC11_A3 = {'CC2-080-M1 (12 \mum)','CC2-080-M2 (35 \mum)','CC2-080-M3 (84 \mum)','CC2-080-M4 (126 \mum)','CC2-080-M5 (185 \mum)','CC2-080-M6 (263 \mum)'};
% Thickness Consistency
% sample_legend_CC13_A = {'CC2-M080-M1 (~ 36 \mum)','CC2-M080-M2 (~ 36 \mum)','CC2-M080-M3 (~ 36 \mum)','CC2-M001-M4 (~ 36 \mum)','CC2-M001-M5 (~ 36 \mum)','CC2-M001-M6 (~ 36 \mum)'}; % 25um - for thickness
% sample_legend_CC13_A = {'CC2-M080-M1 100 mA/g','CC2-M080-M2 100 mA/g','CC2-M080-M3 100 mA/g','CC2-M001-M4 100 mA/g','CC2-M001-M5 100 mA/g','CC2-M001-M6 100 mA/g'}; % 25um - as comparison for formation
% sample_legend_CC13_A = {'CC2-M080-M1 100 mA/g','CC2-M080-M2 100 mA/g','CC2-M080-M3 100 mA/g','CC2-M001-M4','CC2-M001-M5','CC2-M001-M6'}; % 25um - as comparison for spacer
% sample_legend_CC13_A = {'CC2-M080-M1 100 mA/g','CC2-M080-M2 100 mA/g','CC2-M080-M3 100 mA/g','CC2-M001-M4 PVDF','CC2-M001-M5 PVDF','CC2-M001-M6 PVDF'}; % 25um - as comparison for CMC
sample_legend_CC13_A = {'CC2-M080-M1 100 mA/g','CC2-M080-M2 100 mA/g','CC2-M080-M3 100 mA/g','CC2-M001-M4 (3.0-0.01 V)','CC2-M001-M5 (3.0-0.01 V)','CC2-M001-M6 (3.0-0.01 V)'}; % 25um - as comparison for capacitance

sample_legend_CC13_B = {'CC2-B080-M1 (87 \mum)','CC2-B080-M2 (100 \mum)','CC2-B001-M4 (82 \mum)','CC2-B001-M5 (97 \mum)','CC2-B080-M3 (87 \mum)','CC2-B001-M6 (85 \mum)'}; % 50um
sample_legend_CC13_C = {'CC2-T080-M1 (8 \mum)','CC2-T080-M2 (10 \mum)','CC2-T080-M3 (10 \mum)','CC2-T001-M4 (8 \mum)','CC2-T001-M5 (13 \mum)','CC2-T001-M6 (15 \mum)'}; % 10um
% Capacitance
sample_legend_CC22 = {'CC3-M1 (3.0-1.80 V)','CC3-M2 (3.0-1.80 V)','CC3-M3 (3.0-1.80 V)'};
% Counter Protocols
sample_legend_CC18 = {'CC5-M001-M4 10 mA/g','CC5-M001-M5 10 mA/g','CC5-M001-M6 10 mA/g','CC5-M080-M1 10 mA/g','CC5-M080-M2 10 mA/g','CC5-M080-M3 10 mA/g'}; %Formation
sample_legend_CC9 = {'220831_CC9_M5 (3.5-0.01V)','220831_CC9_M6 (3.5-0.01V)','CC6-M3 Di/Ci 6hr','CC6-M2 D1/C1 24hr','CC6-M5 Di/Ci 6hr','CC6-M4 D1/C1 24hr','CC6-M6 D1-D10 6hr','230113_CC9_M2 P3 0.8V D1 (3.0-0.01V)','230113_CC9_M3 P3 D1 0.8V P2 (3.0-0.8V)'}; % Voltage hold
sample_legend_CC14 = {'CC6-M7 D1/C1 (30hr), D2+/C2+ (2hr)','CC6-M8 D1/C1 (30hr), D2+/C2+ (0.4hr)','CC6-M9 D1 (24hr), C1 (2hr), D2+/C2+ (2hr)'}; % Voltage hold - complex
sample_legend_CC15 = {'CC7-M1 spac.x2','CC7-M2 spac.x2','CC7-M3 spac.x2'};
sample_legend_CC17 = {'CC8-M1 CMC','CC8-M2 CMC','CC8-M3 CMC'};
% EPD
sample_legend_CC16 = {'EPD-Horz-A-III','EPD-Horz-A-II CE','EPD-Grav-B-I','EPD-Grav-A-II','EPD-Grav-B-II','EPD-Grav-B-III','EPD-Grav-B-IV'};

% sample_legend = [sample_legend_CC10,sample_legend_CC9,sample_legend_CC12,sample_legend_CC11,sample_legend_CC13_A,sample_legend_CC13_B,sample_legend_CC13_C,sample_legend_CC14,sample_legend_CC15,sample_legend_CC16,sample_legend_CC17,sample_legend_CC18,sample_legend_CC22];
sample_legend = [sample_legend_CC10,sample_legend_CC10_PR2,sample_legend_CC9,sample_legend_CC12,sample_legend_CC11_A1,sample_legend_CC11_A2,sample_legend_CC11_A3,sample_legend_CC13_A,sample_legend_CC13_B,sample_legend_CC13_C,sample_legend_CC14,sample_legend_CC15,sample_legend_CC16,sample_legend_CC17,sample_legend_CC18,sample_legend_CC22];
%--------------------------------------------------------------------------
% 5. Colours
%--------------------------------------------------------------------------% Colors for comparison of different cells
sample_color = [    
    %----------------------------------------------------------------------
    % CC10 - Voltage CutOFFs - QMU (12/07/2022) 
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220121_BaseP_MoS2 
            %--------------------------------------------------------------
                    % 3.0 - 0.01 V
                    0.0, 0.0, 1.0;  %blue 1 (3.0-0.01 V)
                    0.0, 0.0, 1.0;  %blue 1 (3.0-0.01 V)
                    0.0, 0.0, 1.0;  %blue 1 (3.0-0.01 V)
                    % 3.0 - 0.4 V
                    0.5, 0.5, 0.8;  %blue/grey 1 (3.0 - 0.4/0.3 V)
                    0.5, 0.5, 0.8;  %blue/grey 1 (3.0 - 0.4/0.3 V)
                    0.5, 0.5, 0.8;  %blue/grey 1 (3.0 - 0.4/0.3 V)
                    % 3.0 - 0.6 V
                    0.5, 0.1, 0.4;  %purple/red 1 (3.0 - 0.6 V)
                    0.5, 0.1, 0.4;  %purple/red 1 (3.0 - 0.6 V)
                    0.5, 0.1, 0.4;  %purple/red 1 (3.0 - 0.6 V)
                    % 3.0 - 0.8 V
                    0.5, 0.1, 0.9;  %purple 1 (3.0 - 0.8 V)
                    0.5, 0.1, 0.9;  %purple 1 (3.0 - 0.8 V)
                    0.5, 0.1, 0.9;  %purple 1 (3.0 - 0.8 V)
                    % 3.0 - 0.8 V P2
                    0.0 ,0.6, 0.0;  % green
                    0.0 ,0.6, 0.0;  % green
                    0.0 ,0.6, 0.0;  % green
                    % 0,     0,   0;  % black (3.0 - 0.8 V) P2
                    % 0,     0,   0;  % black (3.0 - 0.8 V) P2
                    % 0,     0,   0;  % black (3.0 - 0.8 V) P2
                    % 3.0 - 1.5 V P2
                    1,     0,   0;  % red (3.0 - 1.5 V) P2
                    1,     0,   0;  % red (3.0 - 1.5 V) P2
                    1,     0,   0;  % red (3.0 - 1.5 V) P2
    %----------------------------------------------------------------------
    % CC9 - P1
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 (10wt% - 25um)
            %--------------------------------------------------------------
                   %--------------------
                   % 3.5 - 0.01 V
                   %-------------------- 
                   0.0, 0.5, 0.5  %blue 1
                   0.0, 0.5, 0.5  %blue 1
    %----------------------------------------------------------------------
    % CC9 - P3 
    %----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 (10wt% - 25um)
            %--------------------------------------------------------------
                    %--------------------
                    % 3.0 - 0.01 V
                    %--------------------
                    0.8, 0.8, 0.3  %marsh green
                    0.6, 0.8, 0.2  % green?
                    %--------------------
                    % 3.0 - 0.8 V
                    %--------------------
                    %1.0, 0.4, 1.0;  %pink  (0.01 - 1.80V)
                    0.8, 0.3, 0.8;  %purple y (3.0 - 0.8 V)                                   
                    0.5, 0.1, 0.9;  %purple 1 (3.0 - 0.8 V)
                    1,     0.3,   0.3  % red (3.0 - 0.8 V)

            %--------------------------------------------------------------
            % 201216_BaseP_MoS2 (20wt%)
            %--------------------------------------------------------------
                    % Prelim                     
                    0.4, 0.8, 0.1  % green? (3.0-0.01 V)
                    0.0, 0.0, 0.0; % black (3.0 - 0.8 V) P2
    %----------------------------------------------------------------------
    % CC12
    %----------------------------------------------------------------------      
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 (10wt% - 25um)
            %-------------------------------------------------------------- 
                    0.0, 0.0, 1.0;  %blue 1 (3.0-0.01 V)
                    0.5, 0.1, 0.9;  %purple 1 (3.0 - 0.8 V)
                    1.0, 0.4, 1.0;  %pink  (0.01 - 1.80V)
                    0.8, 0.8, 0.3;  %marsh green
                    0.0, 0.0, 0.0; % black (3.0 - 0.8 V) P2
                    

%----------------------------------------------------------------------
% CC11 - Thickness Testing 
%----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 - A1
            %--------------------------------------------------------------
                    % 3.0 - 0.01 V
                    0,     0,   0  % black 
                    0.0, 0.2, 1.0  %blue 1 (3.0-0.01 V)                    
                    0.0, 0.6, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 0.8, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 1.0, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 1.0, 0.6  %x
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 - A2
            %--------------------------------------------------------------
                    % 3.0 - 0.01 V
                    0,     0,   0  % black - 10 um
                    0.0, 0.2, 1.0  %blue - 25 um
                    0.0, 0.6, 1.0  %blue - 50 um
                    0.0, 0.8, 1.0  %blue 
                    0.0, 1.0, 1.0  %blue 
                    0.0, 1.0, 0.6  %x
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 - A3
            %--------------------------------------------------------------
                    % 3.0 - 0.01 V
                    0,     0,   0  % black 
                    0.0, 0.2, 1.0  %blue 1 (3.0-0.01 V)                   
                    0.0, 0.6, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 0.8, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 1.0, 1.0  %blue 1 (3.0-0.01 V)
                    0.0, 1.0, 0.6  %x

%----------------------------------------------------------------------
% CC13 - Thickness Testing 
%----------------------------------------------------------------------
            %--------------------------------------------------------------
            % 230311_BaseP_MoS2 B (10wt%, 25um) - A (3.0 - 0.01V)
            %--------------------------------------------------------------
                    0.5, 0.3, 1.0;  %purple x (3.0 - 0.8 V)
                    0.5, 0.3, 1.0;  %purple x (3.0 - 0.8 V)
                    0.5, 0.3, 1.0;  %purple x (3.0 - 0.8 V)
                    0.0, 0.0, 1.0;  %blue 1
                    0.0, 0.0, 1.0;  %blue 1
                    0.0, 0.0, 1.0;  %blue 1

%                       0.0, 0.2, 1.0  %blue - 25 um
%                       0.0, 0.2, 1.0  %blue - 25 um
%                       0.0, 0.2, 1.0  %blue - 25 um
%                       0.0, 0.2, 1.0  %blue - 25 um
%                       0.0, 0.2, 1.0  %blue - 25 um
%                       0.0, 0.2, 1.0  %blue - 25 um
            %--------------------------------------------------------------
            % 220815_BaseP_MoS2 (10wt% - 50um) - B (3.0 - 0.01V)
            %--------------------------------------------------------------
%                     0.5, 0.3, 0.8;  %purple y (3.0 - 0.8 V)
%                     0.5, 0.3, 0.8;  %purple y (3.0 - 0.8 V)
%                     0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)
%                     0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)
%                     0.5, 0.3, 0.8;  %purple y (3.0 - 0.8 V)
%                     0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)

                      0.0, 0.6, 1.0  %blue - 50 um
                      0.0, 0.6, 1.0  %blue - 50 um
                      0.0, 0.6, 1.0  %blue - 50 um
                      0.0, 0.6, 1.0  %blue - 50 um
                      0.0, 0.6, 1.0  %blue - 50 um
                      0.0, 0.6, 1.0  %blue - 50 um

            %--------------------------------------------------------------
            % 220722_BaseP_MoS2 (10wt% - 10um) - C (3.0 - 0.01V)
            %--------------------------------------------------------------
%                     0.5, 0.1, 0.5;  %purple 1 (3.0 - 0.8 V)
%                     0.5, 0.1, 0.5;  %purple 1 (3.0 - 0.8 V)
%                     0.5, 0.1, 0.5;  %purple 1 (3.0 - 0.8 V)
%                     0.5, 0.5, 1.0; % light blue
%                     0.5, 0.5, 1.0; % light blue
%                     0.5, 0.5, 1.0; % light blue

                      0,     0,   0  % black - 10 um
                      0,     0,   0  % black - 10 um
                      0,     0,   0  % black - 10 um
                      0,     0,   0  % black - 10 um
                      0,     0,   0  % black - 10 um
                      0,     0,   0  % black - 10 um


%--------------------------------------------------------------------------
% P3 Testing 
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC14 - P3 Testing 230311_BaseP_MoS2 B (10wt%, 25um)
    %----------------------------------------------------------------------
                    0,     0,   0  % black 
                    0,     0,   0  % black 
                    0,     0,   0  % black 

%--------------------------------------------------------------------------
% Pressure TESTING
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC15 - double spacer (1.0 mm) 230311_BaseP_MoS2 B (10wt%, 25um)
    %----------------------------------------------------------------------
                    0,     0,   0  % black 
                    0,     0,   0  % black 
                    0,     0,   0  % black 

%--------------------------------------------------------------------------
% EPD - Water Testing
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC16 - EPD 
    %----------------------------------------------------------------------
%         % 230719_EPD2_CE
%         1.0, 0.0, 0.0 %red
%         % 230719_EPD3_CE
%         1.0, 0.0, 0.0 %red
%         % 230804_EPD3_CE
%         0.5, 0.0, 0.0 %red 2
%         % 230815_EPD4_CE
%         0.5, 0.0, 0.0 %red 2
%         % 230814_EPD1_CE
%         1.0, 0.0, 0.0 %red
%         % 230814_EPD3_CE
%         0.5, 0.0, 0.0 %red 2
%         % 230815_EPD1_CE
%         0.5, 0.0, 0.0 %red 2

        % 230719_EPD2_CE
        0.2, 0.1, 0.8; %  blue
        % 230719_EPD3_CE
        0, 0.4, 1.0; % light blue - Horz. Normal Conc.
        % 230804_EPD3_CE
        0, 0.4, 0; % dark green
        % 230815_EPD4_CE
        0, 0.7, 0; % light green - Grav. Normal Conc.
        % 230814_EPD1_CE
        0, 0.4, 0; % dark green - Grav. High Conc.
        % 230814_EPD3_CE
        0, 0.4, 0; % dark green - Grav. High Conc.
        % 230815_EPD1_CE
        0, 0, 0; % black - Grav. High Conc. (10 V instead of 5 V)

%--------------------------------------------------------------------------
% CMC Water - SC
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC17 - CMC/SC
    %----------------------------------------------------------------------
%             0,     0,   0  % black 
%             0,     0,   0  % black 
%             0,     0,   0  % black 
        1.0, 0.0, 0.0;  % red - CMCP_MoS2
        1.0, 0.0, 0.0;  % red - CMCP_MoS2
        1.0, 0.0, 0.0;  % red - CMCP_MoS2

%--------------------------------------------------------------------------
% Base P - Final CC for Thesis 22/01/2024
%--------------------------------------------------------------------------
    %----------------------------------------------------------------------
    % CC18 - Formation
    %----------------------------------------------------------------------
            % 3.00 - 0.01 V
            0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)
            0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)
            0.0, 0.0, 0.5;  % dark blue (3.0 - 0.01V)

            % 3.00 - 0.8 V
            0.7, 0.1, 0.7;  %purple XX
            % 0.3, 0.3, 0.9;  %purple X - tested a colour
            0.7, 0.1, 0.7;  %purple XX
            0.7, 0.1, 0.7;  %purple XX
    %----------------------------------------------------------------------
    % CC22 - 1.80 V
    %----------------------------------------------------------------------

            % 1.80 - 0.01 V
            1.0, 0.4, 1.0;  %pink  (0.01 - 1.80V)
            1.0, 0.4, 1.0;  %pink  (0.01 - 1.80V)
            1.0, 0.4, 1.0;  %pink  (0.01 - 1.80V)

                    ];

%--------------------------------------------------------------------------
% 5. Sorting Output
%--------------------------------------------------------------------------                
       % change to reflect new colour procedure
        filepath_samples = CellDetails_filepath_trajectory(pc_choice,sample_filepath); % call to function

end