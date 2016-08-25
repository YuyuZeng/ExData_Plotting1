#read data file
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?")

#convert date into computable date format so that we can subset data between two dates
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#subset data between two dates
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
submydata <- subset(mydata, Date >= date1 & Date <= date2)

#convert into numeric data
submydata$Global_active_power <- as.numeric(submydata$Global_active_power)
submydata$Sub_metering_1 <- as.numeric(submydata$Sub_metering_1)
submydata$Sub_metering_2 <- as.numeric(submydata$Sub_metering_2)
submydata$Sub_metering_3 <- as.numeric(submydata$Sub_metering_3)
submydata$Voltage <- as.numeric(submydata$Voltage)
submydata$Global_reactive_power <- as.numeric(submydata$Global_reactive_power)

#combine date and time together
submydata$Datetime <- as.POSIXct(paste(submydata$Date, submydata$Time))

#plot figures
png("plot4.png", width=480, height=480)

par(mfcol = c(2,2))
par(mar=c(5,5,2,2))

plot(submydata$Global_active_power~submydata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

plot(submydata$Sub_metering_1~submydata$Datetime, type="l",
     ylab="Energy sub metering", xlab="", col = "black" )
lines(submydata$Datetime, submydata$Sub_metering_2, col = "red")
lines(submydata$Datetime, submydata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"), bty = "n")

plot(submydata$Voltage~submydata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="datetime")

plot(submydata$Global_reactive_power~submydata$Datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()


