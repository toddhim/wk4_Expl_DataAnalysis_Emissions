
library(plyr)
library(lattice)
library(ggplot2)
library(data.table)
library(sqldf)

#setting working directory
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera/exploratory_data_analysis_wk4")

##Reading PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#subsetting the data
SCC_motor_2 <- SCC[grep("motor|vehicles",SCC$EI.Sector, ignore.case=TRUE),]
                  
NEI_balt_NY_6 <- NEI[NEI$fips %in% c("24510", "06037"),]
##dim(NEI_balt_NY_6)
##[1] 11416     6

# Merging
Balt_NY_Motor <- merge(NEI_balt_NY_6, SCC_motor_2, by.x="SCC", by.y="SCC")


##################

png(filename = "plot6.png")   


plot_data_6 <- ddply(Balt_NY_Motor, .(year, fips), numcolwise(sum)) 

plot <- ggplot(plot_data_6) + 
  aes(x = factor(year), y = Emissions, group = factor(fips), colour = factor(fips)) + geom_point(size = 2) + geom_line() + 
  labs(title = "Motor Vehicle Emissions - Baltimore vs LA", 
       y = expression("Emissions (PM2.5)"),
       x = "Year",
       colour = "City")

print(plot) 

dev.off() 

#################
