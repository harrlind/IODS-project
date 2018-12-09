#Meet and repeat: Wrangling

#The data

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Checking the data

str(BPRS)
dim(BPRS)
str(RATS)
dim(RATS)

summary(BPRS$subject)

#In the BPRS set we have 40 observations and 11 variables. As the summary tells us, our subject variable has 20 values. Each of our subjects have gone through 2 treatments (20 x 2 = 40). The results of the treatments have been recorded and have values from week 0 to 8 (where the 0 is the baseline/the value before the treatment). We have variables for every week (0 - 8) and all in all that makes 11 variables for the whol set.
#Our RATS set has only 16 observations and the number of variables is 13. They are individual rats and they belong to 3 different groups: 8 rats belonging to first category and 4 rats to seconf and third. Every group follows a different diet and the effects of diet to to weights of individual rats are recorded during 11 weeks. Each week forms its own variable.

#Converting some categorial variables to factors

library(dplyr)
library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Converting to long form

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 

#Checking the data

glimpse(BPRSL)
glimpse(RATSL)
dim(BPRSL)
dim(RATSL)

#I have followed the example of the Datacamp exercises with the data. That means that I have also created bprs variable (BPRS) to account for every weeks value. The wrangling exercises assignment stays silent about this but for the analysis this makes more sense. Now we have only 360 observations compared to our old 40, and the amount of variables has decreased from 11 to 5. This means that have substituted our data sets form form the wide form to the long form.   
#With RATS set I have operated the same way as with the BPRS set: I have also created weight variable to replace all the 9 different week variables. Now our new long form dat set has increased to number of observations from 16 to 176 and decreased the number of  

#Let's save our data sets

write.csv(BPRSL, "bprsl.csv", row.names = FALSE)
write.csv(RATSL, "rats.csv", row.names = FALSE)





