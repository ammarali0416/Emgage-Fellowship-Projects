# All you need to read csv's into dataframes is pandas!
import pandas as pd
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
# 1. Loading in the data
# Reading the data from the csv
## Ideally just input a file with a single column datafram containing all the
## zipcodes from our dataset
file = 'FILENAME'
data = pd.read_csv(file)
# Getting the profile urls
zipcodes = data['Zipcode']
# Creates a driver for google chrome
driver = webdriver.Chrome(executable_path = 'C:/Users/ammar/chromedriver.exe')
# Log into incomebyzipcode.come
driver.get('https://www.incomebyzipcode.com/')
# Relevant xpaths for elements
search_xpath = '//*[@id="search_terms"]'
result_xpath = '/html/body/div[1]/div[2]/div/div[1]/table/tbody/tr/td[1]/a'
median_income_xpath = '/html/body/div[2]/div[1]/div[1]/div[1]/div[2]/div/table/tbody/tr[2]/td[1]'
average_income_xpath = '/html/body/div[2]/div[1]/div[1]/div[2]/div[2]/div/table/tbody/tr[2]/td[1]'
per_capita_xpath = '/html/body/div[2]/div[1]/div[1]/div[3]/div[2]/div/table/tbody/tr[2]/td[1]'
high_income_xpath = '/html/body/div[2]/div[1]/div[1]/div[3]/div[2]/div/table/tbody/tr[2]/td[1]'
median_income_25under_xpath = '/html/body/div[2]/div[1]/div[1]/div[5]/div/table/tbody/tr[2]/td[1]'
median_income_25to44_xpath = '/html/body/div[2]/div[1]/div[1]/div[5]/div/table/tbody/tr[3]/td[1]'
median_income_45to64_xpath = '/html/body/div[2]/div[1]/div[1]/div[5]/div/table/tbody/tr[4]/td[1]'
median_income_64over_xpath = '/html/body/div[2]/div[1]/div[1]/div[5]/div/table/tbody/tr[5]/td[1]'

#lists for each element scrapes
median_income_list = []
average_income_list = []
per_capita_income_list = []
high_income_households_list = []
median_income_25under_list = []
median_income_25to44_list = []
median_income_45to64_list = []
median_income_65over_list = []
count = 0

for zipcode in zipcodes:
    # Search for a zipcode
    search_input = driver.find_element_by_xpath(search_xpath)
    search_input.send_keys(str(zipcode))
    search_input.send_keys(Keys.ENTER)
    time.sleep(2)
    try:
        # Select search result
        result = driver.find_element_by_xpath(result_xpath)
        result.click()
        time.sleep(2)
        # Getting the zipcodes income data
        median_income = driver.find_element_by_xpath(median_income_xpath).text
        average_income = driver.find_element_by_xpath(average_income_xpath).text
        per_capita_income = driver.find_element_by_xpath(per_capita_xpath).text
        high_income_households = driver.find_element_by_xpath(high_income_xpath).text
        median_income_25under = driver.find_element_by_xpath(median_income_25under_xpath).text
        median_income_25to44 = driver.find_element_by_xpath(median_income_25to44_xpath).text
        median_income_45to64 = driver.find_element_by_xpath(median_income_45to64_xpath).text
        median_income_64over = driver.find_element_by_xpath(median_income_64over_xpath).text
        median_income_list.append(median_income)
        average_income_list.append(average_income)
        per_capita_income_list.append(per_capita_income)
        high_income_households_list.append(high_income_households)
        median_income_25under_list.append(median_income_25under)
        median_income_25to44_list.append(median_income_25to44)
        median_income_45to64_list.append(median_income_45to64)
        median_income_65over_list.append(median_income_64over)
        time.sleep(2)
    except Exception as exception:
        median_income_list.append('NA')
        average_income_list.append('NA')
        per_capita_income_list.append('NA')
        high_income_households_list.append('NA')
        median_income_25under_list.append('NA')
        median_income_25to44_list.append('NA')
        median_income_45to64_list.append('NA')
        median_income_65over_list.append('NA')
        search_input = driver.find_element_by_xpath(search_xpath)
        search_input.clear()
        #time.sleep(3)
    count = count + 1
    if count % 10 == 0:
        print('Saving')
        data['Median Household Income'] = pd.Series(median_income_list)
        data['Average Household Income'] = pd.Series(average_income_list)
        data['Per Capita Income'] = pd.Series(per_capita_income_list)
        data['Percentage of High Income Housholds (>$200k)'] = pd.Series(high_income_households_list)
        data['Median Household Income of Under 25yr Housholders'] = pd.Series(median_income_25under_list)
        data['Median Household Income of 25-44yr Householders'] = pd.Series(median_income_25to44_list)
        data['Median Household Income of 45-64yr Householders'] = pd.Series(median_income_45to64_list)
        data['Median Household Income of 65+yr Householders'] = pd.Series(median_income_65over_list)
        data.to_csv('Emgage Zipcodes.csv1')
    print(count)
data['Median Household Income'] = pd.Series(median_income_list)
data['Average Household Income'] = pd.Series(average_income_list)
data['Per Capita Income'] = pd.Series(per_capita_income_list)
data['Percentage of High Income Housholds (>$200k)'] = pd.Series(high_income_households_list)
data['Median Household Income of Under 25yr Housholders'] = pd.Series(median_income_25under_list)
data['Median Household Income of 25-44yr Householders'] = pd.Series(median_income_25to44_list)
data['Median Household Income of 45-64yr Householders'] = pd.Series(median_income_45to64_list)
data['Median Household Income of 65+yr Householders'] = pd.Series(median_income_65over_list)
data.to_csv('Zipcode Financial Data.csv1')
