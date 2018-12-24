# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "24510"|neiData$fips == "06037", ]

par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

motor <- grep("motor", sccData$Short.Name, ignore.case = T)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]

library(ggplot2)

g<- ggplot(motor,aes(year,Emissions,color=fips))
g + geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") +
  scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))

dev.off()



#Optional
head(motor)
# Comparing Baltimore, MD-24510 and Los Angeles, CA-06037
library(dplyr)
baltYrTypEmmFips <- summarize(group_by(filter(neiData, neiData$fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
laYrTypEmmFips <- summarise(group_by(filter(neiData, neiData$fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltYrTypEmmFips$County <- "Baltimore City, MD"
laYrTypEmmFips$County <- "Los Angeles County, CA"

motor <- rbind(baltYrTypEmmFips, laYrTypEmmFips)
ggplot(motor, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_grid(County~., scales="free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Baltimore City vs Los Angeles County Motor vehicle emission in tons"))+
  geom_label(aes(fill = County),colour = "yellow", fontface = "bold")