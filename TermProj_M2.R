## Prepare packages
#install.packages('dplyr')
#install.packages('ggplot2')
library(dplyr)
library(ggplot2)

## Read data
data = read.table('fivepcounts-filtered-RPF-siLuc.txt')
head(data)

## Calculate relative position of 5 prime ends to start codon
data$pos = data$V2 - data$V9

## Group by relative position and count reads
pos_table = data %>% group_by(pos) %>% summarise(count = sum(V4))

## View data
pos_table[pos_table$pos>=-5 & pos_table$pos<=5, ]

## Extract relative position between -50~50bp
pos_table_middle = pos_table[pos_table$pos>=-50 & pos_table$pos<=50, ]
dim(pos_table_middle)

## Plot
ggplot(pos_table_middle, aes(pos, count)) + 
  geom_bar(stat='identity', width=0.5, fill='black') +
  geom_vline(xintercept=0, color='red') +
  xlab("Relative position to start codon of 5' end of reads") +
  ylab("Raw read count") +
  ggtitle("Ribosome footprint density of start codons") +
  scale_x_discrete(breaks=seq(-50, 50, 10)) +
  theme_bw()

## Save plot
ggsave('Mission2_figure.pdf', height=4, width=10)
