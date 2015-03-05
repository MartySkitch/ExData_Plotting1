# Project 1 
# Estimate of memory required
# memory required = no. of column * no. of rows * 8 bytes/numeric
memory_require <- 9 * 2075259 * 8

setwd("D:/Skitch/Code/R/DataScienceSpecialization/ExData_Plotting1/ExData_Plotting1")

plot1 <- function(){
  
  library(dplyr)
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipFile <- "./household_power_consumption.zip"
  if (!file.exists(zipFile)) {
    download.file(fileUrl, destfile = zipFile, mode="wb")  # download in binary mode
  }
  householdPowerFile <- "./household_power_consumption.txt"
  if (!file.exists(householdPowerFile)) {
    unzip(zipfile = zipFile)
  }
  
  # read the large data files 
  first.5.rows <- read.table(householdPowerFile, header=TRUE, nrows = 5, sep=";", stringsAsFactors = FALSE, na.strings = "?")
  classes <- sapply(first.5.rows, class)
  householdPower <- filter(read.table(householdPowerFile, header=TRUE,  sep=";", colClasses = classes, 
                               na.strings = "?"), Date=="1/2/2007" | Date=="2/2/2007")
  
  # for the screen
  PlotPowerData(householdPower)
  
  # for the file
  png(filename = "./plot1.png")
  PlotPowerData(householdPower)
  
  dev.off()

}

# function to plot data
PlotPowerData <- function (householdPower) {
  par(mfrow = c(1,1))
  hist(householdPower$Global_active_power, 
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       ylab = "Frequency",
       col = "Red")
}