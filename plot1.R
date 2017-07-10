library("data.table")

setwd("~/Courses/jhk_assignments/4_exploratory/assignment_1")

#download <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "tempdata")
#unzip("tempdata")
#unlink("tempdata")

#Reads in data from file 
powerData <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents scientific notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerData <- powerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Generate a PNG file with a width of 480 pixels and a height of 480 pixels
png("plot1.png", width=480, height=480)

## Plot 1
hist(powerData[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()