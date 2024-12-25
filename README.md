# Overview

This repository contains an example R script that demonstrates fluency in using R for financial data analysis and visualization. The purpose of this code is **not for production use**, but to illustrate capabilities with R packages such as `plyr`, `quantmod`, `TTR`, `ggplot2`, and `scales`. The script fetches stock market data, processes it, and creates visualizations to analyze moving averages and other technical indicators.

## Features

- Download historical stock data using the `quantmod` package.
- Save and read stock data to/from CSV files.
- Visualize stock price trends using technical indicators such as:
  - Moving averages (SMA)
  - Envelopes
  - MACD
  - Rate of Change (ROC)
- Plot stock price and moving averages using `ggplot2`.

## Prerequisites

Ensure you have the following R libraries installed:

```R
install.packages(c("plyr", "quantmod", "TTR", "ggplot2", "scales"))
```

## How to Use

1. Download Historical Stock Data

- Modify the `stock` variable to the desired stock ticker (e.g., `"AAPL"` for Apple, `"IBM"` for IBM).
- Call the `download()` function to fetch stock data from Yahoo Finance and save it as a CSV.

```R
stock <- "IBM"
download(stock, from = "2010-01-01")
```

2. Read Saved Stock Data

- Load the downloaded CSV into an `xts` object using the `read()` function.

```R
IBM <- read(stock)
```

3. Explore Data

- View the structure and first few rows of the data.

```R
class(IBM)
head(IBM)
```

4. Plot Stock Data with Technical Indicators

- Visualize stock data using `chartSeries()` with a variety of indicators.

```R
chartSeries(IBM, TA = "addVo(); addSMA(); addEnvelope(); addMACD(); addROC()")
```

5. Moving Average Analysis

- Generate moving averages for a given set of periods using the `ma()` function.

```R
cdata <- IBM[,"Close"]
ldata <- ma(cdata, c(5, 30, 60))
```

6. Custom Visualization with ggplot2

- Use the `drawLine()` function to create a customized plot of stock prices and moving averages.

```R
title <- "Stock IBM"
sDate <- as.Date(min(index(ldata)))
eDate <- as.Date(max(index(ldata)))
drawLine(ldata, title, sDate, eDate)
```

- To save the plot as a PNG file, set the `out` parameter to `TRUE`.

```R
drawLine(ldata, title, sDate, eDate, out = TRUE)
```

