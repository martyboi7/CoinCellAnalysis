# CoinCellAnalysis
BioLogic Cell Cycler Data Output Analysis

For those that want a simple code to analyse their experimental data (MUST be exported as .mpt file) recorded by a BioLogic coin cell cycler for half cells (Li or similar counter).
There are only a few things to change for your sample.

1. Active mass of your sample (mass_active). There need to be as many active masses as there are filepaths set for the maltab file. 
    e.g: mass_active = [0.05, 0.09, 0.1];
2. The number of cycles or the selection of cycles you want to view. 
    a. A single number e.g: cycles = [2]; will simply print the first 2 cycles (discharge/charge)
    b. Specific cycles e.g: cycles = [1,2,5,6]; will print those specific cycles 
    c. A sequence of cycles e.g: cycles = [1:5]; will print cycles 1 through 5
3. Title - your choice
4. Plot mode. Incredibly important setting:
    1 - Comparison of multiple formation charges. Select which specific cycle you want to compare. Can only compare for a single fixed cycle. Can input several filepaths.
    2 - Discharge cycles of a single cell. Select how many cycles to be printed.
    3 - Charge cycles of a single cell. Select how many cycles to be printed.
    4 - Discharge cycles of a single cell. Automatically prints all the cycles.
    5 - Charge cycles of a single cell. Automatically prints all the cycles.
    6 - Selection of discharge/charge plotted on the same figure for a single cell. See point 2 above to decide how to select your cycles. 
5. Legend - your choice. If you do not have enought legend entries for the number of filepaths it will still run just might give an orange error message saying you did not input enough legend entries. 
6. Filepaths. Make sure you select the correct filepaths for your samples in the correct order which matched the active masses. Use the " " notation for the filepaths. Start every new filepath on a new line. 

That's literally it. Hit run (F5) and see what happens. 
Please cite if used. 

Note: Make sure that your folders are structured as follows.

BioLogic_Analysis (parent folder):
  1. Samples (subfolder)
  2. Templates (subfolder)
  3. Functions (subfolder)
  
  
Otherwise, make sure to adjust the addpath filepath on line 17.
