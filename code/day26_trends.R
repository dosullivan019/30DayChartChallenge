# 30 Day Chart challenge 2021
# 26th April 2021: Uncertainties Trends
# Avocado Prices
# Data Source: Kaggle https://www.kaggle.com/timmate/avocado-prices-2020
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(wesanderson)
library(extrafont)

avocado_prices <- read.csv("data/avocado-updated-2020.csv", na.strings=-99)
avocado_prices$month_name = factor(month.abb[month(avocado_prices$date)],levels=month.abb)

avocado_prices %>% 
  group_by(month_name, type) %>%
  summarize(price_quantile=quantile(average_price, c(0.05, 0.25, 0.5, 0.75, 0.95), na.rm=TRUE), 
            quantile=c('q5', 'q25', 'q50', 'q75', 'q95')) %>% 
  ungroup() %>% pivot_wider(values_from=price_quantile, names_from=quantile) %>%
  ggplot() + 
  geom_errorbar(aes(x=month_name, ymin=q5, ymax=q95, group=type, col=type), position = position_dodge(.5), size=1, alpha=0.5) +
  geom_errorbar(aes(x=month_name, ymin=q25, ymax=q75, group=type, col=type), position = position_dodge(.5), size=1) +
  geom_point(aes(x=month_name, y=q50, group=type, col=type), size=3, position = position_dodge(.5)) +
  geom_smooth(aes(x=month_name, y=q50, group=type, col=type), position=position_dodge(.5), linetype=2, se=FALSE) + 
  scale_colour_manual(values=c(wes_palettes$Zissou1[1],wes_palettes$Zissou1[4])) + 
  scale_y_continuous(limits=c(0.5,2.5), expand = c(0,0)) +
  labs(title='Avocado Prices in America 2015 - 2020',
       subtitle = 'Avocados tend to be more expensive in summer.',
       y = 'Price (USD)',
       x = 'Year',
       colour = 'Avocado Type',
       caption = 'Data Source: Kaggle / Hass Avocado Board\nCreated by: dosullivan019') +
  theme(legend.position = 'top', 
        legend.text = element_text(size=10, family='Georgia'),
        legend.key = element_rect(fill='white'),
        legend.title = element_text(size=12, family= 'Georgia'),
        plot.title = element_text(size=18, family='Georgia'),
        plot.subtitle = element_text(size=11, family='Georgia'),
        plot.caption = element_text(face='italic', size=8),
        axis.text = element_text(size=11, family='Georgia'),
        axis.title = element_text(size=13, family = 'Georgia'),
        panel.background = element_blank())

ggsave('plots/day26_trends.png')  
