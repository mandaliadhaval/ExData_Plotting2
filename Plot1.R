# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.

# Check if data exists for 1999 and 2008

if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}

par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot1.png",width = 480, height = 480,units = "px")

totalEmissions <- aggregate(neiData$Emissions, list(neiData$year), FUN = "sum")

names(totalEmissions)[1]<-"Year"
names(totalEmissions)[2]<-"Emissions"

plot(totalEmissions, type = "b", xlab = "Year", xaxt='n',main = "Total Emissions in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
axis(1,at=seq(1999,2008,by=3),las=3)



dev.off()