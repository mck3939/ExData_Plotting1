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


# set chart variables
ylabel2 = "Global Active Power"
ylabel3 = "Energy sub metering"
ylabel4 = "Voltage"
a <- c("Thu","Fri","Sat")
color1 = "red"
color2 = "blue"



## create graphs
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2),mar=c(4.5,4.5,3,1.5))

##### 1) chart top left
plot(data$Global_active_power, type = "l", xlab = "", ylab = ylabel2,
     lwd=1,main="",lab=c(3,5,7), xaxt="n")
axis(1, at=c(1,1440,2880), labels=a) #add x axis with days

##### 2) chart top right
plot(data$Voltage, type = "l", xlab = "datetime", ylab = ylabel4,
     lwd=1,main="",lab=c(3,5,7), xaxt="n")
axis(1, at=c(1,1440,2880), labels=a) #add x axis with days


##### 3) chart bottom left
plot(data$Sub_metering_1, type ="l",xlab = "", ylab = ylabel3,
     lwd=1,main="",lab=c(3,5,7), xaxt="n")

par(new=T, col= color1) #allow the next chart to write on top, change color
plot(data$Sub_metering_2, type ="l", axes=F, ann = F, ylim=c(0, 39.52))

par(new=T,col = color2) #allow the next chart to write on top, change color
plot(data$Sub_metering_3, type ="l", axes=F, ann= F, ylim=c(0, 39.52))

par(col="black")     #change color

axis(1, at=c(1,1440,2880), labels=a) #add x axis with days
legend("topright",legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black", color1, color2), bty ="n")
par(new=F)  #allow the next chart to be new chart

##### 4) chart bottom right
plot(data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power",
     lwd=1,main="",lab=c(3,5,7), xaxt="n")
axis(1, at=c(1,1440,2880), labels=a) #add x axis with days

dev.off()
