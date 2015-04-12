## This script plots frequency against Global Active Power and saves into a png file.

data <- read.table("household_power_consumption.txt", sep = ";")
data[] <- lapply(data, as.character)
names(data) <- data[1,]
data <- data[2:2075260,]
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data[,3:9] <- lapply(data[,3:9], as.numeric)

feb <- data[ (data$DateTime>="2007-02-01" & data$DateTime<"2007-02-03"), ]

with(feb, plot(DateTime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", main = "", type = "l"))

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()