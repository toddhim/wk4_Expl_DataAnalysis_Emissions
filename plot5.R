
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
NEI_balt_5 <- subset(NEI, NEI$fips == "24510")
SCC_motor <- SCC[grep("motor|vehicles",SCC$EI.Sector, ignore.case=TRUE),]


# Merging the Balt and  PM25 datasets
SCC_Balt_Motor <- merge(NEI_balt_5, SCC_motor, by.x="SCC", by.y="SCC")
#dim(SCC_Balt_Motor)

############

##Open PNG Device
png(filename = "plot5.png", width = 480, height = 480)


plot_5 <- ddply(SCC_Balt_Motor, .(year), numcolwise(sum)) 

plot <- ggplot(plot_5) + 
  aes(x = factor(year), y = Emissions, group = 1) + 
  geom_point(size = 2, color='blue') + 
  geom_line(color='blue') + 
  labs(title = "Motor Vehicle Emissions - Baltimore", 
       y = expression("Emissions (PM2.5)"),
       x = "Year"
  )

print(plot) 

dev.off() 

#################