
best<-function(state,outcome)
{
	## Read outcome data
	## Check that state and outcome are valid
	## Return hospital name in that state with lowest 30-day death
	## rate
	
	#check outcome is sensible
	outcomes<-c("heart attack"=11,"heart failure"=17,"pneumonia"=23)
	if ( ! outcome  %in% names(outcomes) )
	{
		stop('invalid outcome')
	}
	
	# read the data
	data<-read.csv('outcome-of-care-measures.csv',na.strings='Not Available',stringsAsFactors=FALSE)
	
	
	# check state is sensible
	if (! (state %in% data$State) )
	{
		stop('invalid state')
	}
	
	# c(2,7,outcome) => name,state,outcome
	# slimmed contains only the three columns of interest (state is of interest?) ,
	# and only the rows corresponding to the state of interest
	slimmed<-data[ data$State==state, c(2,7,outcomes[outcome])]
	
	# sorted the slimmed dataframe/slice. order by outcome first, then name
	sorted<-order(slimmed[,3],slimmed[,1],na.last=TRUE)
	
	return(slimmed[sorted[1],1])
	
	
	
	
}