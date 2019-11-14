# created on 11/6
# have access to all the laso participants' student IDs, now match them to the psych 10 screening 
library(dplyr)
library(readxl)
full_laso <- read_xlsx("/Users/CCNL2/Desktop/Mengtong/SurveyTrackingTemplate.xlsx")
fall2018 <- read_xlsx("/Users/CCNL2/Desktop/Mengtong/Sophie - Fall 2018.xlsx", sheet = 2, skip = 1)
winter2019 <- read.csv("/Users/CCNL2/Desktop/Mengtong/Pooja - Winter 2019.csv")
spring2019 <- read_xlsx("/Users/CCNL2/Desktop/Mengtong/Pooja - Spring 2019.xlsx", sheet = 2, skip = 1)
track <- read_xlsx("/Users/CCNL2/Desktop/Mengtong/SurveyTrackingTemplate.xlsx")
track <- track[,1:5]

# create a new variable with their full name as an identifier 
fall2018 <- fall2018 %>% mutate(name = paste(first_name, last_name))
winter2019 <- winter2019 %>% mutate(name = paste(first_name, last_name))
spring2019 <- spring2019 %>% mutate(name = paste(first_name, last_name))

# match returns a vector of the positions of (first) matches of its first argument in its second.
# %in% is a more intuitive interface as a binary operator, which returns a logical vector indicating if there is a match or not for its left operand.

# full_laso contains all the people who did laso, and fall2018 is the psych 10 people 
# the first name in full_laso is J.E., and it is in row 461 of the fall2018 dataset 
match(full_laso$`Student ID`, fall2018$SID)
match(full_laso$`Student ID`, winter2019$SID)
match(full_laso$`Student ID`, spring2019$SID)

# the screen df should contain name, student id, and their answers to the 18 questions 
# 37 matches from fall2018 using the name match, 41 matches using the SId match 
# here I omit the na's, change the colnames, and then rbind them 
screen <- fall2018[match(full_laso$`Student ID`, fall2018$SID),c(41, 7, 23:40)] %>% na.omit()
winter2019 <- na.omit(winter2019[match(full_laso$`Student ID`, winter2019$SID), c(41, 7, 23:40)])
colnames(winter2019) <- colnames(screen)
screen <- rbind(screen, winter2019)
spring2019 <- na.omit(spring2019[match(full_laso$`Student ID`, spring2019$SID), c(41, 7, 23:40)])
colnames(spring2019) <- colnames(screen)
screen <- rbind(screen, spring2019)


# now change the character variables to numeric variables 
# code the variables from categorical to numeric 
for(i in 3:20){
  screen[screen[,i] == "Never",i] = 1
  screen[screen[,i] == "Sometimes",i] = 2
  screen[screen[,i] == "Often",i] = 3
  screen[screen[,i] == "Nearly Always",i] = 4
}

# Davon Coburn uid: 5120436 was both in fall2018 and winter2019 with different answers 
# decided to drop the winter2019 data 
screen <- screen[-42,]

# Karlesha Van Holten
# Andrea Nicole Pineda


# need to link their student id with lab participant id 
match(screen$SID, track$`Student ID`) == 1:106






