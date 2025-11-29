# Intall packages
#install.packages("tidyverse")
#install.packages("jsonlite")
#install.packages("ggplot2")

# Load libraries
library(jsonlite)
library(rvest)
library(ggplot2)

########################### Read In & Merge Data ################################

# Load demographics dataset
demographics_df <- read.csv('https://raw.githubusercontent.com/khasenst/datasets_teaching/refs/heads/main/copd_data_demographics.csv', header = TRUE)

# View first few rows if the demographics data frame
head(demographics_df)

# Load medical image dataset
img_json <- fromJSON('https://raw.githubusercontent.com/khasenst/datasets_teaching/refs/heads/main/copd_data_imaging.json')

#Convert to data frame
img_df <- data.frame(img_json$sid, img_json$lung_volume_inspiratory, img_json$emphysema_percentage, img_json$lung_volume_expiratory, img_json$gas_trapping_percentage, img_json$mean_density_inspiratory, img_json$mean_density_expiratory)
names(img_df) <- c('sid', 'lung_volume_inspiratory', 'emphysema_percentage', 'lung_volume_expiratory', 'gas_trapping_percentage', 'mean_density_inspiratory', 'mean_density_expiratory')

# View first few rows if the image data frame
head(img_df)

# Load spirometry data set
html <- read_html('https://raw.githubusercontent.com/khasenst/datasets_teaching/refs/heads/main/copd_data_spirometry.html')
# Read HTML
cat(as.character(html))

# Find variables
p_elements <- html_elements(x = html, css = "p")
p_string <- html_text(p_elements, trim = TRUE)
p_split <- strsplit(p_string, split = " ")

column_names <- c()
for (i in 2:length(p_split)) {
  column_names <- c(column_names, p_split[[i]][1])
}

# Find all values for each variable
td_elements <- html_elements(x = html, css = "tr td")
td_string <- html_text(td_elements, trim = TRUE)

# Create empty vectors for each of the variables
sid <- c()
fev1_fvc_ratio <- c()
fev1 <- c()
fvc <- c()
fev1_phase2 <- c()

# Create vectors for all variables by looping through each group of values
for (i in seq(1, length(td_string), by = 5)) {
  sid            <- c(sid, td_string[i])
  fev1_fvc_ratio <- c(fev1_fvc_ratio, td_string[i + 1])
  fev1           <- c(fev1, td_string[i + 2])
  fvc            <- c(fvc, td_string[i + 3])
  fev1_phase2    <- c(fev1_phase2, td_string[i + 4])
}

# Create a data frame with all of the vectors
spirometry_df <- data.frame(
  sid,
  as.numeric(fev1_fvc_ratio),
  as.numeric(fev1),
  as.numeric(fvc),
  as.numeric(fev1_phase2)
)

# Rename variables
names(spirometry_df) <- c('sid', 'fev1_fvc_ratio', 'fev1', 'fvc', 'fev1_phase2')

# Preview first few rows of data frame
head(spirometry_df)

# Merge the demographics and medical image data frames into a new data frame
first_two_merged <- merge(x = demographics_df, y = img_df, by.x = 'sid', by.y = 'sid', all.x = TRUE, all.y = TRUE)

# Merge the new data frame with the spirometry data frame
merged_df <- merge(x = first_two_merged, y = spirometry_df, by.x = 'sid', by.y = 'sid', all.x = TRUE, all.y = TRUE)

# Check that there are 2,620 observations
str(merged_df)

########################## Data Cleaning ########################################
# Convert gender to a factor
merged_df$gender <- as.factor(merged_df$gender)

# Convert race to a factor
merged_df$race <- as.factor(merged_df$race)

# Convert smoking_status to a factor
merged_df$smoking_status <- as.factor(merged_df$smoking_status)

# Reassign levels for each variable
levels(merged_df$gender) <- c('Male', 'Female')
levels(merged_df$race) <- c('White', 'Black or African American')
levels(merged_df$smoking_status) <- c('Never-smoked', 'Former smoker', 'Current smoker')

# Confirm that the variables were converted to factors with appropriate levels
str(merged_df)

# Convert height from cm to inches(One inch is 2.54 cm, so one cm is 1/2.54 inches)
merged_df$height_in <- (merged_df$height_cm / 2.54)

# Convert weight from kg to pounds(One kg is 2.20462 pounds)
merged_df$weight_lbs <- (merged_df$weight_kg * 2.20462)

# Check each row in the respiratory vector for each variable
resp_vars <- c("hay fever", "asthma", "bronchitis attacks", 
               "chronic bronchitis", "pneumonia", "emphysema", 
               "copd", "sleep apnea")

resp_names <- c("hay_fever", "asthma", "bronchitis_attacks",
                "chronic_bronchitis", "pneumonia", "emphysema",
                "copd", "sleep_apnea")

# Create a vector that includes all of the Yes/No indicators for each respiratory condition
for (i in 1:length(resp_vars)) {
  merged_df[[resp_names[i]]] <- ifelse(grepl(resp_vars[i], merged_df$respiratory), 'Yes', 'No')
}

# View first few rows
head(merged_df)

# Convert the eight respiratory variables to factors
merged_df$hay_fever <- as.factor(merged_df$hay_fever)
merged_df$asthma <- as.factor(merged_df$asthma)
merged_df$bronchitis_attacks <- as.factor(merged_df$bronchitis_attacks)
merged_df$chronic_bronchitis <- as.factor(merged_df$chronic_bronchitis)
merged_df$pneumonia <- as.factor(merged_df$pneumonia)
merged_df$emphysema <- as.factor(merged_df$emphysema)
merged_df$copd <- as.factor(merged_df$copd)
merged_df$sleep_apnea <- as.factor(merged_df$sleep_apnea)

# Remove height_cm, weight_kg, and respiratory columns
merged_df$respiratory <- NULL
merged_df$height_cm <- NULL
merged_df$weight_kg <- NULL

# Export data as a .csv file
write.csv(x = merged_df,
          file = 'copd_data.csv',
          row.names = FALSE)

############################ Descriptive Statistics & Exploratory Analysis #############################
# If the column is numeric, return mean and SD; if it's text, return frequencies for each category
mean_frequency_sd <- function(column) {
  if (class(column) == 'numeric' | class(column) == 'integer') {
    mean_sd <- c(mean(column), sd(column))
    return (mean_sd)
  }
  else if (class(column) == 'character' | class(column) == 'factor') {
    frequency <- (table(column))
    return (frequency)
  }
}

# Remove NA
merged_df <- na.omit(merged_df)

# Apply function to all columns of the data frame
lapply(merged_df, mean_frequency_sd)

# Create a vector with all variables names
vars <- names(merged_df)

# Iterate through each variable in the vector
for (var in vars) {
  # Check if variable is an integer or numeric
  if (class(merged_df[[var]]) %in% c('integer','numeric')) {
    print(ggplot(data = merged_df, aes_string(x = var)) +
            geom_histogram(bins = 30))
  }
}

# Create log-transformed histograms for each variable in the list
# Create boxplots of fev1_phase2 for each respiratory condition
resp_cols <- c("hay_fever", "asthma", "bronchitis_attacks", 
               "chronic_bronchitis", "pneumonia", "emphysema", 
               "copd", "sleep_apnea")

for (col in resp_cols) {
  p <- ggplot(data = merged_df, aes(x = .data[[col]], y = fev1_phase2)) +
    geom_boxplot() +
    labs(
      title = paste(gsub("_", " ", col), "and Fev1 Phase 2"),
      x = gsub("_", " ", col),
      y = "Fev1 Phase 2"
    )
  
  print(p)
}

# Create scatterplots of each variable with fev1_phase2
scatter_vars <- c(
  "bmi",
  "visit_age",
  "duration_smoking",
  "lung_volume_inspiratory",
  "emphysema_percentage",
  "lung_volume_expiratory",
  "gas_trapping_percentage",
  "mean_density_inspiratory",
  "mean_density_expiratory"
)

for (v in scatter_vars) {
  p <- ggplot(data = merged_df, aes(x = .data[[v]], y = fev1_phase2)) +
    geom_point() +
    labs(
      title = paste(gsub("_", " ", v), "and Fev1 Phase 2"),
      x = gsub("_", " ", v),
      y = "Fev1 Phase 2"
    )
  
  print(p)
}

###################### Inference & Modeling ###########################
# Number of bootstrap samples
B <- 1000

# Sample size
n <- nrow(merged_df)

# List to store bootstrap differences between groups for each variable
boot_diffs <- list()

# Vector of categorical variables from task 11
cat_vars <- c('hay_fever', 'asthma', 'bronchitis_attacks', 'chronic_bronchitis', 'pneumonia', 'emphysema', 'copd', 'sleep_apnea')

# Loop to calculate bootstrap differences between groups for each variable (TODO: Check median or mean?)
for (i in 1:B) {
  # Bootstrap sample of size n
  boot_index  <- sample(1:nrow(merged_df), size = n, replace = TRUE)
  boot_samp <- merged_df[boot_index,]
  
  # Loop through each variable from task 11
  for (var in cat_vars) {
    yes_group <- boot_samp[boot_samp[[var]] == 'Yes', 'fev1_phase2']
    no_group <- boot_samp[boot_samp[[var]] == 'No', 'fev1_phase2']
    
    # Compute median difference of single bootstrap sample
    boot_diff <- median(yes_group) - median(no_group)
    
    # Store the bootstrap difference
    boot_diffs[[var]] <- c(boot_diffs[[var]], boot_diff)
  }
}

# Loop through to print differences between groups for each variable
for (var in cat_vars) {
  print(var)
  print(quantile(boot_diffs[[var]], probs = c(0.025, 0.975)))
}

# Number of bootstrap samples
B <- 1000

# Sample size
n <- nrow(merged_df)

# Vector of numeric variables from Task 12
num_vars <- c('bmi', 'visit_age', 'duration_smoking', 'lung_volume_expiratory','lung_volume_inspiratory', 'emphysema_percentage', 'gas_trapping_percentage', 'mean_density_inspiratory', 'mean_density_expiratory')

# List to store slopes for each variable
slopes <- list()

# Loop to calculate bootstrap slopes for each variable
for (i in 1:B) {
  # Bootstrap sample of size n
  boot_index <- sample(1:n, size = n, replace = TRUE)
  boot_samp <- merged_df[boot_index,]
  
  # Loop through each variable from Task 12
  for (var in num_vars) {
    x <- boot_samp[[var]]
    y <- boot_samp[['fev1_phase2']]
    fit <- lm(y ~ x)
    
    slope <- coef(fit)[2]
    slopes[[var]] <- c(slopes[[var]], slope)
    
  }
  
}

for (var in num_vars) {
  print(var)
  print(quantile(slopes[[var]], probs = c(0.025, 0.975)))
}
