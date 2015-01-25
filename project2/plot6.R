library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))
sc.codes= data.table(readRDS("exdata_data_NEI_data/Source_Classification_Code.rds"))

setkeyv(nei.dt, 'SCC'); setkeyv(sc.codes, 'SCC')
all.dt= sc.codes[nei.dt]

motor.vehicles= all.dt[grep("vehicles", SCC.Level.Two, ignore.case=T)]

motor.veh.emm.balt.la= motor.vehicles[fips=='06037' | fips=='24510', list(total.emm= sum(Emissions)), by= c('year', 'fips')]
fips.to.city= data.table(fips= c('24510', '06037'), City= c('Baltimore City', 'Los Angeles County'))
fips.to.city[, City:= as.factor(City)]
setkeyv(motor.veh.emm.balt.la, 'fips'); setkeyv(fips.to.city, 'fips')
motor.veh.emm.balt.la= fips.to.city[motor.veh.emm.balt.la]

png("plot6.png")
qplot(factor(year), total.emm, fill= City, data= motor.veh.emm.balt.la,
      geom= "bar", stat= "identity", width= 0.6, position= "dodge",
      xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Motor Vehicle Emissions by Year at Baltimore and LA")
dev.off()