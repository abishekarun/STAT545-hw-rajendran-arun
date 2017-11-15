source('00_download_data.R')
source('01_exploratory_analysis.R')
source('02_statistical_analysis.R')

rmarkdown::render('03_report.Rmd',output_format = "pdf_document")

unlink("03_report_files/*")
#do.call(file.remove, list(list.files("C:/Temp", full.names = TRUE)))