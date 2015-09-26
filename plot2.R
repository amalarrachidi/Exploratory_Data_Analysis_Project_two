# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")

# Loading the file
N <- readRDS("summarySCC_PM25.rds")


# data of maltimore only
baltimore_data <- N[N$fips=="24510",]

# Aggregation of the total emissions by year for baltimore
agg_baltimore <- aggregate(Emissions ~ year, baltimore_data,sum)

png("plot2.png",width=480,height=480,units="px")

barplot(agg_baltimore$Emissions,names.arg=agg_baltimore$year,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Sum of PM2.5 Emissions for Baltimore City")

dev.off()

