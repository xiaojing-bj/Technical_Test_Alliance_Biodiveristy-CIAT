#This script calculate biodiversity of non-subsistence farms by district

#1.Calculate total harvested areas of non-subsistence farms for each crop by 
#district (hereafter as H_NS_adm2)----

rm(list=ls())

H_TA_adm2<-read.csv("H_TA_adm2.csv",stringsAsFactors = F)
H_TS_adm2<-read.csv("H_TS_adm2.csv",stringsAsFactors = F)

head(H_TA_adm2)
dim(H_TA_adm2)

head(H_TS_adm2)
dim(H_TS_adm2)

H_NS_adm2<-H_TA_adm2
H_NS_adm2[,-1]<-H_TA_adm2[,-1]-H_TS_adm2[,-1]
head(H_NS_adm2)
write.csv(H_NS_adm2,file="H_NS_adm2.csv",row.names = F)

#2.Calculate diversity by district (Shannon index, hereafter D_adm2)----
H_NS_adm2_allcrop<-data.frame(H_NS_adm2[,1],apply(as.matrix(H_NS_adm2[,-1]),1,sum))
head(H_NS_adm2_allcrop)
names(H_NS_adm2_allcrop)<-c("name_adm2","H_NS_all_crops")

pi_NS_adm2<-as.matrix(H_NS_adm2[,-1]/H_NS_adm2_allcrop[,2])
row.names(pi_NS_adm2)<-H_NS_adm2_allcrop[,1]
head(pi_NS_adm2)

ln_pi_NS_adm2<-log(pi_NS_adm2)
head(ln_pi_NS_adm2)
ln_pi_NS_adm2[is.infinite(ln_pi_NS_adm2)] <- 0

D_NS_adm2<-(-(apply(pi_NS_adm2*ln_pi_NS_adm2,1,sum)))
str(D_NS_adm2)
range(D_NS_adm2)

write.csv(D_NS_adm2,file='D_NS_adm2.csv',row.names = T)
