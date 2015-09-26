# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")


# Loading the files
N <- readRDS("summarySCC_PM25.rds")

# Aggregation of the total emissions by year 
aggTotals <- aggregate(Emissions ~ year,N, sum)

png("plot1.png",width=480,height=480,units="px")

barplot((aggTotals$Emissions)/10^6,names.arg=aggTotals$year,xlab="Year",ylab="PM2.5 Emissions (10^6 Tons)",main="Total PM2.5 Emissions From All US Sources")

dev.off()

