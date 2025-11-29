# Results

## Skewness and Transformations

Several variables in the dataset showed substantial skewness, including **hours_on_oxygen**, **emphysema_percentage**, **lung_volume_expiratory**, **gas_trapping_percentage**, and **fev1_fvc_ratio**. Because *hours_on_oxygen*, *emphysema_percentage*, *lung_volume_expiratory*, and *gas_trapping_percentage* were all right-skewed, I applied log transformations to each of them. I did not transform **fev1_fvc_ratio** because it was left-skewed.

Across all variables, each group displayed some outliers at the upper end of the distribution. The interquartile ranges were generally similar between groups, and none of the distributions appeared severely skewed after transformation.

For some categorical variables, the distributions of **fev1_phase2** looked similar between groups, while for others, clear differences were present. For example, individuals without **asthma**, **bronchitis_attacks**, **chronic_bronchitis**, **pneumonia**, **emphysema**, or **COPD** consistently had higher median fev1_phase2 values than individuals with these conditions.

---

## Relationships Between Continuous Predictors and fev1_phase2

- There does **not** appear to be a meaningful relationship between **bmi** and **fev1_phase2**.  
- **Visit age** shows a **weak negative linear relationship** with **fev1_phase2**.  
- **Duration smoking** shows a **very weak negative linear relationship** with **fev1_phase2**.  
- **Lung volume inspiratory** is **moderately and positively** related to **fev1_phase2**.  
- **Emphysema percentage** shows a **negative relationship** with **fev1_phase2**, following an **exponential-decay pattern**.  
- **Lung volume expiratory** shows a **slight negative** relationship with **fev1_phase2**, also with a mild exponential-decay pattern.  
- **Gas trapping percentage** has a **moderate negative linear** relationship with **fev1_phase2**.  
- **Mean density inspiratory** shows a **moderate positive linear** relationship with **fev1_phase2**, with variability increasing at higher densities.  
- **Mean density expiratory** also shows a **moderate positive linear** relationship with **fev1_phase2**, with slightly increasing spread at higher values.

---

## Bootstrapped Differences in fev1_phase2 Between Categorical Groups

- **Hay Fever:**  
  95% CI: **(-0.108025, 0.067000)** → includes zero → **not significant**

- **Asthma:**  
  95% CI: **(-0.6395375, -0.4089000)** → entirely below zero → **significant**

- **Bronchitis Attacks:**  
  95% CI: **(-0.452, -0.300)** → entirely below zero → **significant**

- **Chronic Bronchitis:**  
  95% CI: **(-0.8290250, -0.5769625)** → entirely below zero → **significant**

- **Pneumonia:**  
  95% CI: **(-0.420, -0.255)** → entirely below zero → **significant**

- **Emphysema:**  
  95% CI: **(-1.117000, -0.931475)** → entirely below zero → **significant**

- **COPD:**  
  95% CI: **(-1.1535125, -0.9744375)** → entirely below zero → **significant**

- **Sleep Apnea:**  
  95% CI: **(-0.1740250, 0.0940125)** → includes zero → **not significant**

---

## Regression Slopes and 95% Confidence Intervals

- **BMI:**  
  CI: **(-0.006644279, 0.003793784)** → includes zero → slope **not significant**

- **Visit Age:**  
  CI: **(-0.03575083, -0.02883093)** → entirely below zero → slope **significantly negative**

- **Duration Smoking:**  
  CI: **(-0.02561579, -0.02038060)** → entirely below zero → slope **significantly negative**

- **Lung Volume Expiratory:**  
  CI: **(-0.1774316, -0.1103861)** → entirely below zero → slope **significantly negative**

- **Lung Volume Inspiratory:**  
  CI: **(0.1392070, 0.1921945)** → entirely above zero → slope **significantly positive**

- **Emphysema Percentage:**  
  CI: **(-0.04431843, -0.03884901)** → entirely below zero → slope **significantly negative**

- **Gas Trapping Percentage:**  
  CI: **(-0.02665647, -0.02409951)** → entirely below zero → slope **significantly negative**

- **Mean Density Inspiratory:**  
  CI: **(0.001033478, 0.003065779)** → entirely above zero → slope **significantly positive**

- **Mean Density Expiratory:**  
  CI: **(0.005003379, 0.005848269)** → entirely above zero → slope **significantly positive**

---

# Study Summary

Chronic Obstructive Pulmonary Disease (COPD) is one of the leading causes of illness and death worldwide. While cigarette smoking is a well-known risk factor, many smokers do not develop COPD, suggesting that other contributors—such as genetics and biological variation—play important roles.

The goal of this study was to evaluate whether demographic, genetic, and omic variables are associated with follow-up forced expiratory volume in one second (**fev1_phase2**), a key marker of long-term lung function.

The dataset integrated demographic information, medical imaging measurements, and spirometry results collected across multiple sources. Demographic variables included factors such as visit year, gender, race, heart rate, height, and weight. Medical imaging variables included emphysema percentage, expiratory lung volume, and gas trapping percentage. Spirometry measures captured forced expiratory volume and forced vital capacity at multiple time points.

We used data visualization, bootstrapping, and regression modeling to explore these data. Histograms were used to assess skewness, and log transformations were applied to right-skewed variables to improve interpretability. Boxplots were used to examine differences in fev1_phase2 across categorical groups, and scatterplots were used to examine relationships with continuous predictors. Bootstrapping provided confidence intervals for group differences, and regression models supplied confidence intervals for the slopes of continuous variables.

The findings showed that fev1_phase2 differed significantly across several respiratory conditions, including asthma, bronchitis attacks, and chronic bronchitis, with individuals experiencing these conditions showing lower lung function at follow-up.

Several continuous variables also demonstrated significant associations with fev1_phase2. These included visit age, duration of smoking, inspiratory lung volume, gas trapping percentage, mean inspiratory density, and mean expiratory density.

Overall, this analysis highlights that factors beyond smoking—particularly prior respiratory conditions and biological or demographic variables—contribute to long-term lung function and COPD progression. These findings underline the importance of using a comprehensive, multi-factor approach when considering prevention, risk assessment, and individualized care strategies.

