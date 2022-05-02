library(jsonlite)
x <-3
numlist <- c(0,1,2,3,4,5,6,7,8,9)
demo_table <- read.csv(file='demo.csv', check.names=F,stringsAsFactors=F)
demo_table2 <- fromJSON('demo.json')

numlist[5]

demo_table2[4,'city']
demo_table2[4,2]

demo_table$'Vehicle_Class'
demo_table$'Vehicle_Class'[2]

filter_table <- demo_table2[demo_table2$price > 10000,]