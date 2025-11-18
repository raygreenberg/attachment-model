##attachment-model-rscript
R script analysis for functional attachment modeling and risk-associated decision

##contents
- **Data connection**: Scripts assume `/data/02scalesT1.csv` as the primary cleaned T1 dataset.
- **Attachment modeling**: CFA models built using `lavaan`:
  - removed non-positive definite indicators
  - tested correlated family/peer structures
  - adjusted parental and peer indicators
- **Risk decision associations**: to show latent attachment relation

##workflow
**01. 01cleanedT1.R**
Description: Processes the raw T1 dataset and prepares it for modeling and perform variable name cleaning, missing-value recoding, and selection of relevant indicators.
-Import 00rawdata.csv
-Standardize variable names with clean_names()
-Re-code missing values (e.g., -99 → NA)
-Filter out unusable or flagged cases
-Save output as 01cleanedT1.csv

**02. 02scalesT1.R**
Description: Constructs scale-level variables and reverse-coded items for functional attachment modeling.
-Import 01cleanedT1.csv
-Reverse-code negatively keyed items
-Create preliminary attachment, trust, alienation, and monitoring variables
-Remove composites causing non-positive-definite covariance
-Save output as 02scalesT1.csv

**03. 03ModelT1Attempt1.R**
Description: Runs initial CFA attempts for the attachment construct and diagnoses model issues.
-Import 02scalesT1.csv
-Define candidate indicator sets
-Fit CFA with full item list
-Diagnose non–positive-definite covariance matrix
-Removed problematic indicators (monitoring, solicitation, peer attachment)
-Saved output as 03ModelT1Attempt1.csv

**04. 04_AttachmentModel_refinement.R**
Description: Refines the attachment CFA model using only well-behaved parent and peer indicators.
-Import 02scalesT1.csv
-Specify final accepted indicators (communication, trust, alienationR across domains)
-Fit refined CFA with lavaan::cfa() and std.lv = TRUE
-Output model fit, standardized estimates, and diagnostics
-Saved output as 04AttachmentModelRefined.csv

##dependencies
- `readr`
- `dplyr`
- `lavaan`
