library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)

# download stock data
download <-function(stock,from="2010-01-01"){
	df<-getSymbols(stock,from=from,env=environment(),auto.assign=FALSE)
	names(df)<-c("Open","High","Low","Close","Volume","Adjusted")
	write.zoo(df,file=paste(stock,".csv",sep=""),sep=",",quote=FALSE)
	}

# read stock data from CSV
read <-function(stock){  
	as.xts(read.zoo(file=paste(stock,".csv",sep=""),header = TRUE,sep=",", format="%Y-%m-%d"))
}

# download and read IBM stock data
stock <- "IBM"
download(stock,from="2010-01-01")
IBM <- read(stock)

# inspect data
class(IBM)
head(IBM)

# chart stock data
chartSeries(IBM)
chartSeries(IBM,TA = "addVo(); addSMA(); addEnvelope();addMACD(); addROC()")

# calculate moving averages
ma <- function(cdata, mas = c(5,20,60))
{
	ldata <- cdata
	for(m in mas)
	{
		ldata <- merge(ldata,SMA(cdata,m))
	}
	ldata <- na.locf(ldata, fromLast = TRUE)
	names(ldata) <- c("Value",paste("ma",mas,sep=""))
	return(ldata)
}

# plot moving averages
drawLine <- function(ldata, title = "Stock_MA", sData = min(index(ldata))
	,eDate = max(index(ldata)), out = FALSE)
{
	g <- ggplot(aes(x = Index, y = Value), data = fortify(ldata[,1], melt=TRUE))
	g <- g + geom_line()
	g <- g + geom_line(aes(colour = Series), data = fortify(ldata[,-1],melt=TRUE))
	g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
	g<-g+xlab("") + ylab("Price")+ggtitle(title)

	if(out) ggsave(g,file=paste(titie,".png",sep=""))
	else g
}	

# calculate moving averages and plot
cdata <- IBM[,"Close"]
ldata  <- ma(cdata, c(5,30,60))
title <- "Stock IBM"
sDate <-as.Date(min(index(ldata)))
eDate <- as.Date(max(index(ldata)))
drawLine(ldata,title,sDate,eDate)