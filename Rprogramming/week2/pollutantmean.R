
# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate)
# across a specified list of monitors. 
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant',
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitor's 
# particulate matter data from the directory specified in the 'directory' argument and returns
# the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.
# A prototype of the function is as follows

pollutantmean<- function(directory, pollutant, id=1:332)
{
 # directory is a char vector of length 1, specifying location of the csv files
 # pollutant is a character vector of length 1, either 'sulfate' or 'nitrate'

 # id is an integer vector listing the ids of monitors to be used


# check that a valid value is given for pollutant

if (pollutant != 'nitrate' & pollutant != 'sulfate')
{
errstr <- sprintf('Error, \"pollutant\" must be equal to either "nitrate" or "sulfate" (%s given)',pollutant)
print(errstr)
return()
}

# loop over files. keep track of the total number of (not missing) entries, and their sum
# after loop, take mean as sum/count

mysum<-0
mycount<-0

for (i in id)
{
    filename<-sprintf('%s/%03d.csv',directory,i) # file to read
    #print(paste('loading file',filename))

    theframe<-read.csv(filename) # load dataframe
    notmissing<-theframe[!is.na(theframe[,pollutant]),pollutant]
    thecount <-length(notmissing)
    if (thecount ==0) next
    thesum <- sum(theframe[pollutant],na.rm=TRUE) # take the sum of the pollutant column, ignoring na
    
    # extract the not missing values of the pollutant from the dataframe
    # all use [rows,columns] to subset theframe
    # want the rows where pollutant is not missing : !is.na(theframe[,pollutant])
    # only want the pollutant column
    
    
    mysum<-mysum + thesum
    mycount<- mycount + thecount
    #output<-sprintf('file %s: sum = %f, count = %d',filename,thesum,thecount)
    #print(output)
}

return(mysum/mycount)



}