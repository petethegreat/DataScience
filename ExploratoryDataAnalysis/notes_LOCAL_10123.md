# Exploratory Data Analysis

## preliminary
there are a couple of different plotting systems in R:
- base system - this is built-in functionality. Lots of flexibility and control, but it can take a bit of tweaking to get everything arranged the way you want.
- lattice - plots a bunch of stuff simultaneously, labels things. Can't add anything after plot has been created.
- ggplot2 - 

## Base plotting system
make a plot, then add annotations, labels, etc. Once you start adding stuff, it can't be removed (if you don't like something, start over.)

## with
`with` is pretty handy. Instead of 
'''R
plot(x=data$x_col,y=data$y_col)
'''
can do 
'''R
with(data, plot(x=x_col,y=y_col))
'''


### basic flow
- open a device, either a window on the screen or output file.
- make a plot, either`plot(x,y)` or `hist(x)` (or boxplot). look at `?par` for options. 
-- pch - plot symbol
-- lty - line type
-- lwd - line width
-- col - colour
-- xlab/ylab - axis labels



