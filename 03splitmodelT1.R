##03 Exploratory factor analysis (EFA)
setwd("/Users/raygr/Documents/Git/attachment-model-rscript")

library(dplyr)
library(readr)
library(psych)

T1subset <- read_csv("data/02summaryT1.csv")

#attachment avgs
T1subset$momattach_t1mean <- (T1subset$momcomm_t1 + T1subset$momtrust_t1) / 2
T1subset$fatherattach_t1mean <- (T1subset$fathercomm_t1 + T1subset$fathertrust_t1) / 2
T1subset$peerattacht1_mean <- (T1subset$peercomm_t1 + T1subset$peertrust_t1) / 2

#maltreatment combined
T1subset$maltreat_t1mean <- rowMeans(cbind(T1subset$mommaltreat_t1, T1subset$fathermaltreat_t1),
                                     na.rm = TRUE)
#absolute value for splitting asymmetry 
T1subset$rawsplit <- abs(T1subset$momattach_t1mean - T1subset$fatherattach_t1mean)

#rawsplit residuals (controlling for alienation + maltreatment)
splitting <- lm(rawsplit ~ momalien_t1 + fatheralien_t1 + mommaltreat_t1 + fathermaltreat_t1,
                data = T1subset)

splittingResiduals <- residuals(splitting)

#finding asymmetry classifications
sd(T1subset$rawsplit, na.rm = TRUE)
quantile(T1subset$rawsplit, probs = c(.75, .80, .90), na.rm = TRUE)
#use top 20% @ 1.00

min_parentattachT1 <- pmin(T1subset$momattach_t1mean, T1subset$fatherattach_t1mean)
max_parentattachT1 <- pmax(T1subset$momattach_t1mean, T1subset$fatherattach_t1mean)

summary(T1subset$peerattach_mean)
summary(min_parentattachT1)

#cutoffs
split_cutoff <- 1.0
peer_tolerance <- 0.20

#peer attachment comparison
T1subset$peerbetweenT1 <- T1subset$peerattacht1_mean > min_parentattachT1 & T1subset$peerattacht1_mean < max_parentattachT1
T1subset$peerlowT1 <- T1subset$peerattacht1_mean <= (min_parentattachT1 + peer_tolerance)

#splitting subtypes for future
T1subset$splittingType <- ifelse(T1subset$rawsplit < split_cutoff, "No_Asymmetry", 
                          ifelse(T1subset$peerbetweenT1, "alienated_safety_seeking",
                          ifelse(T1subset$peerlowT1, "disorganized_splitting", "mixed_pattern")))

table(T1subset$splittingType, useNA = "ifany")

write.csv(T1subset, "data/03splitmodelT1.csv", row.names = FALSE)
                          