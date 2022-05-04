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

# reshape (gather vs spread)
demo_table3 <- read.csv(file='demo2.csv', check.names=F,stringsAsFactors=F)
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
long_table <- demo_table3 %>% gather(key='Metric',value='Score',buying_price:popularity)
wide_table <- long_table %>% spread(key='Metric',value='Score')
wide_table <- wide_table[,(colnames(demo_table3))] # reorganize columns to match demo_table3
all.equal(demo_table3,wide_table)

# ggplot2 - using mpg data which is built into R
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar 

#bar
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups='keep')
plt <- ggplot(mpg_summary, aes(x=manufacturer, y=Vehicle_Count))
plt + geom_col()+xlab("Manufacturing Company")+ylab("Number of Vehicles in Dataset")+
  theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate x-axis labels by 45 degrees
#line
mpg_summary <- subset(mpg, manufacturer=='toyota') %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy),.groups='keep') #Create summary table
plt <- ggplot(mpg_summary, aes(x=cyl, y=Mean_Hwy))
plt + geom_line() +
  scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks=c(15:30)) #set breaks in axis
#scatter
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv,size=cty))
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class", shape="Type of Drive", size="Fuel Efficiency")
#boxplot
plt <- ggplot(mpg, aes(x=manufacturer,y=hwy,color=manufacturer))
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1))

#heatmap
mpg_summary <- mpg %>% group_by(model, year) %>% summarize(Mean_Hwy=mean(hwy),.groups='keep')
plt <- ggplot(mpg_summary, aes(x=model, y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x='Model', y='Vehicle Year', fill="Mean Highway (MPG)")+
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5))

#layers
plt <- ggplot(mpg, aes(x=manufacturer, y=hwy))
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45, hjust=1)) + geom_point()

mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups='keep')
plt <- ggplot(mpg_summary, aes(x=class, y=Mean_Engine))
plt + geom_point(size=4) + labs(x="Vehicle Class", y="Mean Engine Size") +
  geom_errorbar(aes(ymin=Mean_Engine-SD_Engine, ymax=Mean_Engine+SD_Engine))

#faceting
mpg_long <- mpg %>% gather(key="MPG_Type", value="Rating", c(cty,hwy))
head(mpg_long)
plt <- ggplot(mpg_long, aes(x=manufacturer, y=Rating, color=MPG_Type))
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) +
  theme(axis.text.x=element_text(angle=45, hjust=1), legend.position='none') +xlab("Manufacturer")

#qualitative test for normality
ggplot(mtcars,aes(x=wt)) + geom_density()

#quantitative test for normality -- p-value > 0.05 means data is considered normally distributed
shapiro.test(mtcars$wt)

#sampling
#population
usedcar_pop <- read.csv('used_car_data.csv',check.names=F, stringsAsFactors=F)
plt <- ggplot(usedcar_pop,aes(x=log10(Miles_Driven)))
plt + geom_density()
#sample
usedcar_sample <- usedcar_pop %>% sample_n(50)
plt <- ggplot(usedcar_sample,aes(x=log10(Miles_Driven)))
plt + geom_density()

#one-sample t-test
t.test(log10(usedcar_sample$Miles_Driven),mu=mean(log10(usedcar_pop$Miles_Driven)))

#two-sample t-test
usedcar_sample2 <- usedcar_pop %>% sample_n(50)
t.test(log10(usedcar_sample$Miles_Driven),log10(usedcar_sample2$Miles_Driven))

#paired t-test
mpg_data <- read.csv('mpg_modified.csv')
mpg_1999 <- mpg_data %>% filter(year==1999)
mpg_2008 <- mpg_data %>% filter(year==2008)
t.test(mpg_1999$hwy,mpg_2008$hwy,paired=T)

#ANOVA - analysis of variance
mtcars_filt <- mtcars[,c('hp','cyl')] #filter columns from data
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl, data=mtcars_filt) #compare means across multiple levels
summary(aov(hp ~ cyl, data=mtcars_filt)) #summarize results of aov (Pr(>F) is our p-value)

#correlation
head(mtcars)
plt <- ggplot(mtcars, aes(x=hp, y=qsec))
plt + geom_point()
cor(mtcars$hp,mtcars$qsec) #correlation coefficient (r)

#another example
usedcar_table <- read.csv('used_car_data.csv',stringsAsFactors = F)
head(usedcar_table)
plt <- ggplot(usedcar_table,aes(x=Miles_Driven,y=Selling_Price))
plt + geom_point()
cor(usedcar_table$Miles_Driven, usedcar_table$Selling_Price)

#correlation matrix
usedcar_matrix <- as.matrix(usedcar_table[,c("Selling_Price","Present_Price","Miles_Driven")])
cor(usedcar_matrix)

#linear models (linear regression)
#simple linear regression
lm(qsec ~ hp,mtcars)
summary(lm(qsec ~ hp,mtcars)) #summarize results of lm
model <- lm(qsec ~ hp,mtcars)
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mtcars,aes(x=hp,y=qsec))
plt + geom_point() + geom_line(aes(y=yvals), color='red')

#multiple linear regression
lm(qsec ~ mpg + disp + drat + wt + hp, data=mtcars)
summary(lm(qsec ~ mpg + disp + drat + wt + hp, data=mtcars)) #summarize (Pr(>|t|) = individual p-values)

#categorical data
#chi-squared test
table(mpg$class, mpg$year) #generate contingency table (calculates frequencies across factors)
