library(httr)
library(jsonlite)
datasharing_date<-function()
{
    con<-dostuff() # get the data about jtleek's repos
    data<-fromJSON(con) # convert the response content from JSON to data frame

    # retrieve the date for datasharing

    date<-data[data$name=='datasharing',c('created_at')]





}

dostuff<-function()
{
# taken from https://github.com/hadley/httr/blob/master/demo/oauth2-github.r, modified by Pete

oauth_endpoints('github')


client_id<-'7fe937aaffc36d27acac'
client_secret<-'6f81679150d5a114dbe03c4085578e2fef24035d'
# id/secret registered to peteApp

peteApp<-oauth_app('github',key=client_id,secret=client_secret)


github_token<-oauth2.0_token(oauth_endpoints('github'),peteApp)
# get a token from github using the the details for peteApp

# now we have credentials from github, can do things via api

gtoken<-config(token=github_token) 
# will be passing this our authorisation token/credentials to github when making requests.

# make a request to github, we want to look at info on jtleek's repos
req<-GET("https://api.github.com/users/jtleek/repos",gtoken)
stop_for_status(req)
return(content(req,as='text'))
}







