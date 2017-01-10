
best<-function(state,outcome)
{
	## Read outcome data
	## Check that state and outcome are valid
	## Return hospital name in that state with lowest 30-day death
	## rate
	outcomes<-c("heart attack"=11,"heart failure"=17,"pneumonia"=23)
	if ( ! outcome  %in% names(outcomes) )
	{
		stop('invalid outcome')
	}
	data<-read.csv('outcome-of-care-measures.csv',na.strings='Not Available',stringsAsFactors=FALSE)
	# outcome<-read.csv('outcome-of-care-measures.csv',na.strings='Not Available',stringsAsFactors=FALSE)
	if (! (state %in% data$State) )
	{
		stop('invalid state')
	}
}