activity5.Rmd
================

### General data reshaping and relationship to aggregation

#### Activity \#5

Lets prepare the dataset for this activity

``` r
#prepare the dataset

dat <- data.frame(
  id = LETTERS[1:5],
   x = sample(0:1, 5, TRUE),
   y = sample(0:1, 5, TRUE),
   z = sample(0:1, 5, TRUE),
   category = c("N1","N2","N3","N4","N5"),
   score = c(134.54,123.23,112.38,129.5,110.8)
)

for(i in 1:5) 
{
      dat<- rbind(dat,c(LETTERS[i],1,0,0,
                        gsub(" ", "",paste('N',as.character(i)), fixed = TRUE),
                        180+i*2.3456))
}
dat$x<-as.numeric(dat$x)
dat$y<-as.numeric(dat$y)
dat$z<-as.numeric(dat$z)
dat$score<-as.numeric(dat$score)
```

**Group**

``` r
#group
B<- dat%>%
      group_by(id,category)%>%
      summarize(Nrows=n(),value=sum(score))
tableFormat(B)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
Nrows
</th>
<th style="text-align:center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
316.8856
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
307.9212
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
299.4168
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
318.8824
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
302.5280
</td>
</tr>
</tbody>
</table>
**Split**

``` r
C <- dcast(B,id~category,value.var="Nrows",fill=0)
tableFormat(C)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
N1
</th>
<th style="text-align:center;">
N2
</th>
<th style="text-align:center;">
N3
</th>
<th style="text-align:center;">
N4
</th>
<th style="text-align:center;">
N5
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
2
</td>
</tr>
</tbody>
</table>
**Stack**

``` r
D <- melt(C,id="id") %>%
  arrange(id)
tableFormat(D)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
variable
</th>
<th style="text-align:center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
2
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
2
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
2
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
2
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
0
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
2
</td>
</tr>
</tbody>
</table>
**Join**

``` r
#join with left_join
first<-data.frame(category=c("A","B","C"), value=10:12)
second<- data.frame(category=c("A","B","B","B","C","A"), 
                    id=c("a","a","a","b","c","b"))
output <- left_join(second,first,by="category")
tableFormat(output)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
10
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
b
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
c
</td>
<td style="text-align:center;">
12
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
b
</td>
<td style="text-align:center;">
10
</td>
</tr>
</tbody>
</table>
``` r
#join with merge function
output_merge <- merge(second,first)
tableFormat(output_merge)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
10
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
b
</td>
<td style="text-align:center;">
10
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
b
</td>
<td style="text-align:center;">
11
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
c
</td>
<td style="text-align:center;">
12
</td>
</tr>
</tbody>
</table>
Although columns now come out sorted when used merge.

**Subset**

``` r
sub_set <- filter(output,category=="A")
tableFormat(sub_set)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
a
</td>
<td style="text-align:center;">
10
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
b
</td>
<td style="text-align:center;">
10
</td>
</tr>
</tbody>
</table>
**Transpose**

``` r
sub_set_transpose <- data.frame(t(sub_set))
kable(sub_set_transpose)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
X1
</th>
<th style="text-align:left;">
X2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
category
</td>
<td style="text-align:left;">
A
</td>
<td style="text-align:left;">
A
</td>
</tr>
<tr>
<td style="text-align:left;">
id
</td>
<td style="text-align:left;">
a
</td>
<td style="text-align:left;">
b
</td>
</tr>
<tr>
<td style="text-align:left;">
value
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
10
</td>
</tr>
</tbody>
</table>
**Sort**

``` r
dat_arranged <- arrange(dat,id,category,score,x,y,z)
tableFormat(dat_arranged)
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
<th style="text-align:center;">
id
</th>
<th style="text-align:center;">
x
</th>
<th style="text-align:center;">
y
</th>
<th style="text-align:center;">
z
</th>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
score
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.5400
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
182.3456
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
123.2300
</td>
</tr>
<tr>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
184.6912
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
112.3800
</td>
</tr>
<tr>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
187.0368
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
129.5000
</td>
</tr>
<tr>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
189.3824
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
110.8000
</td>
</tr>
<tr>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
191.7280
</td>
</tr>
</tbody>
</table>
