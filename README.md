**attachment-model-rscript**
R script analysis for functional attachment modeling and risk-associated decision

**contents**
- *Data connection*: Scripts assume `/data/02scalesT1.csv` as the primary cleaned T1 dataset.
- *Attachment modeling*: EFA models built using `lavaan`:
  - removed non-positive definite indicators
  - tested correlated family/peer structures
  - adjusted parental and peer indicators
- *Risk decision associations*: to show latent attachment relation

**workflow**
*1. 01cleanedT1.R*
Description: Processes the raw T1 dataset and prepares it for modeling and perform variable name cleaning, missing-value recoding, and selection of relevant indicators.
-Import 00rawdata.csv
-Standardize variable names with clean_names()
-Re-code missing values (e.g., -99 → NA)
-Filter out unusable or flagged cases
-Save output as 01cleanedT1.csv

*2. 02summaryT1.R*
Description: Constructs scale-level variables and reverse-coded items for functional attachment modeling.
-Import 01cleanedT1.csv
-Reverse-code negatively keyed items
-Descriptive statistics
-Correlation matrices (for original and reverse-scored variables)
-Bar plots original + reverse

**packages used**
- readr
- janitor
- tidyr
- dplyr
- lavaan
- ggplot2
- dplyr
- sjlabelled
