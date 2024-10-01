
rm(list = ls()) #clear environment

# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation and plotting

# import data -------------------------------------------------------------

df <- readRDS("Rdata/buoy.rds")

# plot of annual changes --------------------------------------------------

#create a plot of average temperture over the entire timeseries
ggplot(df, aes(day_of_year, temp.c))+ #this starts ggplot
  geom_smooth() #this is creating a smooth

#color each line by station
ggplot(df, aes(day_of_year, temp.c, color=station))+ #add station
  geom_smooth() 

#format the plot
ggplot(df, aes(day_of_year, temp.c, color=station))+
  geom_smooth()+
  theme_classic()+
  labs(x="Day of Year",
       y=bquote("Temperature ("*degree*"C)"), #use bquote for special characters
       color="Station",
       subtitle="GAM smooth")

# make a boxplot ----------------------------------------------------------

ggplot(df, aes(x=station, y=temp.c, fill=depth))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Station",
       y=bquote("Temperature ("*degree*"C)"),
       fill="Depth")

#save the figure
ggsave("figures/boxplot1.png",width=8,height=6)
