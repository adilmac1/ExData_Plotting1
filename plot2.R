library("data.table")

setwd("~/Courses/jhk_assignments/4_exploratory/assignment_1")

#download <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "tempdata")
#unzip("tempdata")
#unlink("tempdata")

#Reads in data from file 
powerData <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents Scientific Notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# PNG file with a width of 480 pixels and a height of 480 pixels
png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerData[, dateTime], y = powerData[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
