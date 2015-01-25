#plot 2
makePlot2 = function(dt1)
{
  png('plot2.png', width= 480, height= 480)
  plot(x= dt1$date_time, y= dt1$Global_active_power, 
       type= "l", xlab= "",ylab= "Global active power (kilowatts)")
  dev.off()
}
