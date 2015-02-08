#PLOT4 from the Data.
#We use this file for plot1 plotting functions from extracted subset of Data from the Large Data set.


#We use get_plot_dataset.R for the extraction utility function.
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
source('get_plot_dataset.R')

#function: plot4() is used to data for the 
#Returns : png plot of the dataset
plot4 <- function(){
  #get dataset for plot generation.
  plotdata <- getPlotDataSet(,,66637, 66637, 69516)

  #set margins
  par(mar = c(5,5,1,5),mfrow = c(2,2))
  
  #plot Top-Left data
  plot(plotdata$Global_active_power ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="",ylab="Global Active Power(kilowatts)",xaxt="n")
  #adjust x-axis 
  axis(1,at=c(as.numeric(strptime("1/2/2007 00:00:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("1/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("2/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S"))),labels=c("Thu","Fri","Sat"))

  #plot Top-Right data
  plot(plotdata$Voltage ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="datetime",ylab="Voltage",xaxt="n")
  #adjust x-axis 
  axis(1,at=c(as.numeric(strptime("1/2/2007 00:00:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("1/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("2/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S"))),labels=c("Thu","Fri","Sat"))
  
  #plot Bottom-Left data
  #set common range for the slots, range() provides common max and min
  yrange = range(plotdata$Sub_metering_1,plotdata$Sub_metering_2,plotdata$Sub_metering_3)
  #plot data
  plot(plotdata$Sub_metering_1 ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="",ylab="Energy sub metering",xaxt="n",ylim = yrange,col="black")
  #add to same plot
  par(new=T)
  plot(plotdata$Sub_metering_2 ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="",ylab="",xaxt="n",yaxt="n",col="red",ylim = yrange)
  #add to same plot
  par(new=T)
  plot(plotdata$Sub_metering_3 ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="",ylab="",xaxt="n",yaxt="n",col="blue",ylim = yrange)  
  #adjust x-axis
  axis(1,at=c(as.numeric(strptime("1/2/2007 00:00:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("1/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("2/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S"))),labels=c("Thu","Fri","Sat"))
  #create legend
  legend("topright",lty=c(1,1,1),lwd=c(1,1,1),col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))  
  
  
  #plot Bottom-Right data
  plot(plotdata$Global_reactive_power ~ as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), type="l",xlab="datetime",ylab="Global_reactive_power",xaxt="n")
  #adjust x-axis 
  axis(1,at=c(as.numeric(strptime("1/2/2007 00:00:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("1/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S")),as.numeric(strptime("2/2/2007 23:59:00",format = "%d/%m/%Y %H:%M:%S"))),labels=c("Thu","Fri","Sat"))
  
  #as.Date(as.POSIXct(as.numeric(strptime(paste(plotdata$Date,plotdata$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")), origin="1970-01-01")))
  #send to png device
  dev.copy(png, file="plot4.png")
  dev.off()
}