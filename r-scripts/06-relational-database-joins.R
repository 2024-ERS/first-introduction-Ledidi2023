# Combine cockle data with elevation data using a relational database approach 
# Schiermonnikoog transect

# clear everything in memory
rm(list=ls())

# restore and load libraries
renv::restore()
library(tidyverse) # including ggplot2, dplyr that we 

# load the elevation data and show the first 10 records of the dataset
elevdat<-read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT4C7olgh28MHskOjCIQGYlY8v5z1sxza9XaCccwITnjoafF_1Ntfyl1g7ngQt4slnQlseWT6Fk3naB/pub?gid=1550309563&single=true&output=csv") |>
dplyr::mutate(year=factor(year))
elevdat

# plot the change in transect  elevation along the transect, using a separate graph for each for each year 
names(elevdat)
   ggplot2::ggplot(data=elevdat,aes(TransectPoint_ID,elevation_m))+
  geom_line() +
  facet_wrap(~year)

   # plot the change in transect  elevation along the transect, using a separate line color for each year 
names(elevdat)
elevdat |>
  ggplot(aes(x=TransectPoint_ID,y=elevation_m))+
  geom_line(aes(col=year)) 
  
# Extract the data for 2017 in a new tibble, keep only variables distance_m and elevation
# omit records where Distance_ID is missing (NA)
elevdat2017 <- elevdat |>
  dplyr::filter(year=="2017") |>
# read the cockle data 
# keep only the data for 2017, 
# omit observations (Obs_ID) 468 and 1531
# calculate the mean number of cockles and mean size for each distance
  
cdat2017 <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSpormjGiM4uWMTIZYm9Upt5j1Ige_Wu9CrhGGdvjXwxmHP2R6S7JDyEmiGTn3fXihl5s5yBn_sdo8h/pub?gid=1538766002&single=true&output=csv") 

cdat2017v2 <- cdat2017|>
  dplyr::filter(year==2017,
    CockleObs_ID!=468,
    CockleObs_ID!=1531)|>
  dplyr::group_by(TransectPoint_ID)|>
  dplyr::summarize(n_obs=n(),
                   avg_l=mean(length_mm,na.rm=T),
                   sd_e=sd(length_mm,na.rm = T),
                   se_l=sd_e/sqrt(n_obs))
  
print(cdat2017)
# plot (with a line and points)  how the number of cockles changes with distance along the transect


##### merge the cockle and elevation data into a single table you call "combidat"
# using Distance_ID as the common variable between the two tables

# show in a plot how cockle density changes with elevation

# fit a linear regression

# predicted at 0.5 m (x)
# y = b0 + b1x   (b0 is intercept and b1 is the slope, x is elevation, y is no cockles

# show this model as a line in ggplot, with the confidence interval

# fit a better model, using a loess smoother
# show this model in ggplot

##### plot  how the size (as mean length) of cockles changes with  elevation along the transect
# omit the observations where length is NA (because no cockles were measures)
# fit a quadratic model (second-order polynomial)
# show for each point also the standard errors
# add appropriate labels for the x and y axis 

