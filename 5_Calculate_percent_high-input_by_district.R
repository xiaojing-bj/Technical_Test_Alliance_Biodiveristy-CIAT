#This script calculates the percentage of high-input harvested area (combining all crops) of non-subsistence farms by district.
#I group irrigated (H_TI) and rain fed-high input (H_TH) both as high-input.

#1.Calculate total harvested area, combining all crops, of non-subsistence and low-input farms by district----
H_NS_adm2<-read.csv("H_NS_adm2.csv",stringsAsFactors = F)
head(H_NS_adm2)

H_NS_adm2_allcrop<-data.frame(H_NS_adm2[,1],apply(as.matrix(H_NS_adm2[,-1]),1,sum))
head(H_NS_adm2_allcrop)
names(H_NS_adm2_allcrop)<-c("name_adm2","H_NS_all_crops")


H_TL_adm2<-read.csv("H_TL_adm2.csv",stringsAsFactors = F)
head(H_TL_adm2)

H_TL_adm2_allcrop<-data.frame(H_TL_adm2[,1],apply(as.matrix(H_TL_adm2[,-1]),1,sum))
head(H_TL_adm2_allcrop)
names(H_TL_adm2_allcrop)<-c("name_adm2","H_TL_all_crops")

#2.Calculate percentage of high-input harvested area of non-subsistence farms----
I_NS_adm2<-merge(H_NS_adm2_allcrop,H_TL_adm2_allcrop)
head(I_NS_adm2)
I_NS_adm2$Perc_input<-(1-I_NS_adm2$H_TL_all_crops/I_NS_adm2$H_NS_all_crops)
head(I_NS_adm2)
range(I_NS_adm2$Perc_input)
# 0.6064292 1.0000000
subset(I_NS_adm2,Perc_input==1.0)
#name_adm2 H_NS_all_crops H_TL_all_crops Perc_input
#95   Cho Lach         1914.1              0          1
#235  Kien Hai          236.4              0          1
#check
H_TL_CL<-subset(H_TL_adm2,name_adm2=="Cho Lach")
head(H_TL_CL)
H_TL_KH<-subset(H_TL_adm2,name_adm2=="Kien Hai")
head(H_TL_KH)
#correct

write.csv(I_NS_adm2[,c(1,4)],file="Input_NS_adm2.csv",row.names = F)

rm(list=ls())

