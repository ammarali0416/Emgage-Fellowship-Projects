# Libraries
library(dplyr)
library(tidyr)
library(readr)
#install.packages('anytime')
library(anytime)
# 1 Loading the data & cleaning
## The number donations for the current quarter
qtDonos <- read_csv("YTD C3.csv")
## The board contributions for this quarter
boardDonos <- read_csv("YTD Board C3.csv")
## Removing the board members from the qtDonos df
board <- unique(boardDonos$`Contact Name`)
qtDonos <- qtDonos[! qtDonos$`Contact Name` %in% board, ]  # removes the board 
   # rows from the rest of the contributions
boardDonos$`Date Received` <- anytime(boardDonos$`Date Received`)
qtDonos$`Date Received`<- anytime(qtDonos$`Date Received`)

#all_donos <- rbind(boardDonos, qtDonos)
#all_donos <- all_donos[order(all_donos$`Date Received`), ]
# 2 Calculating based on source code
## Get all the unique source codes
source_codes <- unique(qtDonos$`Source Code`)
source_codes_board <- unique(boardDonos$`Source Code`)
source_codes
source_codes_board

## Virgina totals codes
VA <- qtDonos %>%
  filter(`Source Code` == "Virginia")
temp_df <- qtDonos %>%
  filter(`Home State/Province` == "VA") %>%
  filter(`Source Code` == "c3")
VA <- rbind(VA, temp_df)
## Grants to be deducted when doing YTD / Q1 reconciliation
  ## 11247808 Contribution ID is a grant for $10K
VA_ind <- sum(VA$Amount) - 10000
#VA_ind <- sum(VA$Amount)
VA_board <- boardDonos %>%
  filter(`Home State/Province` %in% c('DC', 'VA')) %>%
  filter(`Source Code` == "c3")
VA_board_total <- sum(VA_board$Amount)
VA_grant <- 10000
total_VA <- VA_board_total + VA_grant + VA_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% VA$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% VA_board$`Contribution ID`), ]

## Texas totals
TX <- qtDonos %>%
  filter(`Source Code` %in% c("TX", "Texas"))
temp_df <- qtDonos %>%
  filter(`Home State/Province` == "TX") %>%
  filter(`Source Code` == "c3")
TX <- rbind(TX, temp_df)
## Q1 YTF grants
  ## 11080584 Contribution ID is a grant for $10K
TX_ind <- sum(TX$Amount) - 10000 # Total individual contributions - grants
#TX_ind <- sum(TX$Amount)
TX_board <- boardDonos %>%
  filter(`Home State/Province` == 'TX') %>%
  filter(`Source Code` == "c3")
TX_board_total <- sum(TX_board$Amount)
TX_grant <- 10000
total_TX <- TX_board_total + TX_grant + TX_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% TX$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% TX_board$`Contribution ID`), ]

## FL totals
FL <- qtDonos %>%
  filter(`Source Code` %in% c("Florida", "FL Ramadan C3", "Ramadan 2021", "Zakat"))
temp_df <- qtDonos %>%
  filter(`Home State/Province` == "FL") %>%
  filter(`Source Code` == "c3")
FL <- rbind(FL, temp_df)
# Q1 grant deductions  
  ## 11080585 Contribution is a grant for $18750
FL_ind <- sum(FL$Amount) - 18750 # Total individual contributions - grants
#FL_ind <- sum(FL$Amount)
FL_board <- boardDonos %>%
  filter(`Home State/Province` == 'FL') %>%
  filter(`Source Code` %in% c("c3", "FL Ramadan C3", "Florida"))
FL_board_total <- sum(FL_board$Amount)
FL_grant <- 18750
total_FL <- FL_board_total + FL_grant + FL_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% FL$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% FL_board$`Contribution ID`), ]

## NY totals
NY <- qtDonos %>%
  filter(`Source Code` == "New York")
temp_df <- qtDonos %>%
  filter(`Home State/Province` %in% c("NY", "NJ")) %>%
  filter(`Source Code` == "c3")
NY <- rbind(NY, temp_df)
## 0 grants
NY_ind <- sum(NY$Amount) - 0 # Total individual contributions - grants
NY_board <- boardDonos %>%
  filter(`Home State/Province` %in% c("NY", "NJ")) %>%
  filter(`Source Code` == "c3")
NY_board_total <- sum(NY_board$Amount)
NY_grant <- 0
total_NY <- NY_board_total + NY_grant + NY_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% NY$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% NY_board$`Contribution ID`), ]

## PA totals
PA <- qtDonos %>%
  filter(`Source Code` == "Pennsylvania")
temp_df <- qtDonos %>%
  filter(`Home State/Province` == "PA") %>%
  filter(`Source Code` == "c3")
PA <- rbind(PA, temp_df)
## 0 grants
PA_ind <- sum(PA$Amount) - 0 # Total individual contributions - grants
PA_board <- boardDonos %>%
  filter(`Home State/Province` == 'PA') %>%
  filter(`Source Code` %in% c("c3",'Pennsylvania'))
PA_board_total <- sum(PA_board$Amount)
PA_grant <- 0
total_PA <- PA_board_total + PA_grant + PA_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% PA$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% PA_board$`Contribution ID`), ]

## MI totals
MI <- qtDonos %>%
  filter(`Source Code` %in% c("Michigan", "Michigan Ramadan"))
temp_df <- qtDonos %>%
  filter(`Home State/Province` == "MI") %>%
  filter(`Source Code` == "c3")
MI <- rbind(MI, temp_df)
## 0 grants
MI_ind <- sum(MI$Amount) - 0 # Total individual contributions - grants
MI_board <- boardDonos %>%
  filter(`Home State/Province` == 'MI') %>%
  filter(`Source Code` %in% c("c3", "Michigan Ramadan", NA))
MI_board_total <- sum(MI_board$Amount)
MI_grant <- 0
total_MI <- MI_board_total + MI_grant + MI_ind

qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% MI$`Contribution ID`),]
boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% MI_board$`Contribution ID`), ]

Nat_ind <- sum(qtDonos$Amount) - (40000+1000)
Nat_board <- sum(boardDonos$Amount)
Nat_grant <- (40000+1000)
total_Nat <- Nat_board + Nat_grant + Nat_ind

######
### No longer needed as the qtDonos df now only has all the national donations
## National totals
#`%notin%` <- Negate(`%in%`)
#
#at <- qtDonos %>%
# filter(`Source Code` %in% c("National", "Nat Ramadan C3", "Cape and Bay"))
#temp_df <- qtDonos %>%
#  filter(`Home State/Province` %notin% c("TX", "FL", "DC", "VA", "NY", "PA", "MI", "NJ")) %>%
#  filter(`Source Code` == "c3")
#Nat <- rbind(Nat, temp_df)
### Grants:
 # 11247809 $40000
 # 11247790 $1000
#Nat_ind <- sum(Nat$Amount) - (40000+1000) # Total individual contributions - grants
#Nat_board <- boardDonos %>%
#  filter(`Source Code` %in% c("National", "Nat Ramadan C3"))
#Nat_board_total <- sum(Nat_board$Amount)
#Nat_grant <- (40000+1000)
#total_Nat <- Nat_board_total + Nat_grant + Nat_ind
######
# Grand total
total <- total_FL + total_MI + total_Nat + total_NY + total_PA + total_TX + total_VA
