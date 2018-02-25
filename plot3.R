## Read the power use data as a table. The separation character is a
## semicolon, and "NA" is represented as "?"

tbl1 <- read.table(file="household_power_consumption.txt", header=TRUE,
                   sep=";", na.strings="?", dec=".")

## Subset the table to extract only the dates of interest
subtbl <- tbl1[(tbl1$Date %in% c("1/2/2007","2/2/2007")), ]

## Optionally, we can remove the larger table from memory to reduce
## memory use
rm(tbl1)

## Get the weekday names
date_n_time <- strptime(paste(subtbl$Date, subtbl$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## Select a PNG file graphic device
png("plot3.png", width=480, height=480)

## We have to build up this graph by one line graph at a time
plot (date_n_time, as.numeric(subtbl$Sub_metering_1),
      type="l",
      ylab="Energy sub metering", xlab="")

lines (date_n_time, as.numeric(subtbl$Sub_metering_2),
       type="l", col="red")

lines (date_n_time, as.numeric(subtbl$Sub_metering_3),
       type="l", col="blue")

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Important to close the device, else the file cannot be opened
# for viewing
dev.off()
