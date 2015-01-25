#plot 1

makePlot1 = function(dt1)
{
  png('plot1.png', width= 480, height= 480)
  hist(dt1$Global_active_power, col= 'red', xlab= "Global active power (kilowatts)", main= "Global Active Power")
  dev.off()
}