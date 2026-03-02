library(tidyverse)

mat_1 <- rnorm(22, 700, 10)
mat_2 <- rnorm(22, 699, 10)
mat_3 <- rnorm(22, 690, 10)
mat_4 <- rnorm(22, 690, 10)


boxes <- tibble(
  material = c(rep(1, 22), rep(2, 22), rep(3, 22), rep(4, 22)),
  strength = c(mat_1, mat_2, mat_3, mat_4)
)

write_csv(boxes, "boxes.csv")

ggplot(boxes, aes(x = strength, y = as.factor(material))) + 
  geom_boxplot(aes(fill = as.factor(material))) + 
  labs(x = "Compression Strength (lb)", 
       y = "Material") + 
  scale_fill_viridis_d(guide = "none") + 
  theme_bw()

ggplot(boxes, aes(x = strength)) +
  geom_histogram(binwidth = 8, aes(fill = as.factor(material)), 
                 color = "black") + 
  facet_wrap(~ material) + 
  scale_fill_viridis_d(guide = "none") + 
  labs(x = "Compression Strength (lb)")

mod <- lm(strength ~ as.factor(material), data = boxes)
summary(mod)
anova(mod)

pairwise.t.test(boxes$strength, as.factor(boxes$material), 
                pool.sd = FALSE,
                p.adjust.method = "bonf")

pair12 <- boxes |>
  filter(material == 1 | material == 2)

t.test(strength ~ material, pair12)

pair13 <- boxes |>
  filter(material == 1 | material == 3)
t.test(strength ~ material, pair13, var.equal = TRUE)

K <- (4*(4-1))/2
0.001658 * K
