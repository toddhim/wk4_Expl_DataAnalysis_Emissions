
#setting working directory
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera/exploratory_data_analysis_wk4")

##Reading PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##Open PNG Device
png(filename = "plot1.png", width = 480, height = 480)


summary_NEI <- with(NEI, aggregate(Emissions, by = list(year), sum))

plot(summary_NEI, xlim=c(1998,2009), type = "b", pch = 20, col="blue", lwd=2, 
     ylab = "Emissions (PM2.5)", 
     xlab = "Year", 
     main = "EMISSIONS TREND")

# Close PNG device
dev.off()