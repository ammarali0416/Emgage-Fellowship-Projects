  # Libraries
  library(dplyr)
  library(tidyr)
  library(readr)
  # 1 Loading the data & cleaning
  ## The number donations for the current quarter
  qtDonos <- read_csv("YTD C4.csv")
  ## The board contributions for this quarter
  boardDonos <- read_csv("YTD Board C4.csv")
  ## Removing the board members from the qtDonos df
  board <- unique(boardDonos$`Contact Name`)
  qtDonos <- qtDonos[! qtDonos$`Contact Name` %in% board, ]  # removes the board 
     # rows from the rest of the contributions
  
  


  # 2 Calculating based on source code
  ## Get all the unique source codes
  source_codes <- unique(qtDonos$`Source Code`)
  source_codes_board <- unique(boardDonos$`Source Code`)
  source_codes
  source_codes_board
  
  ## Virgina totals codes
  VA <- qtDonos %>%
    filter(`Home State/Province` == "VA") %>%
    filter(`Source Code` %in% c("c4", "C4 Membership"))
  #VA <- rbind(VA, temp_df)
  ## 0 grants
  VA_ind <- sum(VA$Amount) - 0
  VA_board <- boardDonos %>%
    filter(`Home State/Province` %in% c('DC', 'VA')) %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'pac', 'Virginia'))
  VA_board_total <- sum(VA_board$Amount)
  VA_grant <- 0
  total_VA <- VA_board_total + VA_grant + VA_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% VA$`Contribution ID`),]
  boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% VA_board$`Contribution ID`), ]
  
  ## Texas totals
  TX <- qtDonos %>%
    filter(`Home State/Province` == "TX") %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'Texas c4', 'c3'))
  ## 11309018 $30000
  TX_ind <- sum(TX$Amount) - 0 # Total individual contributions - grants (grant wasnt included since it didnt have the state listed at TX)
  TX_board <- boardDonos %>%
    filter(`Home State/Province` == 'TX') %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'pac', 'Texas c4', 'TX'))
  TX_board_total <- sum(TX_board$Amount)
  TX_grant <- 30000.00
  total_TX <- TX_board_total + TX_grant + TX_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% TX$`Contribution ID`),]
  boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% TX_board$`Contribution ID`), ]
  
  ## FL totals
  FL <- qtDonos %>%
    filter(`Source Code` == "Florida c4")
  temp_df <- qtDonos %>%
    filter(`Home State/Province` == "FL") %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3'))
  FL <- rbind(FL, temp_df)
  ## FL Immigrant Coalition $6523
  FL_ind <- sum(FL$Amount) # Total individual contributions - grants
  FL_board <- boardDonos %>%
    filter(`Home State/Province` == 'FL') %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'pac', 'Florida', 'FL Ramadan C3'))
  FL_board_total <- sum(FL_board$Amount)
  FL_grant <- 6523
  total_FL <- FL_board_total + FL_grant + FL_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% FL$`Contribution ID`),]
  boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% FL_board$`Contribution ID`), ]
  
  ## NY totals
  NY <- qtDonos %>%
    filter(`Source Code` == "New York")
  temp_df <- qtDonos %>%
    filter(`Home State/Province` %in% c("NY", "NJ")) %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3'))
  NY <- rbind(NY, temp_df)
  ## 0 grants
  NY_ind <- sum(NY$Amount) - 0 # Total individual contributions - grants
  NY_board <- boardDonos %>%
    filter(`Home State/Province` %in% c("NY", "NJ")) %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'pac', 'New York'))
  NY_board_total <- sum(NY_board$Amount)
  NY_grant <- 0
  total_NY <- NY_board_total + NY_grant + NY_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% NY$`Contribution ID`),]
 # boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% NY_board$`Contribution ID`), ]
  
  ## PA totals
  PA <- qtDonos %>%
    filter(`Home State/Province` == "PA") %>%
    filter(`Source Code` %in% c("c4", "C4 Membership"))
  ## 0 grants
  PA_ind <- sum(PA$Amount) - 0 # Total individual contributions - grants
  PA_board <- boardDonos %>%
    filter(`Home State/Province` == 'PA') %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'pac', 'Pennsylvania'))
  PA_board_total <- sum(PA_board$Amount)
  PA_grant <- 0
  total_PA <- PA_board_total + PA_grant + PA_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% PA$`Contribution ID`),]
  boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% PA_board$`Contribution ID`), ]
  
  ## MI totals
  MI <- qtDonos %>%
    filter(`Source Code` == "Michigan c4")
  temp_df <- qtDonos %>%
    filter(`Home State/Province` == "MI") %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'Michigan Ramadan'))
  MI <- rbind(MI, temp_df)
  ## Grants:
   # 11247958 $30000
   # 11248950 $5000
   # 11355453 $10000
  MI_ind <- sum(MI$Amount) - 35000 - 10000 # Total individual contributions - grants
  MI_board <- boardDonos %>%
    filter(`Home State/Province` %in% c('MI', 'FL')) %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3', 'Michigan', 'Michigan c4', NA, 'Michigan Ramadan'))
  
  MI_board_total <- sum(MI_board$Amount)
  MI_grant <- 35000 + 10000
  total_MI <- MI_board_total + MI_grant + MI_ind
  
  qtDonos <- qtDonos[-which(qtDonos$`Contribution ID` %in% MI$`Contribution ID`),]
  boardDonos <- boardDonos[-which(boardDonos$`Contribution ID` %in% MI_board$`Contribution ID`), ]
  
  ## National totals
  Nat_ind <- sum(qtDonos$Amount) - 30000 - 6523
  Nat_board <- sum(boardDonos$Amount)
  Nat_grant <- 0
  total_Nat <- Nat_board + Nat_grant + Nat_ind
  1
  
  
  `%notin%` <- Negate(`%in%`)
  
  Nat <- qtDonos %>%
    filter(`Source Code` == "National c4")
  temp_df <- qtDonos %>%
    filter(`Home State/Province` %notin% c("TX", "FL", "DC", "VA", "NY", "NJ", "PA", "MI")) %>%
    filter(`Source Code` %in% c("c4", "C4 Membership", 'c3'))
  Nat <- rbind(Nat, temp_df)
  ## 0 grants
  Nat_ind <- sum(Nat$Amount) - 0 # Total individual contributions - grants
  Nat_board <- boardDonos %>%
    filter(`Home State/Province`%notin% c("TX", "FL", "DC", "VA", "NY", "NJ", "PA", "MI"))
  Nat_board_total <- sum(Nat_board$Amount)
  Nat_grant <- 0
  total_Nat <- Nat_board_total + Nat_grant + Nat_ind
  
  # Grand total
  ## Adding $6523 from FL immigration coalition
  total_Q1 <- total_FL + total_MI + total_Nat + total_NY + total_PA + total_TX + total_VA
  
  # Finding the duplicated rows using contribution IDs
  dupe_ID <- c(FL$`Contribution ID`, FL_board$`Contribution ID`, MI$`Contribution ID`,
               MI_board$`Contribution ID`, Nat$`Contribution ID`,
               Nat_board$`Contribution ID`, NY$`Contribution ID`, 
               NY_board$`Contribution ID`, PA$`Contribution ID`, 
               PA_board$`Contribution ID`, TX$`Contribution ID`,
               TX_board$`Contribution ID`, VA$`Contribution ID`, 
               VA_board$`Contribution ID`)
