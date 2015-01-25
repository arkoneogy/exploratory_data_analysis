#plot 4
makePlot4= function(dt1, txt, colrs)
{
  png('plot4.png', width = 480, height = 480)
  par(mfrow = c(2,2))
  
  plot(x= dt1$date_time, y= dt1$Global_active_power, 
       type= "l", xlab= "",ylab= "Global active power (kilowatts)")
  
  plot(x= dt1$date_time, y= dt1$Voltage, 
       type= "l", xlab= "datetime",ylab= "Voltage")
  
  plot(x= dt1$date_time, y= dt1$Sub_metering_1, type= "l", col= "black",
       xlab= "", ylab= "Energy sub metering")
  lines(x= dt1$date_time, y= dt1$Sub_metering_2, type= "l", col= "red")
  lines(x= dt1$date_time, y= dt1$Sub_metering_3, type= "l", col= "blue")
  legend("topright", legend= txt, col= colrs, lwd= 1)
  
  plot(x= dt1$date_time, y= dt1$Global_reactive_power, 
       type= "l", xlab= "datetime",ylab= "Global reactive power")
  
  dev.off()
}