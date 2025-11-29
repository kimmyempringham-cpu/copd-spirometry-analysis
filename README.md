# **COPD Lung Function Analysis**

## **Overview**
This project looks at how different factors relate to long-term lung function in people at risk for COPD. The main outcome is **FEV1 Phase 2**, a follow-up lung function measurement collected about five years after the first visit.

The dataset includes demographic information, smoking history, imaging features, and baseline spirometry results. I used R to clean the data, explore patterns, and build simple models to see which variables were most strongly linked to changes in FEV1 over time.

---

## **Data**
The dataset includes:
- Age, sex, race, height, weight  
- Smoking status and years smoked  
- Imaging measures (emphysema %, gas trapping, lung volumes, density metrics)  
- Baseline spirometry (FEV1, FVC, FEV1/FVC ratio)  
- Follow-up FEV1 (~5 years later)

A small synthetic sample is included in the `data/` folder.

---

## **Methods**

### **Data Preparation**
- Cleaned and merged datasets  
- Removed incomplete rows  
- Log-transformed heavily skewed variables  

### **Exploratory Analysis**
- Histograms for distributions  
- Boxplots to compare groups  
- Scatterplots for continuous relationships  

### **Modeling**
- Bootstrapping to estimate uncertainty  
- Linear regression to identify predictors of long-term FEV1  
- All analysis done in R using tidyverse packages  

---

## **Findings**
- Participants with **asthma**, **chronic bronchitis**, or **a history of bronchitis attacks** tended to have lower FEV1 Phase 2.  
- Variables such as **age**, **years smoked**, **gas trapping**, **inspiratory lung volume**, and **lung density** were strongly related to long-term FEV1.  
- Imaging features often explained more variation in lung function decline than basic demographic variables.

Overall, the results show that factors beyond smoking contribute to COPD progression. Combining demographic, clinical, and imaging data can help identify individuals at greater risk for reduced lung function over time.

---

## **Repository Structure**
copd-spirometry-analysis/
│
├─ README.md
├─ analysis.Rmd
├─ data/
│ └─ sample_data.csv
├─ figs/
│ ├─ fev1_distribution.png
│ ├─ fev1_fvc_plot.png
│ └─ model_results.png
└─ results/
└─ model_summary.txt


---

## **Technologies**
- R  
- tidyverse (dplyr, ggplot2)  
- R Markdown  

---

## **How to Run**
1. Download or clone the repository  
2. Open `analysis.Rmd` in RStudio  
3. Install required packages  
4. Knit or run the file
