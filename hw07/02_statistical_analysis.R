library(ggplot2)
library(broom)
library(purrr)

gap_data<-readRDS("files/gapminder_reordered.rds")

#check if continent order is still present

gap_data$continent%>% 
  levels()%>%
  head()

lin_fit<- function(data){
  fit<- lm(lifeExp ~ year,data)
  data.frame(t(coef(fit)),
             summary(fit)$sigma,
             summary(fit)$sigma**2,
             summary(fit)$r.squared
             )%>%
    setNames(c("intercept","slope","Res_Err_Std",
               "Res_Err_Variance","R_squared"))
}

fitted_result<- gap_data %>%
        group_by(country, continent) %>%
        do(lin_fit(.))
saveRDS(fitted_result,"files/fitted_data.rds")

# Oceania has only two countries.So lets omit this and 
# find the best and worst countries in other continents.

fitted_result<- fitted_result%>%
                    filter(continent != "Oceania")

###Normalize the R_squared values and Res_Err_std to get worst & best countries 
fitdata_norm <- fitted_result%>%
                    group_by(continent)%>%
                    mutate(R2_norm = R_squared/max(R_squared))%>%
                    mutate(std_norm = Res_Err_Std/max(Res_Err_Std))%>%
                    arrange(continent)

###Best countries for each continent
best_countries <- 
  fitdata_norm%>%
      group_by(continent)%>%
      filter(R2_norm > 0.997 & std_norm < 0.25)%>%
      arrange(continent)

###Worst countries for each continent
worst_countries <- 
  fitdata_norm%>%
      group_by(continent)%>%
      filter(
        (continent !="Africa" & R2_norm < 0.85 & std_norm > 0.5)|
        (continent =="Africa" & R2_norm < 0.06 & std_norm > 0.5)  
        # Different Threshold for africa as it is poorly fit by the lm model
        )%>%
      arrange(continent)


########Figures######################
saveplot<-function(x){
    
 continent_plot <- 
   gap_data%>%
        filter(continent == x)%>%
        ggplot(aes(year,lifeExp))+
        geom_point()+
        geom_smooth(method = "lm", se = FALSE)+
        facet_wrap(~country)+
        ggtitle(paste('lifeExp_vs_year_for_',x,sep = ""))
    
  ggsave(paste('lifeExp_vs_year_for_',x,'.jpeg',sep = ""),plot = continent_plot,path='files\\')
  
}
map(as.list(levels(gap_data$continent)),saveplot)
