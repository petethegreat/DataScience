
# notes on R stuff

## logic

### elementwise operation

logical comparisons operate elementwise (generally). The shorter thing being compared is recycled to match the length of the longer thing. 

```R
> c(3,5,7,8) == c(3,8)
[1]  TRUE FALSE FALSE  TRUE
```

operators & (and) and | (or) operate elementwise, but && and || only evaluate the first element in the things being compared.

```R
> x=c(TRUE,FALSE,TRUE,FALSE)
> y=c(FALSE,FALSE,TRUE,TRUE)
> x&y
[1] FALSE FALSE  TRUE FALSE
> x|y
[1]  TRUE FALSE  TRUE  TRUE
> x&&y
[1] FALSE
> x||y
[1] TRUE
```

### assignment
The output of a logical operation can be assigned to a variable
```R
> x<- if (2>3) {1} else { if (3 < 4) {2} else {3} }
> x
[1] 2
```

### Order of operations

and operators are evaluated before ors

```R
>  FALSE && FALSE || TRUE && TRUE
[1] TRUE
>  FALSE && (FALSE || TRUE) && TRUE
[1] FALSE
```
## Date and time

function strptime() is handy, can be used to extract time/date from a string, specify the format and strp will pull the date from a string

## lexical scoping

variables that are not defined within a function, or which are not arguments to the function will be looked up **from the environment in which the function is defined**. 
This can be used in cool ways, look up the optimisation notes from week2 of R programming.
Essentially, you can have a "generator" function that loads the data and defines an objective function. The objective function then knows what the data is - it does not need to be (clumsily) passed through arguments somehow, or bundled with the function as an object, it is just there. The only arguments to the objective function are then parameters that can be optimised (e.g. the mean and width of a gaussian).

## apply functions
- lapply - list apply. takes a list/vector/matrix as input, as well as a function (and optionally, some arguments to that function). For each element in the input container, the function (with additional arguments, if applicable) is applied. output is returned as a list (always). This is handy, as instead of looping over a container and invoking the function at each iteration, the whole loop can be condensed into a single invocation of lapply
- sapply - like lapply, but with simplification. If all the outputs from lapply would be the same class, then sapply coerces the output into a vector, instead of returning a list. 
- apply - a little different, assumes the input is a matrix, and will apply the function to a row/column of input at a time. e.g. apply(X,1,mean) will return a vector in which each element is the mean value accross a row of X (dimension 1 -> rows, dimension 2-> columns,etc). If the applied function returns a vector of length l, then the output from apply is an array of with l rows, and one column for each applied-to row/column.
- mapply - multivariate lapply. takes multiple vectors/lists (of the same length) as input, iterates over all of them simultaneously, and supplys elements of these as arguments to the function. Additional (nonvarying) arguments to the function may also be supplied.
 - tapply - tapply(data$column,factor$column,fucntion) -splits the data (first argument, data$cloumn) up based on factor$column. The function is then applied to the data from each group. (e.g. tapply(mtcars$mpg,mtcars$cyl,mean) - mean mpg based on engine cylinders). tapply seems to only like working on a single column at a time.
 - split - splits the data up into groups. e.g. split(mtcars,mtcars$cyl) returns a list of dataframes in which all the cars have the same number of cylinders 
 
 Note that tapply is effectively a split and apply
 ```R
 > tapply(mtcars$hp,mtcars$cyl,max)
   4   6   8 
 113 175 335
 > lapply(split(mtcars$hp,mtcars$cyl),max)
 $`4`
 [1] 113

 $`6`
 [1] 175

 $`8`
 [1] 335
 
 ```
 Maybe there are some subtleties to tapply, but lapply(split()) might be more useful?
 ```R
 lapply(split(mtcars,mtcars$cyl),function(x) colMeans(x[,c('mpg','hp','disp')]) 
 + )
 $`4`
       mpg        hp      disp 
  26.66364  82.63636 105.13636 

 $`6`
       mpg        hp      disp 
  19.74286 122.28571 183.31429 

 $`8`
      mpg       hp     disp 
  15.1000 209.2143 353.1000
 
 ```
 
## random numbers
 
 
 -  rnorm(n,m,s) generates a vector of length n of **normal** random variables with mean m and standard deviation s (seen this a bunch)
 
 - dnorm(x,mean,sd) - give the value of the probability density function at x for a normal random distribution with given mean and standard deviation
 - pnorm(q,mean,sd) - give the value of the cumulative distrubution function (the integral of the density up to q(?)) (pnorm(0.75) gives the value of the cumulative at x=0.75, or the probability that random varialbles will be generated with values below 0.75)
 ```R
 > pnorm(1) - pnorm(-1)
 [1] 0.6826895
 > pnorm(2) - pnorm(-2)
 [1] 0.9544997
 ```
 - qnorm(p) - gives the quantile function - given a probability p, it returns a value q such that random numbers random variables will fall below q with probability p. qnorm and pnorm are inverse functions

These functions (r*,d*,p*,q*) exist for a number of generators (e.g. rpois samples from poisson distribution, qunif gives the quantile for uniform distribution,pexp gives the cumulative for exponential distribution, etc.)

important to set the seed - ```set.seed(2)``` - needed for reproduceability - this has been emphasised a bunch.

## Profiling

two main things: system.time() and Rprof()
### system.time
takes one expression as input. Times how long it takes R to evaluate that expression.
Returns an object of class proc_time. printing this displays three values: User time, system time, and elapsed time.
- User time - the cpu time used. Time that the processor(s) spent working on things.
- System time - Other. Overhead essentially. time spent waiting on i/o things, etc.
- Elapsed time - The time that would be recorded by a "wall clock". The total time that passed from beggining to end.

Generally, elapsed time is the total and in "most" cases will be the sum of the other two.  In cases where the executed code utilises multiple processors (Linear algebra stuff that uses BLAS or something similar), then user time can exceed elapsed time. For example, two processor running for 10 seconds will give a user time of 20 seconds, but an elapsed time of 10.

### Rprof
Rprof('outfilename.out') samples the function call stack at regular intervals and records what it sees in the file given as argument. It does this until it Rprof(NULL) is called. The sample interval can be specified as an optional argument. At each sample, Rprof writes out the function call stack, which looks something like.
```R
"function1" "function2" "function3"
```
This line indicates that R is currently working on function3, which was called by function2, which was called by function1. function1 should be somthing that you told R to do. 

This output by itself is not the most useful. The command summaryRprof('outfilename.out') will read the supplied filename, and return a list. The list contains two dataframes, $by.total and $by.self. 

The by.total dataframe gives statistics on the fraction of time each function was present in the stack. If the user calls one function while Rprof is running, and that function calls many smaller functions, which in turn call other functions and so on, then the top level function will show up as occupying 100% of the time (as it is always present in the function stack). This sometimes isn't the most useful, as the top level functions don't do most of the work.

The by.self dataframe gives statistics on the lowest level functions. This shows how much of the total time was spent executing things in each function, on its own, which is often more useful

### Replicate/vectorisation
replicate(n,expr) will carry out the expr n times, returning a list. For example
'''R
> moose<-replicate(3,rnorm(5))
> moose
           [,1]        [,2]       [,3]
[1,] -1.2137739  0.18631382 -0.9759883
[2,] -1.7646895 -0.46471197  0.8194045
[3,] -1.0854025 -0.08313484  1.1734603
[4,]  0.2003816  2.31647469 -0.1686119
[5,]  1.4291066 -0.11919838 -0.3003799
'''
 
This can be faster than a for loop as replicate is a wrapper for sapply/lapply, which use internal c routines. For loops do a bunch of interpreting and condition testing that are relatively expensive.


 




