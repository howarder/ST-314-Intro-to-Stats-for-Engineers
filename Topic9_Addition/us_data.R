install.packages("usdata")
library(usdata)
library(tidyverse)
View(urban_owner)

urban_owner |>
  filter(state != "District of Columbia") |>
  filter(state != "Puerto Rico") |>
  ggplot(aes(x = poppct_urban, y = pct_owner_occupied)) +
  geom_point() + 
  stat_smooth(method = "lm", 
              formula = y ~ x, 
              geom = "smooth", 
              se = FALSE)

