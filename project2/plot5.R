library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))
sc.codes= data.table(readRDS("exdata_data_NEI_data/Source_Classification_Code.rds"))

setkeyv(nei.dt, 'SCC'); setkeyv(sc.codes, 'SCC')
all.dt= sc.codes[nei.dt]

motor.vehicles= all.dt[grep("vehicles", SCC.Level.Two, ignore.case=T)]

motor.veh.emm.balt= motor.vehicles[fips=='24510', list(total.emm= sum(Emissions)), by= 'year']

png("plot5.png")
qplot(factor(year), total.emm, data= motor.veh.emm.balt, 
      geom= "bar", stat= "identity", width= 0.6, fill= "red",
      xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Motor Vehicle Emissions by Year at Baltimore") + theme(legend.position='None')
dev.off()
