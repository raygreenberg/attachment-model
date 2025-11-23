#computational model map for METHODS section

rm(list = ls())
setwd("/Users/raygr/Documents/Git/attachment-model-rscript")

library(DiagrammeR)

SplittingConceptMap <- grViz(
  " digraph workflow {
  graph [
  layout = dot,
  rankdir = TB,
  fontsize = 24,
  labelloc = t,
  label = 'Computational Workflow Map: Attachment Asymmetry & Splitting Detection' ]

  node [
    shape = box,
    style = filled,
    fillcolor = lightgrey,
    fontsize = 16 ]

  # Top-level steps
  step00 [label = '00: Clean + Map Variables']
  step01 [label = '01: Recode Sentinels\n+ Create T1subset']
  step02 [label = '02: Reverse-Score\nAlienation + Control Items']

  # Parent container node (03–07)
  subgraph cluster_model {
    label = 'Model Construction Steps (03–07)';
    labelloc = t;
    fontsize = 18;
    style = dashed;
    color = grey50;

    step03 [label = '03: Compute Attachment\nMeans (Mother/Father/Peer)\n\nCompute domain-level attachment\ncomposites by averaging communication,\ntrust, alienation-R, and attachment items\nfor each target. Check alpha and\nintercorrelations; standardize for later steps.']

    step04 [label = '04: Compute Asymmetry\n+ Residual Splitting\n\nCalculate cross-target asymmetry scores\n(e.g., Mother–Peer, Father–Peer).\nRegress dyadic scores on overall attachment\nto extract residualized asymmetry that\nindexes directional splitting.']

    step05 [label = '05: Classify 5 Groups\n(Safety vs Splitting)\n\nUse asymmetry and residual indicators to\nassign cases to theory-driven groups:\n(1) Balanced-Secure\n(2) Moderate Asymmetry\n(3) Peer-Skewed\n(4) Parent-Skewed\n(5) High-Splitting (extreme asymmetry).']

    step06 [label = '06: Exploratory Factor\nAnalyses (EFA)\n\nRun EFAs on attachment, asymmetry,\nand splitting indicators. Use parallel\nanalysis and oblimin rotation to identify\nlatent structure and decide factor\nretention.']

    step07 [label = '07: SEM / CFA\nStructural Models\n\nFit CFA/SEM models specifying latent\nattachment, asymmetry, and splitting.\nCompare alternative structures, inspect\nloadings and fit indices, and test\nmediation or pathway models.'] }

  # Workflow arrows
  step00 -> step01
  step01 -> step02
  step02 -> step03
  step03 -> step04
  step04 -> step05
  step05 -> step06
  step06 -> step07 }")

SplittingConceptMap

#save
write.csv(T1subset, "data/01cleanedT1.csv", row.names = FALSE)

setwd("/Users/raygr/Documents/Git/attachment-model-rscript")
system("git add .")
system("git commit -m 'Update scripts'")
system("git push")
