#---------------------------------------------------------------------
# Script:  plot1.R
#
# Description:  Creates plot1.png file
# How to run:   source("plot1.R")
#---------------------------------------------------------------------
# Reads file
filename <- file("../household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value = TRUE), sep = ";", header = TRUE)
close(filename)

# Rename columns in dataframe
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Plots png file (Defaults are 480 x 480 pixels so it is unnecessary to specifiy)
hist(data$Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()