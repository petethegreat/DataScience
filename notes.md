
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



