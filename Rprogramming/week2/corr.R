
# second attempt, only one loop, but not sure if it's much faster.
corr<-function(directory,threshold=0)
{
    corrvec<-numeric(length=0)
    for (theid in 1:332)
    {
        filename<-sprintf('%s/%03d.csv',directory,theid)
        theframe<-read.csv(filename)
        if (sum(complete.cases(theframe)) > threshold)
        {
            thecor<-cor(theframe$nitrate,theframe$sulfate,use='complete.obs')
            corrvec<-c(corrvec,thecor)
        }
    }
    return(corrvec)

}
#####################################################

# this works, but is slow. 
oldcorr<-function(directory,threshold=0)
{
#make use of the complete function from part 2. 
# It's copied and renamed below, so that everything needed is in this file
# (and won't conflict if complete.R is still loaded/reloaded)
cases<-complete2(directory)

# logical vector for the number of cases above threshold
abovethres<- cases$nobs > threshold
# count the nuber of cases above threshold, and allocate a vector for the correlations

thecount<-sum(abovethres)

# print(paste('cases = ',thecount))

correlations<-numeric(length=thecount)

if (thecount==0)
{
    return(correlations)
}

for (index in 1:thecount)
{
    theid<-cases[abovethres,][[index,'id']]
    filename<-sprintf('%s/%03d.csv',directory,theid)
    monitor<-read.csv(filename)
    thecor<-cor(monitor$nitrate,monitor$sulfate,use='complete.obs')
    correlations[index]<-thecor
}
return(correlations)

}
####################################################################
complete2<-function(directory,id=1:332)
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
