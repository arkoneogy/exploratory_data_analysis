library(data.table)
library(lubridate)
options(warn= -1)

source('plot1.R')
source('plot2.R')
source('plot3.R')
source('plot4.R')

print("Reading data...")
dt= fread('household_power_consumption.txt')
dt[, Date:= as.Date(Date, format= "%d/%m/%Y")]
dt1= dt[ Date== "2007-02-01" | Date=="2007-02-02"]
mycols= names(dt1)[3:9]
dt1[, (mycols):= lapply(.SD, as.numeric), .SDcols= mycols]
rm(dt); gc()

dt1[, date_time:= ymd_hms(paste(Date, Time))]
txt= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colrs= c("black", "red", "blue")

print("Making plots..")
makePlot1 (dt1)
makePlot2 (dt1)
makePlot3 (dt1, txt, colrs)
makePlot4 (dt1, txt, colrs)

print("Done! Find all plots in working directory")
