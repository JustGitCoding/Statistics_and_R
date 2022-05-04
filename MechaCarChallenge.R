library(jsonlite)
library(tidyverse)

# Import MechaCar_mpg.csv file
mecha_mpg <- read.csv(file='MechaCar_mpg.csv', check.names=F,stringsAsFactors=F)
# Import Suspension_Coil.csv file
susp_coil <- read.csv(file='Suspension_Coil.csv', check.names=F,stringsAsFactors=F)

# Perform Linear regression on all 6 variables (columns)
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mecha_mpg)
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mecha_mpg))

# Create Visualizations for the Trip Analysis
