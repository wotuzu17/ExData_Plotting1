# Coursera Course Exploratory Data Analysis Assignment 1 plot 4
# Dataset: Electric power consumption
# The zip file that contains the raw dataset must be in the current
# working directory of the R-session

# unzip the zip file
zipfile <- "exdata_data_household_power_consumption.zip"
unzip(zipfile)

# create subset of raw data in a new file filtered.txt (only 1st and 2nd of Feb 2007)
# this results into a handy 180kB file from the huge 133MB source file
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)

# read filtered file into data.frame
df<-read.csv2("filtered.txt", na.strings="?", header=TRUE, as.is=TRUE)
df$Date <- strptime(paste(df$Date, df$Time), format="%e/%m/%Y %H:%M:%S")

# set language for an english label of weekdays in the time series plot
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')

# create plot 4
png(file="plot4.png")
par(mfrow=c(2,2))

# sub-plot 1 (upper left)
plot(df$Date, as.numeric(df$Global_active_power), 
     type="l",
     ylab="Global Active Power",
     xlab="")

# sub-plot 2 (upper right)
plot(df$Date, as.numeric(df$Voltage), 
     type="l",
     ylab="Voltage",
     xlab="datetime")

# sub-plot 3 (lower left)
plot(df$Date, as.numeric(df$Sub_metering_1), 
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(df$Date, as.numeric(df$Sub_metering_2), col="red")
lines(df$Date, as.numeric(df$Sub_metering_3), col="blue")
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1,
       bty="n")

# sub-plot 4 (lower right)
plot(df$Date, as.numeric(df$Global_reactive_power), 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")
dev.off()