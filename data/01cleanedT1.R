library(dplyr)
library(tidyr)
library(janitor)
library(readr)
library(sjlabelled)

#import data set
VTdata <- read_csv(file.choose())
VTdata <- clean_names(VTdata)

#check rows x columns
dim(VTdata)

#create variable T1map
T1map <- tibble::tribble(~pos, ~new, ~label,
                         1172, "momcomm_t1", "Mother communication: child report",
                         1173, "momtrust_t1", "Mother trust: child report T1",
                         1174, "momalien_t1", "Mother alienation: child report T1",
                         1175, "momattach_t1", "Mother attachment composite: child report T1",
                         1176, "fathercomm_t1", "Father communication: child report T1",
                         1177, "fathertrust_t1", "Father trust: child report T1",
                         1178, "fatheralien_t1", "Father alienation: child report T1",
                         1179, "fatherattach_t1", "Father attachment composite: child report T1",
                         1180, "peercomm_t1", "Peer communication: child report T1",
                         1181, "peertrust_t1", "Peer trust: child report T1",
                         1182, "peeralien_t1", "Peer alienation: child report T1",
                         1183, "peerattach_t1", "Peer attachment: child report T1",
                         1187, "disclosure_t1", "Child disclosure mean: child report T1",
                         1188, "parentsolicit_t1", "Parent solicitation mean: child report T1",
                         1189, "parentknow_t1", "Parental knowledge mean: child report T1",
                         1190, "parentcontrol_t1", "Parental control mean: child report T1",
                         1191, "parentmonitor_t1", "Parental monitoring mean: child report T1",
                         1199, "mommaltreat_t1", "Mother PCR Psychological Maltreatment T1",
                         1200, "fathermaltreat_t1", "Father PCR Psychological Maltreatment T1")

View(T1map)
T1positions <- unique(T1map$pos)
T1positions <- T1positions[T1positions <= ncol(VTdata)] #match columns
T1matched <- filter(T1map, pos %in% T1positions) #filter rows
T1matched <- arrange(T1matched, match(pos, T1positions))

#create new data frame
T1subset <- VTdata[, T1positions, drop = FALSE]
names(T1subset) <- T1matched$new 
stopifnot(ncol(T1subset) == nrow(T1matched)) #safe matching

#check dropped
droppedT1 <- setdiff(T1map$pos, T1positions)
if (length(droppedT1)) message("Dropped positions: ", paste(droppedT1, collapse = ", "))
#none dropped

#wide to long 
T1long <- summarise(T1subset, across(everything(), ~ list(unique(.))))
T1long <- pivot_longer(T1long, everything(), 
                       names_to = "variable", values_to = "values")
print(T1long, n = 23) #unique values

T1wide <- summarise(T1subset, across(everything(), ~ {
  T1observed <- sum(!is.na(.))
  T1distinct <- n_distinct(., na.rm = TRUE)
  if (is.numeric(.)) {paste0("n=", T1observed, 
                             "; uniq=", T1distinct,
                             "; min=", min(., na.rm = TRUE),
                             "; max=", max(., na.rm = TRUE))} else {paste0("n=", T1observed, "; uniq=", T1distinct)}}))

#tidy long summaries
T1tidylong <- pivot_longer(T1wide, everything(), names_to = "variable", values_to = "summary")

#print variable summaries
print(T1tidylong, n = 50)

#common negatives and sentinels
NAflags <- c(-99, -98, -97, -9, -8, -7, -1, 66, 77, 88, 99, 666, 777, 888, 999, 9999)
#located NA flags
NApositionwide <- summarise(T1subset, across(everything(), ~ sum(. %in% NAflags, na.rm = TRUE))) #sentinel values list
NAposition <- pivot_longer(NApositionwide, everything(), names_to = "variable", values_to = "NAcount") #create 2 columns

print(NAposition, n = 30) #show NAs

#recode NAflags to NA
T1subset <- mutate(T1subset, across(where(is.numeric), ~ ifelse(. %in% NAflags, NA, .)))

summary(T1subset) #check NA values properly coded

#characters -> number values
T1uniques <- function(v) {
  u <- unique(na.omit(v))
  u <- type.convert(as.character(u), as.is = TRUE)  #converts "1.0000" -> "1"
  u <- sort(u)
  u}

T1long <- summarise(T1subset, across(everything(), ~ list(T1uniques(.))))
T1long <- pivot_longer(T1long, everything(), names_to = "variable", values_to = "values") #2 columns

View(T1long)

#save
write.csv(T1subset, "data/01cleanedT1.csv", row.names = FALSE)

setwd("/Users/raygr/Documents/Git/attachment-model-rscript")
system("git add .")
system("git commit -m 'Update scripts'")
system("git push")