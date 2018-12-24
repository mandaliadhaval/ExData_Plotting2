# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "24510", ]

head(subset)
par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot3.png",width = 480, height = 480,units = "px")

library(ggplot2)

g<- ggplot(subset,aes(year,Emissions,color=type))
g + geom_line(stat = "summary", fun.y="sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) + xlim(1999,2008) +
  ggtitle("Total Emissions in Baltimore City from 1999 to 2008")

dev.off()