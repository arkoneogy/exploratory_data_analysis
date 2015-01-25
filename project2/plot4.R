library(data.table)
library(ggplot2)

nei.dt= data.table(readRDS("exdata_data_NEI_data/summarySCC_PM25.rds"))
sc.codes= data.table(readRDS("exdata_data_NEI_data/Source_Classification_Code.rds"))

setkeyv(nei.dt, 'SCC'); setkeyv(sc.codes, 'SCC')
all.dt= sc.codes[nei.dt]

coal.comb= all.dt[grep("comb.*(coal|lignite)", Short.Name, ignore.case=TRUE)]
coal.comb.total= coal.comb[, list(total.emm= sum(Emissions)), by= 'year']

png("plot4.png")
qplot(factor(year), total.emm, data= coal.comb.total, 
      geom= "bar", stat= "identity", width= 0.6,
      xlab= "Year", ylab= "Total PM2.5 Emission in tons", main= "PM2.5 Coal-Combustion Emissions by Year")
dev.off()
