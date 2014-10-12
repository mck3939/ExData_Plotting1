## Import Data
f <- "household_power_consumption.txt"

if(!file.exists(f)){
        ## Data will to be downloaded the file to a temp directory.
        DateDownloaded <- Sys.time()
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        td <- tempdir()
        temp <- tempfile(tmpdir=td, fileext=".zip")
        download.file(url, temp)
        
        ##unzip the zip folder to the wd and delete temp data
        unzip(temp)
        unlink(temp)
        rm(temp,td,url)
}

temp <- read.table(f, header = TRUE, sep=";",
                   stringsAsFactors = FALSE, na.strings = "?")

## Change date to date format and add weekday column
temp$Date <- as.Date(temp$Date,"%d/%m/%Y")
w <- data.frame(weekdays(temp$Date, abbreviate = TRUE))
colnames(w) <- "Day"
temp <- cbind(w,temp)

## select only data for 2.1.2007 and 2.2.2007
data <-  subset(temp,Date == '2007-02-01' | Date == '2007-02-02')

rm(f,temp,w)


## create graphs

xlabel = "Global Active Power (kilowatts)"
tlabel = "Global Active Power"
color = "red"

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = color, xlab = xlabel, main = tlabel)
dev.off()
