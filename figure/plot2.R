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

#combine date and time together
submydata$Datetime <- as.POSIXct(paste(submydata$Date, submydata$Time))

#plot the png figures
png("plot2.png", width=480, height=480)
plot(submydata$Global_active_power~submydata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

