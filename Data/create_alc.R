---
title: "Student/alcohol dataset"
author: "Harri Lindroos"
date: "13.11.2018"
---
#reading data
mat <- read.csv("student-mat.csv")
por <- read.csv("student-por.csv")
  
#exploring data
str(mat)
dim(mat)
str(por)
dim(por)

#accessing library
library(dplyr)

math <- read.table("student-mat.csv", sep = ";" , header=TRUE)
por <- read.table("student-por.csv", sep = ";" , header=TRUE)

dim(math)
dim(por)

#joining datasets

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

str(math_por)
dim(math_por)
colnames(math_por)

#new data frame
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
    first_column <- select(two_columns, 1)[[1]]
  
    if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

glimpse(alc)

#creating new columns
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

#saving the data and getting rid of the row names
write.csv(alc, "alcdata.csv", row.names = FALSE)
read.csv("alcdata.csv")
str("alcdata.csv")