rankall <- function(outcome, num = "best") {
    ## Read outcome data

	## Check that state and outcome are valid
	## For each state, find the hospital of the given rank
	## Return a data frame with the hospital names and the
	## (abbreviated) state name
	
	#check outcome is sensible
	outcomes<-c("heart attack"=11,"heart failure"=17,"pneumonia"=23)
	if ( ! outcome  %in% names(outcomes) )
	{
		stop('invalid outcome')
	}
	
	# read the data
	
	data<-read.csv('outcome-of-care-measures.csv',na.strings='Not Available',stringsAsFactors=FALSE)
	
	states<-unique(data$State)
	states<-states[order(states)]
	# will want a list of all states.
	
	# slimmed - work with only the hospital, state, and outcome columns
	# keep only the rows for which the outcome is not NA
	slimmed<-data[! is.na(data[,outcomes[outcome]])  ,c(2,7,outcomes[outcome])]
	
	
	ranked<-data.frame(hospitals=character(length=0),states=character(length=0),stringsAsFactors=FALSE)
	
	
	
	for thestate in states
	{
		# loop over states
		# for each state, rank the hospitals (first by outcome, then by name, ignore na)
		
		#first check that we have some
		ordering<-order(slimmed[ slimmed$State == thestate,c(3,1)])
		
		
	}
	
	
	
	
	
}