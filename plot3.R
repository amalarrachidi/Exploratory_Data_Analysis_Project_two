# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")

# Loading the file
N <- readRDS("summarySCC_PM25.rds")


# data of maltimore only
baltimore_data <- N[N$fips=="24510",]

# Aggregation of the total emissions by year for baltimore
agg_baltimore <- aggregate(Emissions ~ year, baltimore_data,sum)

png("plot3.png",width=480,height=480,units="px")

library(ggplot2)

ggp <- ggplot(baltimore_data,aes(factor(year),Emissions,fill=type)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE)+ facet_grid(.~type,scales = "free",space="free") + labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.off()

