library(tidyverse)

rm(list = ls())

d16 = read.csv(file = 'data/Building_Energy_Benchmarking_2016.csv', header = T)
d19 = read.csv(file = 'data/Building_Energy_Benchmarking_2019.csv', header = T)
d20 = read.csv(file = 'data/Building_Energy_Benchmarking_2020.csv', header = T)

compliant_sites <- function(df){
  df = filter(df, ComplianceStatus == 'Compliant')
  return(df)
}

d16 = compliant_sites(d16)
d19 = compliant_sites(d19)
d20 = compliant_sites(d20)

#Filter for sites which contain 'Office' in property type
office_sites <- function(df){
  df = filter(df, grepl('Office', df$PrimaryPropertyType))
  return(df)
}

d16 = office_sites(d16)
d19 = office_sites(d19)
#2020 Uses different label for property type, need to normalize for function
d20$PrimaryPropertyType = d20$EPAPropertyType
d20 = office_sites(d20)

ggplot(d16, aes(y=SiteEUI.kBtu.sf., x = NumberofFloors)) +
  geom_point()



d19$Rise = NA
d19$Rise[d19$NumberofFloors <= 4] = 'Lowrise'
d19$Rise[d19$NumberofFloors > 4 & d19$NumberofFloors<=12] = 'Midrise'
d19$Rise[d19$NumberofFloors > 12] = 'Highrise'



#Keep only low and highrise
d19 = filter(d19, Rise %in% c('Lowrise', 'Highrise'))
highrise = filter(d19, Rise == 'Highrise')
lowrise = filter(d19, Rise == 'Lowrise')

mu.lowrise = mean(d19$SiteEUI.kBtu.sf.[d19$Rise == 'Lowrise'])
mu.highrise = mean(d19$SiteEUI.kBtu.sf.[d19$Rise == 'Highrise'])


ggplot(d19, aes(x=SiteEUI.kBtu.sf., color=Rise)) +
  geom_density() +
  geom_vline(xintercept = mu.lowrise, color = 'blue') +
  geom_vline(xintercept = mu.highrise, color = 'red') +
  xlim(0, 200)

t.test(highrise$SiteEUI.kBtu.sf., mu = 66.05, alternative = 'less')
t.test(highrise$SiteEUI.kBtu.sf., lowrise$SiteEUI.kBtu.sf., alternative = 'less', var.equal = FALSE)

sigma = sd(highrise$SiteEUI.kBtu.sf.)
t = (mu.highrise - mu.lowrise)/(sigma/62^0.5)






hotel19 = filter(d19, PrimaryPropertyType == 'Hotel')
hotel20 = filter(d20, PrimaryPropertyType == 'Hotel')

t.test(hotel19$SiteEUI.kBtu.sf., hotel20$SiteEUI.kBtu.sf., alternative = 'less', var.equal = FALSE)


d19 = filter(d19, grepl('Hospital', d19$PrimaryPropertyType))






