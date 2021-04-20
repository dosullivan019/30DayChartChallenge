# 30 Day Chart challenge 2021
# 20th April 2021: Time Series | Upward
# Tallest Buildings in the USA
# Data Source: COSGIS Dataset Project https://corgis-edu.github.io/corgis/json/skyscrapers/
library(jsonlite)
library(ggplot2)
library(dplyr)
library(ggpattern)   # for adding texture to barplot
library(extrafont)
library(stringr)     # to wrap label text

building_data = fromJSON('./data/skyscrapers.json', flatten=TRUE) %>% as.data.frame

building_data %>% filter(status.current=='completed' & status.completed.year > 0) %>%
  select(status.completed.year, name, statistics.height) %>% arrange(status.completed.year, statistics.height) %>%
  mutate(tallest_height=cummax(statistics.height)) %>% group_by(status.completed.year) %>%
  mutate(tallest_annual_height=max(tallest_height),
         year_as_factor=as.factor(status.completed.year)) %>% # Convert Year to factor so bars don't overlap
  filter(tallest_annual_height==statistics.height) %>%
  ggplot(aes(x=year_as_factor, y=tallest_annual_height)) + 
  geom_bar_pattern(stat='identity', position = 'dodge',  fill='navy',
                   pattern='magick',
                   pattern_colour='grey60',
                   pattern_angle = 0,
                   pattern_spacing = 0.02,
                   pattern_density = 0.04) +
  geom_text(aes(y=tallest_annual_height+50, label=str_wrap(name, width=10)), size=5, col='grey30', family='Georgia') +
  labs(title = 'Tallest Buildings in USA',
       y='Height (m)',
       x='Year',
       caption='Data Source: COSGIS Data Source Project\nCreated by: dosullivan019') +
  scale_y_continuous(limits=c(0,650), expand=c(0,0)) +
  theme(panel.background=element_rect(fill='skyblue'),
        plot.background=element_rect(fill='skyblue'),
        panel.grid.major=element_line(colour='skyblue'),
        panel.grid.minor=element_line(colour='skyblue'),
        axis.title = element_text(colour='grey30', family='Georgia',size=14),
        plot.caption = element_text(face='italic', size=10, colour='grey30'),
        plot.title=element_text(colour = 'grey30', size=20, hjust=0.5, family='Georgia'))

ggsave('plots/day20_upwards.png', width=10, height=7.5)
