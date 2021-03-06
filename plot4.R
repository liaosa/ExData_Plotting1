setwd("I:/Data_Science_JH/Exploratory Data Analysis/") ##set  to the correct folder, and the data set is in the subfolder data
if (!file.exists("data")){dir.create("data")}
data<-read.table("./data/household_power_consumption.txt",sep=";",header=T,stringsAsFactors=FALSE)
str(data)
#data$Date
sum(is.na(data))
for (i in 3:(dim(data)[2])) {
      data[,i][data[,i]=="?"] <- NA
      data[,i]<-as.numeric(data[,i])
} 
head(data)
tail(data)

date<-as.Date(data$Date,"%d/%m/%Y");data$Date<-date
# 2007-02-01 and 2007-02-02
start<-"2007-02-01"
stop<-"2007-02-02"
start<-as.Date(start,"%Y-%m-%d")
stop<-as.Date(stop,"%Y-%m-%d")
dat<-data[data$Date <= stop & data$Date >= start,]
tail(dat)
rm(data);rm(date)
##reduced data set in dat
#dat2<-dat
#str(dat)
dtm<-paste(dat$Date,dat$Time)
dtm<-strptime(dtm,"%Y-%m-%d %H:%M:%S")
#dtm
#str(dtm)
#dim(dat)[2]
dat$Dtm<-dtm
#str(dat)

sum(is.na(dat))
#strptime(data$Time,"%H:%M:%S")
summary(dat)


#plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2),mar=c(5,4,1,1))
#subplot1
plot(dat$Dtm, dat$Global_active_power,type="l",xlab="", ylab="Global Active Power")

plot(dat$Dtm, dat$Voltage,type="l",xlab="datetime", ylab="Voltage",yaxt="n")
aty<-c(234,238,242,246)
axis(side=2, at=aty, col.axis="black", las=2)

plot(dat$Dtm, dat$Sub_metering_1,type="l",col="black",xlab="", ylab="Engegy sub metering")
lines(dat$Dtm,dat$Sub_metering_2,type="l",col="red" )
lines(dat$Dtm,dat$Sub_metering_3,type="l",col="blue" )
legend("topright", lwd=1,col = c("black", "red","blue"),cex=1.0,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty = "n")

plot(dat$Dtm,dat$Global_reactive_power,type="l",col="black",xlab="datetime", ylab="Global_reactive_power")
dev.off()
