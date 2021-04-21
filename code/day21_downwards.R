# 30 Day Chart challenge 2021
# 21st April 2021: Time Series | Downward
# Price of Solar Energy
# Data Source: Our World in Data https://ourworldindata.org/renewable-energy
library(ggplot2)
library(extrafont)

solar_data = read.csv('data/solar-pv-prices.csv')

ggplot(data=solar_data, aes(x=Year, y=Solar.PV.Module.Cost..2019.US..per.W.)) +
  geom_area(fill='gold', col='gold') +
  labs(title = 'Global Solar Panel Prices',
       y='Solar Panel prices ($ / W)',
       caption='Data Source: Our World in Data\nCreate by: dosullivan019') +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(expand=c(0,0)) +
  theme(panel.background = element_rect(fill='white'),
        plot.title = element_text(family='Calisto MT', size=20, hjust=0.5),
        axis.text = element_text(family='Calisto MT', size=12),
        axis.title = element_text(family='Calisto MT', size=14),
        plot.caption=element_text(face='italic'),
        panel.grid.major=element_line(colour='grey90', linetype=2))

ggsave('plots/day21_downwards.png')
