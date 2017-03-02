#!/usr/bin/Rscript

library(knitr)
library(markdown)
knit('StatsNotes.Rmd')
#markdownToHTML('StatsNotes.Rmd','StatsNotes.html')

message('knittted to md')
