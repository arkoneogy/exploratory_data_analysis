library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))
sc.codes= data.table(readRDS("exdata_data_NEI_data/Source_Classification_Code.rds"))

tot.annual.emm= nei.dt[, list(total.emm= sum(Emissions)), by= 'year']
png("plot1.png")
barplot(tot.annual.emm$total.emm, width= 1, space= 1, col= "red", 
				ylim= c(0,8e6), names.arg= tot.annual.emm$year, 
				xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year", 
				axis.lty= 1)
dev.off()

tot.annual.emm.baltimore= nei.dt[fips=='24510', list(total.emm= sum(Emissions)), by= 'year']
png("plot2.png")
barplot(tot.annual.emm.baltimore$total.emm, width= 1, space= 1, col= "blue", 
				ylim= c(0,3.5e3), names.arg= tot.annual.emm.baltimore$year, 
				xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year at Baltimore", 
				axis.lty= 1)
dev.off()


tot.annual.emm.balt.type= nei.dt[fips=='24510', list(total.emm= sum(Emissions)), by= c('year','type')]
png("plot3.png")
tot.annual.emm.balt.type[, Emission_Type:= as.factor(type)]
qplot(factor(year), total.emm, fill= Emission_Type, data= tot.annual.emm.balt.type, 
			geom= "bar", stat= "identity", position= "dodge",
			xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Total Emissions by Year and Type at Baltimore") 
dev.off()

setkeyv(nei.dt, 'SCC'); setkeyv(sc.codes, 'SCC')
all.dt= sc.codes[nei.dt]

coal.comb= all.dt[grep("comb.*(coal|lignite)", Short.Name, ignore.case=TRUE)]
coal.comb.total= coal.comb[, list(total.emm= sum(Emissions)), by= 'year']

png("plot4.png")
qplot(factor(year), total.emm, data= coal.comb.total, 
			geom= "bar", stat= "identity", width= 0.6,
			xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Coal-Combustion Emissions by Year")
dev.off()

motor.vehicles= all.dt[grep("vehicles", SCC.Level.Two, ignore.case=T)]

motor.veh.emm.balt= motor.vehicles[fips=='24510', list(total.emm= sum(Emissions)), by= 'year']
motor.veh.emm.balt.la= motor.vehicles[fips=='06037' | fips=='24510', list(total.emm= sum(Emissions)), by= c('year', 'fips')]
fips.to.city= data.table(fips= c('24510', '06037'), City= c('Baltimore City', 'Los Angeles County'))
fips.to.city[, City:= as.factor(City)]
setkeyv(motor.veh.emm.balt.la, 'fips'); setkeyv(fips.to.city, 'fips')
motor.veh.emm.balt.la= fips.to.city[motor.veh.emm.balt.la]


png("plot5.png")
qplot(factor(year), total.emm, data= motor.veh.emm.balt, 
			geom= "bar", stat= "identity", width= 0.6, fill= "red",
			xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Motor Vehicle Emissions by Year at Baltimore") + theme(legend.position='None')
dev.off()

png("plot6.png")
qplot(factor(year), total.emm, fill= City, data= motor.veh.emm.balt.la,
			geom= "bar", stat= "identity", width= 0.6, position= "dodge",
			xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Motor Vehicle Emissions by Year at Baltimore and LA")
dev.off()
