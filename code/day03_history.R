# 30 Day Chart Challenge 2021
# 3rd April 2021: Historical
# W.E.B DuBois Recreation
# Data Source: Tidy Tuesday 2021 Week 8
library(ggplot2)
library(dplyr)
library(ggrepel)
library(extrafont)

freed_slaves <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/freed_slaves.csv')
head(freed_slaves)

freed_slaves %>% ggplot(aes(x=Year, y=Slave)) +
  geom_line() + geom_area(fill='black') +
 geom_text_repel(aes(x=Year, y=Slave, 
                 label=scales::percent(ifelse(Free==100,NA,Free), accuracy=1, scale=1)),
                 nudge_y=1.5, nudge_x=-0.5, family='Bahnschrift', size=5) +
  annotate('text',label='100%', x=1868, y=91, size=4.5, family='Bahnschrift') +
  annotate('text',label='SLAVES \n ESCLAVES', x=1827, y=50, 
           colour='white',fontface='bold',size=9, family='Bahnschrift') +
  annotate('text',label='FREE - LIBRE', x=1827, y=95, 
           colour='black',size=7, family='Bahnschrift', fontface='bold')  +
  labs(title='PROPORTION OF FREEMEN AND SLAVES AMONG AMERICAN NEGROES .\n \nPROPORTION   DES   NÈGRES   LIBRES   ET   DES   ESCLAVES   EN   AMÉRIQUE . \n',
       subtitle='DONE BY ATLANTA UNIVERSITY . \n') +
  scale_x_continuous(expand = c(0, 0), position='top', breaks=freed_slaves$Year) +
  scale_y_continuous(expand=c(0,0), limits = c(0,100))+
  theme(panel.background = element_rect(fill='forestgreen'),
        panel.grid.major.x = element_line(colour='grey50'),
        panel.grid.minor.y = element_line(colour='forestgreen'),
        panel.grid.minor.x = element_line(colour='forestgreen'),
        panel.grid.major.y = element_line(colour='forestgreen'),
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x= element_text(size=12, colour='black', family='Bahnschrift', face='bold'),
        plot.title = element_text(colour='black', family='Bahnschrift', hjust=0.5),
        plot.subtitle = element_text(colour='black', family='Bahnschrift', hjust=0.5),
        plot.margin = unit(c(1,2,1,2), 'lines'),
        plot.background = element_rect(fill='beige'))

ggsave('plots/day03_history.png', height=7)
