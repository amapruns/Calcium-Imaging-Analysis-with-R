#This function computes Ca Imaging response of a drug application by subtracting the peak response from baseline
#a .csv file (obtained from ImageJ), frame numbers that denote baseline and frame numbers that denote peak response are taken as input from the user
#Only cells that meet the threshold of (baseline mean+2St.dev)and their column names are returned 

#Variables - see documentation for details
  #numeric variables
     #i,j,r1,r2,r3,r4,count, percent
  #matrices
     #A,nob,nor,M, A_new, M1, Mp
  #vectors
     #Back,Mm,St1
  #arrays
     #Mma,orig.cols, Mm1, threshold, Mmp
  #Strings
     #File, filename, outputfile
  #List
     #matandcolnames

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
Mm<-colMeans(M)
Mma<-array(Mm)#vector Mm is dimensionless in R, hence array of means created

#Subtracting baseline mean from all the values and putting into a matrix called nor(normalized)
nor<-nob
for(i in 2:ncol(nob)){
  for(j in 1:nrow(nob)){
   nor[j,i]<-nob[j,i]-Mma[i]
    }
  }
#outputfile<-readline(prompt="Enter .csv output file name ")
#write.csv(nor,file=paste(outputfile,".csv",sep=""))

#Finding Drug Responders
  #Finding mean at baseline level in nor
M1<-nor[r1:r2,]
Mm1<-array(colMeans(M1))
St1<-sqrt(diag(var(M1)))#formula for calculating standard dev of sample
threshold<-array(Mm1+5*St1)

   #Finding mean at peak level in nor
r3<-as.numeric(readline("enter starting frame(row) # for peak mean "))
r4<-as.numeric(readline("enter ending frame(row) # for peak mean "))
Mp<-nor[r3:r4,]
Mmp<-array(colMeans(Mp))

   #Comparing peak and threshold to extract cells that respond
count<-0
percent<-0
A_new=matrix(
  nrow=nrow(nor),
  ncol=ncol(nor))
A_new[,1]=nor[,1]
for(i in 2:ncol(nor)){
  if(isTRUE(Mmp[i]>threshold[i])){
   A_new[,i]=nor[,i]
   count=count+1
   }
  }

percent<-(count/(ncol(nor)-1))*100
print(paste("% ONLY drug responder=",percent))
response<-readline(prompt="Want to save .csv analysed file w/o ionomycin normalization?(y/n)")

if(isTRUE(response=="y")){

outputfile<-readline(prompt="Enter .csv output file name ")
write.csv(A_new,file=paste(outputfile,".csv",sep=""))
}
matandcolnames<-list("A_new"=A_new, "orig.cols"=orig.cols)
assign("matandcolnames",matandcolnames,.GlobalEnv)#declaring it global so that other functions can use it
return(matandcolnames)
}
