
library(plyr)
library(ggplot2)
library(data.table)

#setting working directory
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera/exploratory_data_analysis_wk4")

##Reading PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##coal combustion-related sources
SCC_Coal <- SCC[grep("coal",SCC$EI.Sector,ignore.case=TRUE),]


# Merging the SCC and  PM25 datasets
merged_dataset <- merge(NEI, SCC_Coal, by.x="SCC", by.y="SCC")

############

##Open PNG Device
png(filename = "plot4.png", width = 480, height = 480)


plot_4 <- ddply(merged_dataset, .(year), numcolwise(sum)) 

plot <- ggplot(plot_4) + 
  aes(x = factor(year), y = Emissions, group = 1) + 
  geom_point(size = 2, color='blue') + 
  geom_line(color='blue') + 
  labs(title = "Coal Comb. Related Emissions", 
       y = expression("Emissions (PM2.5)"),
       x = "Year"
  )

print(plot) 

dev.off() 

#################
