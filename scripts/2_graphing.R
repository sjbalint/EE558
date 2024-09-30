# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation and plotting

# import data -------------------------------------------------------------

df <- readRDS("Rdata/buoy.rds")

# plot of annual changes --------------------------------------------------

ggplot(df, aes(day_of_year, temp.c))+ #this starts ggplot
  geom_smooth() #this is creating a smooth

ggplot(df, aes(day_of_year, temp.c, color=station))+ #add station
  geom_smooth() 

#make plot nicer
ggplot(df, aes(day_of_year, temp.c, color=station))+
  geom_smooth()+
  theme_classic()+
  labs(x="Day of Year",
       y=bquote("Temperature ("*degree*"C)"),
       color="Station",
       subtitle="GAM smooth")

# make a boxplot ----------------------------------------------------------

#make plot nicer
ggplot(df, aes(x=station, y=temp.c, fill=depth))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Station",
       y=bquote("Temperature ("*degree*"C)"),
       fill="Depth")

ggsave("figures/boxplot1.png",width=8,height=6)
