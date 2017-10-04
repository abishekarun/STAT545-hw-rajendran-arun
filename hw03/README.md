## Repo for Third Homework of Stat 545A Course 

This is the *readme file* for the second homework. 
**Gapminder** dataset was explored.Different functions such as **filter()**,**piping** etc that belongs to **dplyr** package was explored in this assignment. Also **ggplot** was extensively explored in this assignment. **Knitr**,**kable** and **pander** package was used for making nice tables. Interesting features and stories in the dataset was explored.

You can find the [R markdown document](https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw03/hw03_gapminder.Rmd),the [markdown document](https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw03/hw03_gapminder.md) and the [Rendered Html 
File](http://htmlpreview.github.com/?https://github.com/abishekarun/STAT545-hw-rajendran-arun/blob/master/hw03/hw03_gapminder.html) for __gapminder data__.

### Report your process

Most of the work in markdown file was easier with the dplyr functions and ggplot.The difficulties that I experienced were
1. Embedding ggplot inside a function. This was very difficult and I found many links and ended up using aes_string to do the job,
2. Getting the plots and tables side by side was also kinda difficult but I ended by getting them after refering to the link and trying few times.
3. I found out the interesting trends in the data and also the reason behind them. I felt this exercise was really helpful as it helped me understand the purpose of data analysis and the different insights that can be obtained.

The resources that helped me are:

+ [ggplot cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf) 
+ [dplyr package manual](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf)
+ [html preview on github](https://stackoverflow.com/questions/8446218/how-to-see-an-html-page-on-github-as-a-normal-rendered-html-page-to-see-preview)
+ [side-by-side plot & table](https://gist.githubusercontent.com/jennybc/e9e9aba6ba18c72cec26/raw/31f8ea6b3f69dfb1fb473a00772c5b509e51ee42/2015-03-02_plot-next-to-table.rmd)
+ [Pander guide](http://rapporter.github.io/pander/pandoc_table.html)