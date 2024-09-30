# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation and plotting

# import data -------------------------------------------------------------

df <- readRDS("Rdata/buoy.rds")

# create yearly summary ---------------------------------------------------

yearly.df <- df %>%
  mutate(year=format(datetime, "%Y")) %>%
  group_by(station, depth, year) %>%
  select(temp.c, chl.ugl, ph) %>%
  drop_na() %>%
  summarize_all(mean)

ggplot(yearly.df, aes(year, chl.ugl, color=station, group=interaction(station,depth)))+
  geom_point()+
  geom_line()

yearly.df %>%
  filter(station!="GB") %>%
  ggplot(aes(year, chl.ugl, color=station, group=interaction(station,depth)))+
  geom_point()+
  geom_line()

# export the data ---------------------------------------------------------

write.csv(yearly.df, file="export/yearly.csv")
