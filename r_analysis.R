#Set wd
setwd("C:/Users/Stanislaw Lem/Documents/Academic/University/UCU/Semester 7/ACCMET2J/individual_assignment/")


#libraires
library(tidyverse)
library(ggplot2)
library(sp)
library(ggthemes)
library(dplyr)
library(reshape2)

#import data
data_raw <- read.csv('kurd_kurdistan.csv', stringsAsFactors = FALSE)

test <-1

data_proc <- data_raw %>%
  mutate(deaths_total=deaths_a+deaths_b+deaths_civilians) 

data_proc.melt <- data_proc %>%
  melt(id.var='year') %>%
  filter(variable == 'deaths_b'| variable == 'deaths_a'|variable == 'deaths_civilians') %>%
  mutate(value_num = as.numeric(value) ) %>%
  group_by(year,variable) %>%
  summarise(total_deaths = sum(value_num))

data_proc.melt$value2 <- as.numeric(data_proc.melt$value )
  
ggplot(data_proc.melt, aes(x = year, y = total_deaths, fill=variable)) + 
  geom_bar(stat = "identity")
  labs(title="Turkey-Kurdistan Conflict", subtitle="Incidences of Violence 1989-2015")+
  xlab("Year")+
  ylab("No. Violent Incidents")+
  theme(panel.background = element_rect(fill = "lightblue",colour = "lightblue", size = 0.5, linetype = "solid"))

ggplot(data_proc.melt, aes(fill=death_id,x=year,y=value))+
  geom_bar(stat="identity",position="stack")

#initial exploration plots

#Year 
ggplot(data = data_proc, width=1)+
  
  
  geom_bar(stat="identity",aes(x=year,y=deaths_total))+
  geom_bar(aes(x=year),fill='red')+
  #geom_bar(aes(x=data_raw$deaths_civilians,))+
  labs(title="Turkey-Kurdistan Conflict", subtitle="Incidences of Violence 1989-2015")+
  xlab("Year")+
  ylab("No. Violent Incidents")
  theme(panel.background = element_rect(fill = "lightblue",colour = "lightblue", size = 0.5, linetype = "solid"))



  
  
  
  