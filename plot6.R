

# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")

# Loading the file
N <- readRDS("summarySCC_PM25.rds")
S <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles

vehicles <- grepl("vehicle", S$S.Level.Two, ignore.case=TRUE)

vehiclesS_data <- S[vehicles,]$S

vehiclesN_data <- N[N$S %in% vehiclesS_data,]

# Subset the vehicles NEI data by each city's fip and add city name.

vehiclesBaltimoreNEI <- vehiclesN_data[vehiclesN_data$fips=="24510",]

vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehiclesN_data[vehiclesN_data$fips=="06037",]

vehiclesLANEI$city <- "Los Angeles County"


# Combine the two subsets with city name into one data frame

bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)
 
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +

 geom_bar(aes(fill=year),stat="identity") +

 facet_grid(scales="free", space="free", .~city) +

 guides(fill=FALSE) + theme_bw() +

 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 

 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))


print(ggp)


dev.off()

