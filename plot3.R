##download file from source
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)


##read and clean data
dat <- read.table(unz(temp,"household_power_consumption.txt"), sep = ";")
unlink(temp)
dat[,1] <- as.Date(dat[,1], "%d/%m/%Y")
dat <- subset(dat, dat[,1] == "2007-02-01" | dat[,1] == "2007-02-02")
colnames(dat) <- c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity", "Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3")
datetimes <- paste(dat[,1], dat[,2])
dat[,10] <- datetimes
dat[,3] <- as.numeric(as.character(dat[,3]))
dat[,4] <- as.numeric(as.character(dat[,4]))
dat[,5] <- as.numeric(as.character(dat[,5]))
dat[,7] <- as.numeric(as.character(dat[,7]))
dat[,8] <- as.numeric(as.character(dat[,8]))
dat[,9] <- as.numeric(as.character(dat[,9]))
library(lubridate)
dat[,10] <- ymd_hms(dat[,10])

## Create Plot 3
png(file="plot3.png", width=480, height=480, bg="transparent")
plot(dat[,10], dat[,7], type="l", ylim=c(0,38), xlab="", ylab="Energy sub metering")
par(new=T)
plot(dat[,10], dat[,8], type="l", col="red", axes=F, ylim=c(0,38), xlab="", ylab="")
par(new=T)
plot(dat[,10], dat[,9], type="l", col="blue", axes=F, ylim=c(0,38), xlab="", ylab="")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col= c("black", "red", "blue"), lwd=1)
dev.off()
