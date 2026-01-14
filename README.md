# COPD Lung Function Analysis

## Overview

This project examines how demographic characteristics, respiratory conditions, smoking history, and imaging based lung measurements relate to long term lung function in individuals at risk for Chronic Obstructive Pulmonary Disease. The primary outcome is forced expiratory volume in one second measured at follow up, referred to as FEV1 Phase 2, which was collected approximately five years after baseline assessment.

The goal of the analysis is to identify which factors are most strongly associated with long term lung function and to evaluate whether imaging based measures explain variation beyond smoking history alone.

## Data

The data used in this project originate from the COPDGene Study and were provided for academic research use. The dataset integrates demographic information, smoking history, imaging based lung measurements, and spirometry outcomes.

Because the original data contain sensitive medical information, they cannot be shared publicly. This repository therefore focuses on documenting the full analysis workflow, including data cleaning, visualization, and statistical modeling.

## Methods

The analysis was conducted in R and includes the following components:

Data cleaning and merging across sources  
Removal of incomplete observations  
Log transformation of right skewed variables  
Exploratory data analysis using histograms, boxplots, and scatterplots  
Bootstrapping to estimate uncertainty in group comparisons  
Linear regression modeling to identify predictors of long term lung function  

## Key Findings

Long term lung function differed substantially across several respiratory conditions  
Individuals with asthma, bronchitis attacks, chronic bronchitis, emphysema, or COPD tended to have lower follow up lung function  
Age and duration of smoking were negatively associated with long term FEV1  
Imaging based measures such as gas trapping, lung volumes, and lung density were strongly associated with follow up lung function  
Imaging features often explained more variation in long term lung function than basic demographic variables  

These findings highlight that factors beyond smoking contribute meaningfully to COPD progression.

## Technologies Used

R programming language  
tidyverse for data manipulation and visualization  
ggplot2 for exploratory graphics  
jsonlite and rvest for data ingestion  
RStudio for development  
Git and GitHub for version control  

## Full Report

A complete written report, including figures, statistical results, and interpretation, is available here:
https://www.linkedin.com/in/kimberly-empringham/details/projects/1167545046/multiple-media-viewer/?profileId=ACoAAEmks78Bg-8vupZjyLI4lN5gbGAWb0X3z54&treasuryMediaId=1768357075654
