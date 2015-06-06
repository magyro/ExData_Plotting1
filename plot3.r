## Plot 3 
##  combined lines

rm(list=ls())

#####################################################################################
## if run in different environment it should be set in next sentence
####################################################################################

setwd("~/Coursera R/Exploratory/W1")
options(stringsAsFactors = FALSE)

library(data.table)
library(datasets)

#####################################################################################
## read the data into workData table
# WD is a file created by subsetting the input file to the reqiured data 
# 1. If first time, read the input file, create a new file (WD) with the 
# required data and use it for workData table
# 2. If WD file exists (not first time), read it into workData table 
#------------------------------------------------------------------------------------

if (file.exists("WD.txt")) {
    workData<-read.table ("WD.txt" ,head=TRUE )
}else {
    hpcData <- 
        read.table ("household_power_consumption.txt",na.strings ="?" ,sep=";",head=TRUE )
    
    workData <- 
        subset(hpcData, strptime(hpcData$Date, "%d/%m/%Y", tz="")==
                   strptime("2007/02/01", "%Y/%m/%d", tz="") | 
                   strptime(hpcData$Date, "%d/%m/%Y", tz="")==
                   strptime("2007/02/02", "%Y/%m/%d", tz=""))
    
    write.table(workData,"WD.txt",row.names=FALSE)
}  

####################################################################################
# add a POSIXct column, to the workData table 
###################################################################################

workData[, "PctDT"] <- 
    as.POSIXct(strptime(paste(workData[, "Date"], 
                        workData[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S", tz="")) 

##################################################################################
# create 3 lines and legend
##################################################################################
## produce png file 
png(file="plot3.png", width = 480, height = 480)

Sys.setlocale("LC_TIME", "English")
par(cex=1,mfrow=c(1,1)) 

plot(workData$PctDT , workData$Sub_metering_1, type="l", col="black", 
             ylab="Energy Sub Metering", xlab="") 
with(workData, lines(workData$PctDT , workData$Sub_metering_2, col="red"))  
with(workData, lines(workData$PctDT , workData$Sub_metering_3, col="blue")) 
legend("topright", legend=c(names(workData)[7:9]), 
       col=c("black", "red", "blue"), lty=c(1,1)) 
################################################################################## 

dev.off() 
