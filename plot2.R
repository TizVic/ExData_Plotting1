# The "Electric power consumption" dataset from UC Irvine Machine Learning Repository
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# it is unzipped in ./data/household_power_consumption.txt

# First time the script created the reduced dataset with data from 2007-02-01 to 2007-02-02
# and save it on disk so next time it is quicker to load
if (!file.exists("./data/hhpc_reduced.csv")) {
    
    # Read main file
    hhpc <- read.csv2("./data/household_power_consumption.txt", 
                      header = T, 
                      colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric" ), 
                      dec = ".", 
                      na.strings = "?")
    # create a new colum dt with Date and Time
    hhpc$dt <- strptime(paste(hhpc[, 1], hhpc[,2]), "%d/%m/%Y %H:%M:%S")
    # subsetting between 2007-02-01 and 2007-02-02
    hhok <- subset(hhpc, dt >= "2007-02-01 00:00:00" & dt < "2007-02-03 00:00:00")
    # write on disk reduced dataset
    #    write.csv2(hhok, file = "./data/hhpc_reduced.csv", row.names = F)
    write.csv(hhok[,c(3:10)], "./data/hhpc_reduced.csv", row.names = F)
} else {
    
    # reduced dataset already created so load it
    #hhok <- read.csv2("./data/hhpc_reduced.csv", header = T, colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric" ), dec = ".")
    hhok <- read.csv("./data/hhpc_reduced.csv", 
                     header = T, 
                     colClasses = c("numeric","numeric","numeric","numeric","numeric","numeric","numeric", "POSIXct" ))
    
}

## create second plot
png("plot2.png")
with(hhok, plot(dt, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(hhok, lines(dt, Global_active_power))
dev.off()
