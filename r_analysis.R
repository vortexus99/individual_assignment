#Set wd
setwd("C:/Users/Stanislaw Lem/Documents/Academic/University/UCU/Semester 7/ACCMET2J/individual_assignment/")


#libraires
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(reshape2)
library(xtable)
library(plotly)
options(xtable.floating = FALSE)
options(xtable.timestamp = "")

#import data
data_raw <- read.csv('kurd_kurdistan.csv', stringsAsFactors = FALSE)
world_df <- map_data('world')

#Process data
data_proc <- data_raw %>%
  melt(id.var='year') %>% #change df to long form. Look through data_proc$variable to understand what this does
  filter(variable == 'deaths_b'| variable == 'deaths_a'|variable == 'deaths_civilians') %>% #filter for death_ cols
  mutate(value_num = as.numeric(value) ) %>% #new col with val numeric instead of char
  group_by(year,variable) %>% #aggregate by year and variable
  summarise(total_deaths = sum(value_num)) #sumerise so that each year,variable pair has sum of deaths

#Plot processed data as bar graph
ggplot(data_proc, aes(x = year, y = total_deaths, fill=variable)) + #assigning fill to var lets us stack
  geom_bar(stat = "identity")+
  labs(title="Turkey-Kurdistan Conflict", 
       subtitle="Number of Deaths per Year \n1989-2015")+
  ylab("Deaths")+
  xlab("Year")+
  scale_fill_discrete(name="Party",
                     labels=c("Government\nof Turkey", "PKK", "Civilians"))+ #changes legend labels
  theme(panel.background = element_rect(fill = "lightblue",
                                        colour = "lightblue",
                                        size = 0.5, linetype = "solid"),
                                        axis.title.y = element_text(size = 12),
                                        axis.title.x = element_text(size = 12))


#plot for civilian deaths only
ggplot(data_proc %>% filter(variable == 'deaths_civilians'), #use pipe to filter
       aes(x = year,
           y = total_deaths)) + #assigning fill to var lets us stack
  geom_bar(stat = "identity")+
  labs(title="Turkey-Kurdistan Conflict", 
       subtitle="Number of Civilian Deaths per Year \n1989-2015")+
  ylab("Deaths")+
  xlab("Year")+
  theme(panel.background = element_rect(fill = "lightblue",
                                        colour = "lightblue",
                                        size = 0.5, linetype = "solid"),
                                        axis.title.y = element_text(size = 12),
                                        axis.title.x = element_text(size = 12))

#Creating table for latex
data(data_proc)
xtable(data_proc[1:10, ])


#Map of violent incidents


#Animated Map Plot
map <- ggplot() +
  geom_polygon(data = world_df %>% filter(region == 'Turkey'|region == 'Iraq'|region=='Syria'),
                                          aes(x=long, y=lat, fill=region, group=group))+
  geom_point(data = data_raw, aes(y=latitude,x=longitude, frame=year),color="yellow")+
  ylab("Longitude")+
  xlab("Latitude")+
  scale_fill_discrete(name="Country")+
  labs(title='Incidents of Violence: Turkey Kurdistan Conflict', subtitle='Turkey and Local Regions, 1989-2015')

#animation_opts(map, frame = 1000, easing = "linear")

ggplotly(map)
  
  #+
  #theme(panel.background = element_rect(fill = "lightblue",
                                      #  colour = "lightblue"))
  # Make sure that the ratio of the world map always works
  # remove the axes lines and the background colour


  




  
  
  
  