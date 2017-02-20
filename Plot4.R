# Read in dataset
dataType <- c(Voltage="numeric", Global_active_power="numeric", Global_intensity="numeric",
              Sub_metering_1="numeric", Sub_metering_2="numeric", Sub_metering_3="numeric",
              Global_active_power="numeric", Global_reactive_power="numeric")
pngdata <- read.table("household_power_consumption.txt", sep=";", header=TRUE, 
                      dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=dataType)

# Check that data were read correctly
head(pngdata)

# Subset data to include desired days
png2 <- pngdata[pngdata$Date %in% c("1/2/2007","2/2/2007") ,]

#Check that subsetting worked
head(png2)
str(png2)

# Convert Date and Time to single DateTime variable
png3 <- transform(png2, DateTime=as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# Check for new DateTime variable
head(png3)

# set up graphing space to 2 rows, 2 columns
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# Plot graph #1 in top left
plot(png3$DateTime,png3$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

# Plog graph #2 in top right
plot(png3$DateTime,png3$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

# Plot graph #3 in bottom left
plot(png3$DateTime,png3$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(png3$DateTime, png3$Sub_metering_2, col = "red")
lines(png3$DateTime, png3$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2",
                                                      "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))

# Plot graph #4 in bottom right
plot(png3$DateTime,png3$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()


