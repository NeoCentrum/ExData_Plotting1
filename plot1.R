#PLOT1 from the Data.
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

#function: plot1() is used to data for the Global Active Power values.
#Returns : png plot of the datasert
plot1 <- function(){
  #get dataset for plot generation.
  plotdata <- getPlotDataSet(66637, 66637, 69516)
  #set margins
  par(mar = c(5,5,2,2))
  #plot data
  with(plotdata,hist(Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency")) 
  #send to png device
  dev.copy(png, file="plot1.png")
  dev.off()
}