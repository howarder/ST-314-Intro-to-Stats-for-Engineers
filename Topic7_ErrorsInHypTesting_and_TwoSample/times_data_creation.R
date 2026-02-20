times_A <- round(rchisq(33, 2),2)
times_B <- round(rexp(32, 4/9),2)

mean(times_A)-mean(times_B)
sd(times_A)
sd(times_B)

AB_test <- tibble(
  version = c(rep("A", length(times_A)), 
              rep("B", length(times_B))), 
  time = c(times_A, times_B)
)

write_csv(AB_test, "AB_test.csv")

library(ggplot2)

A <- AB_test |>
  filter(version == "A")
B <- AB_test |>
  filter(version == "B")

ggplot(A, aes(x = time)) + 
  geom_histogram(binwidth = 1, 
                 fill = "lightblue", 
                 color = "black", 
                 boundary = 0) + 
  labs(x = "Time Spend on Standard Site (min)")

ggplot(B, aes(x = time)) + 
  geom_histogram(binwidth = 1, 
                 fill = "red", 
                 color = "black", 
                 boundary = 0) + 
  labs(x = "Time Spent on Updated Site (min)")

t.test(time ~ version, data = AB_test)
