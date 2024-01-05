#This script models crop diversity of non-subsistence farmers at the district level

dat<-read.csv("final_data.csv",stringsAsFactors = F)
head(dat)

#1.Mod1.
mod1<-lm(D~Yield_rice+bio1_ran+bio12_ran+bio6_mean+bio13_mean+bio14_mean,
         data=dat)
mod1_coeff<-as.data.frame(coef(summary(mod1)))
mod1_coeff_r<-round(mod1_coeff,digits=3)
mod1_rsq<-summary(mod1)["adj.r.squared"]
mod1_rsq
#0.38
#Crop diversity decreased with rice yield, increased with climate variability,
#increased with coldness and flooding stresses.The adjusted R2 was 0.38,
#i.e.,together these variables explained roughly 40% of variation in crop diversity.


#2.Mod2.
plot(Perc_input~Yield_rice,dat)
dat$res_perc_input<-0
dat$res_perc_input[complete.cases(dat[,c("Perc_input","Yield_rice")])]<-lm(Perc_input~Yield_rice,dat)$residuals
#Check
plot(res_perc_input~Yield_rice,dat)   
#Good.

dat$res_perc_irri<-0
plot(Percent_Irrigated_rice~Yield_rice,dat)
dat$res_perc_irri[complete.cases(dat[,c("Percent_Irrigated_rice","Yield_rice")])]<-lm(Percent_Irrigated_rice~Yield_rice,dat)$residuals
#Check
plot(res_perc_irri~Yield_rice,dat)   
#Good

mod2<-lm(D~Yield_rice+bio1_ran+bio12_ran+bio6_mean+bio13_mean+bio14_mean+res_perc_input+res_perc_irri,
         data=dat)
summary(mod2)
mod2_coeff<-as.data.frame(coef(summary(mod2)))
mod2_coeff_r<-round(mod2_coeff,digits=3)
mod2_rsq<-summary(mod2)["adj.r.squared"]
mod2_rsq
#0.50
#Crop diversity decreased with input residuals and increased with irrigation.
#R squared improved to 0.50.

write.csv(mod1_coeff,file="mod1_coeff.csv",row.names = T)
write.csv(mod2_coeff,file="mod2_coeff.csv",row.names = T)




