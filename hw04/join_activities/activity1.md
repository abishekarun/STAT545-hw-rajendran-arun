activity1.Rmd
================

### Join, merge, look up

#### Activity \#1

**Preparation of the two data frames**

Lets prepare two data frames for explaining the different joins. The first one is my\_gap which is a subset of gapminder datset with the mean life expectancy data of all continents. Second one is the data1 dataset which contains the codes and hemipshere details of the seven continents.

``` r
#Continent data
continent<-c("Asia","Africa","North America","South America",
             "Europe","Oceania","Antarctica")
hemisphere<-c("Northern","Northern","Southern","NS","Northern","Southern",
              "Southern")
codes<-c("AS","AF","NOA","SOA","EU","OC","AN")
data1<-data.frame(continent,hemisphere,codes)

#gapminder subset
my_gap<- gapminder%>%
              group_by(continent)%>%
              summarize(mean_lifeExp=weighted.mean(lifeExp))
```

Lets view the two datasets

``` r
data1
```

    ##       continent hemisphere codes
    ## 1          Asia   Northern    AS
    ## 2        Africa   Northern    AF
    ## 3 North America   Southern   NOA
    ## 4 South America         NS   SOA
    ## 5        Europe   Northern    EU
    ## 6       Oceania   Southern    OC
    ## 7    Antarctica   Southern    AN

``` r
my_gap
```

    ## # A tibble: 5 × 2
    ##   continent mean_lifeExp
    ##      <fctr>        <dbl>
    ## 1    Africa     48.86533
    ## 2  Americas     64.65874
    ## 3      Asia     60.06490
    ## 4    Europe     71.90369
    ## 5   Oceania     74.32621

### Different types of join

##### inner\_join

``` r
#inner_join
suppressWarnings(suppressMessages(
  inner_join(data1,my_gap,by="continent")
))
```

    ##   continent hemisphere codes mean_lifeExp
    ## 1      Asia   Northern    AS     60.06490
    ## 2    Africa   Northern    AF     48.86533
    ## 3    Europe   Northern    EU     71.90369
    ## 4   Oceania   Southern    OC     74.32621

``` r
suppressWarnings(suppressMessages(
  inner_join(my_gap,data1,by="continent")
))
```

    ## # A tibble: 4 × 4
    ##   continent mean_lifeExp hemisphere  codes
    ##       <chr>        <dbl>     <fctr> <fctr>
    ## 1    Africa     48.86533   Northern     AF
    ## 2      Asia     60.06490   Northern     AS
    ## 3    Europe     71.90369   Northern     EU
    ## 4   Oceania     74.32621   Southern     OC

Both the inner join commands give the same output. This operation returns the common rows from both datasets along with all columns from both datasets.(It is intersection of both datasets) Here the number of common rows is four continents and total number of columns is 4.

##### left\_join

``` r
#left join
suppressWarnings(suppressMessages(
  left_join(data1,my_gap)
))
```

    ##       continent hemisphere codes mean_lifeExp
    ## 1          Asia   Northern    AS     60.06490
    ## 2        Africa   Northern    AF     48.86533
    ## 3 North America   Southern   NOA           NA
    ## 4 South America         NS   SOA           NA
    ## 5        Europe   Northern    EU     71.90369
    ## 6       Oceania   Southern    OC     74.32621
    ## 7    Antarctica   Southern    AN           NA

This operation returns all rows from the first dataset(data1 in this case) and all columns from both datasets. When a row from first dataset has no match, NA values will be present. This happens in the above case for North America,South America and Antarctica as these are not present in my\_gap dataset. So the mean\_lifeExp values are filled with NA.

##### right\_join

``` r
#right join
suppressWarnings(suppressMessages(
  right_join(data1,my_gap)
))
```

    ##   continent hemisphere codes mean_lifeExp
    ## 1    Africa   Northern    AF     48.86533
    ## 2  Americas       <NA>  <NA>     64.65874
    ## 3      Asia   Northern    AS     60.06490
    ## 4    Europe   Northern    EU     71.90369
    ## 5   Oceania   Southern    OC     74.32621

right\_join does the same thing as left\_join but on the second dataset. Here the rows from second dataset are returned. Hence, americas has code and hemisphere value as NA since it is not found in data1 dataset.

##### full\_join

``` r
#full join
suppressWarnings(suppressMessages(
  full_join(data1,my_gap)
))
```

    ##       continent hemisphere codes mean_lifeExp
    ## 1          Asia   Northern    AS     60.06490
    ## 2        Africa   Northern    AF     48.86533
    ## 3 North America   Southern   NOA           NA
    ## 4 South America         NS   SOA           NA
    ## 5        Europe   Northern    EU     71.90369
    ## 6       Oceania   Southern    OC     74.32621
    ## 7    Antarctica   Southern    AN           NA
    ## 8      Americas       <NA>  <NA>     64.65874

Returns all rows and columns from both datasets. Missing values are filled with NAs.Therefore it returns eight columns(it is similar to union of both dataframes).

##### semi\_join

``` r
#semi join
suppressWarnings(suppressMessages(
  semi_join(data1,my_gap)
))
```

    ##   continent hemisphere codes
    ## 1    Africa   Northern    AF
    ## 2      Asia   Northern    AS
    ## 3    Europe   Northern    EU
    ## 4   Oceania   Southern    OC

Returns rows of first dataset that are common with second dataset keeping only the columns of first dataset. (similar to intersection of two datasets with only columns from first dataset). So only three columns of data1 is returned with only four rows(the ones corrosponding to common continents)

##### anti\_join

``` r
#anti join
suppressWarnings(suppressMessages(
  anti_join(data1,my_gap)
))
```

    ##       continent hemisphere codes
    ## 1 North America   Southern   NOA
    ## 2 South America         NS   SOA
    ## 3    Antarctica   Southern    AN

Returns all rows from first dataset that are not matching with second dataset keeping only the columns of first dataset.Returns only the three rows in first dataset that are not there in second dataset.(similar to first dataset - second dataset)
