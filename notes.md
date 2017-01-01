
# notes on R stuff

## logic


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