#attachment-model-rscript
R script analysis for functional attachment modeling and risk-associated decision

#contents
- **Data connection**: Scripts assume `/data/02scalesT1.csv` as the primary cleaned T1 dataset.
- **Attachment modeling**: CFA models built using `lavaan`:
  - removed non-positive definite indicators
  - tested correlated family/peer structures
  - adjusted parental and peer indicators
- **Risk decision associations**: to show latent attachment relation

#workflow
01. **Load/clean data**  
02. **Define attachment indicators**  
03. **Run initial CFA model**  
04. **Assess model failure**  
05. **Remove composites and low-variance indicators**  
06. **Refit/refine model**  
07. **Export model-refined dataset**

#dependencies
- `readr`
- `dplyr`
- `lavaan`
