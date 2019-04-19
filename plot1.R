
# load database -----------------------------------------------------------
# variables in the data set
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#
arquivo <- file.path("./data/household_power_consumption.txt")
dados   <- read.table(
  file = arquivo, 
  header = TRUE,
  sep = ";",
  na.strings = "?", # Note that in this dataset missing values are coded as '?'.
  colClasses = c(rep("character",2), rep("numeric", 7)) 
  )
head(dados)
dim(dados)
str(dados)

dados$Time <- as.POSIXct(paste(dados$Date, dados$Time), format="%d/%m/%Y %H:%M:%S")
# dados$Time <- strptime(paste(dados$Date, dados$Time), format="%d/%m/%Y %H:%M:%S")
head(dados$Time)

dados$Date <- as.Date(dados$Date, format = "%d/%m/%Y")
head(dados$Date)


# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
dados_r <- subset(dados, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

# Plot 1 ------------------------------------------------------------------

par(mfrow = c(1,1))

titulo <- "Global Active Power"
ylabel <- "Frequency"
xlabel <- "Global Active Power (kilowatts)"

with(dados_r, hist(Global_active_power, col = "red", main = titulo, xlab = xlabel))

dev.copy(png, file = "plot1.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()
