library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))

tot.annual.emm= nei.dt[, list(total.emm= sum(Emissions)), by= 'year']

png("plot1.png")
barplot(tot.annual.emm$total.emm, width= 1, space= 1, col= "red", 
        ylim= c(0,8e6), names.arg= tot.annual.emm$year, 
        xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year", 
        axis.lty= 1)
dev.off()
