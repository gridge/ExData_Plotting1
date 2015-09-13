# Plot Global Active power distribution from 2007-02-01 to 2007-02-02
plot1 <- function() {
  #Read input data
  print("Loading file")
  pwr_part <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";",nrow=5)
  detTypes <- sapply(pwr_part, class)
  pwr_full <- read.table("household_power_consumption.txt", header=TRUE,na.strings="?", comment.char="", stringsAsFactors = FALSE,sep = ";", colClasses=detTypes)
  pwr_full$Date <- as.Date(pwr_full$Date, format="%d/%m/%Y")
  pwr <- subset(pwr_full, (pwr_full$Date >= "2007-02-01") & (pwr_full$Date <= "2007-02-02"))
  
  print("Plotting")
  #The following command is platform-specific, 
  # it is used to ensure a new window in case running multiple plot scripts in the same session
  #If running on another platform (non-Unix) adapt or just remove it
  x11() #Note: platform-specific
  
  hist(pwr$Global_active_power, main="Global Active power", col="blue",xlab="Global active power (kW)", ylab="Frequency")
  
  print(paste("Selected rows:" , nrow(pwr), "/", nrow(pwr_full)))
  
  dev.copy(png, file="plot1.png",width=480,height=480)
  dev.off()
}