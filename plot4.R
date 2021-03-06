# Plot the sub-meterings as function of time (minute)
# (data from 2007-02-01 to 2007-02-02 only)
plot4 <- function() {
  #Read input data
  print("Loading file")
  pwr_part <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";",nrow=5)
  detTypes <- sapply(pwr_part, class)
  pwr_full <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";", colClasses=detTypes)
  pwr_full$Date <- as.Date(pwr_full$Date, format="%d/%m/%Y")
  pwr <- subset(pwr_full, (pwr_full$Date >= "2007-02-01") & (pwr_full$Date <= "2007-02-02"))
  pwr$Time <- strptime(paste(pwr$Date, pwr$Time), format="%Y-%m-%d %H:%M:%S")
  
  print("Plotting")
  #The following command is platform-specific, 
  # it is used to ensure a new window in case running multiple plot scripts in the same session
  #If running on another platform (non-Unix) adapt or just remove it
  x11() #Note: platform-specific
  
  par(mfrow=c(2,2))
  plot(x=pwr$Time, y=pwr$Global_active_power, col="blue", ylab="Global active power (kW)", xlab="Time",type="l")
  
  plot(x=pwr$Time, y=pwr$Voltage, col="blue", ylab="Voltage (V)", xlab="Time",type="l")
  
  plot(x=pwr$Time, y=pwr$Sub_metering_1, col="black", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
  par(new=T)
  plot(x=pwr$Time, y=pwr$Sub_metering_2, col="red", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
  par(new=T)
  plot(x=pwr$Time, y=pwr$Sub_metering_3, col="blue", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
    
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"),lwd=2)
  
  plot(x=pwr$Time, y=pwr$Global_reactive_power, col="blue", ylab="Global reactive power (kW)", xlab="Time",type="l")

  print(paste("Selected rows:" , nrow(pwr), "/", nrow(pwr_full)))
  
  dev.copy(png, file="plot4.png")
  dev.off()
}