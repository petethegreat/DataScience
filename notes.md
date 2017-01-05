
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

### assignemnt
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

# lexical scoping

variables that are not defined within a function, or which are not arguments to the function will be looked up **from the environment in which the function is defined**. 
This can be used in cool ways, look up the optimisation notes from week2 of R programming.
Essentially, you can have a "generator" function that loads the data and defines an objective function. The objective function then knows what the data is - it does not need to be (clumsily) passed through arguments somehow, or bundled with the function as an object, it is just there. The only arguments to the objective function are then parameters that can be optimised (e.g. the mean and width of a gaussian).

# apply functions
- lapply - list apply. takes a list/vector/matrix as input, as well as a function (and optionally, some arguments to that function). For each element in the input container, the function (with additional arguments, if applicable) is applied. output is returned as a list (always). This is handy, as instead of looping over a container and invoking the function at each iteration, the whole loop can be condensed into a single invocation of lapply
- sapply - like lapply, but with simplification. If all the outputs from lapply would be the same class, then sapply coerces the output into a vector, instead of returning a list. 
- apply - a little different, assumes the input is a matrix, and will apply the function to a row/column of input at a time. e.g. apply(X,1,mean) will return a vector in which each element is the mean value accross a row of X (dimension 1 -> rows, dimension 2-> columns,etc). If the applied function returns a vector of length l, then the output from apply is an array of with l rows, and one column for each applied-to row/column.
- mapply - multivariate lapply. takes multiple vectors/lists (of the same length) as input, iterates over all of them simultaneously, and supplys elements of these as arguments to the function. Additional (nonvarying) arguments to the function may also be supplied.
 - tapply - table apply
   


