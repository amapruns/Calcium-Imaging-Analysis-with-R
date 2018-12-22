
#This function normalizes all Ca imaging responses to ionomycin response (F/Fmax)
#Returns a matrix with F/Fmax values and %of cells that responded to both Iono and drug

#Variables
  #Numeric
    #i,j,percent, flag
  #Matrices
    #Analyzed,A_new ( from Threshold()), new.analyzed
  #Array
    #orig.cols, new.cols

Normalization_ionomycin<-function(){

Threshold()#returning a Global list with objects A_new, orig.cols: upto baseline subtraction analysis done
Threshold_iono()#returning Mean_peak: an array of actual ionomycin peak response
Analyzed<-matandcolnames$A_new
orig.cols<-matandcolnames$orig.cols

for(j in 2:ncol(Analyzed)){
  for(i in 1:nrow(Analyzed)){
   Analyzed[i,j]<-matandcolnames$A_new[i,j]/Mean_peak[j]
    }
  }

#To get rid of all the columns with NA (for nonresponder cells)
new.cols<-array(dim=c(dim(orig.cols)))
new.cols[1]<-orig.cols[1]
for(j in 2:ncol(Analyzed)){
flag<-0
  for(i in 1:nrow(Analyzed)){
   if(identical(is.na(Analyzed[i,j]),FALSE)){
   flag<-1
   break}
  }
if(isTRUE(flag==1)){
   new.cols[j]<-orig.cols[j]}
}


new.analyzed<-rbind(new.cols,Analyzed)#To preserve the actual column names(cells)
new.analyzed<-new.analyzed[,!apply(is.na(new.analyzed),2,all)] #deleting all columns with NA
percent=((ncol(new.analyzed)-1)/(ncol(Analyzed)-1))*100
print(paste("% cells that responded to the drug =",percent))
outputfile<-readline(prompt="Enter .csv output file name ")
write.csv(new.analyzed,file=paste(outputfile,".csv",sep=""))
return()
}