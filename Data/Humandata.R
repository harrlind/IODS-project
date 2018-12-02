---
  
title: "Data wrangling for exercise 6"
author: "Harri Lindroos"
date: "2.12.2018"

---


#loading the two datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#summaries and dimensions 
summary(hd)
dim(hd)
summary(gii)
dim(gii)

#changing the names of the variables
colnames(hd)[c(1, 2, 3, 4, 5, 6, 7, 8)] <- c("rank", "country", "hdi", "ebirth", "eedu", "medu", "gni", "gnirank")
summary(hd)

colnames(gii)[c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)] <- c("rank", "country", "gii", "matmor", "adob", "parli", "femedu", "maledu", "femlab", "malelab")
summary(gii)

#mutating variables

library(dplyr)
gii <- mutate(gii, eduratio = femedu / maledu)
gii <- mutate(gii, labratio = femlab / malelab)
summary(gii)
dim(gii)

#joining the datasets

join_by <- "country"
hd_gii <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
summary(hd_gii)
dim(hd_gii)
glimpse(hd_gii)

#saving the new dataset


#wrangling continues: gni as numeric

library(stringr)
library(dplyr)
str_replace(hd_gii$gni, pattern=",", replace ="")%>%as.numeric

#saving columns

kc <- c("country", "eduratio", "labratio", "eedu", "gni", "ebirth", "matmor", "adob", "parli")
hd_gii <- select(hd_gii, one_of(kc))

dim(hd_gii)

#removing all rows with missing values

complete.cases(hd_gii)
hdgii <- filter(hd_gii, complete.cases(hd_gii))
complete.cases(hdgii)

data.frame(hdgii[-1], comp = complete.cases(hdgii))

hdgii <- filter(hdgii, complete.cases(hdgii))

#checking and removing all the observations which relate to regions instead of countries 

tail(hdgii, 10)
stop <- nrow(hdgii) - 7
hdgii <- hdgii[1:stop, ]
tail(hdgii, 10)

#changing the the rownames

rownames(hdgii) <- hdgii$country

#last check

summary(hdgii)
dim(hdgii)

#saving the data

write.csv(hdgii, "hdgii.csv")



