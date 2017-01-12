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
	# "Hospitals that do not have data on a particular outcome should be excluded
	# from the set of hospitals when deciding the rankings."

	slimmed<-data[! is.na(data[,outcomes[outcome]])  ,c(2,7,outcomes[outcome])]
	
	
	ranked<-data.frame(hospital=character(length=0),state=character(length=0),stringsAsFactors=FALSE)
	
	
	
	if (num == 'best')
	{
		num<-1
	}


	for (thestate in states)
	{
		# loop over states
		# for each state, rank the hospitals (first by outcome, then by name, ignore na)
		
		# how many hospitals are in this state?
		thisstate<-slimmed[slimmed$State == thestate,]
		maxrows<-nrow(thisstate)
		if (num == 'worst') 
		{ 
			thenum<-maxrows
		}
		else
		{
			thenum<-num
		}

		if (thenum > maxrows)
		{
			# we want a rank greater than the number of hospitals (with outcome data) in this state
			# return NA for this state

			#insert a row into ranked, and move to the next state
			ranked[nrow(ranked)+1,1:2]<-c(NA,thestate)
			next

		}


		#first check that we have some
		ordering<-order(thisstate[,c(3,1)])
		ranked[nrow(ranked) +1,1:2]<-c(thisstate[ordering[thenum],1],thestate)

		
		
	}
	ranked
	
	
	
	
}