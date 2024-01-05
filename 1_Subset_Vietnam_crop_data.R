#This script subsets Vietnam data from the mapSPAM global data.
#The same codes template is applied to H_TA, H_TS, H_TL, H_TI, P_TA, P_TS, and Y_TA.

#1.Import global data
rm(list=ls())
dat<-read.csv("spam2010V2r0_global_H_TA.csv",stringsAsFactors=F, header=T)
dim(dat)
#[1] 500266     57
head(dat)

#2. Subset Vietnam data
which(names(dat)=="name_cntr")
#55
vdat<-dat[which(dat[,55]=="Viet Nam"),]
dim(vdat)
#[1] 3981   57
head(vdat)

#3.Export Vietnam data
write.csv(vdat,"Vietnam_H_TA.csv",row.names = F)




