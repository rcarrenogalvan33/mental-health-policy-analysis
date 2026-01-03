# mental-health-policy-analysis
Exploring mental health burden and socioeconomic factors using U.S. survey data
Mental Health Burden and Socioeconomic Inequality
An Exploratory and Inferential Policy Analysis Using U.S. Survey Data
Project Overview

This project examines patterns of mental health burden in the United States and how they vary across income, education, employment status, and general health. Using large-scale survey data, the analysis combines descriptive visualization, group comparisons, and regression modeling to identify which social and health factors are most strongly associated with poor mental health days.

The goal of this project is not only statistical analysis, but policy-relevant interpretation: understanding who experiences higher mental health burden, how large those differences are, and which groups may require targeted interventions.

Research Questions

This project is guided by the following questions:

How is mental health burden distributed across the population?

Do mental health outcomes differ systematically by:

Income

Education

Employment status

General health status?

Which factors remain strongly associated with mental health burden after accounting for others?

How much explanatory power is gained as additional predictors are added to the model?

What are the policy implications of these observed disparities?

Data Source

Data: U.S. Behavioral Risk Factor Surveillance System (BRFSS)

Unit of analysis: Individual survey respondents

Outcome variables:

MENTHLTH: Number of poor mental health days in the past 30 days (capped at 31)

PHYSHLTH: Number of poor physical health days in the past 30 days

Key predictors:

Income

Education

Employment status

General self-rated health

Note: Raw survey data are not included in this repository due to size and licensing considerations. All cleaning and analysis steps are fully documented in the R script.

Data Cleaning and Preparation

Key cleaning steps included:

Recoding special survey values (e.g., 88, 99) as missing

Capping numeric health-day variables at 31 days

Creating categorical groupings for:

Income

Education

Employment status

General health

Creating a binary mental health indicator:

<14 days vs 14+ days of poor mental health

Ensuring consistent factor reference categories for regression analysis

These steps were critical to ensure interpretability, comparability, and policy relevance of results.

Analytical Approach

This project uses a layered analytical strategy, moving from description to inference:

1. Descriptive Analysis

Histograms of numeric health variables

Bar plots of categorical distributions

Boxplots comparing mental health across groups

Purpose:
To understand distributions, skewness, and subgroup patterns before modeling.

2. Categorical × Categorical Analysis

Cross-tabulations

Row percentages

Chi-square tests

Purpose:
To identify statistically significant disparities in mental health burden across income and employment groups.

3. Numeric × Categorical Analysis

ANOVA

Tukey post-hoc tests

Effect sizes (Eta²)

Purpose:
To quantify how many additional poor mental health days different groups experience, not just whether differences exist.

4. Numeric × Numeric Analysis

Scatterplots

Correlation analysis

Simple linear regression (Mental health ~ Physical health)

Purpose:
To examine how mental and physical health burdens move together and assess predictive relationships.

5. Multivariable Regression and Model Comparison

Sequential models were estimated:

Model 0: Intercept-only

Model 1: Income + Education

Model 2: Income + Education + Employment

Model 3: Income + Education + Employment + General Health

Models were compared using:

Adjusted R²

Nested F-tests

Changes in explained variance

Purpose:
To determine which predictors add meaningful explanatory power and how social and health factors jointly shape mental health burden.

Key Findings

Mental health burden is highly right-skewed, with most respondents reporting few poor mental health days and a smaller but significant subgroup experiencing chronic burden.

Lower income, lower education, and weaker labor force attachment are consistently associated with more poor mental health days.

General health status shows the strongest association with mental health burden, substantially increasing explanatory power when added to the model.

Even after adjusting for health status, income and education remain independently associated with mental health, indicating persistent socioeconomic gradients.

Model comparison demonstrates that each added block of variables significantly improves model fit, supporting a multifactor explanation rather than a single-cause narrative.

Policy Implications

The findings suggest that mental health burden is not evenly distributed and cannot be addressed through universal approaches alone.

Key policy-relevant insights include:

A minority with chronic mental health burden accounts for a disproportionate share of poor mental health days, highlighting the need for targeted, sustained interventions.

Socioeconomic disparities persist even after accounting for general health, indicating that structural conditions (income, education, employment stability) play an independent role.

Employment status and labor force exclusion are particularly important for identifying high-risk groups.

Policies focused solely on individual treatment may miss broader social determinants that shape mental health outcomes.

Effective mental health policy should therefore integrate:

Income security

Educational access

Employment stability

Health system coordination

Files in This Repository

mental_health_analysis.R
Full, annotated R script containing data cleaning, analysis, diagnostics, and model comparison.

outputs/
Visualizations and tables generated during analysis.

policy_brief.pdf
A policy-oriented summary of results and implications.

Author

This project was completed as part of a personal policy analysis portfolio, with a focus on transparent methods, careful interpretation, and real-world relevance.
