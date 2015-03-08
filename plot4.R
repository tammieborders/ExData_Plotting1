#---------------------------------------------------------------------
# Script:  plot4.R
#
# Description:  Creates plot4.png file
# How to run:   source("plot4.R")
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
par(mfrow=c(2,2))
#Plot 1 (top left)
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

#Plot 2 (top right)
plot(data$Voltage ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "datetime")

#Plot 3 (bottom left)
with(data, {
     plot(Datetime, Sub_metering_1, type="n", ylab = "Global Active Power (kilowatts)", xlab="")
     lines(Datetime, Sub_metering_1, col = "Black")
     lines(Datetime, Sub_metering_2, col = "Red")
     lines(Datetime, Sub_metering_3, col = "Blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot 4 (bottom right)
plot(data$Global_reactive_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "datetime")

# Save to png file
dev.copy(png, "plot4.png", width=480, height=480, units="px")
dev.off()