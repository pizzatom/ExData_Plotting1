# Plot2

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
household_power_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")household_power_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
head(household_power_consumption)

# subset data
library(lubridate)                    #lubridate is really handy for handling date time objects
household_power_consumption$Date_Time <- dmy_hms(paste(household_power_consumption$Date,household_power_consumption$Time))
household_power_consumption$Date <- dmy(household_power_consumption$Date)
dt <- subset(household_power_consumption, Date >= '2007-02-01' & Date <= '2007-02-02')


# global active power time series 
par(mfrow=c(1,1))
plot(dt$Date_Time,global_active_power,"l",main = "",xlab = "",ylab = "Global Active Power (kilowatts)")
dev.copy(png,'Plot2.png')
dev.off()
