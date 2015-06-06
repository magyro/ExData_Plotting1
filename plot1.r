## Plot 1 
## Histogram

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
#####################################################################################
#Produce Histogram
####################################################################################
## create png file 
png(file="plot1.png", width = 480, height = 480)
 
hist(workData$Global_active_power,
     col="red", main = "Global Active Power",
     xlab= "Global Active Power (kilowatts)") 


####################################################################################

dev.off() 
