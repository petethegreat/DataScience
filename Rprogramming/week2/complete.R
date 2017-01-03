
complete<-function(directory,id=1:332)
{

# run over the files in directory specified by cases
# count the total number of complete cases (rows with no missing values)
# return the total number of complete observations over all indicated files

nobsvec=vector('numeric',length=length(id))
for (index in seq(along.with=id))
{
    theid<-id[index]
    filename<-sprintf('%s/%03d.csv',directory,theid) # file to read
    #print(paste('loading file',filename))

    theframe<-read.csv(filename) # load dataframe
    nobsvec[index] <-sum(complete.cases(theframe))

}
moose<-data.frame(id=id,nobs=nobsvec)
return(moose)
}
