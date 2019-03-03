#THIS FUNCTION IS FOR IONOMYCIN ONLY - very similar to threshold()
# Returns which cells responded to ionomycin (Threshold=mean+2 * st.dev) and mean peak response of those cells
#Inputs: Ionomycin response .csv file 

Threshold_iono<-function(){

File<-readline(prompt="Enter .csv ionomycin filename (w/o etxn) ")
filename<-paste(File,".csv",sep="")
A<-read.csv(filename, header=T)
Back<-A[,ncol(A)] #vector of mean background intensities

#Subtracting Background intensity and putting into a matrix called nob (no background)
nob<-A[,1:(ncol(A)-1)]
for(i in 2:(ncol(A)-1)){
   nob[,i]<-A[,i]-Back
   }
#Finding mean at baseline level (pH 7.4)
r1<-as.numeric(readline("enter starting frame(row) # for baseline mean "))
r2<-as.numeric(readline("enter ending frame(row) # for baseline mean "))
M<-nob[r1:r2,]
meanM<-colMeans(M)
meanArrayM<-array(meanM)#vector 'meanM' is dimensionless in R, hence array of means 'meanArrayM' created

#Subtracting baseline mean from all the values and putting into a matrix called 'nor'(normalized)
nor<-nob
for(i in 2:ncol(nob)){
  for(j in 1:nrow(nob)){
   nor[j,i]<-nob[j,i]-meanArrayM[i]
    }
  }

#Finding Drug Responders
#Finding mean at baseline level in nor
drug<-nor[r1:r2,]
meanDrug<-array(colMeans(drug))
sigmaDrug<-sqrt(diag(var(drug)))#formula for calculating standard dev of sample
threshold<-array(meanDrug+5*sigmaDrug)


#Finding mean at peak level in nor
r3<-as.numeric(readline("enter starting frame(row) # for peak mean "))
r4<-as.numeric(readline("enter ending frame(row) # for peak mean "))
peak<-nor[r3:r4,]
meanPeak<-array(colMeans(peak))

#Comparing peak and threshold to extract cells that respond
count<-0
percent<-0
A.new=matrix(nrow=nrow(nor), ncol=ncol(nor))
A.new[,1]=nor[,1]

#Matrix 'A.iono' is created to preserve the actual peak from nob matrix (only background is subtracted, baseline is not)
A.iono=matrix(nrow=nrow(nor), ncol=ncol(nor))
A.iono[,1]=nor[,1]

for(i in 2:ncol(nor)){
  if(isTRUE(meanPeak[i]>threshold[i])){
   A.new[,i]=nor[,i]
   A.iono[,i]=nob[,i]
   count=count+1
   }
  }
percent<-(count/(ncol(nor)-1))*100
print(paste("% ionomycin responder=",percent))
response<-readline(prompt="Want to save .csv ONLY ionomycin analysed file?(y/n)")

if(isTRUE(response=="y")){
outputfile<-readline(prompt="Enter .csv ionomycin output file name ")
write.csv(A.new,file=paste(outputfile,".csv",sep=""))
}

#Actual mean peak extracted from the responders
actualPeak<-A.iono[r3:r4,]
Mean_peak<-array(colMeans(actualPeak))
assign("Mean_peak",Mean_peak,.GlobalEnv)#declaring it global so that other functions can use it
return()
}
