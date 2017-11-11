# hw06_task6.Rmd


```r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(broom))
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(robustbase))
suppressPackageStartupMessages(library(MASS))
options(knitr.table.format = "markdown")
```

Lets update the theme of ggplot to make title of all plots centered.

```r
theme_update(plot.title = element_text(hjust = 0.5))
```

####Task 6 Work with a nested Data frame

Lets define the functions for simple linear regression **le_lin_fit()** and robust regression such as **le_rlm_fit()**.

```r
le_lin_fit <- function(data,offset = 1952){
    fit <- lm(lifeExp ~ I(year - offset), data)
}

le_rlm_fit <- function(data,offset = 1952){
    fit <- rlm(lifeExp ~ I(year - offset), data,method="M",maxit=40)
}
```

Now, Lets create the nested data frame from gapminder dataset


```r
(gap_nested <- gapminder %>% 
   group_by(continent, country) %>% 
   nest())
```

```
## # A tibble: 142 x 3
##    continent     country              data
##       <fctr>      <fctr>            <list>
##  1      Asia Afghanistan <tibble [12 x 4]>
##  2    Europe     Albania <tibble [12 x 4]>
##  3    Africa     Algeria <tibble [12 x 4]>
##  4    Africa      Angola <tibble [12 x 4]>
##  5  Americas   Argentina <tibble [12 x 4]>
##  6   Oceania   Australia <tibble [12 x 4]>
##  7    Europe     Austria <tibble [12 x 4]>
##  8      Asia     Bahrain <tibble [12 x 4]>
##  9      Asia  Bangladesh <tibble [12 x 4]>
## 10    Europe     Belgium <tibble [12 x 4]>
## # ... with 132 more rows
```

Lets view the first row of the data 

```r
gap_nested[[1, "data"]]%>%
   kable()
```



| year| lifeExp|      pop| gdpPercap|
|----:|-------:|--------:|---------:|
| 1952|  28.801|  8425333|  779.4453|
| 1957|  30.332|  9240934|  820.8530|
| 1962|  31.997| 10267083|  853.1007|
| 1967|  34.020| 11537966|  836.1971|
| 1972|  36.088| 13079460|  739.9811|
| 1977|  38.438| 14880372|  786.1134|
| 1982|  39.854| 12881816|  978.0114|
| 1987|  40.822| 13867957|  852.3959|
| 1992|  41.674| 16317921|  649.3414|
| 1997|  41.763| 22227415|  635.3414|
| 2002|  42.129| 25268405|  726.7341|
| 2007|  43.828| 31889923|  974.5803|
Each row of gap_nested data frame has a data frame nested in the data column.

Lets apply the linear regression function we had defined earlier to the first entry of data in gap_nested data frame. 

```r
le_lin_fit(gap_nested[[1, "data"]])
```

In order to get this for the entire column, we need to use map and mutate function

```r
(gap_nested <- gap_nested %>% 
   mutate(fit = map(data, le_rlm_fit)))
```

```
## # A tibble: 142 x 4
##    continent     country              data       fit
##       <fctr>      <fctr>            <list>    <list>
##  1      Asia Afghanistan <tibble [12 x 4]> <S3: rlm>
##  2    Europe     Albania <tibble [12 x 4]> <S3: rlm>
##  3    Africa     Algeria <tibble [12 x 4]> <S3: rlm>
##  4    Africa      Angola <tibble [12 x 4]> <S3: rlm>
##  5  Americas   Argentina <tibble [12 x 4]> <S3: rlm>
##  6   Oceania   Australia <tibble [12 x 4]> <S3: rlm>
##  7    Europe     Austria <tibble [12 x 4]> <S3: rlm>
##  8      Asia     Bahrain <tibble [12 x 4]> <S3: rlm>
##  9      Asia  Bangladesh <tibble [12 x 4]> <S3: rlm>
## 10    Europe     Belgium <tibble [12 x 4]> <S3: rlm>
## # ... with 132 more rows
```

Lets use augment function from broom package on the data.

```r
augment(gap_nested$fit[[1]])
```

```
##    lifeExp I.year...offset.  .fitted   .se.fit      .resid       .hat
## 1   28.801                0 29.90729 0.8285128 -1.10629487 0.29487179
## 2   30.332                5 31.28394 0.7236318 -0.95193823 0.22494172
## 3   31.997               10 32.66058 0.6272244 -0.66358159 0.16899767
## 4   34.020               15 34.03722 0.5438163 -0.01722494 0.12703963
## 5   36.088               20 35.41387 0.4802290  0.67413170 0.09906760
## 6   38.438               25 36.79051 0.4450414  1.64748834 0.08508159
## 7   39.854               30 38.16716 0.4450414  1.68684499 0.08508159
## 8   40.822               35 39.54380 0.4802290  1.27820163 0.09906760
## 9   41.674               40 40.92044 0.5438163  0.75355828 0.12703963
## 10  41.763               45 42.29709 0.6272244 -0.53408508 0.16899767
## 11  42.129               50 43.67373 0.7236318 -1.54472844 0.22494172
## 12  43.828               55 45.05037 0.8285128 -1.22237179 0.29487179
##      .sigma
## 1  1.211813
## 2  1.237512
## 3  1.265886
## 4  1.288917
## 5  1.267003
## 6  1.154002
## 7  1.147076
## 8  1.208243
## 9  1.260583
## 10 1.274051
## 11 1.148593
## 12 1.194109
```

Now lets apply this to the full data frame

```r
gap_nested <- gap_nested %>% 
                mutate(augment = map(fit, augment))
```

Now lets simplify to the normal data frame by keeping necessary variables and using unnest().

```r
(gap_coefs <- 
   gap_nested %>% 
      dplyr::select(continent,country,augment) %>% 
      unnest(augment))
```

```
## # A tibble: 1,704 x 9
##    continent     country lifeExp I.year...offset.  .fitted   .se.fit
##       <fctr>      <fctr>   <dbl>            <dbl>    <dbl>     <dbl>
##  1      Asia Afghanistan  28.801                0 29.90729 0.8285128
##  2      Asia Afghanistan  30.332                5 31.28394 0.7236318
##  3      Asia Afghanistan  31.997               10 32.66058 0.6272244
##  4      Asia Afghanistan  34.020               15 34.03722 0.5438163
##  5      Asia Afghanistan  36.088               20 35.41387 0.4802290
##  6      Asia Afghanistan  38.438               25 36.79051 0.4450414
##  7      Asia Afghanistan  39.854               30 38.16716 0.4450414
##  8      Asia Afghanistan  40.822               35 39.54380 0.4802290
##  9      Asia Afghanistan  41.674               40 40.92044 0.5438163
## 10      Asia Afghanistan  41.763               45 42.29709 0.6272244
## # ... with 1,694 more rows, and 3 more variables: .resid <dbl>,
## #   .hat <dbl>, .sigma <dbl>
```

Now lets obtain the mean of each column for all the countries.

```r
gap_coefs <- aggregate(gap_coefs[, 3:9], list(gap_coefs$country), mean)%>%
              dplyr::select(Group.1,lifeExp,.se.fit,.resid,.sigma)%>%
              rename(country=Group.1,
                     meanLifeExp=lifeExp,
                     meanResidual=.resid,
                     meanResStdDev=.sigma,
                     meanStdError=.se.fit)
```

Lets identify the ratio of residuals for the different countries to identify the coutries with large residuals.


```r
gap_coefs%>%
  mutate(res_ratio = meanResidual/max(meanResidual))%>%
  filter(abs(res_ratio)>5)%>%  #threshold value
   kable()
```



|country      | meanLifeExp| meanStdError| meanResidual| meanResStdDev|  res_ratio|
|:------------|-----------:|------------:|------------:|-------------:|----------:|
|Bulgaria     |    69.74375|    0.5170167|   -0.5191047|      2.676081|  -6.333087|
|Cambodia     |    47.90275|    0.1664883|   -1.8609248|      5.958605| -22.703316|
|Lesotho      |    50.00708|    1.4764061|   -1.1947864|      6.362715| -14.576415|
|Mauritius    |    64.95325|    0.2303913|   -0.4330294|      1.888204|  -5.282967|
|Rwanda       |    41.48158|    1.0375338|   -1.7245348|      6.924673| -21.039355|
|South Africa |    53.99317|    0.9290181|   -1.2788164|      5.348421| -15.601583|
|Swaziland    |    49.00242|    1.7207919|   -1.3519535|      7.116450| -16.493856|

This shows that these seven countries have larger residuals(absolute value) compared to other countries. Therefore our model doesnt fit these seven countries properly.

Lets get the number of countries with positive and negative residuals

```r
gap_coefs%>%
  filter(meanResidual>0)%>%
  count()
```

```
## # A tibble: 1 x 1
##       n
##   <int>
## 1    19
```

```r
gap_coefs%>%
  filter(meanResidual<0)%>%
  count()
```

```
## # A tibble: 1 x 1
##       n
##   <int>
## 1   122
```

This shows that only 1 countries have mean residuals greater than zero. Remaining 122 countries have mean residual less than zero.

#### Interesting countries


Now lets fit the rlm model for lifExp vs year on gapminder dataset

```r
gap_nested2 <- gapminder %>% 
                   group_by(continent, country) %>% 
                   nest() %>% 
                   mutate(fit1 = map(data, le_lin_fit))%>%
                   mutate(tidy1 = map(fit1, tidy))%>%
                   unnest(tidy1)%>%
                   mutate(term = recode(term,
                        `(Intercept)` = "lm_intercept",
                        `I(year - offset)` = "lm_slope"))%>% 
                   dplyr::select(continent:estimate) %>% 
                   spread(key = term, value = estimate)
```

Now lets fit the lm model for lifExp vs year on gapminder dataset

```r
gap_nested3 <- gapminder %>% 
                   group_by(continent, country) %>% 
                   nest() %>% 
                   mutate(fit2 = map(data, le_rlm_fit))%>%
                   mutate(tidy2 = map(fit2,tidy))%>%
                   unnest(tidy2)%>%
                   mutate(term = recode(term,
                        `(Intercept)` = "rlm_intercept",
                        `I(year - offset)` = "rlm_slope"))%>% 
                   dplyr::select(continent:estimate) %>% 
                   spread(key = term, value = estimate)
```

Now, lets obtain the difference in parameters estimated by these models and find the interesting countries where the difference is large.

```r
df<-left_join(gap_nested2,gap_nested3,by=c("country","continent"))
df%>%
  mutate(dif_intercept=lm_intercept - rlm_intercept)%>%
  mutate(dif_slope= lm_slope - rlm_slope)%>%
  filter(abs(dif_slope) > 0.05 | abs(dif_intercept) > 1 )%>% #threshold value 
  kable()
```



|continent |country      | lm_intercept|   lm_slope| rlm_intercept| rlm_slope| dif_intercept|  dif_slope|
|:---------|:------------|------------:|----------:|-------------:|---------:|-------------:|----------:|
|Africa    |Lesotho      |     47.37903|  0.0955657|      45.66416| 0.2013714|     1.7148692| -0.1058057|
|Africa    |Mauritius    |     55.37077|  0.3484538|      56.79888| 0.3122690|    -1.4281125|  0.0361848|
|Africa    |Rwanda       |     42.74195| -0.0458315|      42.31571| 0.0323785|     0.4262397| -0.0782100|
|Africa    |South Africa |     49.34128|  0.1691594|      47.52225| 0.2818087|     1.8190369| -0.1126492|
|Africa    |Swaziland    |     46.38786|  0.0950748|      44.51766| 0.2122439|     1.8701954| -0.1171691|
|Asia      |Cambodia     |     37.01542|  0.3959028|      39.54134| 0.3717213|    -2.5259164|  0.0241815|
|Europe    |Bulgaria     |     65.73731|  0.1456888|      67.57414| 0.0977715|    -1.8368321|  0.0479174|

These seven countries are the interesting countries as the difference is predominant(above the threshold manually chosen by trial and error ) in these countries. These countries can be further investigated. 

#### Linear vs Quadratic fit comparison

Lets use anova function to compare the two models, linear fit and quadratic fit for lifeExp against year of gapminder data.

```r
fit1 <- lm(lifeExp~year,gapminder)
coef(fit1)
```

```
##  (Intercept)         year 
## -585.6521874    0.3259038
```

```r
fit2 <- lm(lifeExp~poly(year,2),gapminder)
coef(fit2)
```

```
##    (Intercept) poly(year, 2)1 poly(year, 2)2 
##       59.47444      232.20505      -37.89723
```

```r
anova(fit1,fit2,test="Chisq")
```

```
## Analysis of Variance Table
## 
## Model 1: lifeExp ~ year
## Model 2: lifeExp ~ poly(year, 2)
##   Res.Df    RSS Df Sum of Sq Pr(>Chi)   
## 1   1702 230229                         
## 2   1701 228793  1    1436.2 0.001084 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The very low p-value (0.001084) shows that the two models are widely different. The value of RSS (residual sum of squares) is minium for quadratic fit (model 2) and this shows that the quadratic fit is better in this case. 

#### Reference:
+ [Stack Exchange](https://stats.stackexchange.com/questions/53312/comparing-two-models-using-anova-function-in-r)
+ [Fitting polynomial regression](https://www.r-bloggers.com/fitting-polynomial-regression-in-r/)
