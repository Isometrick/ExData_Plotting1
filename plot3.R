## This script plots frequency against Global Active Power and saves into a png file.

data <- read.table("household_power_consumption.txt", sep = ";")
data[] <- lapply(data, as.character)
names(data) <- data[1,]
data <- data[2:2075260,]
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data[,3:9] <- lapply(data[,3:9], as.numeric)

feb <- data[ (data$DateTime>="2007-02-01" & data$DateTime<"2007-02-03"), ]

with(feb, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
points(feb$DateTime, feb$Sub_metering_1, type = "l", col = "black")
points(feb$DateTime, feb$Sub_metering_2, type = "l", col = "red")
points(feb$DateTime, feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = (7+9*16), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()