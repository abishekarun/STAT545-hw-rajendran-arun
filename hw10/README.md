## Repo for Tenth Homework - Data from Web

This is the *readme file* for the tenth homework. In this homework, different techniques to get data from web are explored.

### Process and reflection

- I found this homework a bit challenging, but now I have got better understanding of the different techniques to get data from web. 
- Make API querys using httr
  + For this part, I chose my own set of favorite movies and their release years for obtaining the results.
  + I faced certain challenges getting the data in a particular format. THe functions from tidyr package came very handy and helped me clean the data.
  + It helped me understand the way api works and I also got to explore other functions from tidyr,purrr for data clearning.
- Scrape the Web
  + It was difficult to find a website suitable for scraping without violating any policies and also ones without in built api. I ended up going forth with the musix match site explored in the class.
  + I obtained results for three different bands and I tried to traverse pages to obtain results for each band.
  + I had to map the two lists in this case which are of uneven sizes. This was difficult and went roundabout way of doing this using expand.grid to produce lists of same length.
- Use an R package that wraps an API
  + Prompt 1, For the first part, it was difficult to obtain the urban population data for years 1952 and 1957. So I ended up using data from 1962-2007 for both gapminder and urban population dataset. Getting the appropriate data was the difficult part and remainging process went easier thereon.
  + Prompt 1, The second part was difficult as it took sometime for me to get used to the different packages namely geonames and countrycode etc. as it is the first time I am using them. But later it was easy as the tip given was handy.
  + Prompt 2, It was difficult to imagine the format of data required  to combine the two datasets. It also took sometime figuring out how both the packages worked and then how to map one package to another. 
  - Overall, It was a great experience as now I am capable of obtaining data from web much easier courtesy of these three different useful techniques.

**Resources:**

- [Stat 545 Getting data from Web](http://stat545.com/webdata03_activity.html)
- [Remove html tags from string](https://stackoverflow.com/questions/17227294/removing-html-tags-from-a-string-in-r)
- [Importing data into R](https://rpubs.com/williamsurles/290389)
- [Factor reordering inside custom function for ggplot](https://stackoverflow.com/questions/35933199/dplyr-and-ggplot-in-a-function-use-reorder-in-aes-function)
- [expand.grid](https://stackoverflow.com/questions/39071763/create-all-possible-combinations-from-two-values-for-each-element-in-a-vector-in)
