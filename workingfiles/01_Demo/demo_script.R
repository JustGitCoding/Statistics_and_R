library(jsonlite)
library(tidyverse)
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

filter_table2 <- subset(demo_table2, price>10000 & drive == "4wd" & "clean" %in% title_status) #filter by price and drivetrain

num_rows <- 1:nrow(demo_table)
sample_rows <- sample(num_rows, 3)
demo_table[sample_rows,]

demo_table[sample(1:nrow(demo_table),3),]

# add columns to original dataframe
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year), IsActive=TRUE)

# group_by() & summarize
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups='keep')
# group_by() & summarize with multiple columns
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups='keep')

demo_table3 <- read.csv(file='demo2.csv', check.names=F,stringsAsFactors=F)
