# Getting and Cleaning Data

## Things that make a good dataset
- the Raw data - this is as it was found/downloaded. Before you have done anything to it/ran anythin on it.
- the Tidy data- one column for each variable, one row for each observation. Different tables for different 'types' of variables (should contain foreign keys to relate to each other, if needed). A row at the top for column names
- a codebook 
-- a markdown file or document that describes exactly what all the variables are in the tidy data set, especially any units.
-- information about the study design, how the data was collected, how it has been summarised, any choices made
- an instruction list, an explicit recipe to get from the raw data to the tidy data. This can be in the form of an R script. Ideally this script should not take any parameters. If external software needs to be run, then the program, it's version, and any arguments should be noted.

## Downloading files

First, set the working directory
'''R
setwd('./data')
'''

"file.exists(dirname)" can be used to check whether the directory exists, and "dir.create(dirname)" can be used to create the directory if it does not exist.

The "download.file" function can be used to download a file:
'''R
fileurl<-"https://theurl.com/data"
download.file(fileurl,destfile='./data/thedata.csv',method='curl')
list.files('./data')
'''
For 'https' urls, might need to use method=curl. 
be sure to use "dateDownloaded<-date()" to record **when** the file was downloaded.

## Reading data
-read.table is good for flat, text based files. It is similar to read.csv but you can specify the delimiter, characters that should be interpreted as quotes,strings to interpret as NA, the number of rows to read, etc.
- read.xlsx, read.xlsx2 for excel files. XLconnect is a package that has some options for excel stuff.

### XML

wikipedia article: <http://en.wikipedia.org/wiki/XML>
'''R
library('XML')
doc<-xmlTreeParse(xmlurl,useInternal=true)
rootNode<-xmlRoot(doc)
'''
the elements under the root node can then be accessed using '''rootNode[[1]]'''

xmlSApply - like the sapply function, applies the specified function to given node

XPath - '/node' is the top node, '//node' for nodes at any level. See [this pdf](./XML.pdf) for some notes on XPath.
xpathSApply(rootNode,'//name',some.function)



### JSON

'''R
library('jsonlite')
data<-fromJSON('url or text')
json<-toJSON(dataframe)
'''

## data tables
Can do certain things much faster than data frames

## HDF5
Hierarchal Data Format. Designed for storing and organising large amounts of data
organises things into Datasets (multidimensional arrays), and Groups (hold Datasets)
Can be used to read and write things to disk. A fraction of a Dataset/dataframe can be read/written at a time, so you do not need to load the full dataset into R to work with a subset of it.

##Reading data from the web
'''R
con<-url('www.website.com/pages/webpage.html')
htmlcode<-readlines(con)
close(con)
htmlcode
'''
Alternatively (more usefully), use htmlTreeParse:
'''R
library('XML')
theurl<-'www.website.com/pages/webpage.html'
thehtml<-htmlTreeParse(url,useInternalNode=TRUE)
XPathSApply(thehtml,'//node',xmlValue)
'''
use GET to pull the html, then parse it
'''R
library('httr')
thehtml2<-GET(theurl)
thecontent=content(thehtml2,as='text')
theparsedhtml<-htmlparse(thecontent,asText=TRUE)
XpathSApply(theparsedhtml,...)
'''
GET can also take authenticate options for connecting to websites that require usernames and passwords.






## reshaping data
this page is good [http://seananderson.ca/2013/10/19/reshape.html]
Sometimes things are organised weirdly. The melt function can be used to "dissolve" a dataframe, making it easier to reshape it into the desired form.
'''R
> library('reshape2')
> mtcars$carname<-rownames(mtcars)
> melted<-melt(mtcars,id=c('carname','gear','cyl'),measure.vars=c('hp','wt','mpg'))
> head(melted,n=3)
        carname gear cyl variable value
1     Mazda RX4    4   6       hp   110
2 Mazda RX4 Wag    4   6       hp   110
3    Datsun 710    4   4       hp    93

> tail(melted,n=3)
         carname gear cyl variable value
94  Ferrari Dino    5   6      mpg  19.7
95 Maserati Bora    5   8      mpg  15.0
96    Volvo 142E    4   4      mpg  21.4

'''
melt makes a very tall, thin dataframe ('long format' data), with a column for each of the id variables, and then one 'variable' column and one 'value' column. This makes it very easy to subset the data and individually select the desired variables.


dcast can be used to summarise the melted data. dcast takes a melted (molten) dataframe and casts it into  a dataframe (acast casts to array/vector/matrix). Syntax is dcast(melted,formula,aggregate), where melted is the input dataset, formula defines the relationship between id columns and variable columns (x + y ~ z will treat z as dependant on x and y). If there are multiple observations for a given combination of id identifiers, then an aggregate function is used. By default length is used if nothing is specified. 

'''R
> cylData<-dcast(melted,cyl ~ variable,mean)
> cylData
  cyl        hp       wt      mpg
1   4  82.63636 2.285727 26.66364
2   6 122.28571 3.117143 19.74286
3   8 209.21429 3.999214 15.10000
'''
This gives the mean hp, wt, and mpg as a function of number of cylinders.

ddply from the plyr package will also do split apply combine type operations.
'''R
> ddply(mtcars,.(cyl),summarize,mean=mean(mpg))
  cyl     mean
1   4 26.66364
2   6 19.74286
3   8 15.10000
> ddply(mtcars,'cyl',summarize,mean=mean(mpg))
  cyl     mean
1   4 26.66364
2   6 19.74286
3   8 15.10000
'''

dplyer - optimised version of plyr

'verbs`
- select - return subset of columns
- filter - subset data by row
- arrange - rename variables
- mutate - add new rows/columns
- summarize - generate summary statisttics

kind of the same old operations, but syntax is simpler, can do things in fewer steps.
Pretty handy.
Also, for tidying, package tidyr works well. 'gather' merges multiple columns into a single column as a key-value pair (gather(data,key,value,columns_to:gather)). This is similar to melt
seperate takes one column and seperates it into multiple



'''R
> amtcars<-arrange(mtcars,mpg)
> head(amtcars,n=3)
   mpg cyl disp  hp drat    wt  qsec vs am gear carb             carname
1 10.4   8  472 205 2.93 5.250 17.98  0  0    3    4  Cadillac Fleetwood
2 10.4   8  460 215 3.00 5.424 17.82  0  0    3    4 Lincoln Continental
3 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4          Camaro Z28
'''
can use %>% to pipe things. when doing stuff with dplyr functions, the output from a pipe is implicitly assumed to be the first argument.

## merging data
merge() - like a join in sql
merged<-merge(x,y,by.x='yid',by.y='id',all=true)
select * from x join y on x.yid=y.id
join from plyr does similar things, fewer features. requires joining columns to have the same name.


