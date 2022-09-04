# loading the packages -----
library(tidyverse)
library(readr)

# importing the data -----
particledata <- read_csv("~/R Work/Particle Physics Work/samples_test_data.csv")
particledata <- particledata %>%
  select(-...1)

# pivoting correctly and making sample size a dbl
particledata_long <- particledata %>%
  pivot_longer(names_to = "samplesize",
               values_to = "percentaccuracy",
               '50' : '700')
particledata_long$samplesize <- as.double(particledata_long$samplesize)

# finding the summary statistics -----
statssamplesize <- particledata_long %>%
  group_by(samplesize) %>%
  summarize(average = mean(percentaccuracy),
            sd = sd(percentaccuracy)) %>%
  arrange(samplesize)

# plotting the data -----
particledata_long %>%
  ggplot(aes(x = samplesize, y = percentaccuracy)) +
  geom_jitter()

particledata_long %>%
  ggplot(aes(x = samplesize, y = percentaccuracy)) +
  geom_jitter() + 
  geom_smooth() +
  labs(title = "Particle Collision Model Accuracy Based on Sample Size",
       x = "Sample Size",
       y = "Accuracy (%)")

ggsave("accuracy_vs_samplesize.png")

# plotting mean averages with standard deviation
particledata_long %>%
  group_by(samplesize) %>%
  summarize(average = mean(percentaccuracy),
            std = sd(percentaccuracy)) %>%
  ggplot(aes(x = samplesize, y = average)) +
  geom_col() + 
  geom_errorbar(aes(x = samplesize, ymin = average - std, 
                    ymax = average + std)) +
  labs(title = "Particle Collision Model Mean Accuracy Based on Sample Size",
       x = "Sample Size",
       y = "Mean Accuracy (%)")

ggsave("meanaccuracy_vs_samplesize.png")
