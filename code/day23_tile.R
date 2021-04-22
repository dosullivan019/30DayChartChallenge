# 30 Day Chart challenge 2021
# 23rd April 2021: Time Series Tile
# Data Source: Kaggle https://www.kaggle.com/sudalairajkumar/daily-temperature-of-major-cities
library(dplyr)
library(ggplot2)
library(extrafont)

temperature_data <- read.csv("data/city_temperature.csv", na.strings=-99)
temperature_data$month_name = factor(month.abb[temperature_data$Month],levels=month.abb)

temperature_data %>% filter(City=='New York City' & Year==2019) %>%
  mutate(avg_temp_celcius = round((AvgTemperature - 32) * (5/9),1) ) %>%
  ggplot() + geom_tile(aes(x = Day, y = month_name, 
                           fill = avg_temp_celcius)) +
  scale_fill_viridis_c() + 
  scale_y_discrete(limits=rev(levels(temperature_data$month_name)), expand = c(0,0)) + # reverse order so it Jan is at the top
  scale_x_continuous(breaks=c(1:31), labels=c(1:31), expand = c(0,0)) +
  labs(title='A Year in New York City',
       subtitle='Average Daily Temperature in NYC in 2019',
       y='', fill='Avg Temperature (C)',
       caption = 'Data Source: Kaggle / University of Dayton\n Created by: dosullivan019') +
  theme(panel.background = element_blank(),
        legend.position = 'top',
        legend.title = element_text(family='Comic Sans MS', size=12, vjust=0.85),
        axis.ticks = element_blank(),
        axis.text = element_text(family='Comic Sans MS', size=11),
        axis.title = element_text(family='Comic Sans MS', size=12),
        plot.title = element_text(family='Comic Sans MS', size=20, hjust=0.5),
        plot.subtitle = element_text(family='Comic Sans MS', size=16, hjust=0.5),
        plot.caption = element_text(family='Comic Sans MS', face='italic'))

ggsave('plots/day23_tile.png')  
