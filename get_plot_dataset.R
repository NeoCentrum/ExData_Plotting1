getPlotDataSet <- function(skipr=1, strow = 0, edrow = 0){
  datasetfound <- FALSE
  skiprows <- skipr
  #startrow<-66637
  startrow <- strow
  #endrow <- 69516
  endrow<- edrow
  while(datasetfound == FALSE && endrow == 0) {
    record <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",quote = "\"'",na.strings = "?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),nrows = 1, skip = skiprows)
    startTime <- strptime("1/2/2007 00:00:00",format = "%d/%m/%Y %H:%M:%S")
    endTime <- strptime("2/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S")  
    recTime <- strptime(paste(record[[1]],record[[2]],sep=" "),format = "%d/%m/%Y %H:%M:%S")
    
    if(recTime >= startTime && (startrow == 0)){
      startrow = skiprows
      #print(record[1])
      
    } else if(recTime >= endTime && (endrow == 0)){
      endrow <- skiprows
      datasetfound <- TRUE
      #print(record[1]) 
      break;
    }
    skiprows <- skiprows + 1
    #print(record[1])
    #print(skiprows) 
  }
  datast <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",quote = "\"'",na.strings = "?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),nrows = (endrow - startrow), skip = startrow)
  #print(length(datast))
  #print(startrow)
  #print(endrow)
}