#---------------------------------------------------------------------
# Script:  plot2.R
#
# Description:  Creates plot2.png file
# How to run:   source("plot2.R")
#---------------------------------------------------------------------
# Reads file
filename <- file("../household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value = TRUE), sep = ";", header = TRUE)
close(filename)

# Rename columns in dataframe
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Convert dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

# Plots png file (Defaults are 480 x 480 pixels so it is unnecessary to specifiy)
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, "plot2.png", width=480, height=480, units="px")
dev.off()