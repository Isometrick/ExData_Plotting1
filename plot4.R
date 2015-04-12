## This script plots frequency against Global Active Power and saves into a png file.

data <- read.table("household_power_consumption.txt", sep = ";")
data[] <- lapply(data, as.character)
names(data) <- data[1,]
data <- data[2:2075260,]
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data[,3:9] <- lapply(data[,3:9], as.numeric)

feb <- data[ (data$DateTime>="2007-02-01" & data$DateTime<"2007-02-03"), ]

par(mfrow = c(2,2), mar = c(6,3,2,2), cex = .7)

with(feb, plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", main = "", type = "l"))

with(feb, plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", main = "", type = "l"))

with(feb, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
points(feb$DateTime, feb$Sub_metering_1, type = "l", col = "black")
points(feb$DateTime, feb$Sub_metering_2, type = "l", col = "red")
points(feb$DateTime, feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = (7+9*16), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(feb, plot(DateTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", main = "", type = "l"))

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()