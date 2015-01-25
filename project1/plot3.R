#plot 3
makePlot3= function(dt1, txt, colrs)
{
  png('plot3.png', width = 480, height = 480)
  plot(x= dt1$date_time, y= dt1$Sub_metering_1, type= "l", col= "black",
       xlab= "", ylab= "Energy sub metering")
  lines(x= dt1$date_time, y= dt1$Sub_metering_2, type= "l", col= "red")
  lines(x= dt1$date_time, y= dt1$Sub_metering_3, type= "l", col= "blue")
  
  legend("topright", legend= txt, col= colrs, lwd= 1)
  dev.off()
}