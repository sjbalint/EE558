
rm(list = ls()) #clear environment

# load packages -----------------------------------------------------------

library(tidyverse) #for data manipulation and plotting

# import data -------------------------------------------------------------

df <- readRDS("Rdata/buoy.rds")

df <- df %>%
  mutate(datetime=paste(date,time),
         datetime=as.POSIXct(datetime, format="%m/%d/%Y %H:%M"))


# make a graph ------------------------------------------------------------

#make a subset so it graphs faster
subset.df <- df %>%
  arrange(datetime,station) %>%
  head(100000) %>%
  drop_na(chl.ugl)

#check distribution
hist(subset.df$chl.ugl)
hist(log10(subset.df$chl.ugl))

#order the stations for wally
subset.df <- subset.df %>%
  mutate(station=factor(station,levels=c("GB","TW","GD")),
         depth=factor(depth, levels=c("Surface","Bottom")))

mycolor <- "navy"

ggplot(subset.df, aes(x=station, y=chl.ugl, fill=station)) +
  theme_classic()+
  geom_violin(alpha=0.6)+ #violin for emily
  geom_boxplot(fill="white",width=0.1, outlier.shape=NA, alpha=0.8)+
  scale_y_continuous(trans="log10")+ #log scale
  scale_fill_viridis_d(option="mako", begin=0.4)+ #colorblind accessable
  #scale_fill_manual(values=c("forestgreen","cyan","#008080"))+ #custom colors
  theme(legend.position="none",
        strip.background = element_blank(),
        strip.placement = "outside",
        text = element_text(color=mycolor,family="Georgia"),
        axis.text=element_text(color=mycolor,family="Georgia"),
        strip.text =element_text(color=mycolor,family="Georgia"),
        axis.line = element_line(color=mycolor),
        axis.ticks = element_line(color=mycolor))+ #remove redundant legend
  labs(y=bquote("Chlorophyll ("*mu*"g"~L^-1*")"),
       x="Station")+ #change for drew and wally
  facet_wrap(.~depth, ncol=1, strip.position = "left")

#save the beautiful figure
ggsave("figures/myfancyfigure.svg", width=8, height=6) #width and height in inches
