source('get_plot_dataset.R')
plot1 <- function(){
  plotdata <- getPlotDataSet(66637, 66637, 69516)
  par(mar = c(5,5,2,2))
  #mfrow(1,1)
  with(plotdata,hist(Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency")) 
  dev.copy(png, file="plot1.png")
  dev.off()
}