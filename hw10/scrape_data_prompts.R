library(tidyverse)
library(magrittr)
library(glue)
library(stringr)
library(purrr)

library(xml2)
library(rvest)


get_lyrics <- function(lyr_link){
  lyr_link%>%
    read_html()%>%
    html_nodes(css=".mxm-lyrics__content")%>% 
    html_text()%>%
    collapse(sep="\n")%>%
    return ()
}

get_lyrics_safe <- possibly(
  function(link)get_lyrics(link), 
  otherwise = "None Available",
  quiet = TRUE)

artist_list<- c("Eminem","Katy Perry","Maroon 5")
page_no <- c(1:20)

get_artistwise_lyrics<-function(x,y){
  x <- gsub(" ","-",x,fixed = TRUE)
  my_url <- paste0("https://www.musixmatch.com/artist/",x,"/",y)
  page_title <- read_html(my_url)
  results<-data_frame(Band=paste0(x),
                      title= page_title%>%
                        html_nodes(css=".title")%>% 
                        html_text(),
                      url_add=page_title%>%
                        html_nodes(css=".title")%>%
                        html_attr('href'),
                      Link=glue('https://www.musixmatch.com{url_add}')%>%
                        str_replace_all(" ","-"),
                      Lyrics = map(Link,get_lyrics_safe))%>%
                      unnest()
  return(results)  
}

#get_artistwise_lyrics("Katy Perry",2)%>%View()
artist_list_mod <- expand.grid(artist_list,page_no)$Var1
page_no_mod <- expand.grid(artist_list,page_no)$Var2

results<- map2(artist_list_mod,page_no_mod,get_artistwise_lyrics)

output <- data.table::rbindlist(results)

output$Band <- as.factor(output$Band)

output_mod <- output%>%
                  group_by(Band)%>%
                  subset(!duplicated(Link))

table(output_mod$Band)

saveRDS(output_mod,'data/musix_match_results.rds')

ggplot(output_mod,aes(Band))+
  geom_bar(stat="count",fill="blue")
ggsave("plots/musix_result.png")

