############################################################
# Mental Health & Social Determinants Analysis
# Author: Rebe
# Purpose: Policy-oriented analysis of poor mental health days
# Dataset: Behavioral Risk Factor Surveillance System (BRFSS)
############################################################

############################
# 1. Load Libraries
############################
library(tidyverse)
library(effectsize)

############################
# 2. Load Data
############################
# Replace with your actual file path
mh <- read.csv("mental_health_data.csv")

############################
# 3. Variable Selection & Cleaning
############################

# Keep only variables used in analysis
mh <- mh %>%
  select(
    MENTHLTH,      # Poor mental health days (1–31)
    PHYSHLTH,      # Poor physical health days (1–31)
    INCOME3,       # Income category
    EDUCA,         # Education level
    EMPLOY1,       # Employment status
    GENHLTH        # General health
  )

# Create binary mental health indicator (policy-relevant threshold)
mh <- mh %>%
  mutate(
    poor_menthlth_14 = case_when(
      MENTHLTH < 14 ~ "<14 days",
      MENTHLTH >= 14 ~ "14+ days",
      TRUE ~ NA_character_
    )
  )

# Convert categorical variables to factors
mh <- mh %>%
  mutate(
    INCOME3  = factor(INCOME3),
    EDUCA    = factor(EDUCA),
    EMPLOY1  = factor(EMPLOY1),
    GENHLTH  = factor(GENHLTH),
    poor_menthlth_14 = factor(poor_menthlth_14)
  )

############################
# 4. Missingness Check
############################
sapply(
  mh[, c("MENTHLTH","PHYSHLTH","INCOME3","EDUCA","EMPLOY1","GENHLTH")],
  function(x) mean(is.na(x))
)

############################
# 5. Descriptive Statistics
############################
summary(mh$MENTHLTH)
summary(mh$PHYSHLTH)

############################
# 6. Visualizations
############################

# Histogram: Mental health days
ggplot(mh, aes(x = MENTHLTH)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Poor Mental Health Days")

# Boxplot: Mental health by employment
ggplot(mh, aes(x = EMPLOY1, y = MENTHLTH)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Poor Mental Health Days by Employment Status")

############################
# 7. Cross-tabs & Chi-square Tests
############################

# Mental health (14+ days) by employment
mh_tab_employ <- table(mh$poor_menthlth_14, mh$EMPLOY1)
mh_tab_employ
prop.table(mh_tab_employ, margin = 1) * 100
chisq.test(mh_tab_employ)

# Mental health (14+ days) by income
mh_tab_income <- table(mh$poor_menthlth_14, mh$INCOME3)
mh_tab_income
prop.table(mh_tab_income, margin = 1) * 100
chisq.test(mh_tab_income)

############################
# 8. ANOVA + Tukey + Effect Size
############################

# Mental health by income
anova_income <- aov(MENTHLTH ~ INCOME3, data = mh)
summary(anova_income)
TukeyHSD(anova_income)
eta_squared(anova_income, partial = FALSE)

# Mental health by education
anova_educa <- aov(MENTHLTH ~ EDUCA, data = mh)
summary(anova_educa)
TukeyHSD(anova_educa)
eta_squared(anova_educa, partial = FALSE)

# Mental health by general health
anova_genhlth <- aov(MENTHLTH ~ GENHLTH, data = mh)
summary(anova_genhlth)
TukeyHSD(anova_genhlth)
eta_squared(anova_genhlth, partial = FALSE)

############################
# 9. Numeric × Numeric Analysis
############################

# Scatterplot: Mental vs physical health
ggplot(mh, aes(x = PHYSHLTH, y = MENTHLTH)) +
  geom_jitter(alpha = 0.2) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Mental vs Physical Health Days")

# Correlation
cor(mh$MENTHLTH, mh$PHYSHLTH, use = "complete.obs")
cor.test(mh$MENTHLTH, mh$PHYSHLTH)

############################
# 10. Simple Linear Regression
############################

lm_phys_ment <- lm(MENTHLTH ~ PHYSHLTH, data = mh)
summary(lm_phys_ment)
confint(lm_phys_ment)

# Diagnostics
par(mfrow = c(2,2))
plot(lm_phys_ment)

############################
# 11. Multiple Regression (Policy Model)
############################

mh_complete <- mh %>%
  drop_na(MENTHLTH, INCOME3, EDUCA, EMPLOY1, GENHLTH)

# Baseline model
m0 <- lm(MENTHLTH ~ 1, data = mh_complete)

# Incremental models
m1 <- lm(MENTHLTH ~ INCOME3 + EDUCA, data = mh_complete)
m2 <- lm(MENTHLTH ~ INCOME3 + EDUCA + EMPLOY1, data = mh_complete)
m3 <- lm(MENTHLTH ~ INCOME3 + EDUCA + EMPLOY1 + GENHLTH, data = mh_complete)

# Model summaries
summary(m1)
summary(m2)
summary(m3)

############################
# 12. Model Comparison
############################

summary(m0)$adj.r.squared
summary(m1)$adj.r.squared
summary(m2)$adj.r.squared
summary(m3)$adj.r.squared

anova(m0, m1, m2, m3)

############################
# End of Script
############################
