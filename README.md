# Calcium Imaging code
The purpose of this toolbox is to analyze calcium imaging data obtained by using Fluo4 (non-ratiometric Calcium indicator) and raw mean gray values obtained from the ImageJ software.

## Installation instructions
-	Download and install R following [these instructions](https://cran.r-project.org/)
- Clone/download this repository on to your local machine. Extract all contents from the zip file, if necessary.
-	Open R interface.
- Select `File > Change dir`: set #Working Directory# to the folder 'Calcium-Imaging-Analysis-with-R' that your downloaded and extracted. This directory should contain all your function and data files that you will work with. You have to set this at the beginning of each session.
- In the R interface, select `File > Source R code` : select each R file. Repeat the process until all source files you need to execute are selected.


### Aim 1: To identify % of cells that have responded to the drug of interest and the positive control. 

Description: This function takes separate drug response file and ionomycin (or any other drug you want to normalize to, for e.g. KCl) response file from a Calcium Imaging dataset as input and gives out a file with F/Fmax values for all the cells that meet threshold (mean+5 st.dev) for both ionomycin and drug. The input is directly from ImageJ mean gray values of ROIs saved as .csv filed.
Download CaImagingFunctionsRDocumentation.docx for detailed methodology and variable listing. 

Important considerations:
* Make sure the input file is in .csv format with column headers as Time/frame#, cell number (1, 2, 3, ... n), column with background intensity (obtained by selecting a dark area in the field of view in ImageJ). 
* Two sample input files are provided: one with ph5 response named “TestR.csv” and another with ionomycin response called “ionotest.csv”.
* “SampleCalculations.xlsx” shows a step-by-step breakdown of the calculations performed by this software in an excel format for ease of understanding.

Filename: Normalization_ionomycin.R

To run this program:
Type `Normalization_ionomycin()` in the R console and follow along with the prompt

  
### Aim 2: To record peak response of a drug responder. 

This function computes the maxima of each column.

Important consideration: Use the normalized (output) file from the above function in a .csv format. 

Filename: Peakcurrent.R

To run this program:
Type `peakresponse()` in your R prompt and follow subsequent instructions
