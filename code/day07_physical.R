# 30 Day Chart challenge 2021
# 7th April 2021: Physical Distribution
# Sea Ice Extent
# Data Source: https://earth.gsfc.nasa.gov/cryo/data/arcticantarctic-sea-ice-time-series
library(data.table)
library(ggplot2)
library(scales)
library(jpeg)
library(grid)
library(pals)
library(extrafont)

ice_extent_data = fread('https://earth.gsfc.nasa.gov/sites/default/files/neptune/files/SH_IceExt_Monthly_1978-2017.txt', 
                        header = FALSE, skip=5, 
                        colClasses = c('factor', 'numeric','numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

colnames(ice_extent_data) = c('year','month','Weddell Sea', 'Indian Ocean', 'Western Pacific Ocean',
                              'Ross Sea', 'Bellingshausen & Amundsen Seas', 'Total')

ice_extent_data$month_name = factor(month.abb[ice_extent_data$month],levels=month.abb)

img <- readJPEG("./images/sea_ice.jpg")

ggplot(ice_extent_data, aes(x=month_name, y=Total,group=year,col=year)) + 
  annotation_custom(rasterGrob(img, width=unit(1,"npc"), height=unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf) +
  geom_line(size=0.8) + 
  labs(title='Annual Sea Ice Cover in the Southern Ocean',
       y='Sea Ice Cover (squared km)',
       x='Month',
       caption='Data Source: NASA Earth Sciences\nImage: NASA\'s Operation IceBridge\nCreated by: dosullivan019') + 
  scale_color_manual(values=brewer.blues(length(unique(ice_extent_data$year)))) +
  scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6),expand=c(0,0)) +
  scale_x_discrete(expand=c(0,0)) +
  theme(legend.position = 'none',
        axis.title.y = element_text(family='Georgia', size=13),
        axis.title.x = element_text(family='Georgia', size=12),
        axis.text.y = element_text(family='Georgia'),
        axis.text.x = element_text(family='Georgia', hjust=0.9),
        plot.caption = element_text(face='italic', size=10),
        plot.title = element_text(size=20, hjust=0.5,family='Georgia'),
        panel.background = element_blank())


ggsave('plots/day7_sea_ice_cover.png')
