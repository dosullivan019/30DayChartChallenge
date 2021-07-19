library(ggplot2)
library(dplyr)
library(tidyr)
library(imager)
library(cowplot)

# Load both teams logos
italy_logo <- load.image(file = "./images/italy.png")
england_logo <- load.image(file = "./images/england.png")

euros_final_2021 = data.frame(c('Italy', 'England'), 
                              c(1, 1),
                              c(19, 6), 
                              c(6, 2),
                              c(66, 34),
                              c(21, 13))

colnames(euros_final_2021) = c('team', 'Goals', 'Shots', 'Shots on Target', 'Possession', 'Fouls')

stats_plot=
  euros_final_2021 %>% 
  pivot_longer(cols=c('Goals', 'Shots', 'Shots on Target', 'Possession', 'Fouls'), 
               names_to = 'variable') %>%
  group_by(variable) %>%
  mutate(percentage = value/sum(value),
         label_position = ifelse(team == 'Italy', 0.025, 0.975)) %>%
  ggplot() +
  geom_bar(aes(x=percentage, y=variable, fill=team), stat = 'identity') +
  geom_text(aes(x=label_position, y=variable, label=value), col='white') +
  scale_fill_manual(values=c('grey60', 'grey20')) +
  labs(title = 'UEFA Euro 2020 Final') +
  theme_minimal() +
  theme(axis.text.x = element_blank(), 
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust=0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position = 'none')

ggdraw(stats_plot) + 
  draw_image(italy_logo, x=-0.25, y=0.55, scale=0.25) +
  draw_image(england_logo, x=0.4, y=0.55, scale=0.25) +
  theme(plot.margin = unit(c(2.5,1,1,1), 'cm'))

ggsave('plots/day01_part_to_whole.png')
