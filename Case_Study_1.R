#Install the packages the libraries
install.packages('tidyverse')
install.packages('janitor')
install.packages('lubridate')
install.packages('dplyr')

#Load the Packages
library(tidyverse)
library(janitor)
library(lubridate)
library(dplyr)

# Import the files
library(readxl)
df_1 <- read.csv("2023Q1-divvy-tripdata.csv")
df_2 <- read.csv("2023Q2-divvy-tripdata.csv")
df_3 <- read.csv("2023Q3-divvy-tripdata.csv")
df_4 <- read.csv("2023Q4-divvy-tripdata.csv")


str(df_1)
str(df_2)
#Make sure dataframes are in the global environment (current search pathway)
attach(df_1)
attach(df_2)
attach(df_3)
attach(df_4)

#View dataframes
View(df_1)
View(df_2)
View(df_3)
View(df_4)


#Creating a new dataset by merging all the datasets together
merged_df <- dplyr::bind_rows(df_1,df_2,df_3,df_4)

#Cleaning & removing any parentheses
merged_df <- clean_names(merged_df)

#Remove empty rows
remove_empty(merged_df, which=c())

#Create new columns
#starting_hour column
merged_df$starting_hour <- format(as.POSIXct(merged_df$started_at),'%H')

#month column
merged_df$month <- format(as.Date(merged_df$started_at), '%m')

#trip duration column
merged_df$trip_duration <- difftime(merged_df$ended_at, merged_df$started_at, units = 'sec')

# Remove any trip durations less than or equivalent to 0
cleaned_df <- merged_df[!(merged_df$trip_duration <=0),]

#create a new csv file with all the merged data
write.csv(cleaned_df, file='Cyclistic_2.csv')

