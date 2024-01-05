#This script conducts exploratory data anlaysis (EDA).

mdat<-read.csv("merged_data.csv",stringsAsFactors = F)
head(mdat)

#1.Sanity checks---
#Rice yield should increase with input level
plot(Yield_rice~Perc_input,mdat)
#Good

#Rice yield should increase with irrigation
plot(Yield_rice~Percent_Irrigated_rice,mdat)
#Good

#The spatial variability of temperature should be positively correlated with that of precipitation
#(assuming spatial variability of elevation and topography contribute to both)
plot(bio1_ran~bio12_ran,mdat)
#Good

#2. First looks at key hypotheses----
#Among non-subsistence farmers, lower rice yield motivates farmers to diversify into other crops.
plot(D~Yield_rice,mdat)
#D decreases with Yield_rice.The relationship was non-linear and with changing variance.
#Notably, among districts where rice yield was low, D generally was higher, 
#however, among districts where rice yield was high, D still varied quite a bit.

#Crop diversity within districts is partially driven by climate variability.
plot(D~bio1_ran,mdat)
plot(D~bio12_ran,mdat)
#D increases with both indicators of climate variability.
#Notably, among districts with low climate variability, D still varied considerably,
#indicating other factor(s) contribute to D.

#3. Using PCA to untangle co-linearity among predictors----
library(ggfortify)
names(mdat)
preds <- mdat[,c(3:10)]
preds_noNA<-preds[complete.cases(preds),]
pca_preds <- prcomp(preds_noNA, scale. = TRUE)

#Check loadings.
(pca_preds$sdev^2)/sum(pca_preds$sdev^2)
#[1] 0.32143412 0.20501750 0.17985427 ....

#Check rotations
autoplot(pca_preds,loadings=T,loadings.label = TRUE,loadings.label.size=4)
autoplot(pca_preds,loadings=T)

#Rice, input level, and irrigation positively correlated with each other,
#and negatively correlated with climate variability.
#These results suggested that the districts with lower climate variability - likely with
#flatter topography - were more attractive for rice production.

#The stress indicators were more correlated with each other and independent
#from other predictors.The districts with less severe coldness (higher bio6) tended 
#to suffer less flooding (lower bio13) but more severe drought (lower bio14). 
#Considering that Viet Nam is a country that covering a large latitudinal span
#but a small longitudinal span (i.e., it's a long strip), the correlations between 
#the abiotic stresses probably reflect its North-South latitudinal gradient,
#with northern districts suffering more severe coldness and drought, while 
#southern districts being more prone to flooding.

#Extract the first 2 principle components.
dim(pca_preds$x)
mdat$PC1<-0
mdat$PC1[complete.cases(preds)]<-pca_preds$x[,1]
mdat$PC2<-0
mdat$PC2[complete.cases(preds)]<-pca_preds$x[,2]
head(mdat)

write.csv(mdat,file="final_data.csv",row.names = F)








