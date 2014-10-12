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

## Add date in date format column
w <- data.frame(as.Date(temp$Date,"%d/%m/%Y"))
colnames(w) <- "Day"
temp <- cbind(w,temp)

## select only data for 2.1.2007 and 2.2.2007
data <-  subset(temp,Day == '2007-02-01' | Day == '2007-02-02')

rm(f,temp,w)


## create graphs

ylabel2 = "Global Active Power (kilowatts)"
a <- c("Thu","Fri","Sat")

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$Global_active_power, type = "l", xlab = "", ylab = ylabel2,
        lwd=1,main="",lab=c(3,5,7), xaxt="n")
axis(1, at=c(1,1440,2880), labels=a)    

dev.off()

