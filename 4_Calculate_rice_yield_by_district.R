#This script calculates rice yield by district. 

#1.Calculate total harvested area of rice of non-subsistence farms by district----
H_NS_adm2<-read.csv("H_NS_adm2.csv",stringsAsFactors = F)
head(H_NS_adm2)
H_NS_adm2_rice<-H_NS_adm2[,c(1,3)]
head(H_NS_adm2_rice)
names(H_NS_adm2_rice)[2]<-"H_rice_ns"
#Save for later use
write.csv(H_NS_adm2_rice,file="H_NS_adm2_rice.csv",row.names = F)


#2.Calculate total production of rice of non-subsistence farms by district----
P_TA_rice_adm2<-read.csv("P_TA_rice_adm2.csv",stringsAsFactors = F)
P_TS_rice_adm2<-read.csv("P_TS_rice_adm2.csv",stringsAsFactors = F)

P_rice_adm2<-merge(P_TA_rice_adm2,P_TS_rice_adm2)
head(P_rice_adm2)

P_rice_adm2$P_rice_ns<-P_rice_adm2$rice_a-P_rice_adm2$rice_s
head(P_rice_adm2)
range(P_rice_adm2$P_rice_ns)
# 0 1765532

#3.Calculate rice yield of non-subsistence farms by district----
Y_NS_adm2_rice<-merge(H_NS_adm2_rice,P_rice_adm2)
head(Y_NS_adm2_rice)
Y_NS_adm2_rice$Y_rice_ns<-Y_NS_adm2_rice$P_rice_ns/Y_NS_adm2_rice$H_rice_ns
head(Y_NS_adm2_rice)
range(Y_NS_adm2_rice$Y_rice_ns,na.rm = T)
#0.500000 9.535555

#check
Y_TA<-read.csv("Vietnam_Y_TA.csv",stringsAsFactors = F)
head(Y_TA)
range(Y_TA$rice_a,na.rm = T)
#0.0 12718.7
#unit=kg/ha

H_TA<-read.csv("Vietnam_H_TA.csv",stringsAsFactors = F)
H_TA$unit[1]
#"ha"

P_TA<-read.csv("Vietnam_P_TA.csv",stringsAsFactors = F)
P_TA$unit[1]
#"mt"
#mt/ha= 1000kg/ha
#9.5mt/ha~=10mt/ha=10^4kg/ha
#The magnitudes match.

write.csv(Y_NS_adm2_rice[,c(1,6)],file="Y_NS_adm2_rice.csv",row.names = F)
