
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

# Plot 4 ------------------------------------------------------------------

par(mfrow = c(2,2))

# Chart # 1

titulo <- ""
xlabel <- ""
ylabel <- "Global Active Power"

with(dados_r, {
  plot(Time, Global_active_power, type = "n", main = titulo , ylab = ylabel, xlab = xlabel )
  lines(Time, Global_active_power, lwd = 1, lty = 1, col = 1)
})

# Chart # 2

titulo <- ""
xlabel <- "datetime"
ylabel <- "Voltage"

with(dados_r, {
  plot(Time, Voltage, type = "n", main = titulo , ylab = ylabel, xlab = xlabel )
  lines(Time, Voltage, lwd = 1, lty = 1, col = 1)
})

# Chart # 3

titulo  <- ""
xlabel  <- ""
ylabel  <- "Energy sub metering"
legenda <- c("Sub Metering 1","Sub Metering 2","Sub Metering 3")

with(dados_r, {
  plot(
    Time, Sub_metering_1, type = "n", main = titulo , ylab = ylabel, xlab = xlabel,
    ylim = c(min(Sub_metering_1,Sub_metering_2,Sub_metering_3),max(Sub_metering_1,Sub_metering_2,Sub_metering_3)), 
  )
  lines(Time, Sub_metering_1, lwd = 1, lty = 1, col = 1)
  lines(Time, Sub_metering_2, lwd = 1, lty = 1, col = 2)
  lines(Time, Sub_metering_3, lwd = 1, lty = 1, col = 4)
  legend("topright", legend = legenda, col = c(1,2,4), lwd = c(1,1,1), lty = c(1,1,1), pch = c(NA, NA, NA))
})

# Chart # 4

titulo <- ""
xlabel <- "datetime"
ylabel <- "Global Reactive Power"

with(dados_r, {
  plot(Time, Global_reactive_power, type = "n", main = titulo , ylab = ylabel, xlab = xlabel )
  lines(Time, Global_reactive_power, lwd = 1, lty = 1, col = 1)
})

dev.copy(png, file = "plot4.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()