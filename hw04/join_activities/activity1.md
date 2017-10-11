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

Lets view the dataset data1

``` r
tableFormat(data1)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
</tr>
<tr>
<td style="text-align:center;">
North America
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
NOA
</td>
</tr>
<tr>
<td style="text-align:center;">
South America
</td>
<td style="text-align:center;">
NS
</td>
<td style="text-align:center;">
SOA
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
</tr>
<tr>
<td style="text-align:center;">
Antarctica
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
AN
</td>
</tr>
</tbody>
</table>
Lets view the other dataset my\_gap

``` r
tableFormat(my_gap)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
48.86533
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
64.65874
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
60.06490
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
71.90369
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
74.32621
</td>
</tr>
</tbody>
</table>
Lets explore the different ways of joining these two dataframes.

### Different types of join

#### inner\_join(data1,my\_gap)

``` r
#inner_join
suppressWarnings(suppressMessages(
  tableFormat(inner_join(data1,my_gap,by="continent"))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
<td style="text-align:center;">
60.06490
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
<td style="text-align:center;">
48.86533
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
<td style="text-align:center;">
71.90369
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
<td style="text-align:center;">
74.32621
</td>
</tr>
</tbody>
</table>
#### inner\_join(my\_Gap,data1)

``` r
suppressWarnings(suppressMessages(
  tableFormat(inner_join(my_gap,data1,by="continent"))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
48.86533
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
60.06490
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
71.90369
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
74.32621
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
</tr>
</tbody>
</table>
Both the inner join commands give the same output. This operation returns the common rows from both datasets along with all columns from both datasets.(It is intersection of both datasets) Here the number of common rows is four continents and total number of columns is 4.

#### left\_join

``` r
#left join
suppressWarnings(suppressMessages(
  tableFormat(left_join(data1,my_gap))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
<td style="text-align:center;">
60.06490
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
<td style="text-align:center;">
48.86533
</td>
</tr>
<tr>
<td style="text-align:center;">
North America
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
NOA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
South America
</td>
<td style="text-align:center;">
NS
</td>
<td style="text-align:center;">
SOA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
<td style="text-align:center;">
71.90369
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
<td style="text-align:center;">
74.32621
</td>
</tr>
<tr>
<td style="text-align:center;">
Antarctica
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
AN
</td>
<td style="text-align:center;">
NA
</td>
</tr>
</tbody>
</table>
This operation returns all rows from the first dataset(data1 in this case) and all columns from both datasets. When a row from first dataset has no match, NA values will be present. This happens in the above case for North America,South America and Antarctica as these are not present in my\_gap dataset. So the mean\_lifeExp values are filled with NA.

#### right\_join

``` r
#right join
suppressWarnings(suppressMessages(
  tableFormat(right_join(data1,my_gap))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
<td style="text-align:center;">
48.86533
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
64.65874
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
<td style="text-align:center;">
60.06490
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
<td style="text-align:center;">
71.90369
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
<td style="text-align:center;">
74.32621
</td>
</tr>
</tbody>
</table>
**right\_join** does the same thing as **left\_join** but on the second dataset. Here the rows from second dataset are returned. Hence, americas has code and hemisphere value as NA since it is not found in data1 dataset.

#### full\_join

``` r
#full join
suppressWarnings(suppressMessages(
  tableFormat(full_join(data1,my_gap))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
<th style="text-align:center;">
mean\_lifeExp
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
<td style="text-align:center;">
60.06490
</td>
</tr>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
<td style="text-align:center;">
48.86533
</td>
</tr>
<tr>
<td style="text-align:center;">
North America
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
NOA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
South America
</td>
<td style="text-align:center;">
NS
</td>
<td style="text-align:center;">
SOA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
<td style="text-align:center;">
71.90369
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
<td style="text-align:center;">
74.32621
</td>
</tr>
<tr>
<td style="text-align:center;">
Antarctica
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
AN
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
Americas
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
64.65874
</td>
</tr>
</tbody>
</table>
Returns all rows and columns from both datasets. Missing values are filled with NAs.Therefore it returns eight columns(it is similar to union of both dataframes).

#### semi\_join

``` r
#semi join
suppressWarnings(suppressMessages(
  tableFormat(semi_join(data1,my_gap))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
Africa
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AF
</td>
</tr>
<tr>
<td style="text-align:center;">
Asia
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
AS
</td>
</tr>
<tr>
<td style="text-align:center;">
Europe
</td>
<td style="text-align:center;">
Northern
</td>
<td style="text-align:center;">
EU
</td>
</tr>
<tr>
<td style="text-align:center;">
Oceania
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
OC
</td>
</tr>
</tbody>
</table>
Returns rows of first dataset that are common with second dataset keeping only the columns of first dataset. (similar to intersection of two datasets with only columns from first dataset). So only three columns of data1 is returned with only four rows(the ones corrosponding to common continents)

#### anti\_join

``` r
#anti join
suppressWarnings(suppressMessages(
  tableFormat(anti_join(data1,my_gap))
))
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
continent
</th>
<th style="text-align:center;">
hemisphere
</th>
<th style="text-align:center;">
codes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
North America
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
NOA
</td>
</tr>
<tr>
<td style="text-align:center;">
South America
</td>
<td style="text-align:center;">
NS
</td>
<td style="text-align:center;">
SOA
</td>
</tr>
<tr>
<td style="text-align:center;">
Antarctica
</td>
<td style="text-align:center;">
Southern
</td>
<td style="text-align:center;">
AN
</td>
</tr>
</tbody>
</table>
Returns all rows from first dataset that are not matching with second dataset keeping only the columns of first dataset.Returns only the three rows in first dataset that are not there in second dataset.(similar to first dataset - second dataset)
