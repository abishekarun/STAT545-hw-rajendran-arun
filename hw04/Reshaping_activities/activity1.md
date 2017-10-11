activity1.Rmd
================

### General data reshaping and relationship to aggregation

#### Activity \#1

Lets explore the important tidyr functions and how they are similar to the dplyr functions.

Lets build a data for our purpose..

``` r
dat <- data.frame(
  id = LETTERS[1:5],
   x = sample(0:1, 5, TRUE),
   y = sample(0:1, 5, TRUE),
   z = sample(0:1, 5, TRUE),
   category = c("N1","N2","N3","N4","N5"),
   score = c(134.54,123.23,112.38,129.5,110.8)
)
tableFormat(dat,"Sample Data")
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Sample Data
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
0
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
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
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
123.23
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
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
112.38
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
129.50
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
1
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
</tbody>
</table>
**gather()**

Lets explore the function gather().

``` r
dat%>%
  gather(coordinate,values,-c(category,id))%>% #dont gether category and id
  tableFormat()
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
coordinate
</th>
<th style="text-align:center;">
values
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
x
</td>
<td style="text-align:center;">
1.00
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
x
</td>
<td style="text-align:center;">
0.00
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
x
</td>
<td style="text-align:center;">
1.00
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
x
</td>
<td style="text-align:center;">
1.00
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
x
</td>
<td style="text-align:center;">
0.00
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
0.00
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
y
</td>
<td style="text-align:center;">
1.00
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
y
</td>
<td style="text-align:center;">
1.00
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
y
</td>
<td style="text-align:center;">
0.00
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
y
</td>
<td style="text-align:center;">
1.00
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
0.00
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
z
</td>
<td style="text-align:center;">
0.00
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
z
</td>
<td style="text-align:center;">
1.00
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
z
</td>
<td style="text-align:center;">
0.00
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
z
</td>
<td style="text-align:center;">
1.00
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
score
</td>
<td style="text-align:center;">
134.54
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
score
</td>
<td style="text-align:center;">
123.23
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
score
</td>
<td style="text-align:center;">
112.38
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
score
</td>
<td style="text-align:center;">
129.50
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
score
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
</tbody>
</table>
``` r
dat%>%
  gather(coordinate,values,-c(category,id,score))%>%
  tableFormat()
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
score
</th>
<th style="text-align:center;">
coordinate
</th>
<th style="text-align:center;">
values
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
134.54
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
123.23
</td>
<td style="text-align:center;">
x
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
112.38
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
110.80
</td>
<td style="text-align:center;">
x
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
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
y
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
123.23
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
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
112.38
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
y
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
110.80
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
z
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
123.23
</td>
<td style="text-align:center;">
z
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
112.38
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
z
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
110.80
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
</td>
</tr>
</tbody>
</table>
``` r
dat%>%
  gather(coordinate,values,x:z,-y)%>%   #gathering only x&z
  tableFormat()
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
y
</th>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
score
</th>
<th style="text-align:center;">
coordinate
</th>
<th style="text-align:center;">
values
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
N2
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
x
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
1
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
N4
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
N5
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
x
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
0
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
z
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
1
</td>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
z
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
1
</td>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
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
N4
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
z
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
1
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
</td>
</tr>
</tbody>
</table>
``` r
#gather(),separate(),spread(),extract()
```

**spread()** This does the opposite of the function gather().

``` r
dat%>%
  gather(coordinate,values,x,y)%>%
  spread(coordinate,values)%>%
  tableFormat()
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
z
</th>
<th style="text-align:center;">
category
</th>
<th style="text-align:center;">
score
</th>
<th style="text-align:center;">
x
</th>
<th style="text-align:center;">
y
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
1
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
N2
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
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
N3
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
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
N4
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
1
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
1
</td>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
</tr>
</tbody>
</table>
``` r
dat%>%
  gather(coordinate,values,-c(category,id,score))%>%
  tableFormat()
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
score
</th>
<th style="text-align:center;">
coordinate
</th>
<th style="text-align:center;">
values
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
134.54
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
123.23
</td>
<td style="text-align:center;">
x
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
112.38
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
x
</td>
<td style="text-align:center;">
1
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
110.80
</td>
<td style="text-align:center;">
x
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
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
y
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
123.23
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
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
112.38
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
y
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
110.80
</td>
<td style="text-align:center;">
y
</td>
<td style="text-align:center;">
1
</td>
</tr>
<tr>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
z
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
123.23
</td>
<td style="text-align:center;">
z
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
112.38
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
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
129.50
</td>
<td style="text-align:center;">
z
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
110.80
</td>
<td style="text-align:center;">
z
</td>
<td style="text-align:center;">
1
</td>
</tr>
</tbody>
</table>
``` r
dat%>%
  gather(coordinate,values,-c(category,id,score))%>%
  spread(coordinate,values)%>%
  spread(category,score,fill=0)%>%
  tableFormat()
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
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
0.0
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
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
0.0
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
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
0.0
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
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
129.5
</td>
<td style="text-align:center;">
0.0
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
1
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.00
</td>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
110.8
</td>
</tr>
</tbody>
</table>
Note the re ordering of columns after performing gathering and spreading operations simultaneously.

Now, lets look at **extract()**,**complete()**, **expand()** and **replace\_na()**

``` r
#taking no. in category & get variable class
dat%>%
  extract(category,"class",regex="([0-9]+)")%>%
  tableFormat()  
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
class
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
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
134.54
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
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
2
</td>
<td style="text-align:center;">
123.23
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
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
3
</td>
<td style="text-align:center;">
112.38
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
4
</td>
<td style="text-align:center;">
129.50
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
1
</td>
<td style="text-align:center;">
5
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
</tbody>
</table>
``` r
#Creates rows for each id for each score in the data.
dat%>%
  complete(category, nesting(id),score)%>%
  tableFormat()  
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
score
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
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
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
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
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
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
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
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
<td style="text-align:center;">
NA
</td>
</tr>
</tbody>
</table>
``` r
# complete is for a common application of expand
dat%>%
  expand(category,nesting(id),score)%>%
  tableFormat()  
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
score
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
112.38
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
123.23
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
129.50
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
134.54
</td>
</tr>
</tbody>
</table>
``` r
#complete() - completing a data frame with missing combinations.
#expand() - Expanding a data frame to include all combinations.

dat%>%
  complete(category, nesting(id,score))%>%
  #Finds the combinations of id and score that occur in the data.
  replace_na(list(x=-1,y=-1,z=-1))%>%
  #Replaces the na values with -1 in x,y,z.
  tableFormat()  
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
score
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
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
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
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N1
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
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
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N2
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N3
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
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
</tr>
<tr>
<td style="text-align:center;">
N4
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
A
</td>
<td style="text-align:center;">
134.54
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
B
</td>
<td style="text-align:center;">
123.23
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
C
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
D
</td>
<td style="text-align:center;">
129.50
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
<td style="text-align:center;">
-1
</td>
</tr>
<tr>
<td style="text-align:center;">
N5
</td>
<td style="text-align:center;">
E
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
</tr>
</tbody>
</table>
**separate()** and **unite()** functions Lets explore the functions separate() and unite().

``` r
dat%>%
  unite(idAndCategory,id,category,sep=":",remove = FALSE)%>%
  select(-id,-category)%>%
  separate(idAndCategory, c("id", "category"), ":")%>%
  tableFormat()  
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
x
</th>
<th style="text-align:center;">
y
</th>
<th style="text-align:center;">
z
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
N1
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
134.54
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
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
123.23
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
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
112.38
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
1
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
129.50
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
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
110.80
</td>
</tr>
</tbody>
</table>
**unnest()** function Now lets check the unnest() function.

``` r
#makes each element of list column its own row.
dat%>%
  unite(idAndCategory,id,category,sep=":",remove = FALSE)%>%
  select(-id,-category)%>%
  unnest(idAndCategory=strsplit(idAndCategory, ":"))%>%
  tableFormat()   
```

<table class="table table-striped table-hover table-responsive" style="font-size: 14px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
</caption>
<thead>
<tr>
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
score
</th>
<th style="text-align:center;">
idAndCategory
</th>
</tr>
</thead>
<tbody>
<tr>
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
134.54
</td>
<td style="text-align:center;">
A
</td>
</tr>
<tr>
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
134.54
</td>
<td style="text-align:center;">
N1
</td>
</tr>
<tr>
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
123.23
</td>
<td style="text-align:center;">
B
</td>
</tr>
<tr>
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
123.23
</td>
<td style="text-align:center;">
N2
</td>
</tr>
<tr>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
C
</td>
</tr>
<tr>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
112.38
</td>
<td style="text-align:center;">
N3
</td>
</tr>
<tr>
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
129.50
</td>
<td style="text-align:center;">
D
</td>
</tr>
<tr>
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
129.50
</td>
<td style="text-align:center;">
N4
</td>
</tr>
<tr>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
E
</td>
</tr>
<tr>
<td style="text-align:center;">
0
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
1
</td>
<td style="text-align:center;">
110.80
</td>
<td style="text-align:center;">
N5
</td>
</tr>
</tbody>
</table>
