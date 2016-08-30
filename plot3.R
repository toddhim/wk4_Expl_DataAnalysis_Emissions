
library(plyr)
library(ggplot2)
library(data.table)

#setting working directory
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera/exploratory_data_analysis_wk4")

##Reading PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")




#subsetting the data
NEI_balt_3 <- subset(NEI, NEI$fips == "24510")


#################
##Open PNG Device
png(filename = "plot3.png", width = 480, height = 480)


NEI_balt_3_plot <- ddply(NEI_balt_3, .(year, type), numcolwise(sum))


plot <- ggplot(NEI_balt_3_plot) + 
  aes(x = factor(year), y = Emissions, group = type, col = type) + 
  geom_line() + geom_point() + 
  labs(title = "Emissions by type - Baltimore City, Maryland", 
       y = expression("Emissions (PM2.5)"),
       x = "Year"

  )

print(plot)


# Close PNG device
dev.off()

################


