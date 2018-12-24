setwd("D:/Documents/Training/John Hopkins Data Science/Course 4 - Exploratory Data/Project/ExData_Plotting2")
rm(list=ls())

neiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(neiData)
#     fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999

head(SCC)
#SCC        Data.Category Short.Name                                               EI.Sector Option.Group Option.Set
#1 10100101 Point         Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal Fuel Comb - Electric Generation - Coal

#SCC.Level.One       SCC.Level.Two               SCC.Level.Three SCC.Level.Four Map.To Last.Inventory.Year Created_Date
#External Combustion Boilers Electric Generation Anthracite Coal Pulverized Coal NA    NA

dim(neiData)
#[1] 6497651       6

dim(SCC)
# [1] 11717    15