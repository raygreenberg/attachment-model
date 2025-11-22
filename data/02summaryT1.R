##02 reverse coding and descriptive statistics
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

T1subset <- read_csv("data/01cleanedT1.csv")

#reverse score negatives
T1subset$momalien_t1R <- 6 - T1subset$momalien_t1
T1subset$fatheralien_t1R <- 6 - T1subset$fatheralien_t1
T1subset$peeralien_t1R <- 6 - T1subset$peeralien_t1
T1subset$parentcontrol_t1R <- 6 - T1subset$parentcontrol_t1

T1variables <- c("momcomm_t1", "momtrust_t1", "momalien_t1R",
                 "fathercomm_t1", "fathertrust_t1", "fatheralien_t1R",
                 "disclosure_t1", "parentsolicit_t1", "parentknow_t1",
                 "parentcontrol_t1R", "parentmonitor_t1")

#mean
means <- sapply(T1subset[T1variables], function(x) mean(x, na.rm = TRUE))
#SD
sds <- sapply(T1subset[T1variables], function(x) sd(x, na.rm = TRUE))
#N
ns <- sapply(T1subset[T1variables], function(x) sum(!is.na(x)))

#descriptive summary stats table
T1summary <- data.frame(variable = T1variables,
                           n = ns,
                           mean = means,
                           sd = sds,
                           row.names = NULL)

cor(T1subset$momalien_t1, T1subset$momalien_t1R, use = "pairwise.complete.obs")

#reverse coding worked, but values are negatively associated
#view summary
T1summary

#clear environment
rm(list = ls())

#reload csv
T1subset <- read_csv("data/01cleanedT1.csv")

#reverse code again
T1subset$momalien_t1R <- 6 - T1subset$momalien_t1
T1subset$fatheralien_t1R <- 6 - T1subset$fatheralien_t1
T1subset$peeralien_t1R <- 6 - T1subset$peeralien_t1
T1subset$parentcontrol_t1R <- 6 - T1subset$parentcontrol_t1

T1variablesR <- c("momcomm_t1", "momtrust_t1", "momalien_t1R",
     "fathercomm_t1", "fathertrust_t1", "fatheralien_t1R",
     "disclosure_t1", "parentsolicit_t1", "parentknow_t1",
     "parentcontrol_t1R", "parentmonitor_t1")

T1variables <- c("momcomm_t1", "momtrust_t1", "momalien_t1",
                 "fathercomm_t1", "fathertrust_t1", "fatheralien_t1",
                 "disclosure_t1", "parentsolicit_t1", "parentknow_t1",
                 "parentcontrol_t1", "parentmonitor_t1")

#redo descriptive statistics
#mean
means <- sapply(T1subset[T1variables], function(x) mean(x, na.rm = TRUE))
#SD
sds <- sapply(T1subset[T1variables], function(x) sd(x, na.rm = TRUE))
#N
ns <- sapply(T1subset[T1variables], function(x) sum(!is.na(x)))

#descriptive summary stats table
T1summary <- data.frame(variable = T1variables,
                        n = ns,
                        mean = means,
                        sd = sds,
                        row.names = NULL)

T1summary #looks better!

#meanR
meansR <- sapply(T1subset[T1variablesR], function(x) mean(x, na.rm = TRUE))
#SDR
sdsR <- sapply(T1subset[T1variablesR], function(x) sd(x, na.rm = TRUE))
#NR
nsR <- sapply(T1subset[T1variablesR], function(x) sum(!is.na(x)))

#descriptive summary stats table
T1summaryR <- data.frame(variable = T1variablesR,
                        n = nsR,
                        mean = meansR,
                        sd = sdsR,
                        row.names = NULL)
T1summaryR #check

#barplot for descriptive stats
barplot(height = T1summary$mean,
        names.arg = T1summary$variable,
        las = 2,
        main = "Parent-child variables",
        ylab = "Mean",
        ylim = c(0,5))

barplot(height = T1summaryR$mean,
        names.arg = T1summaryR$variable,
        las = 2,
        main = "Parent-child variables (incl. reverse-scored variables)",
        ylab = "MeanR",
        ylim = c(0,5))

#correlation matrices
T1correlation <- cor(T1subset[T1variables], use = "pairwise.complete", method = "pearson")

T1correlationR <- cor(T1subset[T1variablesR], use = "pairwise.complete", method = "pearson")

#view 
T1correlation 
T1correlationR

#alienation variables low correlation
#2 factor model possible
#keep: momcomm_t1, momtrust_t1, fathercomm_t1, fathertrust_t1, 
#disclosure_t1, parentsolicit_t1, parentknow_t1, parentmonitor_t1

#save 
write.csv(T1subset, "data/02scalesT1.csv", row.names = FALSE)

setwd("/Users/raygr/Documents/Git/attachment-model-rscript")
system("git add .")
system("git commit -m 'Update scripts'")
system("git push")
