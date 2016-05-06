## Coursera's Exploratory Data Analysis - Project assignemnt 1
## Plot 2

## Download Data if not already done
if(!file.exists("household_power_consumption.txt")) {
  ## Download and unzip the data
  message("Downloading dataset")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  fileName <- "ZippedFile.zip"
  download.file(fileUrl, destfile = fileName, method = "curl")
  
  ## Unzip files and remove zip archive file
  unzip(fileName)
  file.remove(fileName)
} else {
  message("Reusing prevously downloaded data")
}

## Load the data
## The entire dataset required requires about 142MB to be stored in R
## 2075259 rows * 9 numeric atributes * 8 bytes per numeric / 2^10 to convert to MB
## My computer has enough memory to load the entired dataset

message("Loading data")
epcData <-read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))


## Convert Data column to date format
epcData$Date <- as.Date(epcData$Date, "%d/%m/%Y")

## Filter rows for 2007-02-01 and 2007-02-02 dates
dateFilter <- as.Date(c("2007-02-01","2007-02-02"))
epcData <- subset(epcData, epcData$Date %in% dateFilter)

## Create a new column combining Date and Time that will be used for the X-axis
epcData$DateTime <- as.POSIXct(paste(epcData$Date, epcData$Time, sep = " "))

message("Generating graph: Plot2.png")
## Create plot
png("plot2.png", width=480, height=480)
plot(epcData$DateTime, epcData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()