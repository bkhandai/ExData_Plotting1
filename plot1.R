## Read the power use data as a table. The separation character is a
## semicolon, and "NA" is represented as "?"

tbl1 <- read.table(file="household_power_consumption.txt", header=TRUE,
                   sep=";", na.strings="?", dec=".")

## Subset the table to extract only the dates of interest
subtbl <- tbl1[(tbl1$Date %in% c("1/2/2007","2/2/2007")), ]

## Optionally, we can remove the larger table from memory to reduce
## memory use
rm(tbl1)

## Select a PNG file graphic device
png("plot1.png", width=480, height=480)

# Plot the histogram onto the PNG file
hist(as.numeric(subtbl$Global_active_power),
     col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# Important to close the device, else the file cannot be opened
# for viewing
dev.off()
