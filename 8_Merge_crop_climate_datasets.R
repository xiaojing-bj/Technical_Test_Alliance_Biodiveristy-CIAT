#This script merge the district-level crop and climate data sets for subsequent modelling.

#1.Load data ----
##crop data
D<-read.csv("D_NS_adm2.csv",stringsAsFactors = F)
head(D)
names(D)<-c("name_adm2","D")


Y_rice<-read.csv("Y_NS_adm2_rice.csv",stringsAsFactors = F)
head(Y_rice)
names(Y_rice)[2]<-c("Yield_rice")

Input<-read.csv("INput_NS_adm2.csv",stringsAsFactors = F)
head(Input)

Irrigation<-read.csv("Irri_NS_adm2_rice.csv",stringsAsFactors = F)
head(Irrigation)

bioclim<-read.csv("bioclim_by_dist.csv",stringsAsFactors = F,row.names=1)
head(bioclim)
bioclim2<-bioclim[,c(1,6:10)]
head(bioclim2)
dist_names<-read.csv("names_adm2.csv",stringsAsFactors = F)
head(dist_names)
bioclim2$name_adm2<-dist_names[,2]
head(bioclim2)
dim(bioclim2)

#2.Merge and export results----
mdat1<-merge(D,Y_rice)
mdat2<-merge(mdat1,Input)
mdat3<-merge(mdat2,Irrigation)
mdat4<-merge(mdat3,bioclim2)
head(mdat4)
dim(mdat4)

write.csv(mdat4,file="merged_data.csv", row.names = F)
