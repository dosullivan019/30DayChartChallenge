# 30 Day Chart challenge 2021
# 22nd April 2021: Time Series | Animate
# Post Offices Established in USA
library(ggplot2)
library(rnaturalearth)
library(gganimate)
library(gifski)     # for creating gif
library(extrafont)

# Creating map using rnaturalearth
rne_map <- ne_countries(scale = "medium", returnclass = "sf", country='United States of America')

post_offices <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-13/post_offices.csv')


post_office_map =
  ggplot(rne_map) + 
  geom_sf(color = NA) +
  geom_point(data=post_offices,
             aes(x=longitude, y=latitude),
             colour='navy', size=0.35) +
  xlim(-170, -60) + ylim(15, 75) +
  transition_manual(established, cumulative=TRUE) + # animate the cumulative post offices established in USA
  labs(title = 'USA Post Offices : {current_frame}',  
       caption  = 'Data Source: Tidy Tuesday | Blevins, Cameron; Helbock, Richard W., 2021, "US Post Offices"\nCreated by: dosullivan019"'
  ) +
  theme(panel.background = element_blank(),
        plot.title = element_text(family='Georgia', colour='navy', size=20, hjust=0.5),
        plot.caption = element_text(face='italic', size=10))

animate(post_office_map, renderer = gifski_renderer("plots/day22_animate.gif"),
        fps=8, rewind=FALSE, end_pause=5)
