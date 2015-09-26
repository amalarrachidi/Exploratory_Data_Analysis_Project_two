
# Downloading the data 

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("data.zip")

# Loading the file
N <- readRDS("summarySCC_PM25.rds")
S <- readRDS("Source_Classification_Code.rds")

# Subset of needed data 
combustion_data <- grepl("comb", S$S.Level.One, ignore.case=TRUE)
coal_data <- grepl("coal", S$S.Level.Four, ignore.case=TRUE) 
coalCombustion_data <- (combustion_data & coal_data)
combustionS <- S[coalCombustion_data,]$S
combustionN <- N[N$S %in% combustionS,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(combustionN,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()

