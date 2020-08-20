URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- paste("./data_household", "/", "data_household.zip", sep = "")
dir.create("data_household")
download.file(url = URL, destfile = filename)
unzip(zipfile = filename, exdir = "./data_household")


data_household <- read.table("./data_household/household_power_consumption.txt", sep = ";", header = TRUE)
data_household$Global_active_power <- as.numeric(data_household$Global_active_power)
data_household$Date <- as.Date(strptime(data_household$Date, format = "%d/%m/%Y"))
data_subset <- subset(data_household, Date <= "2010-09-18" & Date >= "2010-09-16")  

png("plot1.png", width = 480, height = 480)

par(mfrow = c(1,1))
hist(data_subset$Global_active_power, 
     col = "red", 
     xlim = c(0,8),
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     xaxt = "n",
)
axis(1, at = 0:6)

dev.off()
