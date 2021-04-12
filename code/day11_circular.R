# 30 Day Chart challenge 2021
# 11th April 2021: Circular
# Data Source: R package geosphere calculates length of day for a given location and date
library(ggplot2)
library(geosphere) # to calculate daylength
library(dplyr)
library(extrafont)

# daylength function takes lat and doy, will use 3 different cities
data = data.frame(city=c(rep('Dublin', 365), rep('Rio de Janeiro', 365), rep('Melbourne', 365)),
                  doy = c(rep(seq(as.Date("2020-01-01"), as.Date("2020-12-31"), length.out = 365), 3)),
                  lat = c(rep(53.34, 365), rep(-22.9, 365), rep(-37.8, 365)))

data$month = sapply(data$doy, function(x) as.integer(format(x, '%m')))
data$month_name = factor(month.abb[data$month],levels=month.abb)
data$hours_daylight = mapply(daylength, data$lat, data$doy)

data %>% group_by(month_name, city) %>% 
  summarise(avg_monthly_daylength = mean(hours_daylight)) %>%
  ggplot() +
  geom_bar(aes(x=month_name, y=avg_monthly_daylength, fill=avg_monthly_daylength), stat='identity') +
  scale_fill_viridis_c(option='plasma') +
  facet_wrap(vars(city)) + coord_polar() +
  labs(title='Average Monthly Daylight Hours',
       fill = 'Daylight Hours',
       caption = 'Data Source: R package geosphere\nCreated by: dosullivan019') +
  theme(legend.position='top',
        legend.title = element_text(family='Georgia',size=12,vjust=0.85),
        panel.background = element_rect(fill='white'),
        axis.title = element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title=element_text(family='Georgia', size=20, hjust=0.5),
        plot.caption = element_text(face='italic', size=9),
        axis.text.x = element_text(family='Georgia',size=11),
        strip.text.x = element_text(size = 14, family='Georgia'), # modify facet text
        strip.background = element_rect(fill='white'))

ggsave('plots/day11_circular.png')
