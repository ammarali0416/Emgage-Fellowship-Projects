# This script will take a look at and categorize pre-EA Emgage donors.
# STEP 0: Load some libraries
library(dplyr)
library(tidyr)
library(readr)
library(readxl)

# STEP 1: Load and clean the data
donations <- read_excel("Emgage/Founding Donors/donations recevived from jan 2013 to dec 2015.xlsx")
donations <- donations[, -c(1,2,3,4,5,7,9,11,13,15,17,19,21,23,25,27,29)]
donations <- donations[-c(1:14, 871:873 ,1227:1323) ,]
  # removing the records with no name
donations <- donations[-which(is.na(donations$Name) == TRUE), ]

data <- donations %>% group_by(Name) %>%
   summarise(Amount = n())
data[3] <- aggregate(donations$Amount, list(donations$Name), sum)[2]

colnames(data) <- c("Name", "Number.of.Donations", "Total.Amount")

data[4]<- data %>%
  summarise(Total.Amount / Number.of.Donations) %>%
  round(digits = 2)
colnames(data)[4] <- "Average.Donation.Amount"

data <- data[order(data$Number.of.Donations, decreasing = TRUE),] 

write.csv(data, file = 'Founding Donors.csv')
