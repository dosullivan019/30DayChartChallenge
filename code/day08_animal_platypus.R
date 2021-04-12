# 30 Day Chart challenge 2021
# 8th April 2021: Animal Distribution
# Data Source: https://www.gbif.org/dataset/5c88c333-373d-46bb-8e22-5a2f50913ed0
library(dplyr)
library(ggplot2)
library(rnaturalearth)
library(extrafont)
library(imager)

platypus_data = read.csv('data/platypus_occurence_data.csv', sep='\t')

# Read in image
platypus_image = load.image(file = "./images/platypus.jpg")

# Creating map using rnaturalearth
rne_map <- ne_countries(scale = "medium", returnclass = "sf", country='Australia')

ggplot(rne_map) + 
  geom_point(data=platypus_data[which(platypus_data$order=='Monotremata' &  platypus_data$decimalLatitude>-43.7),],
             aes(x=decimalLongitude, y=decimalLatitude),
             colour='orange', size=4) +
  geom_sf(color = NA) +
  geom_text(aes(x=135, y=-49, label='Platypus\ndistribution'), colour='brown', size=8, family='Goudy Stout') +
  annotation_raster(platypus_image, xmin=110, xmax=138, ymin=-35, ymax=-45) +
  labs(caption='Data Source: Atlas of Living Australia\nCreated by: dosullivan019') +
  theme_void()

ggsave('plots/day08_animal_platypus.png')
  
