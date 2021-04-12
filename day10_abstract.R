# 30 Day Chart challenge 2021
# 10th April 2021: Abstract Distribution
# Creating abstract art using an image and random sampling following http://mfviz.com/r-image-art/
library(imager)
library(dplyr)
library(ggplot2)
library(tidyr)     

img <- load.image(file = "images/melbourne_xmas_town_hall.jpg")

# Represent the image as a data frame. Data frame includes the x and y values for plotting, 
# the colour channel (1, 2 or 3 which represents red, green and blue respectively) and the value of that channel
img_df <- as.data.frame(img)

# reshape data so that each row is a point, calculate rgb colour using rgb function
img_wide = 
  img_df %>% mutate(channel = case_when(cc==1 ~ 'Red', 
                                      cc==2 ~ 'Green',
                                      cc==3 ~ 'Blue')) %>%
  select(x, y, channel, value) %>%
  pivot_wider(names_from = channel, values_from=value) %>%
  mutate(rgb_colour = rgb(Red, Green, Blue))


# Randomly sample to create an abstract image
sample_size = 10000
img_wide[(sample(nrow(img_wide), sample_size)),] %>%
  mutate(size=runif(sample_size)) %>%
  ggplot() +
  geom_point(mapping = aes(x = x, y = y, color = rgb_colour, size=Blue)) +
  scale_color_identity() + # use the actual value in the `color` column
  scale_y_reverse() + 
  guides(size=FALSE) +
  theme_void()

ggsave('plots/day10_abstract.png')
