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
date_n_time     <- strptime(paste(subtbl$Date, subtbl$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

global_active   <- as.numeric(subtbl$Global_active_power)
global_reactive <- as.numeric(subtbl$Global_reactive_power)
sub_metering1   <- as.numeric(subtbl$Sub_metering_1)
sub_metering2   <- as.numeric(subtbl$Sub_metering_2)
sub_metering3   <- as.numeric(subtbl$Sub_metering_3)
voltage         <- as.numeric(subtbl$Voltage)

## Select a PNG file graphic device
png("plot4.png", width=480, height=480)

## Define two rows and two columns for the composite plot
par(mfrow = c(2, 2))

## The plots laid out go by Row1, Row2

## Global Active plot
plot (date_n_time, global_active, type = "l",
      xlab = "", ylab = "Global Active Power")

## Voltage plot
plot (date_n_time, voltage, type = "l",
      xlab = "datetime", ylab = "Voltage")

## Energy Sub-metering Plot
## We have to build up this graph by one line graph at a time
plot (date_n_time, sub_metering1, type="l",
      ylab="Energy sub metering", xlab="")

lines (date_n_time, sub_metering2, type="l", col="red")

lines (date_n_time, sub_metering3, type="l", col="blue")

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=, lwd=2.5, bty="n",
       col=c("black", "red", "blue"))

## Global reactive power plot
plot (date_n_time, global_reactive, type = "l",
      xlab = "datetime", ylab = "Global_reactive_power")


# Important to close the device, else the file cannot be opened
# for viewing
dev.off()
