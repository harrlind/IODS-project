---
  
title: "Data wrangling for exercise 5"
author: "Harri Lindroos"
date: "25.11.2018"

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

write.csv(hd_gii, "hd_gii.csv", row.names = FALSE)

