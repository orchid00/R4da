# Ref: https://micahallen.org/2018/03/15/introducing-raincloud-plots/
# Description: I loved the blog post above for rain cloud plots. On a rainy day
# I've tried to tidy the code 
# Author: Paula Andrea Martinez
# Date: March 22, 2018 

# 1. Libraries ----
library(tidyverse)

# 2. source geom_flat_violin ----
source("https://gist.githubusercontent.com/benmarwick/2a1bb0133ff568cbe28d/raw/fb53bd97121f7f9ce947837ef1a4c65a73bffb3f/geom_flat_violin.R")

# 3. Read in data ----
my_data <- read_csv("https://data.bris.ac.uk/datasets/112g2vkxomjoo1l26vjmvnlexj/2016.08.14_AnxietyPaper_Data%20Sheet.csv")
colnames(my_data)
glimpse(my_data)

# 4. Tidy data to long format ----
my_datal <- my_data %>% 
  select(Participant, AngerUH, DisgustUH, FearUH, HappyUH) %>% 
  gather(c("AngerUH", "DisgustUH", "FearUH", "HappyUH"), 
         key = "EmotionCondition", value = "Sensitivity")

head(my_datal)

# 5. Make a new theme ----
raincloud_theme <- theme(
  text = element_text(size = 10),
  axis.title.x = element_text(size = 16),
  axis.title.y = element_text(size = 16),
  axis.text = element_text(size = 14),
  axis.text.x = element_text(angle = 45, vjust = 0.5),
  legend.title = element_text(size = 16),
  legend.text = element_text(size = 16),
  legend.position = "right",
  plot.title = element_text(lineheight = .8, face = "bold", size = 16),
  panel.border = element_blank(),
  panel.grid.minor = element_blank(),
  panel.grid.major = element_blank(),
  axis.line.x = element_line(colour = "black", size = 0.5, linetype = "solid"),
  axis.line.y = element_line(colour = "black", size = 0.5, linetype = "solid"))

# 6. Calculate summary stats ----
lb <- function(x) mean(x) - sd(x)
ub <- function(x) mean(x) + sd(x)

sumld <- my_datal %>% 
  select(-Participant) %>% 
  group_by(EmotionCondition) %>% 
  summarise_all(funs(mean, median, lower = lb, upper = ub))

sumld
groups(sumld) # just to show that after summarise there is no groups

# 7. Ready to plot, first raincloud plot! ----
g <- 
  ggplot(data = my_datal, 
         aes(x = EmotionCondition, y = Sensitivity, fill = EmotionCondition)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = Sensitivity, color = EmotionCondition), 
             position = position_jitter(width = .15), size = .5, alpha = 0.8) +
  geom_boxplot(width = .1, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 5.25) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  scale_color_brewer(palette = "Spectral") +
  scale_fill_brewer(palette = "Spectral") +
  coord_flip() + # flip or not
  theme_bw() +
  raincloud_theme

g
# 8. Same plot - replacing the boxplot with a mean and confidence interval ----
g <- 
  ggplot(data = my_datal, 
         aes(x = EmotionCondition, y = Sensitivity, fill = EmotionCondition)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = Sensitivity, color = EmotionCondition), 
             position = position_jitter(width = .15), size = .5, alpha = 0.8) +
  geom_point(data = sumld, aes(x = EmotionCondition, y = mean), 
             position = position_nudge(x = 0.3), size = 2.5) +
  geom_errorbar(data = sumld, aes(ymin = lower, ymax = upper, y = mean), 
                position = position_nudge(x = 0.3), width = 0) +
  expand_limits(x = 5.25) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  coord_flip() + # flip or not?
  scale_color_brewer(palette = "Spectral") +
  scale_fill_brewer(palette = "Spectral") +
  theme_bw() +
  raincloud_theme

g

# note: this gives a Warning: Ignoring unknown aesthetics: y
# It is from the geom_errorbar, but when removed gives and error
# Error in FUN(X[[i]], ...) : object 'Sensitivity' not found