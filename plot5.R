
# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")

# Loading the file
N <- readRDS("summarySCC_PM25.rds")
S <- readRDS("Source_Classification_Code.rds")

# Subset of the vehicles data

vehicles <- grepl("vehicle", S$S.Level.Two, ignore.case=TRUE)

vehiclesS_data <- S[vehicles,]$S

vehiclesN_data <- N[N$S %in% vehiclesS_data,]


# Subset of the baltimore data

baltimoreVehiclesNEI <- vehiclesN_data[vehiclesN_data$fips=="24510",]


png("plot5.png",width=480,height=480,units="px")

library(ggplot2)

ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +

  geom_bar(stat="identity",fill="grey",width=0.75) +

  theme_bw() +  guides(fill=FALSE) +

  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 

  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)
dev.off()

