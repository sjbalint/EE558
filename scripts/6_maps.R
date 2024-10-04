rm(list = ls()) #clear environment


# install new packages ----------------------------------------------------

#install.packages("sf")
#install.packages("tigres")

# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation
library(tigris) #for census
library(sf)

sf_use_s2(FALSE) #this is required for compatibility

# import census data ------------------------------------------------------

ma.sf <- counties(state="MA") 

ma.sf <- ma.sf %>%
  erase_water(area_threshold=0.99)


# map of MA ---------------------------------------------------------------

ggplot()+
  theme_void()+
  geom_sf(data=ma.sf, aes(fill=NAME))+
  theme(legend.position="none")

# map of boston area ------------------------------------------------------

#set coordinates of our plot
xmin=-70.8
xmax=-71.2
ymin=42.2
ymax=42.5

ggplot()+
  theme_classic()+
  geom_sf(data=ma.sf, aes(fill=NAME))+
  scale_fill_grey()+
  coord_sf(xlim = c(xmin, xmax), ylim = c(ymin, ymax), expand = FALSE)+
  theme(legend.position="none")

roads.sf <- roads(state="MA", county=c("Suffolk", "Norfolk", "Middlesex"))
  
#set coordinates of our plot
xmin=-71.0
xmax=-71.15
ymin=42.32
ymax=42.38

ggplot()+
  theme_classic()+
  geom_sf(data=ma.sf, aes(fill=NAME))+
  geom_sf(data=roads.sf)+
  scale_fill_grey()+
  coord_sf(xlim = c(xmin, xmax), ylim = c(ymin, ymax), expand = FALSE)+
  theme(legend.position="none")
