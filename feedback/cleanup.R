

# Clean and export feedback

# libraries --------------------------
library(tidyverse)

# Reading in data --------------------
mydata <- read_csv(file = "data/Elixir_Workshop_Feedback_2018_Data_1519391579.csv", 
                   skip = 1, col_names = FALSE, na = c(""," ","NA"))
tail(mydata, n = 2)
mydata <- mydata[, c(7, 1, 6, 3, 2, 5, 4, 8, 9:14)]
tail(mydata)
names(mydata) <- c("Workshop", "Date", "Hear_About_Workshop", "Career_Stage", 
                   "Employment_Sector", "Country_Employment", "Gender",
                   "Have_Used_tools", "Will_use_tools_again",
                    "Recommend", "Satisfaction",
                    "Enjoy", "To_improve", "LongTermContact")
tail(mydata)
glimpse(mydata)

# convert factor to date
head(mydata$Date)
mydata$Date <- lubridate::ymd_hms(as.character(mydata$Date), tz = "CET")
head(mydata$Date)
save(mydata, file = "Rdata/mydata.RData")

# filter workshop
newWorkshop <- 
  mydata %>% 
    filter(Workshop == "Tidyverse_UAntwerp") %>% 
    select(-LongTermContact)

glimpse(newWorkshop)

write_csv(newWorkshop, path = "data_cleaned/2018-02-21_tidyverse_Antwerp.csv")


# Plots-------------------------------------
myplots <-  function(mydata, nam){
  library(scales)
  cbPalette <- c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#999999","#E69F00",
                 "#D55E00", "#CC79A7", "#90EE90")
  scale_fill_manual(values = cbPalette)
  # To use for line and point colors, add
  scale_colour_manual(values = cbPalette)
  
  
  ggplot(data = mydata, mapping = aes(x = Satisfaction)) +
    geom_bar(fill = "skyblue", colour = "steelblue") +
    labs(title = "Overall satisfaction with the workshop?") +
    theme_light() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
  ggsave(filename =  paste("plots/", nam, "_Satisfaction",
                           ".png", sep = ""))
  
  ggplot(mydata, aes(x = "", fill = factor(Satisfaction))) +
    geom_bar(width = 1) +
    coord_polar(theta = "y") +
    scale_fill_manual(values = cbPalette,
                      name = "Satisfaction with the workshop") +
    theme_light()
  ggsave(filename =  paste("plots/", nam, "_Satisfaction_pie_",
                           ".png", sep = ""))
  
  ggplot(data = mydata, mapping = aes(x = Career_Stage)) +
    geom_bar(fill = "skyblue", colour = "steelblue") +
    labs(title = "Career stage of attendees") +
    theme_light() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
  ggsave(filename =  paste("plots/", nam, "_Career_stage_",
                           ".png", sep = ""))
  
   ggplot(mydata, aes(x = "", fill = factor(Career_Stage))) +
    geom_bar(width = 1) +
    coord_polar(theta = "y") +
    scale_fill_manual(values = cbPalette,
                      name = "Career Stage") +
    theme_light()
  ggsave(filename =  paste("plots/", nam, "_Career_stage_pie_",
                           ".png", sep = ""))
  
  ggplot(data = mydata, mapping = aes(x = Gender)) +
    geom_bar(fill = "skyblue", colour = "steelblue") +
    labs(title = "Gender") +
    theme_light() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
  ggsave(filename =  paste("plots/", nam, "_Gender_",
                           ".png", sep = ""))
  
}

### subset
myplots(newWorkshop, "2018-02-21_tidyverse_Antwerp")

# sessionInfo()
# R version 3.4.3 (2017-11-30)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 16.04.3 LTS
# 
# Matrix products: default
# BLAS: /usr/lib/libblas/libblas.so.3.6.0
# LAPACK: /usr/lib/lapack/liblapack.so.3.6.0
# 
# locale:
#   [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=de_BE.UTF-8       
# [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=de_BE.UTF-8    LC_MESSAGES=en_US.UTF-8   
# [7] LC_PAPER=de_BE.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
# [10] LC_TELEPHONE=C             LC_MEASUREMENT=de_BE.UTF-8 LC_IDENTIFICATION=C       
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] scales_0.5.0    bindrcpp_0.2    forcats_0.3.0   stringr_1.3.0   dplyr_0.7.4    
# [6] purrr_0.2.4     readr_1.1.1     tidyr_0.8.0     tibble_1.4.2    ggplot2_2.2.1  
# [11] tidyverse_1.2.1
