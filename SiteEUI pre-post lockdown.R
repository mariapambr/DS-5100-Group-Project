library(dplyr)
library(tidyverse)

#reading the data sets
dati20<-read.csv(file = 'Energy_20.csv',header = T)
dati19<-read.csv(file = 'Energy_19.csv',header = T)

# selecting variables of interest
datis20<-subset(dati20,select = c(OSEBuildingID,DataYear,Latitude, Longitude, YearBuilt, NumberofFloors, SiteEUI.kBtu.sf., LargestPropertyUseType,TotalGHGEmissions))
datis19<-subset(dati19,select = c(OSEBuildingID,DataYear,Latitude, Longitude, YearBuilt, NumberofFloors, SiteEUI.kBtu.sf., LargestPropertyUseType,TotalGHGEmissions))

# rename variables
datis20<-rename(datis20,PropertyUse = LargestPropertyUseType, SiteEUI=SiteEUI.kBtu.sf.)
datis19<-rename(datis19,PropertyUse = LargestPropertyUseType, SiteEUI=SiteEUI.kBtu.sf.)

#Occurences of each property use per year
propertype20<-datis20 %>% group_by(PropertyUse) %>% summarise(occurrences = n())
propertype19<-datis20 %>% group_by(PropertyUse) %>% summarise(occurrences = n())

#Filter for sites which contain PropertyUse of interest
sites_interest <- function(df){
  df = filter(df, grepl(c('^Office|^Restaurant|Hospital|K-12 School|Hotel|Multifamily Housing'),df$PropertyUse))
  return(df)
}

ds20<-sites_interest(datis20)
ds19<-sites_interest(datis19)

# boxplot energy vs propertyuse
ggplot(ds19, aes(x=SiteEUI,y=PropertyUse)) + geom_boxplot() + xlim(0,250) + labs(x="Property Use",y="EUI per sq (kBtu)",title = "EUI per property type 2019") 
ggplot(ds20, aes(x=SiteEUI,y=PropertyUse)) + geom_boxplot() + xlim(0,250) + labs(x="Property Use",y="EUI per sq (kBtu)",title = "EUI per property type 2020") 

# boxplot for all Property use 2019 vs 2020
ggplot() + geom_boxplot(data = ds19, aes(x = SiteEUI, y = PropertyUse), fill="light blue",outlier.color="light blue") + 
  geom_boxplot(data = ds20, aes(x = SiteEUI, y = PropertyUse),color="dark blue", outlier.color="black",alpha = 0.5) + labs(x="EUI per sq (kBtu)",y="Property Use")+xlim(0,250) + coord_flip()

# filtering for hotel 
hotel20 <- ds20 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Hotel")  
hotel19 <- ds19 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Hotel") 

# boxplot only for hotels 2019 vs 2020
ggplot() + geom_boxplot(data = hotel19, aes(x = SiteEUI, y = PropertyUse), fill="Pink",outlier.color="Purple") + 
  geom_boxplot(data = hotel20, aes(x = SiteEUI, y = PropertyUse),color="blue") + labs(x="Property Use",y="EUI per sq (kBtu)")+xlim(0,250)+coord_flip()
t.test(hotel19$SiteEUI, hotel20$SiteEUI, alternative = 'less', var.equal = FALSE)

# filtering for hospital
hospital20 <- ds20 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Hospital (General Medical & Surgical)")  
hospital19 <- ds19 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Hospital (General Medical & Surgical)") 
t.test(hospital19$SiteEUI, hospital20$SiteEUI, alternative = 'less', var.equal = FALSE)

# filtering for restaurant
restaurant20 <- ds20 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Restaurant")  
restaurant19 <- ds19 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Restaurant") 
t.test(restaurant19$SiteEUI, restaurant20$SiteEUI, alternative = 'less', var.equal = FALSE)

# filtering for office
office20 <- ds20 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Office")  
office19 <- ds19 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "Office") 
t.test(office19$SiteEUI, office20$SiteEUI, alternative = 'less', var.equal = FALSE)

#filtering for K-12 School
school20 <- ds20 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "K-12 School")  
school19 <- ds19 %>% select(c(PropertyUse,SiteEUI))%>%subset(PropertyUse == "K-12 School") 
t.test(school19$SiteEUI, school20$SiteEUI, alternative = 'less', var.equal = FALSE)
