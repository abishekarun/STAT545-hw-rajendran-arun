#########Prompt 1
## Part 2

# install.packages("devtools")
# require(devtools)
# install.packages("rjson")
# install_github("ropensci/geonames")
# options(geonamesUsername=yourusername)

library(geonames)
library(dplyr)
library(gapminder)
library(ggplot2)
library(downloader)
library(stringr)
library(forcats)
library(tidyr)
library(countrycode)

gapminder$countryCode <- countrycode(gapminder$country,
                                     origin = "country.name",
                                     destination = "iso2c")
geonames <- GNcountryInfo()%>%
                      select("countryCode","areaInSqKm")

gap_final <- left_join(gapminder,geonames,by="countryCode")
gap_final$areaInSqKm<-as.numeric(gap_final$areaInSqKm)

gap_final <- gap_final%>%
                group_by(country)%>%
                mutate(pop_density = pop/areaInSqKm)

gap_final%>%
  filter(continent != "Oceania")%>%
  ggplot(aes(x = year, y = pop_density, group = country, color = country)) +
  geom_line(lwd = 1, show.legend = FALSE) + facet_wrap(~ continent) +
  scale_color_manual(values = country_colors) + theme_bw() +
  theme(strip.text = element_text(size = rel(1.1))) + 
  scale_y_log10() +
  ggtitle("Log Population Density across Continents in 1952-2007") +
  xlab("Year") + 
  ylab("Population Density")
ggsave("plots/prompt1part2.png")

## Part 1
## Download and load urban pop excel file
url_urban_pop <- "http://docs.google.com/spreadsheet/pub?key=pyj6tScZqmEfH89V6UQhpZA&output=csv"
download(url = url_urban_pop,destfile = "data/urban_pop_orig.csv")

urban_pop <- read.csv("data/urban_pop_orig.csv")

col_names <- colnames(urban_pop) %>%
  str_replace("Urban.population","country") %>%
  str_replace("^X","")

# Set the cleaned column names
colnames(urban_pop) <- col_names

urban_pop <- urban_pop[,c("country",seq(1962,2007,5))]

urban_pop <- urban_pop%>%
                gather(year,urban_population,c(2:11))%>%                
                arrange(country)%>%
                na.omit()

urban_pop$year <- as.integer(urban_pop$year)
  
gap_final <- gap_final%>%
  filter(year %in% c(1962:2007))

gap_final <- left_join(gap_final,urban_pop,by=c("country","year"))

gap_final <- gap_final%>%
                  mutate(urban_pop_ratio = urban_population/pop)

gap_final%>%
  ggplot(aes(x = urban_population , y = gdpPercap, group = country, color = country)) +
    geom_line(lwd = 1, show.legend = FALSE) + facet_wrap(~ continent) +
    scale_color_manual(values = country_colors) + theme_bw() +
    theme(strip.text = element_text(size = rel(1.1))) +
    scale_y_log10()+
    scale_x_log10()+
    ggtitle("GdpPercap vs Urban pop in 1962-2007(log-log scale)") +
    xlab("Urban Population") + 
    ylab("GdpPercap")
ggsave("plots/prompt1part1.png")

######## Prompt 2

# devtools::install_github("ropensci/rebird")
library(rebird)
# devtools::install_github("ropensci/rplos")
library(rplos)

bird_data <- ebirdfreq("counties", "CA-BC-GV", 1900,2016, 1, 12)%>%arrange(desc(frequency))

# query <- noquote()

# For second most frequent bird species, namely song sparrow we search the results from rplos

df <- tibble(species_name=character(),title=character(),abstract=character())

get_df <- function(x){
(out <- highplos(q=paste("\'",shQuote(x),"~0\'"),
                 hl.fl = 'title,abstract',
                 fq='doc_type:full',
                 row=100))
out <- compact(out)

results <- tibble(
          species_name = rep(paste(x),length(out)),
          title = map(out,"title"),
          abstract = map(out, "abstract")
        )
results$title <- gsub("<.*?>", "",results$title)
results$abstract <- gsub("<.*?>", "",results$abstract)
return(results)
}

df <- lapply(unique(bird_data$comName)[1:50],get_df)%>%
                                            bind_rows()
df$title <- as.character(df$title)

df <- df%>% filter(df$title != "NULL")

saveRDS(df,'data/prompt2_wrap_api.rds')

df$species_name <- fct_infreq(df$species_name)
ggplot(data=df,aes(species_name))+
  geom_bar()+
  theme_bw()+
  ggtitle("Plot of Articles on each bird species")+
  xlab("Bird Species Name")+
  ylab("Count")+
  theme(
    plot.title = element_text(hjust = 0.5,vjust=1,color = "red",
                              size="18",face="bold.italic"),
    axis.title.x = element_text(color="green", size=12, face="bold"),
    axis.title.y = element_text(color="grey", size=14, face="bold"),
    axis.text.x = element_text(angle = 90,vjust=0.5,hjust=1),
    legend.position = c(0.9,0.1)
  )
ggsave('plots/articles_bird.png')
