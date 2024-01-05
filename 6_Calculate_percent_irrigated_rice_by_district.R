#This script calculates the percentage of irrigated rice area of non-subsistence farms by district.

H_NS_adm2_rice<-read.csv("H_NS_adm2_rice.csv",stringsAsFactors = F)
head(H_NS_adm2_rice)

H_TI_adm2_rice<-read.csv("H_TI_rice_adm2.csv",stringsAsFactors = F)
head(H_TI_adm2_rice)

Irri_NS_adm2_rice<-merge(H_NS_adm2_rice,H_TI_adm2_rice)
head(Irri_NS_adm2_rice)
Irri_NS_adm2_rice$Percent_Irrigated_rice<-Irri_NS_adm2_rice$rice_i/Irri_NS_adm2_rice$H_rice_ns
range(Irri_NS_adm2_rice$Percent_Irrigated_rice,na.rm = T)
#[1] 0 1

#check
nrow(subset(Irri_NS_adm2_rice,Percent_Irrigated_rice==0))
#8
nrow(subset(Irri_NS_adm2_rice,Percent_Irrigated_rice==1))
#136

write.csv(Irri_NS_adm2_rice[,c(1,4)],
          file="Irri_NS_adm2_rice.csv",row.names = F)


