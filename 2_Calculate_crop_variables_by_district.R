#This script prepare district-level crop variables.

library(data.table)

#1.Calculate total H_TA,H_TS,H_TL of each crop by district----
##H_TA
H_TA<-fread("Vietnam_H_TA.csv",stringsAsFactors=F,sep=",",header=T)
head(H_TA)
colnames(H_TA)

H_TA_adm2<-H_TA[,lapply(.SD,sum),by=name_adm2,.SDcols = c(10:51)]
head(H_TA_adm2)

write.csv(H_TA_adm2,file="H_TA_adm2.csv",row.names = F)

##H_TS
H_TS<-fread("Vietnam_H_TS.csv",stringsAsFactors=F,sep=",",header=T)
head(H_TS)
colnames(H_TS)

H_TS_adm2<-H_TS[,lapply(.SD,sum),by=name_adm2,.SDcols = c(10:51)]
head(H_TS_adm2)

write.csv(H_TS_adm2,file="H_TS_adm2.csv",row.names = F)

##H_TL
H_TL<-fread("Vietnam_H_TL.csv",stringsAsFactors=F,sep=",",header=T)
head(H_TL)
colnames(H_TL)
H_TL_adm2<-H_TL[,lapply(.SD,sum),by=name_adm2,.SDcols = c(10:51)]
head(H_TL_adm2)

write.csv(H_TL_adm2,file="H_TL_adm2.csv",row.names = F)

#2.Calculate total H_TI, P_TA, P_TS of rice by district----
##H_TI
H_TI<-fread("Vietnam_H_TI.csv",stringsAsFactors=F,sep=",",header=T)
head(H_TI)
colnames(H_TI)
H_TI_rice<-H_TI[,list(name_adm2,rice_i),]
head(H_TI_rice)
dim(H_TI_rice)

H_TI_rice_adm2<-H_TI_rice[,sum(rice_i),by=name_adm2]
head(H_TI_rice_adm2)
names(H_TI_rice_adm2)[2]<-"rice_i"

write.csv(H_TI_rice_adm2,file="H_TI_rice_adm2.csv",row.names = F)

##P_TA
P_TA<-fread("Vietnam_P_TA.csv",stringsAsFactors=F,sep=",",header=T)
head(P_TA)
colnames(P_TA)
P_TA_rice<-P_TA[,list(name_adm2,rice_a),]
head(P_TA_rice)
dim(P_TA_rice)

P_TA_rice_adm2<-P_TA_rice[,sum(rice_a),by=name_adm2]
head(P_TA_rice_adm2)
names(P_TA_rice_adm2)[2]<-"rice_a"

write.csv(P_TA_rice_adm2,file="P_TA_rice_adm2.csv",row.names = F)

##P_TS
P_TS<-fread("Vietnam_P_TS.csv",stringsAsFactors=F,sep=",",header=T)
head(P_TS)
colnames(P_TS)
P_TS_rice<-P_TS[,list(name_adm2,rice_s),]
head(P_TS_rice)
dim(P_TS_rice)

P_TS_rice_adm2<-P_TS_rice[,sum(rice_s),by=name_adm2]
head(P_TS_rice_adm2)
names(P_TS_rice_adm2)[2]<-"rice_s"

write.csv(P_TS_rice_adm2,file="P_TS_rice_adm2.csv",row.names = F)
