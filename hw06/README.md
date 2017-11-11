## Repo for Sixth Homework - First of Stat 547M Course 

This is the *readme file* for the sixth homework. 
**Gapminder** dataset was explored.Different functions for linear regression models package such as **lm()**,**rl()** and **lmrob** etc were explored in this assignment. 
Functions such as **revgeocode** from ggmap package and **map()** from purrr package were explored for reading and writing tables. Also **leaflet** was used to obtain the interactive plot for visualzing geo codes.Lists were extensively explored following through the lesson from [purrr tutorial](https://jennybc.github.io/purrr-tutorial/index.html).
**Knitr** package was used for making nice tables.

You can find the [R markdown document](https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw06/hw06.Rmd),the [markdown document](https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw06/hw06.md)and 
[Rendered html file](http://htmlpreview.github.io/?https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw06/hw06.html)
for __gapminder data__.

### Report your process

Most of the work in markdown file was easier but was longer as compared to previous homworks. Difficulties that I experienced were
1. I didnt know that only 2500 queries can be made on revgeocode. After facing lot of difficulty I came to know about this and then sampled the data to small number.
2. Possibly doesnt show errors but still was showing the warning messages. It took some time for me to understand that they were not error messages and possibly was indeed working. 
3. It was a great homework as it helped me understand how to work with lists and the importance of map functions. I also understood the different linear regression models and how they can be analyzed.

The resources that helped me are:

+ [Stat Notes](http://stat545.com/block012_function-regress-lifeexp-on-year.html)
+ [Multiple linear regression - Quick R](https://www.statmethods.net/stats/regression.html)
+ [Separate](http://tidyr.tidyverse.org/reference/separate.html)
+ [ggmap](https://cran.r-project.org/web/packages/ggmap/ggmap.pdf)