## Repo for Seventh Homework - First of Stat 547M Course 

This is the *readme file* for the seventh homework. In this homework, the automation pipeline was explored. **Gapminder** dataset was used for this purpose. 

### Summary
In this homework, Gapminder dataset was cleaned, aggregated,analyzed and results were rendered in R markdown file through makefile pipeline.

The contents of this homework are:
+ [00_download_data.R]: (**Download data**)
  - Downloads the gapminder dataset and saves it locally.
+ [01_exploratory_analysis.R]: (**cleaning & exploratory analysis**)
  - Reads the data and does cleaning tasks
  - Renders and saves basic plots such as histogram,density and frequency plot.
  - Continent factor variable is reordered and the data is saved in rds format to keep reordering intact.
+ [02_statistical_analysis.R]: (**aggregating & statistical analysis**)
  - Reads in the rds data.
  - Fits a linear regression model for lifeExp vs year for each country
  - Reports Best and worst 5 countries based on R_squared and residual error std.
  - Saves lifeExp vs year figures for each country over different continents.
+ [03_report.Rmd]: (**final report**)
  - Presents the original data,cleaned data and the changes.
  - Shows the different plots and the reordered data.
  - Imports figures and also Presents the best and worst countries.
+ [makefile]:
  - It is the one stop location reponsible for running all files in sequence.
  - It renders the Rmarkdown to give the Html file.
+ [makefile.R]: 
  - Extra R script file that functions similar to makefile.
  - It renders the Rmarkdown to give the pdf file.
  
### Report your process

Most of the work in the R scripts and R markdown were easier. 
1. I am a windows user and I faced difficulty getting make to work. Later, realized that the 'curl' command alone didnt work and rest worked with make.
2. I also had problems installing pandoc to render the files. I also didnt have latex and this was resulting in problems as I couldn't render documents in pdf.
3. It was a great homework as it helped me understand how automated pipeline works and its importance in group projects where work can be done independently which can be combined later.

The resources that helped me are:

+ [Data Analysis Pipeline Shaun Jackman](https://github.com/sjackman/makefile-example/)
+ [Introduction to Make](http://kbroman.github.io/minimal_make/)
+ [Using Make for reproducible scientific analyses](http://www.bendmorris.com/2013/09/using-make-for-reproducible-scientific.html)
+ [Stack Overflow](https://stackoverflow.com/questions/26007005/using-makefile-to-clean-subdirectories)