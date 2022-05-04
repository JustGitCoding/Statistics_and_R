library(dplyr)

# Import MechaCar_mpg.csv file
mecha_mpg <- read.csv(file='MechaCar_mpg.csv', check.names=F,stringsAsFactors=F)
# Import Suspension_Coil.csv file
susp_coil <- read.csv(file='Suspension_Coil.csv', check.names=F,stringsAsFactors=F)

# Perform Linear regression on all 6 variables (columns)
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mecha_mpg)
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mecha_mpg))

# Create Visualizations for the Trip Analysis
total_summary <- summarize(susp_coil, Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
lot_summary <- summarize(susp_coil %>% group_by(Manufacturing_Lot), Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))

# T-tests on suspension coils
t.test(susp_coil$PSI, mu=1500)
t.test(subset(susp_coil, Manufacturing_Lot=='Lot1')$PSI, mu=1500)
t.test(subset(susp_coil, Manufacturing_Lot=='Lot2')$PSI, mu=1500)
t.test(subset(susp_coil, Manufacturing_Lot=='Lot3')$PSI, mu=1500)
