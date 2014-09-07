url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zipfile <- 'household_power_consumption.zip'
txtfile <- 'household_power_consumption.txt'
dates <- as.Date(c('2007-2-1', '2007-2-2'))

if (!file.exists(zipfile)) download.file(url, zipfile, method = 'curl')
if (!file.exists(txtfile)) unzip(zipfile)

hpc <- read.csv(txtfile, sep = ';', quote = '', na.strings = '?', as.is = TRUE)
hpc <- subset(hpc, as.Date(Date, '%d/%m/%Y') %in% dates)
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

png(filename = 'plot2.png')
plot(hpc$datetime, hpc$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.off()
