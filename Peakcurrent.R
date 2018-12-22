
#This function finds the peak Ca imaging response (F/Fmax)



peakresponse<-function(){

File<-readline(prompt="Enter .csv filename (w/o etxn)")
filename<-paste(File,".csv",sep="")
data<-read.csv(filename, check.names=FALSE)
colMax <- function (colData) {
    apply(colData, MARGIN=c(2), max)
}
peak<-colMax(data)


outputfile<-readline(prompt="Enter .csv output file name ")
write.csv(peak,file=paste(outputfile,".csv",sep=""))
return()
}