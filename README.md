# Calcium Imaging
# The purpose of this toolbox is to analyze calcium imaging data obtained by using Fluo4 (non-ratiometric Calcium indicator) and raw mean gray values obtained from the ImageJ software.

# Aim 1: To identify % of cells that have responded to the drug of interest and the positive control. Download CaImagingFunctionsRDocumentation.docx for detailed methodology and variable listing. 

Important considerations:
Make sure the input file is in .csv format with column headers as Time/frames, however many cells you have, column with background intensity (obtained by selecting a dark area in the field of view in ImageJ). 
Two sample input files are provided: one with ph5 response named “TestR.csv” and another with ionomycin response “ionotest.csv”.
“SampleCalculations.xlsx” shows a step-by-step breakdown of this software in an excel format for ease of understanding.


Function: Normalization_ionomycin() (This function integrates two other functions, see below)
Filename: Normalization_ionomycin.R
Description: This function takes separate drug response file and ionomycin (or any other drug you want to normalize to, for e.g. KCl) response file from a Calcium Imaging dataset as input and gives out a file with F/Fmax values for all the cells that meet threshold (mean+5 st.dev) for both ionomycin and drug. The input is directly from ImageJ mean gray values of ROIs saved as .csv filed.  For detailed explanations and variable listings see CaImagingFunctionsRDocumentations.docx.
How to use this function?
1.	Install R from https://cran.r-project.org/
2.	Open R interface  File  Change dir … : set to a folder where you will store function files and data files. You have to set this at the beginning of each session
3.	Copy and paste Normalization.R, Threshold.R and Threshold_iono.R files into the folder from step 2
4.	In the R interface: File  Source R code select a file from step 3, repeat for all the three files
5.	Type: Normalization_ionomycin() in the R console and follow along with the prompt

  
# Aim 2: To record peak response of a drug responder. 

Important consideration: Use the normalized (output) file from the above function in a .csv format. 

Filename: Peakcurrent.R

How to use this function?

1) Type: peakresponse() in your R prompt and follow instructions

This function computes the maxima of each column.

