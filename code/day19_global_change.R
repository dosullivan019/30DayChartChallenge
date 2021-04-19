1# 30 Day Chart challenge 2021
# 19th April 2021: Time Series | Global Change | Annual CO2 emmission per capita
# Data Source: Our World in Data https://ourworldindata.org/co2-emissions
library(dplyr)
library(ggplot2)
library(ggrepel)    # for labelling end of line
library(extrafont)
library(wesanderson)

co2_data <- read.csv("data/co-emissions-per-capita.csv")

co2_data %>% filter(Entity %in% c('United States', 'United Kingdom', 'Australia', 'China', 'India', 'Brazil')) %>%
  mutate(country_label = ifelse(Entity=='United States', 'USA', ifelse(Entity=='United Kingdom', 'UK', Entity))) %>%
  mutate(label = if_else(Year == max(Year), as.character(country_label), NA_character_)) %>%
  ggplot(aes(x=Year, y=Per.capita.CO2.emissions, group=Entity, col=Entity)) + 
  geom_line(size=1) +
  labs(title='Annual CO2 emissions per capita',
       subtitle='CO2 emissions in Australia, the UK and US have been falling since early 2000s.\nEmissions continue to rise in China, India and Brazil.',
       caption='Data Source: Our World in Data\nCreated by: dosullivan019',
       y='Annual CO2 emissions per capita') +
  geom_label_repel(aes(label = label), fill='grey90', nudge_x = 3, na.rm = TRUE,
                   box.padding = unit(0.25, 'lines'), fontface='bold',size=4.5) +
  scale_x_continuous(limits=c(1800, 2050), expand=c(0,0))+
  scale_colour_manual(values = c(wes_palette("FantasticFox1", n = 5), wes_palettes$Darjeeling1[2])) +
  theme(legend.position='none',
        panel.background = element_rect(fill='white'),
        panel.grid.major=element_line(colour='grey90', linetype=2),
        plot.caption=element_text(face='italic'),
        plot.title=element_text(family='Georgia',size=17),
        plot.subtitle=element_text(family='Georgia',size=12),
        axis.title.x = element_text(family='Georgia', size=12),
        axis.title.y=element_text(family='Georgia', size=13),
        axis.text = element_text(family='Georgia',size=10,hjust=0.9))

ggsave('plots/day19_global_change_CO2_emissions.png')