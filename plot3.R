URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- paste("./data_household", "/", "data_household.zip", sep = "")
dir.create("data_household")
download.file(url = URL, destfile = filename)
unzip(zipfile = filename, exdir = "./data_household")


data_household <- read.table("./data_household/household_power_consumption.txt", sep = ";", header = TRUE)
data_household$Global_active_power <- as.numeric(data_household$Global_active_power)
data_household$Date <- as.Date(strptime(data_household$Date, format = "%d/%m/%Y"))
data_subset <- subset(data_household, Date <= "2010-09-18" & Date >= "2010-09-16")  


png("plot3.png", width = 480, height = 480)

par(mfrow = c(1,1))
plot(1:length(data_subset$Date), data_subset$Sub_metering_1, 
     type = "n",
     ylim = c(0,75),
     ylab = "Energy sub metering",
     xlab = "",
     xaxt = "n"
)

lines(1:length(data_subset$Date), data_subset$Sub_metering_1, col = "black")
lines(1:length(data_subset$Date), data_subset$Sub_metering_2, col = " red")
lines(1:length(data_subset$Date), data_subset$Sub_metering_3, col = "blue")

weekdats <- c(0,2160,4320)
weekdats2 <- c(1,2160,4320)
axis(1, at = weekdats, labels = weekdays(data_subset$Date[weekdats2]))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col = c("black","red","blue"), cex = 0.8, lty = 1)

dev.off()
