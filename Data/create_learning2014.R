---
  
title: "Chapter 2 Exercise"
author: "Harri Lindroos"
date: "05.11.2018"

---
  
#datan tuonti
  
lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#struktuurin ja dimensioiden tutkailua
str(lrn2014)
dim(lrn2014)

#dplyr mukaan

library(dplyr)

#yhdistelyä

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#uusia sarakkeita

deep_columns <- select(lrn2014, one_of(deep_questions))
lrn2014$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn2014, one_of(surface_questions))
lrn2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn2014, one_of(strategic_questions))
lrn2014$stra <- rowMeans(strategic_columns)


#uusi datapaketti

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn2014, one_of(keep_columns))

#pisteet oltava != 0

learning2014 <- filter(learning2014, Points != 0) 

#datapaketin tarkistus

dim(learning2014)
str(learning2014)
learning2014

#datapaketin tallennus (write.csv())

write.csv(learning2014, "learning2014.csv", row.names = FALSE)

#ja testaus

read.csv("learning2014.csv")
head(read.csv("learning2014.csv"))
str(read.csv("learning2014.csv"))
dim(read.csv("learning2014.csv"))

