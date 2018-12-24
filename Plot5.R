# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

if (!"neiData" %in% ls()) {
  neiData <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  sccData <- readRDS("Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "24510", ]

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot5.png",     width = 480, height = 480,     units = "px")

motor <- grep("motor", sccData$Short.Name, ignore.case = TRUE)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]
motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

plot(motorEmissions, type = "b", xlab = "Year", xaxt='n',
     main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City", 
     ylab = expression('Total PM'[2.5]*" Emission"))
axis(1,at=seq(1999,2008,by=3),las=3)

dev.off()