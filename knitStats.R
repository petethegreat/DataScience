#!/usr/bin/Rscript

library(knitr)
library(markdown)
knit('StatsNotes.Rmd')
pandoc('StatsNotes.md',format='latex')
markdownToHTML('StatsNotes.md','StatsNotes.html')
# knit2html('PA1_template.Rmd','PA1_template.html')


