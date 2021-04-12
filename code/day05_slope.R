# 30 day chart challenge 2021
# 5th April 2021: Slope
# Data Source: https://datacatalog.worldbank.org/dataset/climate-change-data
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(extrafont)

climate_data <- read_excel('./data/climate_change_download_0.xls',sheet='Data',na='..')
climate_data %>% filter(`Country name`=='World' & 
                                 `Series name` %in% c('CO2 emissions per capita (metric tons)',
                                                      'Energy use per capita (kilograms of oil equivalent)')) %>%
  pivot_longer(cols=7:28, names_to='year') %>% filter(!is.na(value)) %>% 
  select(`Series name`, year, value) %>% 
  pivot_wider(names_from = `Series name`) %>%
  ggplot(aes(x=`Energy use per capita (kilograms of oil equivalent)`,
             y=`CO2 emissions per capita (metric tons)`)) + 
  geom_point(colour='darkgrey', size=2) +
  geom_smooth(method='lm', fill='lightblue', colour='cornflowerblue') +
  scale_x_continuous(expansion(mult=0.1, add=0.5)) +
  labs(title='Relationship between global energy consumption and CO2 emissions',
       caption='Data Source: Climate Change Data, World Bank Group \n Created by: dosullivan019') +
  theme(panel.background = element_rect(fill='grey99'),
        panel.grid.major=element_line(colour='grey90', linetype=2),
        plot.caption=element_text(face='italic'),
        plot.title=element_text(family='Georgia',size=17, hjust=0.9),
        axis.title.x = element_text(family='Georgia', size=12),
        axis.title.y=element_text(family='Georgia', size=13),
        axis.text = element_text(family='Georgia',size=10,hjust=0.9))

ggsave('plots/day05_slope.png')
