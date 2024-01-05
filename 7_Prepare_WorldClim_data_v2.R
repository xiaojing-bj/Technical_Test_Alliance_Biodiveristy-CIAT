#This script downloads and prepares worldclim data. 

library(geodata)
library(terra)

#1.Download and prepare bioclimatic variables from worldClim
#clim_vn<-worldclim_country("Vietnam","bio",path=getwd())
clim_vn<-rast("VNM_wc2.1_30s_bio.tif")

#Subset 5 bioclimatic variables for subsequent analyses: 
#bio1 = Annual Mean Temperature
#bio12 = Annual Precipitation
#bio6 = Min Temperature of Coldest Month
#bio13 = Precipitation of Wettest Month
#bio14 = Precipitation of Driest Month
#The first two variables indicate general climate conditions.
#I calculate their ranges as indicators for spatial climate variability within districts.
#The rest three variables give a sense of the severity of cold temperature, drought, and flooding.
#These stresses are identified as potential barriers for Vietnamese farmers to rotate other crops with rice. 
. 
bio_vn<-clim_vn[[c(1,12,6,13,14)]]

#Aggregate bio_vn from 30sec to 5m to match mapSPAM data.
bio_agg<-aggregate(bio_vn,fact=10,fun="mean",cores=1)
bio_agg


#2.Create a raster indicating administrative level 2 based on mapSPAM data
H_TA<-read.csv("Vietnam_H_TA.csv", row.names = 1)
dist<-H_TA[,c(5,6,56,57)]
dist<-as.data.table(dist)
dist$name_adm1<-as.factor(dist$name_adm1)
dist$name_adm2<-as.factor(dist$name_adm2)
#save province and district names for future reference.
names_adm1<-levels(dist$name_adm1)
names_adm2<-levels(dist$name_adm2)
write.csv(names_adm1,file="names_adm1.csv")
write.csv(names_adm2,file="names_adm2.csv")

dist$name_adm1<-as.numeric(dist$name_adm1)
dist$name_adm2<-as.numeric(dist$name_adm2)
dist_long<-melt(dist,id.vars=c(1,2),variable.name="Layer",
                value.name = "Cell values")
dist_df<-as.data.frame(dist_long)
crs_bio<-crs(bio_vn[[1]])
dist_rast<-rast(dist_df,type="xylz",crs=crs_bio,digits=2)
dist_rast
#Test
plot(dist_rast[[1]])

#3.Summarize bioclimatic variables by district and export results
bio_cropped<-crop(bio_agg,dist_rast)
bio_cropped

bio_by_dist_a<-zonal(bio_cropped[[c(1,2)]],dist_rast[[2]],"min",na.rm=T)
names(bio_by_dist_a)[c(2,3)]<-c("bio1_min","bio12_min")
bio_by_dist_b<-zonal(bio_cropped[[c(1,2)]],dist_rast[[2]],"max",na.rm=T)
names(bio_by_dist_b)[c(2,3)]<-c("bio1_max","bio12_max")
bio_by_dist<-merge(bio_by_dist_a,bio_by_dist_b)
bio_by_dist$bio1_ran<-bio_by_dist$bio1_max-bio_by_dist$bio1_min
bio_by_dist$bio12_ran<-bio_by_dist$bio12_max-bio_by_dist$bio12_min

bio_by_dist_c<-zonal(bio_cropped[[c(3:5)]],dist_rast[[2]],"mean",na.rm=T)
names(bio_by_dist_c)[c(2:4)]<-c("bio6_mean","bio13_mean","bio14_mean")
head(bio_by_dist_c)
bio_by_dist<-merge(bio_by_dist,bio_by_dist_c)

write.csv(bio_by_dist,file="bioclim_by_dist.csv")
