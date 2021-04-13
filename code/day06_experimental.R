# 30 Day Chart challenge 2021
# 6th April 2021: Experimental
# Coral Reef Restoration
# Data Source: https://www.icriforum.org/restoration/coral-restoration-database/
library(readxl)
library(dplyr)
library(ggplot2)
library(extrafont)
library(stringr)
library(imager)
library(cowplot)

img <- load.image(file = "./images/reef.jpg")

reef_data <- read_excel('./data/Coral restoration review - 2020 Update - for download (anon).xlsx',
                        sheet='Peer reviewed literature')
# data cleaning
reef_plot =
  reef_data %>%
  mutate(survival_pct = as.numeric(`survival % (if measured)`),
         restoration_technique=gsub('Coral Gardening-Nursery phase',
                                    'Coral Gardening - Nursery phase',`Coral Restoration Technique or methods`),
         total_experiments=n()) %>%
  group_by(restoration_technique,total_experiments) %>% 
  summarise(mean=mean(survival_pct, na.rm=TRUE), # average survival rate for each technique
            no_projects_in_group=n()) %>% 
  mutate(group_pct_of_total=(no_projects_in_group/total_experiments)*100) %>% # percent of total experiments
  filter(group_pct_of_total > 1 & !is.na(restoration_technique) & !is.na(mean)) %>%
  ggplot(aes(x=reorder(restoration_technique,-mean), y=mean, fill=group_pct_of_total)) + 
  geom_bar(stat='identity') +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
  scale_fill_gradient(low = "#56B1F7",
                      high = "#132B43")  +
  ylim(0,100) +
  labs(title='Reef Restoration Methods',
       subtitle = 'Peer reviewed experimental techniques to restore reefs',
       fill = '% of overall projects\nDarker colour = More Experiments',
       caption = 'Data Source: Coral Restoration Database, Boström-Einarsson et al (2020)\nCreated by: dosullivan019',
       y = 'survival rate (%)') +
  theme(legend.position='top',
        legend.justification = c("left", "top"),
        legend.title = element_text( size=13, vjust=0.85, colour='gray30'),
        plot.title = element_text(size=20, family='Georgia', colour='gray30'),
        plot.subtitle = element_text(size=16, family='Georgia', colour='gray30', vjust=0.1),
        plot.caption = element_text(size=10, face='italic', colour='gray30'),
        plot.background = element_rect(fill='white'),
        panel.background = element_rect(fill='white'),
        axis.title.y = element_text(size=13, family='Georgia', colour='gray30'),
        axis.title.x = element_blank(),
        axis.text = element_text(family='Georgia', colour='gray30'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


ggdraw(reef_plot) +
  draw_image(img, x=0.325, y=0.275, scale=0.475)

ggsave('plots/day06_experimental_reefs.png')
