

datahpc <- file("household_power_consumption.txt")

##examine data for only the limited period
hpcex <- read.table(text = grep("^[1,2]/2/2007", readLines(datahpc), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)



## Getting full dataset
hpc <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      na.strings = "?", nrows = 2075259, check.names = F, 
                      stringsAsFactors = F, comment.char = "", quote = '\"')
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

## Subsetting the data
data <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(hpc)

## Setting dates formate
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Generate Plot 3
with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 3, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
