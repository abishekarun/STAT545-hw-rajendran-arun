library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(forcats)

gap_data<-read.table(file = 'files/gapminder.tsv', sep = '\t', header = TRUE)
str(gap_data)

#Data preprocessing

gap_data$country<-as.character(gap_data$country)
x<-gap_data[grep("Cote",gap_data$country), ]$country
gap_data[grep("Cote",gap_data$country), ]$country <- "Cote dIvoire"
gap_data$country<-as.factor(gap_data$country)

x<-gsub("\\n.*","",x)
x<-as.data.frame(x)
names(x)<-"country"
x<-separate(x,country,into=c("country","continent","year","lifeExp","pop","gdpPercap"),sep='\t')

#fixing data type of variables in x
x$country<- as.factor(x$country)
x$continent<-as.factor(x$continent)
x$year<-as.integer(x$year)
x$lifeExp<-as.numeric(x$lifeExp)
x$pop<-as.integer(x$pop)
x$gdpPercap<-as.double(x$gdpPercap)

#Lets merge the two data frames
gap_clean_data<-suppressWarnings(
                  suppressMessages(
                    full_join(gap_data,x) %>% arrange(country,year)
                    ))
#Modifying typeof of continent and country variable
gap_clean_data$continent<-as.factor(gap_clean_data$continent)                 
gap_clean_data$country<-as.factor(gap_clean_data$country)
 
boxplot <- ggplot(gap_clean_data,aes(x=continent,y=lifeExp))+
              geom_boxplot()+
              scale_y_log10()

m <- ggplot(gap_clean_data,aes(lifeExp))

hist_plot <- m + geom_histogram(binwidth=0.5)+ scale_x_log10() #Histogram plot
density_plot <- m + scale_x_log10() + geom_density(kernel="gaussian") #density plot
freq_plot <- m + scale_x_log10() + geom_freqpoly(binwidth=0.5) #freq poly plot

gap_clean_data$continent%>% 
  levels()%>%
  head()

gap_reordered <- gap_clean_data
gap_reordered$continent <- fct_reorder(gap_clean_data$continent, gap_clean_data$lifeExp, mean,.desc = TRUE) 

gap_reordered$continent%>% 
              levels()%>%
              head()

gap_reordered%>%
  group_by(continent)%>%
  summarize(mean_lifeExp=mean(lifeExp))%>%
  dplyr::arrange(desc(mean_lifeExp))

saveRDS(gap_reordered,"files/gapminder_reordered.rds")


