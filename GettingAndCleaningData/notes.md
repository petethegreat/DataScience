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






