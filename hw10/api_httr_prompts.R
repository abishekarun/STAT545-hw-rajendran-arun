library(httr)
library(tidyverse)
library(magrittr)
library(glue)
library(stringr)
library(purrr)
library(ggplot2)
library(forcats)

# key <-  api_key
get_movie_TY <- function(title,year){
  title<-gsub(" ", "+", title, fixed = TRUE)
  query_string <- 
    glue("http://www.omdbapi.com/?t={title}&y={year}&apikey={key}")
  movie_result<- httr::GET(query_string)
  movie_content <- content(movie_result)
  return(movie_content)
}

list_of_movies <- list(
  "Baby Driver","Interstellar",
  "the shawshank redemption",
  "Pulp Fiction",
  "Se7en","Fight Club",
  "The Matrix","Gladiator",
  "The Godfather","The Dark Knight",
  "12 Angry Men","Schindler's List ",
  "Forrest Gump","Inception",
  "The Usual Suspects"
)
release_years <- list(
  "2017","2014",
  "1994",
  "1994",
  "1995","1999",
  "1999","2000",
  "1972","2008",
  "1957","1993",
  "1994","2010",
  "1995"
)

output <- map2(list_of_movies,release_years,function(x,y)get_movie_TY(x,y))

results <- as.data.frame(t(as.data.frame(sapply(output, unlist))))

names(results)[15] <- "Ratings.Source1"
names(results)[17] <- "Ratings.Source2"
names(results)[19] <- "Ratings.Source3"

names(results)[16] <- "Ratings.Value1"
names(results)[18] <- "Ratings.Value2"
names(results)[20] <- "Ratings.Value3"
results <-   
    results%>%
      spread(Ratings.Source1,Ratings.Value1)%>%
      spread(Ratings.Source2,Ratings.Value2)%>%
      spread(Ratings.Source3,Ratings.Value3)

names(results) <- map(names(results),function(x)gsub(" ", "_",x,fixed = TRUE)) 

results$Rotten_Tomatoes<- gsub("%","",results$Rotten_Tomatoes,fixed=TRUE)
results$Internet_Movie_Database<-gsub("/10","",results$Internet_Movie_Database,
                                      fixed=TRUE)
results$Metacritic<-gsub("/100","",results$Metacritic,
                         fixed=TRUE)

results$Rotten_Tomatoes<-as.numeric(results$Rotten_Tomatoes)
results$Internet_Movie_Database<-as.numeric(results$Internet_Movie_Database)
results$Metacritic<-as.numeric(results$Metacritic)


plot<-function(dataFrame,xvalue,yvalue){
  
  ggplot(data=dataFrame,aes_string(x= paste("fct_reorder(",xvalue,",",yvalue,",.desc=TRUE)"),
                                   y= yvalue))+
    geom_bar(stat = "identity")+
    theme_bw()+
    ggtitle(paste("Plot of Ratings from",gsub("_"," ",yvalue,fixed = TRUE)))+
    xlab("Movie Name")+
    ylab(paste(gsub("_"," ",yvalue,fixed = TRUE)))+
    theme(
      plot.title = element_text(hjust = 0.5,vjust=1,color = "red",
                                size="18",face="bold.italic"),
      axis.title.x = element_text(color="green", size=12, face="bold"),
      axis.title.y = element_text(color="grey", size=14, face="bold"),
      axis.text.x = element_text(angle = 90,vjust=0.5,hjust=1),
      legend.position = c(0.9,0.1)
    )
}

plot(results,"Title","Internet_Movie_Database")
ggsave("plots/imdb.png")
plot(results,"Title","Rotten_Tomatoes")
ggsave("plots/rotten_tomatoes.png")
plot(results,"Title","Metacritic")
ggsave("plots/metacritic.png")
