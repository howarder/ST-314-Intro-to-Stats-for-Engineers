#### ST 314 - Class 2 R Programming Demo ####

# comment your code by adding a # in front of any 
# text you don't intend to run as code

# Load Libraries - often we need functions and datasets that live in packages
# To install a package (a one-time occurrence) use the install.packages() function
# For example, if I didn't have the tidyverse package installed, I would run:
# install.packages("tidyverse")
# Once the package is installed, it needs to be opened with each new R session:
library(tidyverse)
library(openintro)

## Numerical variables ##

# Create a short vector of data using the c() function:
data_small <- c(1, 15, 34, 19, 52, 12)

# Compute summary statistics using built in functions: 
mean(data_small)
median(data_small)
sd(data_small)
var(data_small)
IQR(data_small, type = 1)
length(data_small)

# Use a data set already stored in R:
data(nycflights)
glimpse(nycflights)
names(nycflights)
?nycflights # displays the help file

# Construct a histogram of the distance variable in the nycflights dataset
ggplot(data = nycflights, aes(x = distance)) +
  geom_histogram()

# Customize the histogram
ggplot(data = nycflights, aes(x = distance)) +
  geom_histogram(bins = 15, color = "black", fill = "blue") + 
  labs(x = "Distance Flown (mi)")

# Construct a boxplot of the distance variable in the nycflights dataset
ggplot(data = nycflights, aes(x = distance)) +
  geom_boxplot() + 
  labs(x = "Distance Flown (mi)")

# Compute summary statistics about the distance variable for each 
# origin airport in NYC  using piping operator %>%
nycflights %>%
  group_by(origin) %>%
  summarise(mean = mean(distance), 
            median = median(distance), 
            sd = sd(distance), 
            iqr = IQR(distance), 
            n = length(distance))

## Categorical Variables ##

# Compute tables of counts and proportions for the origin variable
nycflights %>%
  group_by(origin) %>%
  summarise(n = n()) %>%
  mutate(proportion = n/sum(n))

# The following two lines of code will perform the same calculations (there 
# are almost always multiple ways to do something in R)
table(nycflights$origin)
prop.table(table(nycflights$origin))

# Construct a barplot for the origin variable with counts on the y-axis
ggplot(data = nycflights, aes(x = origin)) + 
  geom_bar()

# Construct a barplot for the origin variable with proportions on the y-axis
ggplot(data = nycflights, aes(x = origin)) + 
  geom_bar(aes(y = ..prop.., group = 1), stat = "count")

# Switch demo to use diamonds dataset

# Create a stacked barplot of diamond colors by cut 
ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut))

# Create a dodged barplot of diamond colors by cut 
ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut), position = "dodge")

# Create a standardized barplot of diamond colors by cut 
ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut), position = "fill") + 
  labs(y = "Proportion")
