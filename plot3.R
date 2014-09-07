url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zipfile <- 'household_power_consumption.zip'
txtfile <- 'household_power_consumption.txt'
dates <- as.Date(c('2007-2-1', '2007-2-2'))

if (!file.exists(zipfile)) download.file(url, zipfile, method = 'curl')
if (!file.exists(txtfile)) unzip(zipfile)

hpc <- read.csv(txtfile, sep = ';', quote = '', na.strings = '?', as.is = TRUE)
hpc <- subset(hpc, as.Date(Date, '%d/%m/%Y') %in% dates)
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

png(filename = 'plot3.png')

with(hpc, {
    plot(datetime, Sub_metering_1, type = 'n', ylab = 'Energy sub metering', xlab = '')
    lines(datetime, Sub_metering_1, col = 'black')
    lines(datetime, Sub_metering_2, col = 'red')
    lines(datetime, Sub_metering_3, col = 'blue')
    legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           lwd = 1, col = c('black', 'red', 'blue'))
})

dev.off()
