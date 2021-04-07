# 30 Day Chart challenge 2021
# 6th April 2021: Experimental
# Coral Reef Restoration
# Data Source: https://www.icriforum.org/restoration/coral-restoration-database/
library(readxl)
library(dplyr)
library(ggplot2)

reef_data <- read_excel('./data/Coral restoration review - 2020 Update - for download (anon).xlsx',
                        sheet='Peer reviewed literature')
# data cleaning
reef_data %>%
  mutate(survival_pct = as.numeric(`survival % (if measured)`),
         restoration_technique=gsub('Coral Gardening-Nursery phase',
                                    'Coral Gardening - Nursery phase',`Coral Restoration Technique or methods`),
         total_experiments=n()) %>%
  group_by(restoration_technique,total_experiments) %>% 
  summarise(mean=mean(survival_pct, na.rm=TRUE), # average survival rate for each technique
            no_projects_in_group=n()) %>% 
  mutate(group_pct_of_total=(no_projects_in_group/total_experiments)*100) %>% # percent of total experiments
  filter(group_pct_of_total > 5 & !is.na(restoration_technique)) %>%
  ggplot(aes(x=mean, y=no_projects_in_group)) + 
  facet_wrap(vars(restoration_technique), ncol=2) +
  geom_text(aes(x=58.2,y=64.75,label=paste(round(group_pct_of_total,0), '%\nProjects')),
                         size=8, colour='gold') +
              #'%Survival:', round(mean,0), '%')), 
  ylim(64,65) + xlim(58,59) + 
  labs(title='Reef Restoration Methods',
       subtitle = 'Peer reviewed experimental techniques to restore reefs') +
  theme(plot.title = element_text(colour='white', size=20, hjust=0.5),
        plot.subtitle = element_text(colour='white', size=14, hjust=0.5),
        plot.background = element_rect(fill='dodgerblue3'),
        panel.background = element_rect(fill='dodgerblue3'),
        strip.text.x = element_text(size = 14, colour='gold',hjust=0),
        strip.background = element_rect(fill='dodgerblue3'),
        axis.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

