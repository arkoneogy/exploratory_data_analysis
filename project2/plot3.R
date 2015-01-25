library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))

tot.annual.emm.balt.type= nei.dt[fips=='24510', list(total.emm= sum(Emissions)), by= c('year','type')]

png("plot3.png")
tot.annual.emm.balt.type[, Emission_Type:= as.factor(type)]
qplot(factor(year), total.emm, fill= Emission_Type, data= tot.annual.emm.balt.type, 
      geom= "bar", stat= "identity", position= "dodge",
      xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year and Type at Baltimore") 
dev.off()
