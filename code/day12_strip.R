# 30 Day Chart challenge 2021
# 12th April 2021: Strip Distribution
# Data Source: Kaggle https://www.kaggle.com/sudalairajkumar/daily-temperature-of-major-cities
library(dplyr)
library(ggplot2)
library(ggridges)
library(wesanderson)
library(extrafont)

temperature_data <- read.csv("data/city_temperature.csv", na.strings=-99)
temperature_data$month_name = factor(month.abb[temperature_data$Month],levels=month.abb)

# Filter for Moscow
temperature_data %>% filter(City=='Moscow' & !is.na(AvgTemperature)) %>%
  mutate(avg_temp_celcius = round((AvgTemperature - 32) * (5/9),1) ) %>%
  ggplot(aes(x=month_name, y=avg_temp_celcius, colour=round(avg_temp_celcius, 1))) +
  geom_point() +
  labs(title = 'Average Daily Temperature in Moscow',
       caption = 'Data Source: Kaggle / University of Dayton\n Created by: dosullivan019',
       x='Month',
       y='Temperature (C)',
       colour= 'Temp (C)') +
  scale_colour_viridis_c(option='plasma') +
  theme(legend.position='top',
        panel.background = element_rect(fill='white'),
        plot.title=element_text(family='Georgia', size=20, hjust=0.5),
        plot.caption = element_text(face='italic', size=9),
        axis.title.x = element_text(family='Georgia', size=12),
        axis.title.y = element_text(family='Georgia', size=14),
        axis.text = element_text(family='Georgia',size=11))

ggsave('plots/day12_strip_temperature_chart.png')
