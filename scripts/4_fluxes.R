
rm(list = ls()) #clear environment


# install packages --------------------------------------------------------

library(tidyverse)
library(ggpmisc)

# import data -------------------------------------------------------------

df <- read.csv("raw/concentration.csv")

str(df)


# graph O2 concentration over time ----------------------------------------

O2.df <- df %>%
  mutate(datetime.local=as.POSIXct(datetime.local)) %>%
  filter(gas == "O2",
         sample.inlet == " Inlet 1 ")

ggplot(O2.df, aes(datetime.local, umolL))+
  geom_point()+
  geom_smooth(method="lm")+
  stat_poly_eq(label.x="right", use_label(c("eq", "r2")))


# calculate flux in units of umol/m2/hr -----------------------------------

r.cm <- 10 #radius of the core
h.cm <- 18 #height of the water above the core

v.cm3 <- pi*r.cm^2*h.cm
v.l <- v.cm3/1000

cm2 <-  pi * r.cm^2 #area = pi r^2
m2 <- cm2/(100*100) #convert cm2 to m2

slope.umolL <- 0.00109 #this is from our graph
slope.umol <- slope.umolL * v.l
slope.umolm2 <- slope.umol/m2

slope.umolm2hr <- slope.umolm2*3600

slope.umolm2hr #you should get 686 umol/m2/hr
