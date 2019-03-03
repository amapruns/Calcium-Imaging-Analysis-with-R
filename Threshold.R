#This function computes Ca Imaging response of a drug application by subtracting the peak response from baseline
#Inputs: .csv file (obtained from ImageJ), frame numbers for baseline, frame numbers for denote peak response
#Only cells that meet the threshold of (baseline mean+2St.dev)and their column names are returned 

Threshold<-function(){

File<-readline(prompt="Enter .csv filename (w/o etxn) where each column is a cell (last column is Background) and each row is a frame ")
filename<-paste(File,".csv",sep="")
A<-read.csv(filename, check.names=FALSE)
orig.cols<-array(colnames(A))
orig.cols<-orig.cols[1:ncol(A)-1]
Back<-A[,ncol(A)] #vector of background

#Subtracting Background intensity and putting into a matrix called nob (no background)
nob<-A[,1:ncol(A)-1]
for(i in 2:(ncol(A)-1)){
   nob[,i]<-A[,i]-Back
   }
#Finding mean at baseline level (pH 7.4)
r1<-as.numeric(readline("enter starting frame(row) # for baseline mean "))
r2<-as.numeric(readline("enter ending frame(row) # for baseline mean "))
M<-nob[r1:r2,]
meanM<-colMeans(M)
meanArrayM<-array(meanM)#vector 'meanM' is dimensionless in R, hence array of means 'meanArrayM' created

#Subtracting baseline mean from all the values and putting into a matrix called 'norm'
norm<-nob
for(i in 2:ncol(nob)){
  for(j in 1:nrow(nob)){
   norm[j,i]<-nob[j,i]-meanArrayM[i]
    }
  }
#outputfile<-readline(prompt="Enter .csv output file name ")
#write.csv(norm,file=paste(outputfile,".csv",sep=""))

#Finding Drug Responders
#Finding mean at baseline level in 'norm'
drug<-norm[r1:r2,]
meanDrug<-array(colMeans(drug))
sigmaDrug<-sqrt(diag(var(drug)))#formula for calculating standard dev of sample
threshold<-array(meanDrug+5*sigmaDrug)

#Finding mean at peak level in 'norm'
r_beg<-as.numeric(readline("enter starting frame(row) # for peak mean "))
r_end<-as.numeric(readline("enter ending frame(row) # for peak mean "))
peak<-norm[r_beg:r_end,]
meanPeak<-array(colMeans(peak))

#Comparing peak and threshold to extract cells that respond
count<-0
percent<-0
A_new=matrix(nrow=nrow(norm), ncol=ncol(norm))
A_new[,1]=norm[,1]
for(i in 2:ncol(norm)){
  if(isTRUE(meanPeak[i]>threshold[i])){
   A_new[,i]=norm[,i]
   count=count+1
   }
  }

percent<-(count/(ncol(norm)-1))*100
print(paste("% ONLY drug responder=",percent))
response<-readline(prompt="Want to save .csv analysed file w/o ionomycin normalization?(y/n)")

if(isTRUE(response=="y")){

outputfile<-readline(prompt="Enter .csv output file name ")
write.csv(A_new,file=paste(outputfile,".csv",sep=""))
}
matandcolnames<-list("A_new"=A_new, "orig.cols"=orig.cols)
assign("matandcolnames",matandcolnames,.GlobalEnv)#declaring it global so that other functions can use it
return()
}
