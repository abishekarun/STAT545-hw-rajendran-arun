hw05\_gapminder.Rmd
================

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(dplyr))
options(knitr.table.format = "html")
```

``` r
tableFormat<-function(table,title=""){
  table %>%      
    kable("html",caption=title, align=c(rep('c', 5))) %>%
    kable_styling(bootstrap_options = 
                    c("striped", "hover",  "responsive"),
                  position="center",font_size=14)
}
```

Lets update the theme of ggplot to make title of all plots centered.

``` r
theme_update(plot.title = element_text(hjust = 0.5))
```

Task 1
------

### Factor Management

#### Gapminder version

First lets load the gapminder dataset

``` r
suppressPackageStartupMessages(library(gapminder))
```

Now lets drop the continent oceania

``` r
gap_dropped<-subset(gapminder,continent!="Oceania")
```

Now we have two datasets. The original gapminder dataset and the gap\_dropped with "Oceania" dropped.

Lets check the dimensions of both the datasets

``` r
dim(gapminder)
```

    ## [1] 1704    6

``` r
dim(gap_dropped)
```

    ## [1] 1680    6

So ,it shows that 24 entries belong to continent "Oceania". Lets check if this is indeed true.

``` r
nrow(gapminder[gapminder$continent=="Oceania",])
```

    ## [1] 24

Now lets check the levels of factor country in both the datasets.

``` r
length(levels(gapminder$country))
```

    ## [1] 142

``` r
length(levels(gap_dropped$country))
```

    ## [1] 142

This shows that some factor levels are remaining even though they are unused in gap\_dropped. Lets remove this using droplevels() function from base R.

``` r
length(levels(droplevels(gap_dropped$country)))
```

    ## [1] 140

Thus two levels of country corrosponding to Australia and New Zealand are dropped in the gap\_dropped.

*This can be done in a couple of other ways.*

1.  **Base R** We can factorize the column after subsetting the data frame.

``` r
length(levels(gap_dropped$continent))
```

    ## [1] 5

``` r
gap_dropped$continent<-factor(gap_dropped$continent)
#gap_dropped$continent<-as.factor(as.character(gap_dropped$continent))

length(levels(gap_dropped$continent))
```

    ## [1] 4

Thus the levels for factor variable continent in gap\_dropped is changed.

1.  \***gdata package** Dropping of levels can be done for all the variables at once using drop.levels() function from gdata package.

``` r
suppressPackageStartupMessages(library(gdata))

gapminder[gapminder$continent!="Oceania",]%>%
  drop.levels()%>%
  sapply(nlevels)
```

    ##   country continent      year   lifeExp       pop gdpPercap 
    ##       140         4         0         0         0         0

1.  **forcats package** Dropping of levels can be done using droplevels() function in forcats() package. &gt; The base function droplevels() operates on all the factors in a data frame or on a single factor. The function forcats::fct\_drop() operates on a factor.

``` r
suppressPackageStartupMessages(library(forcats))

gapminder[gapminder$continent!="Oceania",]$continent%>%
  fct_drop() %>%
  nlevels()
```

    ## [1] 4

``` r
gapminder[gapminder$continent!="Oceania",]%>%
  droplevels()%>%
  sapply(nlevels)
```

    ##   country continent      year   lifeExp       pop gdpPercap 
    ##       140         4         0         0         0         0

#### Reordering levels of factor variables

##### Continent Variable

**First, lets reorder levels of continent variable by frequency.**

We order continent by frequency, forwards and backwards.

``` r
fct_count(gapminder$continent)
```

    ## # A tibble: 5 × 2
    ##          f     n
    ##     <fctr> <int>
    ## 1   Africa   624
    ## 2 Americas   300
    ## 3     Asia   396
    ## 4   Europe   360
    ## 5  Oceania    24

``` r
## order by frequency (highest first)
gapminder$continent %>% 
  fct_infreq()%>% 
  levels()
```

    ## [1] "Africa"   "Asia"     "Europe"   "Americas" "Oceania"

``` r
## backwards!
gapminder$continent %>% 
  fct_infreq() %>%
  fct_rev() %>% 
  levels()
```

    ## [1] "Oceania"  "Americas" "Europe"   "Asia"     "Africa"

Now we order continent by another variable forwards and backwards. Lets use different summarizing function such as mean,median, minimum value.

``` r
#order by median of lifeExp
fct_reorder(gapminder$continent, gapminder$lifeExp) %>% 
  levels()
```

    ## [1] "Africa"   "Asia"     "Americas" "Europe"   "Oceania"

``` r
#order by min of gdpPercap
fct_reorder(gapminder$continent, gapminder$gdpPercap, min) %>% 
  levels()
```

    ## [1] "Africa"   "Asia"     "Europe"   "Americas" "Oceania"

``` r
#backwards
fct_reorder(gapminder$continent, gapminder$lifeExp,.desc=TRUE) %>% 
  levels()
```

    ## [1] "Oceania"  "Europe"   "Americas" "Asia"     "Africa"

Now lets reorder country levels based on mean of population variable

``` r
fct_reorder(gapminder$country, gapminder$pop, mean) %>% 
  levels()%>%
  head()
```

    ## [1] "Sao Tome and Principe" "Iceland"               "Djibouti"             
    ## [4] "Equatorial Guinea"     "Comoros"               "Bahrain"

#### Importance of reordering with plots

Lets understand the importance of reordering the factor variables by plotting mean population of each country in Americas continent with and without reordering the factor variable.

``` r
h_gap <- gapminder%>%
           filter(continent=="Americas")%>%
           group_by(country)%>%
           summarize(mean_pop=mean(pop))%>%
           arrange(mean_pop)

tableFormat(h_gap,"Mean Population of Countries in America")
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Mean Population of Countries in America
</caption>
<thead>
<tr>
<th style="text-align:center;">
country
</th>
<th style="text-align:center;">
mean\_pop
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Trinidad and Tobago
</td>
<td style="text-align:center;">
1006470
</td>
</tr>
<tr>
<td style="text-align:center;">
Panama
</td>
<td style="text-align:center;">
1985290
</td>
</tr>
<tr>
<td style="text-align:center;">
Jamaica
</td>
<td style="text-align:center;">
2135123
</td>
</tr>
<tr>
<td style="text-align:center;">
Costa Rica
</td>
<td style="text-align:center;">
2400008
</td>
</tr>
<tr>
<td style="text-align:center;">
Uruguay
</td>
<td style="text-align:center;">
2912487
</td>
</tr>
<tr>
<td style="text-align:center;">
Nicaragua
</td>
<td style="text-align:center;">
3040975
</td>
</tr>
<tr>
<td style="text-align:center;">
Puerto Rico
</td>
<td style="text-align:center;">
3115178
</td>
</tr>
<tr>
<td style="text-align:center;">
Paraguay
</td>
<td style="text-align:center;">
3555486
</td>
</tr>
<tr>
<td style="text-align:center;">
Honduras
</td>
<td style="text-align:center;">
3920593
</td>
</tr>
<tr>
<td style="text-align:center;">
El Salvador
</td>
<td style="text-align:center;">
4343441
</td>
</tr>
<tr>
<td style="text-align:center;">
Haiti
</td>
<td style="text-align:center;">
5401634
</td>
</tr>
<tr>
<td style="text-align:center;">
Bolivia
</td>
<td style="text-align:center;">
5610395
</td>
</tr>
<tr>
<td style="text-align:center;">
Dominican Republic
</td>
<td style="text-align:center;">
5735697
</td>
</tr>
<tr>
<td style="text-align:center;">
Guatemala
</td>
<td style="text-align:center;">
6858695
</td>
</tr>
<tr>
<td style="text-align:center;">
Ecuador
</td>
<td style="text-align:center;">
8212243
</td>
</tr>
<tr>
<td style="text-align:center;">
Cuba
</td>
<td style="text-align:center;">
9232576
</td>
</tr>
<tr>
<td style="text-align:center;">
Chile
</td>
<td style="text-align:center;">
11205725
</td>
</tr>
<tr>
<td style="text-align:center;">
Venezuela
</td>
<td style="text-align:center;">
15129801
</td>
</tr>
<tr>
<td style="text-align:center;">
Peru
</td>
<td style="text-align:center;">
17559093
</td>
</tr>
<tr>
<td style="text-align:center;">
Canada
</td>
<td style="text-align:center;">
24462967
</td>
</tr>
<tr>
<td style="text-align:center;">
Colombia
</td>
<td style="text-align:center;">
27256100
</td>
</tr>
<tr>
<td style="text-align:center;">
Argentina
</td>
<td style="text-align:center;">
28602240
</td>
</tr>
<tr>
<td style="text-align:center;">
Mexico
</td>
<td style="text-align:center;">
68414297
</td>
</tr>
<tr>
<td style="text-align:center;">
Brazil
</td>
<td style="text-align:center;">
122312127
</td>
</tr>
<tr>
<td style="text-align:center;">
United States
</td>
<td style="text-align:center;">
228211233
</td>
</tr>
</tbody>
</table>
**Unordered Plot of Mean pop for Each Country**

``` r
ggplot(h_gap,aes(x=mean_pop,y=country))+
  geom_point(color="blue")+
  theme(
        plot.title = element_text(color="red", size=18, face="bold.italic"),
        axis.title.x = element_text(color="green", size=14,
                                    face="bold",hjust=0.5),
        axis.title.y = element_text(color="#993333", size=14,
                                    face="bold",vjust=0.5),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(angle = 90)
        )+
  scale_x_log10(breaks=c(10^6,5*10^6,10^7,20*10^6,40*10^6,
                         80*10^6,160*10^6,220*10^6),
                labels = function(x) format(x, scientific = FALSE))+
  xlab("Mean Population")+
  ylab("Countries in America")+
  ggtitle("Unordered Plot of Mean Population")
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

**Ordered Plot of Mean pop for Each Country**

``` r
ggplot(h_gap,aes(x=mean_pop,y=fct_reorder(country,mean_pop,.desc = TRUE)))+
  geom_point(color="blue")+
  theme(
        plot.title = element_text(color="red", size=18, face="bold.italic"),
        axis.title.x = element_text(color="green", size=14,
                                    face="bold",hjust=0.5),
        axis.title.y = element_text(color="#993333", size=14,
                                    face="bold",vjust=0.5),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(angle = 90)
        )+
  scale_x_log10(breaks=c(10^6,5*10^6,10^7,20*10^6,40*10^6,
                         80*10^6,160*10^6,220*10^6),
                labels = function(x) format(x, scientific = FALSE))+
  xlab("Mean Population")+
  ylab("Countries in America")+
  ggtitle("Ordered Plot of Mean Population")
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-18-1.png)

Now lets take use of fct\_reorder2() function. It is useful when one quantitative variable is plotted against another and the factor varible gives the color. This way the legend appears in some order as the data! Contrast the legend on the two plots below.

``` r
gg_gap <- gapminder%>%
                group_by(continent,year)%>%
                summarize(mean_gdpPercap=mean(gdpPercap))%>%
                arrange(continent, year, mean_gdpPercap)

tableFormat(gg_gap,"Mean GDP Per Capita Over Years")
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Mean GDP Per Capita Over Years
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
year
</th>
<th style="text-align:center;">
mean\_gdpPercap
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1952
</td>
<td style="text-align:center;">
1252.572
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1957
</td>
<td style="text-align:center;">
1385.236
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1962
</td>
<td style="text-align:center;">
1598.079
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1967
</td>
<td style="text-align:center;">
2050.364
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1972
</td>
<td style="text-align:center;">
2339.616
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1977
</td>
<td style="text-align:center;">
2585.939
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1982
</td>
<td style="text-align:center;">
2481.593
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1987
</td>
<td style="text-align:center;">
2282.669
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1992
</td>
<td style="text-align:center;">
2281.810
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
1997
</td>
<td style="text-align:center;">
2378.760
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
2002
</td>
<td style="text-align:center;">
2599.385
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
2007
</td>
<td style="text-align:center;">
3089.033
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1952
</td>
<td style="text-align:center;">
4079.063
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1957
</td>
<td style="text-align:center;">
4616.044
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1962
</td>
<td style="text-align:center;">
4901.542
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1967
</td>
<td style="text-align:center;">
5668.253
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1972
</td>
<td style="text-align:center;">
6491.334
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1977
</td>
<td style="text-align:center;">
7352.007
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1982
</td>
<td style="text-align:center;">
7506.737
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1987
</td>
<td style="text-align:center;">
7793.400
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1992
</td>
<td style="text-align:center;">
8044.934
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
1997
</td>
<td style="text-align:center;">
8889.301
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
2002
</td>
<td style="text-align:center;">
9287.677
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
2007
</td>
<td style="text-align:center;">
11003.032
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1952
</td>
<td style="text-align:center;">
5195.484
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1957
</td>
<td style="text-align:center;">
5787.733
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1962
</td>
<td style="text-align:center;">
5729.370
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1967
</td>
<td style="text-align:center;">
5971.173
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1972
</td>
<td style="text-align:center;">
8187.469
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1977
</td>
<td style="text-align:center;">
7791.314
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1982
</td>
<td style="text-align:center;">
7434.135
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1987
</td>
<td style="text-align:center;">
7608.227
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1992
</td>
<td style="text-align:center;">
8639.690
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
1997
</td>
<td style="text-align:center;">
9834.093
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
2002
</td>
<td style="text-align:center;">
10174.090
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
2007
</td>
<td style="text-align:center;">
12473.027
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1952
</td>
<td style="text-align:center;">
5661.057
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1957
</td>
<td style="text-align:center;">
6963.013
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1962
</td>
<td style="text-align:center;">
8365.487
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1967
</td>
<td style="text-align:center;">
10143.824
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1972
</td>
<td style="text-align:center;">
12479.575
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1977
</td>
<td style="text-align:center;">
14283.979
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1982
</td>
<td style="text-align:center;">
15617.897
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1987
</td>
<td style="text-align:center;">
17214.311
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1992
</td>
<td style="text-align:center;">
17061.568
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
1997
</td>
<td style="text-align:center;">
19076.782
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
2002
</td>
<td style="text-align:center;">
21711.732
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
2007
</td>
<td style="text-align:center;">
25054.482
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1952
</td>
<td style="text-align:center;">
10298.086
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1957
</td>
<td style="text-align:center;">
11598.522
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1962
</td>
<td style="text-align:center;">
12696.452
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1967
</td>
<td style="text-align:center;">
14495.022
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1972
</td>
<td style="text-align:center;">
16417.333
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1977
</td>
<td style="text-align:center;">
17283.958
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1982
</td>
<td style="text-align:center;">
18554.710
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1987
</td>
<td style="text-align:center;">
20448.040
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1992
</td>
<td style="text-align:center;">
20894.046
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
1997
</td>
<td style="text-align:center;">
24024.175
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
2002
</td>
<td style="text-align:center;">
26938.778
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
2007
</td>
<td style="text-align:center;">
29810.188
</td>
</tr>
</tbody>
</table>
**Unordered Plot of Mean gdpPerCap vs Year for Each Continent**

``` r
ggplot(gg_gap,aes(year,mean_gdpPercap,color=continent))+
  geom_line(size=1.25)+
  theme(
        plot.title = element_text(color="grey40", size=18, face="bold.italic"),
        axis.title.x = element_text(color="grey40", size=14, 
                                    face="bold",hjust=0.5),
        axis.title.y = element_text(color="grey40", size=14,
                                    face="bold",vjust=0.5),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(angle = 0)
        )+
  scale_y_continuous(breaks=seq(0,30000,5000),
                     limits = c(0,30000))+
  xlab("Year")+
  ylab("Mean GDP Per Capita")+
  ggtitle("Unordered Plot of Mean GDP Per Capita")
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-20-1.png)

**Ordered Plot of Mean gdpPerCap vs Year for Each Continent**

``` r
ggplot(gg_gap, aes(x = year, y = mean_gdpPercap,
                  color = fct_reorder2(continent, year, mean_gdpPercap))) +
  geom_line(size=1.25)+
  theme(
        plot.title = element_text(color="grey40", size=18, face="bold.italic"),
        axis.title.x = element_text(color="grey40", size=14, 
                                    face="bold",hjust=0.5),
        axis.title.y = element_text(color="grey40", size=14,
                                    face="bold",vjust=0.5),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(angle = 0)
        )+
  scale_y_continuous(breaks=seq(0,30000,5000),
                     limits = c(0,30000))+
  labs(x="Year",y="Mean GDP Per Capita",color = "continent")+
  ggtitle("Ordered Plot of Mean GDP Per Capita")
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-21-1.png)

#### Factor Relevel

In order to just hoist one or more levels manually, we can use fct\_relevel() function.

``` r
gg_gap$continent %>% levels()
```

    ## [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"

``` r
gg_gap$continent %>% fct_relevel("Asia") %>% levels()
```

    ## [1] "Asia"     "Africa"   "Americas" "Europe"   "Oceania"

``` r
gg_gap$continent %>% fct_relevel("Oceania","Americas") %>% levels()
```

    ## [1] "Oceania"  "Americas" "Africa"   "Asia"     "Europe"

#### Factor Recode

Change the names of the levels..

``` r
fct_recode(gg_gap$continent,North_America="Americas",Australia="Oceania")%>%
  levels()
```

    ## [1] "Africa"        "North_America" "Asia"          "Europe"       
    ## [5] "Australia"

Use NULL to remove a particular level.

``` r
fct_recode(gg_gap$continent,NULL="Americas")%>%
  levels()
```

    ## [1] "Africa"  "Asia"    "Europe"  "Oceania"

**Effects of arrange**

Now lets take the dataset of mean values of gdpPercap,lifeExp and population for each country in Africa continent.

``` r
gap_le <- gapminder%>%
                filter(continent=="Africa")%>%
                group_by(country)%>%
                summarize(mean_gdpPercap=mean(gdpPercap),
                          mean_pop=mean(pop),
                          mean_lifeExp=mean(lifeExp))
gap_le%>%
  arrange(desc(mean_gdpPercap))%>%
  tableFormat("Mean Values for Countries in Africa")
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Mean Values for Countries in Africa
</caption>
<thead>
<tr>
<th style="text-align:center;">
country
</th>
<th style="text-align:center;">
mean\_gdpPercap
</th>
<th style="text-align:center;">
mean\_pop
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Libya
</td>
<td style="text-align:center;">
12013.5792
</td>
<td style="text-align:center;">
3166803.6
</td>
<td style="text-align:center;">
59.30417
</td>
</tr>
<tr>
<td style="text-align:center;">
Gabon
</td>
<td style="text-align:center;">
11529.8655
</td>
<td style="text-align:center;">
795415.4
</td>
<td style="text-align:center;">
51.22050
</td>
</tr>
<tr>
<td style="text-align:center;">
South Africa
</td>
<td style="text-align:center;">
7247.4311
</td>
<td style="text-align:center;">
29928352.2
</td>
<td style="text-align:center;">
53.99317
</td>
</tr>
<tr>
<td style="text-align:center;">
Botswana
</td>
<td style="text-align:center;">
5031.5036
</td>
<td style="text-align:center;">
971186.2
</td>
<td style="text-align:center;">
54.59750
</td>
</tr>
<tr>
<td style="text-align:center;">
Reunion
</td>
<td style="text-align:center;">
4898.3984
</td>
<td style="text-align:center;">
518497.8
</td>
<td style="text-align:center;">
66.64425
</td>
</tr>
<tr>
<td style="text-align:center;">
Mauritius
</td>
<td style="text-align:center;">
4768.9422
</td>
<td style="text-align:center;">
926072.2
</td>
<td style="text-align:center;">
64.95325
</td>
</tr>
<tr>
<td style="text-align:center;">
Algeria
</td>
<td style="text-align:center;">
4426.0260
</td>
<td style="text-align:center;">
19875406.2
</td>
<td style="text-align:center;">
59.03017
</td>
</tr>
<tr>
<td style="text-align:center;">
Namibia
</td>
<td style="text-align:center;">
3675.5821
</td>
<td style="text-align:center;">
1157849.8
</td>
<td style="text-align:center;">
53.49133
</td>
</tr>
<tr>
<td style="text-align:center;">
Angola
</td>
<td style="text-align:center;">
3607.1005
</td>
<td style="text-align:center;">
7309390.1
</td>
<td style="text-align:center;">
37.88350
</td>
</tr>
<tr>
<td style="text-align:center;">
Tunisia
</td>
<td style="text-align:center;">
3477.2104
</td>
<td style="text-align:center;">
6686770.2
</td>
<td style="text-align:center;">
60.72100
</td>
</tr>
<tr>
<td style="text-align:center;">
Congo, Rep.
</td>
<td style="text-align:center;">
3312.7882
</td>
<td style="text-align:center;">
1923209.1
</td>
<td style="text-align:center;">
52.50192
</td>
</tr>
<tr>
<td style="text-align:center;">
Swaziland
</td>
<td style="text-align:center;">
3163.3524
</td>
<td style="text-align:center;">
679052.0
</td>
<td style="text-align:center;">
49.00242
</td>
</tr>
<tr>
<td style="text-align:center;">
Egypt
</td>
<td style="text-align:center;">
3074.0307
</td>
<td style="text-align:center;">
46522774.2
</td>
<td style="text-align:center;">
56.24300
</td>
</tr>
<tr>
<td style="text-align:center;">
Djibouti
</td>
<td style="text-align:center;">
2697.8332
</td>
<td style="text-align:center;">
260243.9
</td>
<td style="text-align:center;">
46.38075
</td>
</tr>
<tr>
<td style="text-align:center;">
Equatorial Guinea
</td>
<td style="text-align:center;">
2469.1667
</td>
<td style="text-align:center;">
327551.0
</td>
<td style="text-align:center;">
42.96000
</td>
</tr>
<tr>
<td style="text-align:center;">
Morocco
</td>
<td style="text-align:center;">
2447.9089
</td>
<td style="text-align:center;">
20555741.9
</td>
<td style="text-align:center;">
57.60883
</td>
</tr>
<tr>
<td style="text-align:center;">
Cote d'Ivoire
</td>
<td style="text-align:center;">
1912.8254
</td>
<td style="text-align:center;">
9153109.5
</td>
<td style="text-align:center;">
48.43617
</td>
</tr>
<tr>
<td style="text-align:center;">
Sudan
</td>
<td style="text-align:center;">
1835.0104
</td>
<td style="text-align:center;">
21560331.4
</td>
<td style="text-align:center;">
48.40050
</td>
</tr>
<tr>
<td style="text-align:center;">
Cameroon
</td>
<td style="text-align:center;">
1774.6342
</td>
<td style="text-align:center;">
9816648.4
</td>
<td style="text-align:center;">
48.12850
</td>
</tr>
<tr>
<td style="text-align:center;">
Senegal
</td>
<td style="text-align:center;">
1533.1217
</td>
<td style="text-align:center;">
6446305.4
</td>
<td style="text-align:center;">
50.62592
</td>
</tr>
<tr>
<td style="text-align:center;">
Nigeria
</td>
<td style="text-align:center;">
1488.3094
</td>
<td style="text-align:center;">
73708017.8
</td>
<td style="text-align:center;">
43.58133
</td>
</tr>
<tr>
<td style="text-align:center;">
Sao Tome and Principe
</td>
<td style="text-align:center;">
1382.7820
</td>
<td style="text-align:center;">
105977.8
</td>
<td style="text-align:center;">
57.89633
</td>
</tr>
<tr>
<td style="text-align:center;">
Zambia
</td>
<td style="text-align:center;">
1358.1994
</td>
<td style="text-align:center;">
6353804.8
</td>
<td style="text-align:center;">
45.99633
</td>
</tr>
<tr>
<td style="text-align:center;">
Mauritania
</td>
<td style="text-align:center;">
1356.6710
</td>
<td style="text-align:center;">
1782723.8
</td>
<td style="text-align:center;">
52.30208
</td>
</tr>
<tr>
<td style="text-align:center;">
Madagascar
</td>
<td style="text-align:center;">
1335.5950
</td>
<td style="text-align:center;">
9902402.2
</td>
<td style="text-align:center;">
47.77058
</td>
</tr>
<tr>
<td style="text-align:center;">
Comoros
</td>
<td style="text-align:center;">
1314.3803
</td>
<td style="text-align:center;">
361683.9
</td>
<td style="text-align:center;">
52.38175
</td>
</tr>
<tr>
<td style="text-align:center;">
Kenya
</td>
<td style="text-align:center;">
1200.4157
</td>
<td style="text-align:center;">
18206250.2
</td>
<td style="text-align:center;">
52.68100
</td>
</tr>
<tr>
<td style="text-align:center;">
Chad
</td>
<td style="text-align:center;">
1165.4537
</td>
<td style="text-align:center;">
5329256.3
</td>
<td style="text-align:center;">
46.77358
</td>
</tr>
<tr>
<td style="text-align:center;">
Benin
</td>
<td style="text-align:center;">
1155.3951
</td>
<td style="text-align:center;">
4017496.7
</td>
<td style="text-align:center;">
48.77992
</td>
</tr>
<tr>
<td style="text-align:center;">
Togo
</td>
<td style="text-align:center;">
1153.8201
</td>
<td style="text-align:center;">
2895964.0
</td>
<td style="text-align:center;">
51.49875
</td>
</tr>
<tr>
<td style="text-align:center;">
Somalia
</td>
<td style="text-align:center;">
1140.7933
</td>
<td style="text-align:center;">
5197197.8
</td>
<td style="text-align:center;">
40.98867
</td>
</tr>
<tr>
<td style="text-align:center;">
Sierra Leone
</td>
<td style="text-align:center;">
1072.8195
</td>
<td style="text-align:center;">
3605424.9
</td>
<td style="text-align:center;">
36.76917
</td>
</tr>
<tr>
<td style="text-align:center;">
Ghana
</td>
<td style="text-align:center;">
1044.5820
</td>
<td style="text-align:center;">
12616626.4
</td>
<td style="text-align:center;">
52.34067
</td>
</tr>
<tr>
<td style="text-align:center;">
Central African Republic
</td>
<td style="text-align:center;">
958.7847
</td>
<td style="text-align:center;">
2560963.0
</td>
<td style="text-align:center;">
43.86692
</td>
</tr>
<tr>
<td style="text-align:center;">
Tanzania
</td>
<td style="text-align:center;">
849.2813
</td>
<td style="text-align:center;">
20499497.7
</td>
<td style="text-align:center;">
47.91233
</td>
</tr>
<tr>
<td style="text-align:center;">
Burkina Faso
</td>
<td style="text-align:center;">
843.9907
</td>
<td style="text-align:center;">
7548677.2
</td>
<td style="text-align:center;">
44.69400
</td>
</tr>
<tr>
<td style="text-align:center;">
Uganda
</td>
<td style="text-align:center;">
810.3838
</td>
<td style="text-align:center;">
14361049.4
</td>
<td style="text-align:center;">
47.61883
</td>
</tr>
<tr>
<td style="text-align:center;">
Niger
</td>
<td style="text-align:center;">
781.0768
</td>
<td style="text-align:center;">
6857373.8
</td>
<td style="text-align:center;">
44.55867
</td>
</tr>
<tr>
<td style="text-align:center;">
Lesotho
</td>
<td style="text-align:center;">
780.5534
</td>
<td style="text-align:center;">
1389696.4
</td>
<td style="text-align:center;">
50.00708
</td>
</tr>
<tr>
<td style="text-align:center;">
Guinea
</td>
<td style="text-align:center;">
776.0673
</td>
<td style="text-align:center;">
5360550.7
</td>
<td style="text-align:center;">
43.23983
</td>
</tr>
<tr>
<td style="text-align:center;">
Gambia
</td>
<td style="text-align:center;">
680.1326
</td>
<td style="text-align:center;">
793138.6
</td>
<td style="text-align:center;">
44.40058
</td>
</tr>
<tr>
<td style="text-align:center;">
Rwanda
</td>
<td style="text-align:center;">
675.6690
</td>
<td style="text-align:center;">
5298435.7
</td>
<td style="text-align:center;">
41.48158
</td>
</tr>
<tr>
<td style="text-align:center;">
Mali
</td>
<td style="text-align:center;">
673.0931
</td>
<td style="text-align:center;">
7112340.1
</td>
<td style="text-align:center;">
43.41350
</td>
</tr>
<tr>
<td style="text-align:center;">
Guinea-Bissau
</td>
<td style="text-align:center;">
652.1572
</td>
<td style="text-align:center;">
882008.4
</td>
<td style="text-align:center;">
39.21025
</td>
</tr>
<tr>
<td style="text-align:center;">
Congo, Dem. Rep.
</td>
<td style="text-align:center;">
648.3426
</td>
<td style="text-align:center;">
32681655.2
</td>
<td style="text-align:center;">
44.54375
</td>
</tr>
<tr>
<td style="text-align:center;">
Zimbabwe
</td>
<td style="text-align:center;">
635.8580
</td>
<td style="text-align:center;">
7641966.1
</td>
<td style="text-align:center;">
52.66317
</td>
</tr>
<tr>
<td style="text-align:center;">
Liberia
</td>
<td style="text-align:center;">
604.8141
</td>
<td style="text-align:center;">
1813857.2
</td>
<td style="text-align:center;">
42.47625
</td>
</tr>
<tr>
<td style="text-align:center;">
Malawi
</td>
<td style="text-align:center;">
575.4472
</td>
<td style="text-align:center;">
7016377.4
</td>
<td style="text-align:center;">
43.35158
</td>
</tr>
<tr>
<td style="text-align:center;">
Mozambique
</td>
<td style="text-align:center;">
542.2783
</td>
<td style="text-align:center;">
12046695.3
</td>
<td style="text-align:center;">
40.37950
</td>
</tr>
<tr>
<td style="text-align:center;">
Eritrea
</td>
<td style="text-align:center;">
541.0025
</td>
<td style="text-align:center;">
2820216.8
</td>
<td style="text-align:center;">
45.99925
</td>
</tr>
<tr>
<td style="text-align:center;">
Ethiopia
</td>
<td style="text-align:center;">
509.1152
</td>
<td style="text-align:center;">
41632518.8
</td>
<td style="text-align:center;">
44.47575
</td>
</tr>
<tr>
<td style="text-align:center;">
Burundi
</td>
<td style="text-align:center;">
471.6630
</td>
<td style="text-align:center;">
4651608.3
</td>
<td style="text-align:center;">
44.81733
</td>
</tr>
</tbody>
</table>
**Unordered Plot** Lets plot mean gdpPercap of each country in Africa without ordering the factor variable country.

``` r
unordered_plot<- 
  gap_le%>%
    arrange(desc(mean_gdpPercap))%>%
    ggplot(aes(country,mean_gdpPercap))+
      geom_point(color="blue")+ 
      theme(
        plot.title = element_text(color="grey40", size=18, face="bold.italic"),
        axis.text.x = element_text(angle = 90,vjust = 0.5, hjust = 1),
        axis.title.x = element_text(color="grey40", size=14, face="bold.italic"),
        axis.title.y = element_text(color="grey40", size=14, face="bold.italic"),
        axis.ticks = element_blank()
        )+
      scale_y_continuous(breaks=seq(0,12500,1250),
                     limits = c(0,12500))+
      labs(x="Countries in Africa",y="Mean GDP Per Capita")+
      ggtitle("Unordered Plot of Mean gdpPerCapita in Africa")
unordered_plot
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-1.png)

**Reordering with Base R function** Lets reorder the country variable based on decreasing value of mean\_gdpPercap

``` r
#Base R function order()
gap_le$country<-factor(gap_le$country,
                         levels = gap_le$country[order(gap_le$mean_gdpPercap,
                                                         decreasing = TRUE)],
                         ordered=TRUE)
baseR_plot<-
  ggplot(gap_le,aes(country,mean_gdpPercap))+
    geom_point(color="blue")+ 
    theme(
        plot.title = element_text(color="grey40", size=18, face="bold.italic"),
        axis.text.x = element_text(angle = 90,vjust = 0.5, hjust = 1),
        axis.title.x = element_text(color="grey40", size=14, face="bold.italic"),
        axis.title.y = element_text(color="grey40", size=14, face="bold.italic"),
        axis.ticks = element_blank()
        )+
    scale_y_continuous(breaks=seq(0,12500,1250),
                     limits = c(0,12500))+
    labs(x="Countries in Africa",y="Mean GDP Per Capita")+
    ggtitle("Ordered Plot of Mean gdpPerCapita(Base R)")

baseR_plot
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-27-1.png)

**Reordering with Forcats** Lets reorder the country variable based on decreasing value of mean\_gdpPercap using fct\_reorder() from forcats package.

``` r
#forcats function fct_reorder()
forcats_plot <-
  gap_le %>%
    ggplot(aes(x=fct_reorder(country,mean_gdpPercap,.desc=TRUE),
             y=mean_gdpPercap))+
      geom_point(color="blue")+ 
      theme(
        plot.title = element_text(color="grey40", size=18, face="bold.italic"),
        axis.text.x = element_text(angle = 90,vjust = 0.5, hjust = 1),
        axis.title.x = element_text(color="grey40", size=14, face="bold.italic"),
        axis.title.y = element_text(color="grey40", size=14, face="bold.italic"),
        axis.ticks = element_blank()
        )+
      scale_y_continuous(breaks=seq(0,12500,1250),
                     limits = c(0,12500))+
      labs(x="Countries in Africa",y="Mean GDP Per Capita")+
      ggtitle("Ordered Plot of Mean gdpPerCapita (Forcats)")
forcats_plot
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-28-1.png)

**Explore the effects of arrange(). Does merely arranging the data have any effect on, say, a figure?**

Arrange() function is helpful to sort the numeric variables. But in case of factors it is not sufficient to reorder the data. As seen above with h\_gap plot, the country variable was not reordered in the ggplot according to mean\_pop even after using arrange(mean\_pop). This shows that merely arranging the data is not sufficient for reordering the factors. For this purpose, functions from base R or forcats package need to be used.

**Explore the effects of reordering a factor and factor reordering coupled with arrange().Especially, what effect does this have on a figure?**

As mentioned above, arrange() works pretty well for sorting numeric variables. For re ordering factor variables we need to use other functions from base R or forcats package. When they are coupled the data from the table and plots go hand in hand and are easier to understand and interpret.

> The above answer is supported by tables and plots above.

#### Resources

+[forcats manual](https://cran.r-project.org/web/packages/forcats/forcats.pdf) +[Factors in R](https://www.stat.berkeley.edu/classes/s133/factors.html) +[Forcats Blog](https://blog.rstudio.com/2016/08/31/forcats-0-1-0/) +[R for Datascience](http://r4ds.had.co.nz/factors.html)

Task 2
------

### File I/O

Lets filter the gapminder dataset for countries in Asia and for 2007 year .

``` r
gap_asia<- gapminder%>%
              filter(continent=="Asia" & year ==2007)
```

Lets reorder the country variable by mean of population

``` r
gap_asia$country<- fct_reorder(gap_asia$country, gap_asia$pop, mean) 

gap_asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Bahrain"            "Kuwait"             "Mongolia"          
    ## [4] "Oman"               "Lebanon"            "West Bank and Gaza"

#### write.csv() and read.csv()

Now lets write this dataset to a csv file and save it.

``` r
write.csv(gap_asia,"hw05_gapminder_files\\gap_asia.csv")
```

Next up,Lets read this csv file into asia data frame

``` r
asia<-read.csv("hw05_gapminder_files\\gap_asia.csv")
```

Lets check if the reordering of factors is still present.

\_Note: rm() is used to free the memory space by removing the dataframe. The csv file is also deleted to avoid overwriting using unlink() function.

``` r
asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Afghanistan"      "Bahrain"          "Bangladesh"      
    ## [4] "Cambodia"         "China"            "Hong Kong, China"

``` r
gap_asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Bahrain"            "Kuwait"             "Mongolia"          
    ## [4] "Oman"               "Lebanon"            "West Bank and Gaza"

``` r
rm(asia)
unlink("gap_asia.csv")
```

The order of the factors is not same. This shows that the reordering doesnt survive the round trip of writing to csv and reading back.

#### write\_csv() and read\_csv()

``` r
write_csv(gap_asia,"hw05_gapminder_files\\gap_asia.csv")
asia<-read_csv("hw05_gapminder_files\\gap_asia.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double(),
    ##   pop = col_integer(),
    ##   gdpPercap = col_double()
    ## )

``` r
class(asia$continent)
```

    ## [1] "character"

``` r
rm(asia)
```

This returns NULL for the levels because the class of continent is now character and not factor anymore. This happens because read\_csv() doesnt convert strings to factors unlike read.csv(). Instead, it is guessing the column specification of each variable when reading which is printed as well.So in this case, the class of the variable is itself not factor let alone keep reordering intact.

#### saveRDS() and readRDS()

``` r
saveRDS(gap_asia,"hw05_gapminder_files\\gap_asia.rds")
asia<-readRDS("hw05_gapminder_files\\gap_asia.rds")

asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Bahrain"            "Kuwait"             "Mongolia"          
    ## [4] "Oman"               "Lebanon"            "West Bank and Gaza"

``` r
gap_asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Bahrain"            "Kuwait"             "Mongolia"          
    ## [4] "Oman"               "Lebanon"            "West Bank and Gaza"

``` r
rm(asia)
```

The order of the factor variable is retained. This shows that saving as .rds file and reading it back keeps the ordering of factor variable intact.

#### dput() and dget()

``` r
dput(gap_asia,"hw05_gapminder_files\\random_name")
asia<-dget("hw05_gapminder_files\\random_name")
asia$country%>%
  levels()%>%
  head()
```

    ## [1] "Bahrain"            "Kuwait"             "Mongolia"          
    ## [4] "Oman"               "Lebanon"            "West Bank and Gaza"

This works and it saves the data as in a text file with a representation that remembers the ordering of the factor levels.

#### Resources:

-   [Retrieving ordered factors](http://r.789695.n4.nabble.com/Retrieving-Factors-with-Levels-Ordered-td3169990.html) +[Saving & Loading objects](http://www.fromthebottomoftheheap.net/2012/04/01/saving-and-loading-r-objects/) +[Delete files](https://stat.ethz.ch/R-manual/R-devel/library/base/html/unlink.html) +[readr](https://blog.rstudio.com/2016/08/05/readr-1-0-0/)

### Task 3

#### Visualization Design

Lets take the plot of lifeExp of countries over time facetted by continent. I had used this plot in the [third homework](http://htmlpreview.github.io/?https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw03/hw03_gapminder.html)

``` r
ggplot(gapminder,aes(year,lifeExp,group=country))+
  geom_line()+
  facet_wrap(~continent)
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-37-1.png)

The `RColorBrewer` is a nice R package, based on designs by Cynthia Brewer, a colour expert. Here are the palettes available:

``` r
library(RColorBrewer)
#display.brewer.all()
```

Now lets modify this plot and report the changes made.

``` r
colorder <- c(unique(gapminder$year))

gapminder %>%
  group_by(country) %>%
  mutate(mean_lifeExp=mean(lifeExp)) %>%
  ggplot(aes(year,lifeExp))+
    geom_line(aes(group=country,color=mean_lifeExp),alpha=0.5)+
    facet_wrap(~continent)+
    theme_bw()+
    ggtitle("Plot of lifeExp vs year for Continent")+
    theme(
      plot.title = element_text(hjust = 0.5,vjust=1,color = "red",
                                size="18",face="bold.italic"),
      axis.title.x = element_text(color="green", size=12, face="bold"),
      axis.title.y = element_text(color="grey", size=14, face="bold"),
      axis.text.x = element_text(angle = 90,vjust=0.5,hjust=1),
      legend.position = c(0.9,0.1)
    )+
    scale_x_discrete(limits=colorder,
                     breaks=colorder,
                     labels=as.character(colorder))+
    scale_colour_distiller(palette="Purples", direction=1)+
    expand_limits(x = c(1950,2010))
```

![](hw05_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-39-1.png)

The changes made are - Color each country lifeExp by the mean of lifeExp experienced by the country - The value of alpha(transparency) is set to 0.5 for better visualization. - The country grouping is embedded inside the geom\_line aesthetic. - theme\_bw is applied for better graphics. - The title is included using ggtitle and its theme is modified. - Similary, the theme of x and y axis title is modified - X axis labels are rotated by 90 and centered. - The legend is placed inside the graph at the right bottom using legend.position - The colorder contains the year values present in gapminder as a vector. - The labels of x axis are modified using scale\_x\_discrete function. - The expand\_limits makes sure there is some space on either side of the graph. - The legend color palette is taken from RColorBrewer package.

#### Resources:

+[Color Reference](http://sape.inf.usi.ch/quick-reference/ggplot2/colour) +[Theme Components](http://ggplot2.tidyverse.org/reference/theme.html) +[Axis scales & Transformations](http://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations) +[Axis manipulation & Themes](https://rstudio-pubs-static.s3.amazonaws.com/3364_d1a578f521174152b46b19d0c83cbe7e.html) +[expand\_limits()](http://ggplot2.tidyverse.org/reference/expand_limits.html) +[ggplot2 Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)

### Task 4

#### Writing Figures to Files

Earlier we had saved three plots to variables namely, unordered\_plot, baseR\_plot and forcats\_plot. Now lets try saving these to figures to files.

When we use ggsave() function without mentioning the plot name, it saves the last plot.

``` r
ggsave('unordered.jpg',
      path='hw05_gapminder_files\\')
```

    ## Saving 7 x 5 in image

The saved file is ![forcats\_plot]()

This clearly shows that it saves the last plot by default.Instead we can save the plots by mentioning their name as the next argument 'plot'. Thus this argument is extremely useful if you are saving a plot by mentioning its name and it will work perfectly even if it is not the last plot.

Vector Graphics Format('eps' and 'pdf') &gt; Vector graphics formats, which store an image as a series of lines of specified shape, color, and size between relative points in a space. Thus the image is rendered by drawing each of those vectors from the instructions encoded in the file. Vector graphics look sharp at any size because the vectors are simply drawn larger or smaller, depending on the requested size of the image.

``` r
ggsave('unordered_plot.pdf',device='pdf',plot = unordered_plot,
      path='hw05_gapminder_files\\vector_format_files\\')
```

    ## Saving 7 x 5 in image

``` r
ggsave('baseR_plot.eps',plot = baseR_plot,
      path='hw05_gapminder_files\\vector_format_files\\')
```

    ## Saving 7 x 5 in image

``` r
ggsave('forcats_plot.pdf',plot = forcats_plot,
      path='hw05_gapminder_files\\vector_format_files\\')
```

    ## Saving 7 x 5 in image

Raster Graphics Format() &gt; Raster graphics, like TIFF, BMP, JPEG, and GIF. Unlike vector graphics, raster graphics are stored as a matrix of colored pixels.

``` r
ggsave('forcats_plot1.jpg',plot = forcats_plot,
      path='hw05_gapminder_files\\raster_format_files\\',
      scale=0.5)
```

    ## Saving 3.5 x 2.5 in image

``` r
ggsave('forcats_plot2.jpg',plot = forcats_plot,
      path='hw05_gapminder_files\\raster_format_files\\',
      scale=2)
```

    ## Saving 14 x 10 in image

The tiff format is the best raster format as it helps keep the high end graphics of image intact to some extent.

> When a vector graphic format is not available or for some reason not accepted, graphics need to be saved as high-resolution TIFF files of an appropriate size in order to avoid the grainy or pixelated images sometimes found in journals.

``` r
ggsave('unordered_plot.tiff',plot = unordered_plot,
      path='hw05_gapminder_files\\raster_format_files\\',
      dpi=600,height=5,width=10)
```

The height and width of the image in terms of pixels is product of the parameters with dpi value. And the value of dpi directly affects the size of non plot elements such as text. The higher the resolution the better the text is.

``` r
res<-60
ggsave('baseR_plot1.png',plot = baseR_plot,
      path='hw05_gapminder_files\\raster_format_files\\',
       width=800/res, height=800/res,units = 'in', dpi = res)

res<-100
ggsave('baseR_plot2.png',plot = baseR_plot,
      path='hw05_gapminder_files\\raster_format_files\\',
       width=800/res, height=800/res,units = 'in', dpi = res)
```

**Resources:** +[Text Factor](https://stackoverflow.com/questions/26551359/r-ggsave-save-thumbnail-size-200-x-200-scaled-image) +[Write figure to file](https://www.stat.ubc.ca/~jenny/STAT545A/topic12_writeFigureToFile.html) +[High Resoultion graphics](https://thepoliticalmethodologist.com/2013/11/25/making-high-resolution-graphics-for-academic-publishing/)

### Task 5

#### Cleaning up the Repo

For cleaning the repositories following actions were taken

1.  All the homeworks were organized in a single repository and each one has its own folder.
2.  Each homework has a readme file explainging the concepts covered in that particular homework.
3.  Each homework folder has a hw0x\_gapminder\_files folder containing the extra files such as images,table files,csv files etc.
4.  The main readme file has the link to navigate to each of these homework folders.

### Task 6

#### But I want to do more

Lets create a filtered dataset for this activity

``` r
# !diagnostics off
country_list<- c("Austria","Germany","Mexico","Argentina","Spain","Portugal"
                 ,"Brazil","Australia","New Zealand","Canada")
languages<-c(rep("German",2),rep("Spanish",3),
             rep("Portugese",3),rep("English",3))
gap_six<-subset(gapminder,country%in%country_list)

suppressWarnings(suppressMessages(
  gap_six$language<-cbind(gap_six$language,
                        languages[match(gap_six$country,country_list)]
                        )
))
gap_six$language<-as.factor(gap_six$language)
levels(gap_six$language)
```

    ## [1] "English"   "German"    "Portugese" "Spanish"

#### Reordering levels of factor variables

We order language by frequency, forwards and backwards.

``` r
fct_count(gap_six$language)
```

    ## # A tibble: 4 × 2
    ##           f     n
    ##      <fctr> <int>
    ## 1   English    24
    ## 2    German    24
    ## 3 Portugese    36
    ## 4   Spanish    36

``` r
## order by frequency (highest first)
gap_six$language %>% 
  fct_infreq()%>% 
  levels()
```

    ## [1] "Portugese" "Spanish"   "English"   "German"

``` r
## backwards!
gap_six$language %>% 
  fct_infreq() %>%
  fct_rev() %>% 
  levels()
```

    ## [1] "German"    "English"   "Spanish"   "Portugese"

Now we order language by another variable forwards and backwards. Lets use different summarizing function such as mean,median, minimum value.

``` r
#order by median of lifeExp
fct_reorder(gap_six$language, gap_six$lifeExp) %>% 
  levels()
```

    ## [1] "Spanish"   "Portugese" "German"    "English"

``` r
#order by min of gdpPercap
fct_reorder(gap_six$language , gap_six$gdpPercap, min) %>% 
  levels()
```

    ## [1] "Portugese" "Spanish"   "German"    "English"

``` r
#backwards
fct_reorder(gap_six$language , gap_six$lifeExp,.desc=TRUE) %>% 
  levels()
```

    ## [1] "English"   "German"    "Portugese" "Spanish"

#### Factor Relevel

In order to just hoist one or more levels manually, we can use fct\_relevel() function.

``` r
gap_six$language  %>% levels()
```

    ## [1] "English"   "German"    "Portugese" "Spanish"

``` r
gap_six$language  %>% fct_relevel("German") %>% levels()
```

    ## [1] "German"    "English"   "Portugese" "Spanish"

``` r
gap_six$language %>% fct_relevel("Spanish","Portugese") %>% levels()
```

    ## [1] "Spanish"   "Portugese" "English"   "German"

#### Factor Reverse

If you just want to reverse the order, there’s the fct\_rev function.

``` r
levels(gap_six$language)
```

    ## [1] "English"   "German"    "Portugese" "Spanish"

``` r
fct_rev(gap_six$language)%>%levels()
```

    ## [1] "Spanish"   "Portugese" "German"    "English"

#### Factor Recode

Change the names of the levels..

``` r
fct_recode(gap_six$language,Eng="English",Spa="Spanish")%>%
  levels()
```

    ## [1] "Eng"       "German"    "Portugese" "Spa"

Use NULL to remove a particular level.

``` r
fct_recode(gap_six$language,NULL="English")%>%
  levels()
```

    ## [1] "German"    "Portugese" "Spanish"

#### fct\_unique()

Get the unique values of a factor

``` r
unique(gap_six$language)     # in order of appearance
```

    ## [1] Spanish   Portugese German    English  
    ## Levels: English German Portugese Spanish

``` r
fct_unique(gap_six$language) # in order of levels
```

    ## [1] English   German    Portugese Spanish  
    ## Levels: English German Portugese Spanish

#### fct\_expand()

Add additional levels to a factor

``` r
fct_expand(gap_six$language,"Hindi") %>% levels()
```

    ## [1] "English"   "German"    "Portugese" "Spanish"   "Hindi"

#### fct\_explicit\_na()

This gives missing value an explicit factor level, ensuring that they appear in summaries and on plots.

``` r
f1 <- factor(c("a", "a", NA, NA, "a", "b", NA, "c", "a", "c", "b"))
f2<- fct_explicit_na(f1, na_level = " (Missing) ")
table(f2)
```

    ## f2
    ##           a           b           c  (Missing)  
    ##           4           2           2           3

Resources: +[forcats manual](https://cran.r-project.org/web/packages/forcats/forcats.pdf) +[cbind](http://stat.ethz.ch/R-manual/R-devel/library/base/html/cbind.html) +[language data](https://www.infoplease.com/languages-spoken-each-country-world)
