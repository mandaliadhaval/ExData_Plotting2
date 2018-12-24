# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Check if data exists for 1999 and 2008

if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "24510", ]

par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot2.png",width = 480, height = 480,units = "px")

totalEmissions <- aggregate(subset$Emissions, list(subset$year), FUN = "sum")

names(totalEmissions)[1]<-"Year"
names(totalEmissions)[2]<-"Emissions"

plot(totalEmissions, type = "b", xlab = "Year", xaxt='n',main = "Total Emissions in Baltimore City from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
axis(1,at=seq(1999,2008,by=3),las=3)



dev.off()

#Optional but not working
par(old.par)
subset <- neiData[neiData$fips=="24510", ]
baltYrEmm <- aggregate(subset$Emissions, list(subset$year), FUN = "sum")

cols1 <- c("maroon", "yellow", "orange", "Aquamarine")
barplot(height=baltYrEmm$Emissions/1000, names.arg=baltYrEmm$year, xlab="Year", xaxt='n',
        ylab=expression('Aggregated Emission'),main=expression('Baltimore Aggregated PM'[2.5]*' Emmissions by Year'), 
        col = cols1)

