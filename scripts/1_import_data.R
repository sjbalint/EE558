
rm(list = ls()) #clear environment

# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation and plotting
library(readxl) #import excel docs

# import data -------------------------------------------------------------

raw.df <- read_excel("raw/buoy_subset.xlsx")

# check data structure ----------------------------------------------------

head(raw.df)

str(raw.df)

#fix the date
df <- raw.df %>%
  mutate(datetime = paste(date,time),
         datetime = as.POSIXct(datetime, format="%m/%d/%Y %H:%M"))

#create a day of year column
df <- df %>%
  mutate(day_of_year = format(datetime, "%j"),
         day_of_year = as.numeric(day_of_year))

#set station and depth to factor
df <- df %>%
  mutate(station=as.factor(station),
         depth=as.factor(depth))

str(df)

# save the file -----------------------------------------------------------

saveRDS(df, file="Rdata/buoy.rds")
