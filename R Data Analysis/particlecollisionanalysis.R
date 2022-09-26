# loading the packages -----
library(tidyverse)
library(readr)

# importing the data -----
particledata <- read_csv("R work/samples_test_175_data.csv")
particledata <- particledata %>%
  select(-...1)

# pivoting correctly and making sample size a dbl
particledata_long <- particledata %>%
  rename(`50` = `50 samples`,
         `100` = `100 samples`,
         `150` = `150 samples`,
         `200` = `200 samples`,
         `250` = `250 samples`,
         `300` = `300 samples`,
         `350` = `350 samples`,
         `400` = `400 samples`,
         `450` = `450 samples`,
         `500` = `500 samples`,
         `550` = `550 samples`,
         `600` = `600 samples`,
         `650` = `650 samples`,
         `700` = `700 samples`) %>%
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

fivenumsummary <- particledata_long %>%
  group_by(samplesize) %>%
  summarize(min = min(percentaccuracy),
            Q1 = quantile(percentaccuracy, probs = 0.25),
            median = median(percentaccuracy),
            Q3 = quantile(percentaccuracy, probs = 0.75),
            max = max(percentaccuracy)) %>%
  arrange(samplesize)

# density plots
particledata_long %>%
  ggplot(aes(x = percentaccuracy)) + 
  geom_density() +
  facet_wrap(~ samplesize, ncol = 2)

# plotting the data -----
particledata_long %>%
  ggplot(aes(x = samplesize, y = percentaccuracy)) +
  geom_jitter()

particledata_long %>%
  ggplot(aes(x = samplesize, y = percentaccuracy)) +
  geom_jitter() + 
  labs(x = "Sample Size",
       y = "Accuracy (%) for 175 test samples")

statssamplesize %>%
  ggplot(aes(x = samplesize, y = sd)) + 
  geom_line() + 
  labs(x = "Sample Size",
       y = "Standard Deviation of Accuracy (%) for 175 Test Samples")
  
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
