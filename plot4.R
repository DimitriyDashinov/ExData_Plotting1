# Download the file
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
              , 'exdata_data_household_power_consumption.zip'
              , mode='wb' )

unzip("exdata_data_household_power_consumption.zip")

df <- read.table("household_power_consumption.txt", sep = ";", head = T)
str(df)
head(df)

## Subset Date 2007-02-01 and 2007-02-02
df$Date <- as.Date.character(as.character(df$Date), "%d/%m/%Y")

library(dplyr)

df_subset <- filter(df, df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"))

remove(df)

head(df_subset)

## Change variable format and build plot3

df_subset$Sub_metering_1 <- as.numeric(df_subset$Sub_metering_1)
df_subset$Sub_metering_2 <- as.numeric(df_subset$Sub_metering_2)
df_subset$Sub_metering_3 <- as.numeric(df_subset$Sub_metering_3)

df_subset$Global_active_power <- as.numeric(df_subset$Global_active_power)
df_subset$Global_reactive_power <- as.numeric(df_subset$Global_reactive_power)
df_subset$Voltage <- as.numeric(df_subset$Voltage)

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(new=F)
par(mfrow=c(2,2))

###Global Active Power
plot(df_subset$Global_active_power, main ="Global Active Power", type="l", 
     ylab="Global Active Power(kilowatts)", xlab="",axes=FALSE)
axis(1, at = c(0,1500,2900),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0,2,4,6))
box(lty = 1, col = 'black')

###voltage
plot(df_subset$Voltage, main="voltage", type="l", ylab="voltage", xlab="",axes=FALSE)
axis(1, at = c(0,1500,2900),labels = c("Thu","Fri","Sat"))
axis(2,at=c(234,238,240,242),labels=c("234","238","240","242"))
box(lty = 1, col = 'black')

###plot3
plot(1:nrow(df_subset), df_subset$Sub_metering_1, main="", ylab="Energy sub metering", xlab = "", 
     type = "l", col="black", axes=FALSE)
par(new=T)
plot(df_subset$Sub_metering_2, col = "red", type = "l", axes = FALSE, ylim = c(0,40), xlab = "",ylab="")
par(new=T)
plot(df_subset$Sub_metering_3, col = "blue", type = "l", axes = FALSE, ylim = c(0,40), xlab = "",ylab= "")
axis(1, at = c(0,1500,2900),labels = c("Thu","Fri","Sat"))
axis(2, at = c(0,10,20,30),labels = c("0","10","20","30"))
legend("topright", legend = c("sub-metering1","sub-metering2","sub-metering3"), 
       col = c("black","red","blue"),lty=c(1,1,1),lwd=2)
box(lty = 1, col = 'black')

###Global_reactive_power
par(new=F)
plot(df_subset$Global_reactive_power, main ="Global Reactive Power", type="l", 
     ylab = "",xlab = "",axes = FALSE)
axis(1, at = c(0,1500,2900),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0.1,0.2,0.3,0.4),c("0.1","0.2","0.3","0.4"))
box(lty = 1, col = 'black')

dev.off()
