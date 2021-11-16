# CoinCellAnalysis
BioLogic Cell Cycler Data Output Analysis

For those that want a simple code to analyse their experimental data (MUST be exported as .mpt file) recorded by a BioLogic coin cell cycler for half cells (Li or similar counter).
There are only a few things to change for your sample (PARAMETERS).

1. Plot mode. Incredibly important setting - decides what type of plot to create:
    % Single Cell (Polarization and Degradation)

    % 1 - Discharge cycles of a single cell. Select how many cycles.
    % 2 - Charge cycles of a single cell. Select how many cycles.
    % 3 - Discharge cycles of a single cell. All the cycles.
    % 4 - Charge cycles of a single cell. All the cycles.
    % 5 - Mixed Discharge and Charge of a single cell. Select how many cycles.

    % Multi Cell - Polarization
    % 6 - Comparison of multiple cells - single discharge.
    % 7 - Comparison of multiple cells - single charge.

    % Multi-Cell - Degradation
    % 8. Degradation Comparison Discharge (LSV)
    % 9. Degaradation Comparison Discharge (LSV) - Tiled plot with current
    % densities 
    % 10. Degradation Comparison Charge
    % 11. Degradation Comparison Discharge/Charge

    % Single Cell - Rate Data (CURRENTLY NOT FUNCTIONAL)
    % 12. Tian2019 Regression
    % 13. dQ/dV
    
2. Active mass of your sample (mass_active). There need to be as many active masses as there are filepaths set for the maltab file. 
    e.g: mass_active = [0.05, 0.09, 0.1];
3. Selection (my_selection) - pick which out of all the filepaths imported to analyse 
4. The number of cycles or the selection of cycles you want to view (cycles). 
    a. A single number e.g: cycles = [2]; will simply print the first 2 cycles (discharge/charge)
    b. Specific cycles e.g: cycles = [1,2,5,6]; will print those specific cycles 
    c. A sequence of cycles e.g: cycles = [1:5]; will print cycles 1 through 5
5. Filepaths - of your cells that you want to analyse (filepath_sample). Use the "" notation to input this. The file must be in the .mpt format.

Figure Extras 
1. Title - your choice
2. Legend - your choice. If you do not have enought legend entries for the number of filepaths it will still run just might give an orange error message saying you did not input enough legend entries. 

That's literally it. Hit run (F5) and see what happens. 
Please cite if used. 

Note: Make sure that your folders are structured as follows.

BioLogic_Analysis (parent folder):
  1. Samples (subfolder)
  2. Templates (subfolder)
  3. Functions (subfolder)
  
  
Otherwise, make sure to adjust the addpath filepath on line 62.

Template_20211116_Automatic_Github.m
Is the final version to use!
