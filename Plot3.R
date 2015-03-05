# Project 1 
# Estimate of memory required
# memory required = no. of column * no. of rows * 8 bytes/numeric
memory_require <- (9 * 2075259 * 8) / 2 ^ 20
print(  paste("Memory required: ", memory_require, " MB"))

setwd("D:/Skitch/Code/R/DataScienceSpecialization/ExData_Plotting1/ExData_Plotting1")

plot3 <- function(){
  
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
  # now convert Data and Time to as.Date
  householdPower$DateTime <- strptime(paste(householdPower$Date, householdPower$Time), "%d/%m/%Y %H:%M:%S") 

  # for the screen
  PlotPowerData(householdPower)
  
  # for the file
  png(filename = "./plot3.png")
  PlotPowerData(householdPower)

  dev.off()

}

# function to plot data
PlotPowerData <- function (householdPower) {
  par(mfrow = c(1,1))
  
  with(householdPower, plot(DateTime, Sub_metering_1, type = "n",
                            xlab = "",
                            ylab = "Energy sub metering") )
  with(householdPower, points(DateTime, Sub_metering_1, type = "l") )
  with(householdPower, points(DateTime, Sub_metering_2, type = "l", col = "red") )
  with(householdPower, points(DateTime, Sub_metering_3, type = "l", col = "blue") )
  legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "o",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
