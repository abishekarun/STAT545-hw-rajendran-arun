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
tableFormat(movies)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Force awakens
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
J.J. Abrams
</td>
<td style="text-align:center;">
Star wars
</td>
</tr>
</tbody>
</table>
``` r
tableFormat(studios)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Star trek
</td>
<td style="text-align:center;">
1966
</td>
</tr>
</tbody>
</table>
### Different types of join

##### inner\_join(movies,studios)

> inner\_join(x, y): Return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#inner_join
suppressWarnings(suppressMessages(
  tableFormat(inner_join(movies,studios))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
</tbody>
</table>
We lose Force Awakens in the join because, although they appear in x = movies, their corrosponding company "Star wars" doesn't not appear in y = studios. The join result has all variables from x = movies plus yr\_founded, from y.

##### semi\_join(movies,studios)

> semi\_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.

``` r
#semi join
suppressWarnings(suppressMessages(
  tableFormat(semi_join(movies,studios))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
<td style="text-align:center;">
Marvel
</td>
</tr>
<tr>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
<td style="text-align:center;">
DC
</td>
</tr>
<tr>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
</tr>
</tbody>
</table>
We get a similar result as with inner\_join() but the join result contains only the variables originally found in x = movies. But note the row order has changed.

##### left\_join(movies,studios)

> left\_join(x, y): Return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#left join
suppressWarnings(suppressMessages(
  tableFormat(left_join(movies,studios))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Force awakens
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
J.J. Abrams
</td>
<td style="text-align:center;">
Star wars
</td>
<td style="text-align:center;">
NA
</td>
</tr>
</tbody>
</table>
We basically get x = movies back, but with the addition of variable yr\_founded, which is unique to y = studios. Force Awakens, whose company don't appear in y = studios, has an NA for company.

##### anti\_join(movies,studios)

> anti\_join(x, y): Return all rows from x where there are not matching values in y, keeping just columns from x. This is a filtering join.

``` r
#anti join
suppressWarnings(suppressMessages(
  tableFormat(anti_join(movies,studios))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Force awakens
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
J.J. Abrams
</td>
<td style="text-align:center;">
Star wars
</td>
</tr>
</tbody>
</table>
We keep only Force Awakens now (and do not get company).

##### inner\_join(studios,movies)

> inner\_join(x, y): Return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.

``` r
#inner_join
suppressWarnings(suppressMessages(
  tableFormat(inner_join(studios,movies))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
</tr>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
</tr>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
</tr>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
</tr>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
</tr>
</tbody>
</table>
In a way, this does illustrate multiple matches, if you think about it from the x = studios direction. Every company that has a match in y = movies appears multiple times in the result, once for each match. In fact, we’re getting the same result as with inner\_join(movies,studios), up to variable order (which you should also never rely on in an analysis).

##### semi\_join(studios,movies)

> semi\_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.

``` r
#semi join
suppressWarnings(suppressMessages(
  tableFormat(semi_join(studios,movies))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
</tbody>
</table>
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
  tableFormat(anti_join(studios,movies))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Star trek
</td>
<td style="text-align:center;">
1966
</td>
</tr>
</tbody>
</table>
We keep only company star wars now (and the variables found in x = studios).

##### full\_join

> full\_join(x, y): Return all rows and all columns from both x and y. Where there are not matching values, returns NA for the one missing. This is a mutating join.

``` r
#full join
suppressWarnings(suppressMessages(
  tableFormat(full_join(movies,studios))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
names
</th>
<th style="text-align:center;">
release\_year
</th>
<th style="text-align:center;">
directors
</th>
<th style="text-align:center;">
company
</th>
<th style="text-align:center;">
yr\_founded
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Iron Man
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Jon Favreau
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Thor
</td>
<td style="text-align:center;">
2008
</td>
<td style="text-align:center;">
Kenneth Branagh
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
The Avengers
</td>
<td style="text-align:center;">
2011
</td>
<td style="text-align:center;">
Joss Whedon
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Ant Man
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
Peyton Reed
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Doctor Strange
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Scott Derrickson
</td>
<td style="text-align:center;">
Marvel
</td>
<td style="text-align:center;">
1934
</td>
</tr>
<tr>
<td style="text-align:center;">
Man of steel
</td>
<td style="text-align:center;">
2013
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Dawn of Justice
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Suicide squad
</td>
<td style="text-align:center;">
2016
</td>
<td style="text-align:center;">
David Ayer
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Wonder woman
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Patty Jenkins
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Justice league
</td>
<td style="text-align:center;">
2017
</td>
<td style="text-align:center;">
Zack Snyder
</td>
<td style="text-align:center;">
DC
</td>
<td style="text-align:center;">
1939
</td>
</tr>
<tr>
<td style="text-align:center;">
Force awakens
</td>
<td style="text-align:center;">
2015
</td>
<td style="text-align:center;">
J.J. Abrams
</td>
<td style="text-align:center;">
Star wars
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
Star trek
</td>
<td style="text-align:center;">
1966
</td>
</tr>
</tbody>
</table>
We get all rows of x = movies plus a new row from y = movies, containing the company star wars. We get all variables from x = movies AND all variables from y = studios. Any row that derives solely from one table or the other carries NAs in the variables found only in the other table.
