# Plot Global Active power as function of time (minute)
# (data from 2007-02-01 to 2007-02-02 only)
plot2 <- function() {
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
  
  plot(x=pwr$Time, y=pwr$Global_active_power, col="blue", ylab="Global active power (kW)", xlab="Time",type="l")
  
  print(paste("Selected rows:" , nrow(pwr), "/", nrow(pwr_full)))
  
  dev.copy(png, file="plot2.png")
  dev.off()
}