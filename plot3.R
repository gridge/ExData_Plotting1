# Plot the sub-meterings as function of time (minute)
# (data from 2007-02-01 to 2007-02-02 only)
plot3 <- function() {
  #Read input data
  print("Loading file")
  pwr_part <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";",nrow=5)
  detTypes <- sapply(pwr_part, class)
  pwr_full <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";", colClasses=detTypes)
  pwr_full$Date <- as.Date(pwr_full$Date, format="%d/%m/%Y")
  pwr <- subset(pwr_full, (pwr_full$Date >= "2007-02-01") & (pwr_full$Date <= "2007-02-02"))
  pwr$Time <- strptime(paste(pwr$Date, pwr$Time), format="%Y-%m-%d %H:%M:%S")
  
  print("Plotting")
  plot(x=pwr$Time, y=pwr$Sub_metering_1, col="black", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
  par(new=T)
  plot(x=pwr$Time, y=pwr$Sub_metering_2, col="red", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
  par(new=T)
  plot(x=pwr$Time, y=pwr$Sub_metering_3, col="blue", ylab="Energy sub-metering", xlab="Time",type="l",ylim=c(0,40))
  
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"),lwd=2)
  
  print(paste("Selected rows:" , nrow(pwr), "/", nrow(pwr_full)))
  
  dev.copy(png, file="plot3.png")
  dev.off()
}