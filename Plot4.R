# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}


par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png",     width = 480, height = 480,     units = "px")

coal<- grep("coal",sccData$Short.Name,ignore.case = T)
coal<-sccData[coal,]
coal<- neiData[neiData$SCC %in% coal$SCC,]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

plot(coalEmissions, type = "b", xlab = "Year", xaxt='n',
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
axis(1,at=seq(1999,2008,by=3),las=3)

dev.off()