#GETTING SUBSET OF DATA
#We use this file for utility functions for extracting subset of Data from the Large Data set.

#function: getPlotDataSet(...) is used to get the subset of Data from the Lareg Dateset, this helps with optmial memory
#                         utilization because we do not need to store the whole data. in addition, the function can
#                         is designed to run a trace to get data only for dates 1/2/2007 and 2/2/2007, if run without
#                         parameters, it will take longer but will provide the required dataset, since I could run it 
#                         I have found where the data exactly is and thus we can use exact data start and end points to
#                         quickly get the data. Another important aspect is that for a uniform data ,we culd have found
#                         start and end mathematically using the sample data finding the data collection interval.
#Parameters: startdate : target extraction start date, in this case : "1/2/2007 00:00:00" - (dd/mm/yyyy hh:mm:ss)
#            enddate : target extraction end date, in this case : "2/2/2007 23:59:00" - (dd/mm/yyyy hh:mm:ss)       
#            skipr: skip rows can be used to skip specific number of rows
#            strow : start row, where to start extraction from.
#            edrow : end row, where to end extraction. helps quickly get the data.
#Returns : dataset containing extracted data 
getPlotDataSet <- function(startdate = "1/2/2007 00:00:00", enddate = "2/2/2007 23:59:00",skipr=1, strow = 0, edrow = 0){
  #Flag for terminating trace loop for data.
  datasetfound <- FALSE
  skiprows <- skipr
  #startrow<-66637
  startrow <- strow
  #endrow <- 69516
  endrow<- edrow
  #Lopp through Data one row at a time, till we get to startdate and then enddate.
  while(datasetfound == FALSE && endrow == 0) {
    record <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",quote = "\"'",na.strings = "?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),nrows = 1, skip = skiprows)
    startTime <- strptime(startdate,format = "%d/%m/%Y %H:%M:%S")
    endTime <- strptime(enddate,format = "%d/%m/%Y %H:%M:%S")  
    recTime <- strptime(paste(record[[1]],record[[2]],sep=" "),format = "%d/%m/%Y %H:%M:%S")
    
    if(recTime >= startTime && (startrow == 0)){
      startrow = skiprows
      
    } else if(recTime >= endTime && (endrow == 0)){
      endrow <- skiprows
      datasetfound <- TRUE
      break;
    }
    skiprows <- skiprows + 1
  }
  #extract data for the given startdate -> enddate range.
  datast <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",quote = "\"'",na.strings = "?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),nrows = (endrow - startrow), skip = startrow)

}