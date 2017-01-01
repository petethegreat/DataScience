
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

