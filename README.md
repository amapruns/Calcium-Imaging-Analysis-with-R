# Calcium Imaging code
The purpose of this toolbox is to analyze calcium imaging data obtained by using Fluo4 (non-ratiometric Calcium indicator) and raw mean gray values obtained from the ImageJ software.

## Installation instructions
-	Download and install R. Instructions can be found [here](https://cran.r-project.org/).
- Clone/download this repository on to your local machine. Extract all contents from the zip file, if necessary.
-	Open R interface.
- Select `File > Change dir`: set **Working Directory** to the folder 'Calcium-Imaging-Analysis-with-R' that you downloaded and extracted. All the source R files and input csv files should be at the root of this directory. The output files will also be written there. You have to set this at the beginning of each session.
- In the R interface, select `File > Source R code` : select each R file. Repeat the process until all source files you need to execute are selected.


### Part 1: Identify % of cells that have responded to the drug of interest and positive control

Description: This function takes a separate drug response file and ionomycin (or any other drug you want to normalize to, for e.g. KCl) response file from a Calcium Imaging dataset as input and generates a csv file with normalized instensity (`F/Fmax`) values for all the cells that meet threshold (mean + 5 X st.dev) for both ionomycin and the drug in question. The input is directly from ImageJ mean gray values of ROIs saved as .csv files.
Read `CaImagingFunctionsRDocumentation.docx` for detailed methodology and variable listing. 

Filename: Normalization_ionomycin.R

Important considerations:
- Make sure the input file is in .csv format.
- Column headers are \[Time/frame#, cell number (1, 2, 3, ... n), column with background intensity (obtained by selecting a dark area in the field of view in ImageJ] from left to right. 
- Each row of the csv file should contain intensity value for a single time instant/frame.
- Two sample input files are provided: one with ph5 response named `TestR.csv` and another with ionomycin response called `ionotest.csv`.
- `SampleCalculations.xlsx` shows a step-by-step breakdown of the calculations performed by this software in an excel format for ease of understanding.

To run this program:
Type `Normalization_ionomycin()` in the R console and follow along with the prompt

  
### Part 2: Record peak response of a drug responder 

Description: This function computes the maxima of each column from the data produced in **Part 1**.

Filename: Peakcurrent.R

Important consideration: Use the normalized (output) file from the above function in a .csv format. 

To run this program:
Type `peakresponse()` in your R prompt and follow subsequent instructions
