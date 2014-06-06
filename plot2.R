# Coursera Course Exploratory Data Analysis Assignment 1 plot 2
# Dataset: Electric power consumption
# The zip file that contains the raw dataset must be in the current
# working directory of the R-session

# unzip the zip file
zipfile <- "exdata_data_household_power_consumption.zip"
unzip(zipfile)

# create subset of raw data in a new file filtered.txt (only 1st and 2nd of Feb 2007)
# this results into a handy 180kB file from the 133MB source file
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)

# read filtered file into data.frame
df<-read.csv2("filtered.txt", na.strings="?", header=TRUE, as.is=TRUE)
df$Date <- strptime(paste(df$Date, df$Time), format="%e/%m/%Y %H:%M:%S")

# set language for an english label of weekdays in the time series plot
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')

# create plot 2
png(file="plot2.png")
plot(df$Date, as.numeric(df$Global_active_power), 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")
dev.off()