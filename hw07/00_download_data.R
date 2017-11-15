# Download the raw data
library(downloader)
download(url = "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv", 
         destfile = "files/gapminder.tsv")
