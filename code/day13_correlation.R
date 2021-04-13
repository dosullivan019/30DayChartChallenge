# 30 Day Chart challenge 2021
# 13th April 2021: Correlation
# Palmer Penguins Dataset
library(palmerpenguins)
library(ggplot2)
library(extrafont)
library(wesanderson)
library(imager)
library(cowplot)

# Read in image
penguin_image = load.image(file = "./images/penguin.jpg")

penguin_plot = 
  ggplot(penguins) +
  geom_point(aes(x=bill_length_mm, y=flipper_length_mm, col=species, shape=species), size=2) +
  geom_smooth(aes(x=bill_length_mm, y=flipper_length_mm, col=species),method='lm', se=FALSE) +
  geom_text(x=32.5, y=198, colour=wes_palettes$Zissou1[1], size=5,
   label=paste("R = ", 
               round(cor(penguins[which(penguins$species=='Adelie'),'bill_length_mm'], 
                         penguins[which(penguins$species=='Adelie'),'flipper_length_mm'],
                         use = 'pairwise.complete.obs'),2))) +
  geom_text(x=58, y=208, colour=wes_palettes$Zissou1[3], size=5,
            label=paste("R = ", 
                        round(cor(penguins[which(penguins$species=='Chinstrap'),'bill_length_mm'], 
                                  penguins[which(penguins$species=='Chinstrap'),'flipper_length_mm'],
                                  use = 'pairwise.complete.obs'),2))) +
  geom_text(x=57, y=235, colour=wes_palettes$Zissou1[5], size=5,
            label=paste("R = ", 
                        round(cor(penguins[which(penguins$species=='Gentoo'),'bill_length_mm'], 
                                  penguins[which(penguins$species=='Gentoo'),'flipper_length_mm'],
                                  use = 'pairwise.complete.obs'),2))) +
  labs(title = 'Relationship between penguin flipper and bill length',
       subtitle = 'Gentoo penguins have a higher correlation between flipper and bill length compared to Adelie and Chinstrap penguins',
       caption = 'Data Source: Horst AM, Hill AP, Gorman KB (2020). palmerpenguins\nClipart: clipartkid.com\nCreated by: dosullivan019',
       colour = 'Penguin Species',
       shape = 'Penguin Species',
       y = 'Flipper length (mm)',
       x = 'Bill length (mm)') +
  scale_colour_manual(values = wes_palettes$Zissou1[c(1,3,5)]) +
  theme(legend.position = 'top',
         legend.title = element_text(size=14),
        legend.text = element_text(size=13),
        plot.title = element_text(size=20,family='Georgia'),
        plot.subtitle = element_text(size=11.5, family='Georgia',vjust=0.95),
        plot.caption = element_text(face='italic', size=10),
        panel.background = element_rect(fill='white'),
        panel.grid.major=element_line(colour='grey90', linetype=2),
        axis.text = element_text(size=11, family = 'Georgia'),
        axis.title.y = element_text(size=13, family='Georgia'),
        axis.title.x = element_text(size=13, family='Georgia'))

ggdraw(penguin_plot) +
  draw_image(penguin_image, x=-0.35, y=0.27, scale=0.225)

ggsave('plots/day13_correlation_penguins.png')
