# Plot4

# download data (if it doesn't exist)
f.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f.dest<-"household_power_consumption.zip"

if (!file.exists(f.dest)){
  download.file(f.url,f.dest,method = "curl")  
}


# read data
if (!file.exists("household_power_consumption.txt")){
  unzip(f.dest)  
}
household_power_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
head(household_power_consumption)

# subset data
library(lubridate)                    #lubridate is really handy for handling date time objects
household_power_consumption$Date_Time <- dmy_hms(paste(household_power_consumption$Date,household_power_consumption$Time))
household_power_consumption$Date <- dmy(household_power_consumption$Date)
dt <- subset(household_power_consumption, Date >= '2007-02-01' & Date <= '2007-02-02')

# 2 x 2 summary plot  
attach(mtcars)
par(mfrow=c(2,2))
# 1,1 global active power
plot(dt$Date_Time,dt$Global_active_power,"l", main = "",xlab = "",ylab = "Global Active Power")

# 1,2 voltage
plot(dt$Date_Time,dt$Voltage, "l", main = "", xlab = "datetime", ylab = "Voltage")

# 2,1 submetering
plot(dt$Date_Time, dt$Sub_metering_1, "l", main = "", xlab = "", ylab = "Energy submetering")
lines(dt$Date_Time, dt$Sub_metering_2, col = "red")
lines(dt$Date_Time, dt$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub metering 1","Sub metering 2","Sub metering 3"), lty=c(1,1,1), col=c("black","red","blue"))

# 2,2 global reactive power
plot(dt$Date_Time, dt$Global_reactive_power, "l", main = "", xlab = "datetime")

dev.copy(png,'Plot4.png')
dev.off()