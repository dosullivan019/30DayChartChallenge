# 30 Day Chart challenge 2021
# 14th April 2021: Space
# Data Source: Tidy Tuesday UFO Sightings
library(geosphere)
library(ggplot2)
library(dplyr)
library(extrafont)

ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")

# change date from string to date type
ufo_sightings$date_time = as.Date(ufo_sightings$date_time, tryFormats = c("%d/%m/%Y"))
ufo_sightings$hours_daylight = mapply(daylength, ufo_sightings$latitude, ufo_sightings$date_time)

ufo_sightings %>% filter(encounter_length < 100000 & !is.na(date_time)) %>%
  ggplot() + geom_point(aes(x=hours_daylight, y=encounter_length/60, 
                            col=ifelse(is.na(ufo_shape), 'white', 
                                       ifelse(ufo_shape=='fireball', 'red',
                                              ifelse(ufo_shape=='light', 'gold', 'white')))),
                        size = 2, shape = 19) +
  labs(title = 'Is there a relationship between daylight hours and UFO sightings length?',
       y = 'Encounter Length (mins)',
       x = 'Hours Daylight',
       caption = 'Data Source: National UFO Reporting Centre\nCreated by: dosullivan019',
       colour = 'UFO Shape') +
  scale_colour_identity(guide='legend', labels = c('light', 'fireball', 'other', NA)) +
  theme(legend.position='top',
        legend.key = element_rect(fill = 'black'),
        legend.background = element_rect(fill='black'),
        legend.title = element_text(colour = 'white', family = 'Kristen ITC', size=10),
        legend.text = element_text(colour = 'white', family = 'Kristen ITC', size=9),
        plot.title = element_text(colour = 'white', size=14, family = 'Kristen ITC', hjust=0.65),
        plot.caption = element_text(colour = 'white', size = 8, face = 'italic'),
        axis.title.x = element_text(colour='white', family = 'Kristen ITC', size=12),
        axis.title.y = element_text(colour='white', family = 'Kristen ITC', size=12),
        axis.text = element_text(colour = 'white', family = 'Kristen ITC', size=10),
        panel.background = element_rect(fill='black'),
        plot.background = element_rect(fill = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin=unit(c(0.5,1,0.5,1),"cm"))

ggsave('plots/day14_space.png')
