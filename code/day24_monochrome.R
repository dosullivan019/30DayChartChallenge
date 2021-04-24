library(imager)
library(ggplot2)
library(rnaturalearth)
library(extrafont)
library(gganimate)

orca = read.csv('data/orca_occurrence_au.csv')
plotting_data = orca[which(!is.na(orca$year) & orca$decimalLatitude<0 & orca$decimalLongitude>75),]
orca_image = load.image(file = "./images/orca.png")

rne_map <- ne_countries(scale = "medium", returnclass = "sf", country=c('Australia'))

orca_map =
  ggplot(rne_map) + 
  geom_sf(color = NA) +
  geom_point(data=plotting_data,
             aes(x=decimalLongitude, y=decimalLatitude),
             colour='black', size=1) +
  transition_states(year, state_length = 2.25) +
  annotation_raster(orca_image, xmin=67.5, xmax=105, ymin=-5, ymax=-30) +
  labs(title='Killer Whale Distribution {closest_state}',
       caption='Data Source: Atlas of Living Australia\nCreated by: dosullivan019') +
  theme(panel.background = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(family='Goudy Stout', size=14, hjust=0.5),
        plot.caption = element_text(size=13, face='italic'))

# Animate the map to change each year and save in GIF File Format:
animate(orca_map, fps=6,
        renderer = gifski_renderer("plots/orca_animation4.gif"), rewind=FALSE, end_pause=5)
