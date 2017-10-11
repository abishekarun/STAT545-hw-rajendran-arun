activity2.Rmd
================

### Join, merge, look up

#### Activity \#2

Creating datasets (movies and studios) for explaining the joins

``` r
names<-c("Iron Man","Thor","The Avengers","Ant Man","Doctor Strange","Man of steel","Dawn of Justice","Suicide squad","Wonder woman","Justice league","Force awakens")
release_year<-c("2008","2008","2011","2015","2016","2013","2016","2016","2017","2017","2015")
directors<-c("Jon Favreau","Kenneth Branagh","Joss Whedon","Peyton Reed","Scott Derrickson","Zack Snyder","Zack Snyder","David Ayer","Patty Jenkins","Zack Snyder","J.J. Abrams")
company<-c(rep("Marvel",5),rep("DC",5),"Star wars")
movies<-data.frame(names,release_year,directors,company)

company<-c("Marvel","DC","Star trek")
yr_founded<-c(1934,1939,1966)
studios<-data.frame(company,yr_founded)
```

Lets view the datasets movies and studios

``` r
movies
```

    ##              names release_year        directors   company
    ## 1         Iron Man         2008      Jon Favreau    Marvel
    ## 2             Thor         2008  Kenneth Branagh    Marvel
    ## 3     The Avengers         2011      Joss Whedon    Marvel
    ## 4          Ant Man         2015      Peyton Reed    Marvel
    ## 5   Doctor Strange         2016 Scott Derrickson    Marvel
    ## 6     Man of steel         2013      Zack Snyder        DC
    ## 7  Dawn of Justice         2016      Zack Snyder        DC
    ## 8    Suicide squad         2016       David Ayer        DC
    ## 9     Wonder woman         2017    Patty Jenkins        DC
    ## 10  Justice league         2017      Zack Snyder        DC
    ## 11   Force awakens         2015      J.J. Abrams Star wars

``` r
studios
```

    ##     company yr_founded
    ## 1    Marvel       1934
    ## 2        DC       1939
    ## 3 Star trek       1966

### Different types of join

##### inner\_join(movies,studios)

> inner\_join(x, y): Return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#inner_join
suppressWarnings(suppressMessages(
  inner_join(movies,studios)
))
```

    ##              names release_year        directors company yr_founded
    ## 1         Iron Man         2008      Jon Favreau  Marvel       1934
    ## 2             Thor         2008  Kenneth Branagh  Marvel       1934
    ## 3     The Avengers         2011      Joss Whedon  Marvel       1934
    ## 4          Ant Man         2015      Peyton Reed  Marvel       1934
    ## 5   Doctor Strange         2016 Scott Derrickson  Marvel       1934
    ## 6     Man of steel         2013      Zack Snyder      DC       1939
    ## 7  Dawn of Justice         2016      Zack Snyder      DC       1939
    ## 8    Suicide squad         2016       David Ayer      DC       1939
    ## 9     Wonder woman         2017    Patty Jenkins      DC       1939
    ## 10  Justice league         2017      Zack Snyder      DC       1939

We lose Force Awakens in the join because, although they appear in x = movies, their corrosponding company "Star wars" doesn't not appear in y = studios. The join result has all variables from x = movies plus yr\_founded, from y.

##### semi\_join(movies,studios)

> semi\_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.

``` r
#semi join
suppressWarnings(suppressMessages(
  semi_join(movies,studios)
))
```

    ##              names release_year        directors company
    ## 1         Iron Man         2008      Jon Favreau  Marvel
    ## 2             Thor         2008  Kenneth Branagh  Marvel
    ## 3     The Avengers         2011      Joss Whedon  Marvel
    ## 4          Ant Man         2015      Peyton Reed  Marvel
    ## 5   Doctor Strange         2016 Scott Derrickson  Marvel
    ## 6     Man of steel         2013      Zack Snyder      DC
    ## 7  Dawn of Justice         2016      Zack Snyder      DC
    ## 8    Suicide squad         2016       David Ayer      DC
    ## 9     Wonder woman         2017    Patty Jenkins      DC
    ## 10  Justice league         2017      Zack Snyder      DC

We get a similar result as with inner\_join() but the join result contains only the variables originally found in x = movies. But note the row order has changed.

##### left\_join(movies,studios)

> left\_join(x, y): Return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#left join
suppressWarnings(suppressMessages(
  left_join(movies,studios)
))
```

    ##              names release_year        directors   company yr_founded
    ## 1         Iron Man         2008      Jon Favreau    Marvel       1934
    ## 2             Thor         2008  Kenneth Branagh    Marvel       1934
    ## 3     The Avengers         2011      Joss Whedon    Marvel       1934
    ## 4          Ant Man         2015      Peyton Reed    Marvel       1934
    ## 5   Doctor Strange         2016 Scott Derrickson    Marvel       1934
    ## 6     Man of steel         2013      Zack Snyder        DC       1939
    ## 7  Dawn of Justice         2016      Zack Snyder        DC       1939
    ## 8    Suicide squad         2016       David Ayer        DC       1939
    ## 9     Wonder woman         2017    Patty Jenkins        DC       1939
    ## 10  Justice league         2017      Zack Snyder        DC       1939
    ## 11   Force awakens         2015      J.J. Abrams Star wars         NA

We basically get x = movies back, but with the addition of variable yr\_founded, which is unique to y = studios. Force Awakens, whose company don't appear in y = studios, has an NA for company.

##### anti\_join(movies,studios)

> anti\_join(x, y): Return all rows from x where there are not matching values in y, keeping just columns from x. This is a filtering join.

``` r
#anti join
suppressWarnings(suppressMessages(
  anti_join(movies,studios)
))
```

    ##           names release_year   directors   company
    ## 1 Force awakens         2015 J.J. Abrams Star wars

We keep only Force Awakens now (and do not get company).

##### inner\_join(studios,movies)

> inner\_join(x, y): Return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#inner_join
suppressWarnings(suppressMessages(
  inner_join(studios,movies)
))
```

    ##    company yr_founded           names release_year        directors
    ## 1   Marvel       1934        Iron Man         2008      Jon Favreau
    ## 2   Marvel       1934            Thor         2008  Kenneth Branagh
    ## 3   Marvel       1934    The Avengers         2011      Joss Whedon
    ## 4   Marvel       1934         Ant Man         2015      Peyton Reed
    ## 5   Marvel       1934  Doctor Strange         2016 Scott Derrickson
    ## 6       DC       1939    Man of steel         2013      Zack Snyder
    ## 7       DC       1939 Dawn of Justice         2016      Zack Snyder
    ## 8       DC       1939   Suicide squad         2016       David Ayer
    ## 9       DC       1939    Wonder woman         2017    Patty Jenkins
    ## 10      DC       1939  Justice league         2017      Zack Snyder

In a way, this does illustrate multiple matches, if you think about it from the x = studios direction. Every company that has a match in y = movies appears multiple times in the result, once for each match. In fact, we’re getting the same result as with inner\_join(movies,studios), up to variable order (which you should also never rely on in an analysis).

##### semi\_join(studios,movies)

> semi\_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.

``` r
#semi join
suppressWarnings(suppressMessages(
  semi_join(studios,movies)
))
```

    ##   company yr_founded
    ## 1  Marvel       1934
    ## 2      DC       1939

Now the effects of switching the x and y roles is more clear. The result resembles x = studios, but the company star wars is lost, because there are no observations where company == "star wars" in y = movies.

##### left\_join(studios,movies)

> left\_join(x, y): Return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#left join
suppressWarnings(suppressMessages(
  left_join(studios,movies)
))
```

    ##      company yr_founded           names release_year        directors
    ## 1     Marvel       1934        Iron Man         2008      Jon Favreau
    ## 2     Marvel       1934            Thor         2008  Kenneth Branagh
    ## 3     Marvel       1934    The Avengers         2011      Joss Whedon
    ## 4     Marvel       1934         Ant Man         2015      Peyton Reed
    ## 5     Marvel       1934  Doctor Strange         2016 Scott Derrickson
    ## 6         DC       1939    Man of steel         2013      Zack Snyder
    ## 7         DC       1939 Dawn of Justice         2016      Zack Snyder
    ## 8         DC       1939   Suicide squad         2016       David Ayer
    ## 9         DC       1939    Wonder woman         2017    Patty Jenkins
    ## 10        DC       1939  Justice league         2017      Zack Snyder
    ## 11 Star trek       1966            <NA>         <NA>             <NA>

We get a similar result as with inner\_join() but the company star wars survives in the join, even though no moveis from star wars that appear in y = movies. As a result, star wars has NA in names,release\_year and directors.

##### anti\_join(studios,moviess)

> anti\_join(x, y): Return all rows from x where there are not matching values in y, keeping just columns from x. This is a filtering join.

``` r
#anti join
suppressWarnings(suppressMessages(
  anti_join(studios,movies)
))
```

    ##     company yr_founded
    ## 1 Star trek       1966

We keep only company star wars now (and the variables found in x = studios).

##### full\_join

> full\_join(x, y): Return all rows and all columns from both x and y. Where there are not matching values, returns NA for the one missing. This is a mutating join.

``` r
#full join
suppressWarnings(suppressMessages(
  full_join(movies,studios)
))
```

    ##              names release_year        directors   company yr_founded
    ## 1         Iron Man         2008      Jon Favreau    Marvel       1934
    ## 2             Thor         2008  Kenneth Branagh    Marvel       1934
    ## 3     The Avengers         2011      Joss Whedon    Marvel       1934
    ## 4          Ant Man         2015      Peyton Reed    Marvel       1934
    ## 5   Doctor Strange         2016 Scott Derrickson    Marvel       1934
    ## 6     Man of steel         2013      Zack Snyder        DC       1939
    ## 7  Dawn of Justice         2016      Zack Snyder        DC       1939
    ## 8    Suicide squad         2016       David Ayer        DC       1939
    ## 9     Wonder woman         2017    Patty Jenkins        DC       1939
    ## 10  Justice league         2017      Zack Snyder        DC       1939
    ## 11   Force awakens         2015      J.J. Abrams Star wars         NA
    ## 12            <NA>         <NA>             <NA> Star trek       1966

We get all rows of x = movies plus a new row from y = movies, containing the company star wars. We get all variables from x = movies AND all variables from y = studios. Any row that derives solely from one table or the other carries NAs in the variables found only in the other table.
