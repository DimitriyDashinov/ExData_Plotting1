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

## Change variable format and build plot1

df_subset$Global_active_power <- as.numeric(df_subset$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480, units = "px")

dev.cur()

hist(df_subset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
