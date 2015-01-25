library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))

tot.annual.emm.baltimore= nei.dt[fips=='24510', list(total.emm= sum(Emissions)), by= 'year']

png("plot2.png")
barplot(tot.annual.emm.baltimore$total.emm, width= 1, space= 1, col= "blue", 
        ylim= c(0,3.5e3), names.arg= tot.annual.emm.baltimore$year, 
        xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year at Baltimore", 
        axis.lty= 1)
dev.off()
