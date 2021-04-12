# 30 Day Chart challenge 2021
# 11th April 2021: Statistics Distribution
# Data Source: Kaggle https://www.kaggle.com/sudalairajkumar/daily-temperature-of-major-cities
library(dplyr)
library(ggplot2)
library(ggridges)
library(wesanderson)

temperature_data <- read.csv("data/city_temperature.csv", na.strings=-99)

# Filter for only Australia cities
temperature_data %>% filter(Country == 'Australia' & !is.na(AvgTemperature)) %>%
  mutate(avg_temp_celcius = round((AvgTemperature - 32) * (5/9)) ) %>%
  ggplot(aes(x=avg_temp_celcius, y=City, fill=City)) +
  geom_density_ridges(alpha=0.95, colour='white') +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = expansion(mult = c(0, 0.2))) +
  scale_fill_manual(values = wes_palette("FantasticFox1", n = 5)) +
  labs(title='Temperatures in Australia',
       subtitle = 'Distribution of Daily Temperatures in Major Australian Cities from 1995-2013.',
       x='Temperature (C)') +
  # TODO: Change font
  theme(legend.position = 'none',
        panel.background = element_rect(fill='white'))
