# Google-Data-Analytics-Capstone---Cyclistic-Case-Study
# Introduction
  In this case study, I will perform the real-world tasks of a junior data analyst at a fictional company - Cyclistic. The answer of key business questions, will be done through the data analyst process: Ask, Prepare, Process, Analyze, Act, and Share. 

# Cyclistic
  Cyclistic has had a successful bike-share program, since its launch in 2016. As of now, the program has grown into a fleet of 5824 bicycles which are geotracked and locked into a network of 692 stations across Chicago. Thus far, Cyclistic's strategy has been on buiding general awareness and appealing to broad consumer segments. The approach that helped make the company possible was the flexibility of the company's pricing plans: single-ride passes, full-day passess, and annual memberships. Anyone who purchases single-day or full-day passes are known as 'casual' riders, while anyone who purchases annual membership as known as 'members'.

  Cyclistic has determined the annual members are more profitable than casual riders. Though  flexibie pricing helps Cyclistic attract customers, the management believes that maximizing the number of annual members will be key to attracting growth. As such, there has been an effort launched to convert more casual riders into members. To do this, Lily Moreno - Director of Marketing - at Cyclistic, has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members.

  In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

# Ask
## Business Task
Devise marketing strategies necessary to convert casual riders into annual members.

Three questions guide the future of the marketing program:
  1. How do annual members and casual riders use Cyclistic bikes differently?
  2. Why would casual riders buy Cyclistic annual memberships?
  3. How can Cyclistic use digital media to influence casual riders to become members?

Lily Moreno - a key stakeholder - has assigned us the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

## Stakeholders
The key stakeholders in this are Lily Moreno - Director of Marketing, and the Cyclistic executive team, who will ultimately be responsible for approving the marketing deal. 

# Prepare
## Data Source
I will use Cyclistic's historical trip data to analyze and identify trends from Jan 2023 to May 2023. The data can be downloaded from [here](https://divvy-tripdata.s3.amazonaws.com/index.html), with the data itself being made avaialble by Motivate International Inc. under his [license](https://divvybikes.com/data-license-agreement).

## Data Organization
In the end, 4 files were downloaded for Cyclistic usage from January through May 2023. The files include information such as ride_id, bike_type,start time, end time, start station, end station, start location, end location, and membership type. 

# Process
The tools being used to analyze the data are Google Spreadsheet and then combined together using R as the overall worksheet had 1,065,942 data points after cleaning. 

## Combining the Data
  In order to process all the records, RStudio was utilized as Google Spreadsheet would not be able to handle such vasts amount of data. As such, the first step was to install and load packages such as **Tidyverse, Janitor, Lubridate, and Dplyr** as seen below.
  
  ![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/afb35794-9856-4da8-9c08-0d461d0a9c16)

  Subsequently, the files were imported into RStudio and were made into dataframes using the **read_csv** function. 
  
  ![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/d0138e4a-49e6-4492-a55c-834fd7809a46)

*Note: The **attach** function was used to attach all the dataframes to the current search path in my local directory. This was not necessary at all, I just did this as my RStudio environment kept on crashing.*

  Before the files are merged, it is important to check if **all** the columns have identical column names and correctly formatted data types. 
![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/ec05ee42-a36e-4e07-8201-a03be8dbf385)
![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/df63c9d9-c817-489e-bf41-b40c0f8ff77a)

As seen in the images above, there is no incorrectly formatted data types and all the column names are identical. Finally, the data is then merged together using the **bind_rows** method, which is part of **dplyr** package.

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/fa9fab14-44c2-4285-b64d-3e33e0ddd0b5)

## Data Cleaning & Data Exploration
  After merging all the files together, a cleaning process ensues through using the **clean_names** and **remove_empty** functions, respectively. The former ensures that we remove any spaces, parentheses, etc. from our column titles. The latter ensures that we remove any empty rows & columns from the entire dataset.
  
![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/b8dabfb3-1b07-48ec-8153-1dee2d5f5f22)

  Once the cleaning process is complete, we need to add new columns to the merged dataframe. The  columns are: Day of the Week, Start hour (using **format(as.POSIXct)**, Month (using **format(as.Date())**, and trip duration (**using difftime()**). 

> Day of the Week

The Day of the Week column was added using Google Spreadsheets with the **WEEKDAY(serial_number, Return_type)** function. The serial number indiciates the date of the day, we need to find, which the return_type indiciates the return value (e.g. 1 means numbers 1 (Sunday) through 7 (Monday)) as seen [here](https://support.microsoft.com/en-us/office/weekday-function-60e44483-2ed1-439f-8bd0-e404c190949a).

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/bf45eeb5-b6e7-4b4d-a69e-2fddf0a7f878)

> Start hour

Start hour column extracts a TIME HOUR format from an object, which is formatted in a date/time manner. The function utilized is **format(as.POSIXct)**, where the POSIXct extacts a TIME HOUR format from an object as mentioned before.

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/dfe69688-6df5-4033-bc17-e75a935ffc5c)

> Month

The Month column is used to extract a month column from the an object, which is again formatted in a date/time manner. This time, it is done using the **format(as.Date())** function, where as.Date() extracts the date from the date/time object.

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/9d79a7b4-74a7-40e5-babb-bdae6e108346)

> Trip Duration

Trip duration calculates the time the rider took when using the Cyclistic services. It does this by using **difftime()**, which calculates the difference between two columns within a dataset (with those columns having a date format).

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/0c00044a-973a-4c65-9f02-0ed274ef5d27)

*Note: The **$** is used to **access/select** a specific column within the dataframe.*

A final cleaning is done one last time, with the data being filtered out to ensure that any trip durations less than or equialent to 0 are removed. In this manner, we create a new dataframe called 'cleaned_df'. The new dataframe is that written into a new csv file called 'Cyclistic_2.csv' to have it ready for visulaization purposes in **_Tableau Public_**.

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/a4d98bbe-196b-4736-9a96-fe08b9b8c715)

# Analyze 
The business task we have to solve for is "**Devising marketing strategies necessary to convert casual riders into annual members**". The task will be solved by obtaining answers to the following questions:

1) How does the ridership vary between members by each day of week?
2) How does the average trip duration vary between casual and annual members?
3) What is the hourly usage difference between casual and annual members?
4)  What are the most popular destinations where members (casual and annual members) start their rides?

All of these questions give us an answer into understanding the pattern of behaviour between casual and annuual member usage of bikes. All the plots of this were carried out on **_Tableau Public_**.

### 1) Ridership variation by member type
![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/60fa3166-8555-4b77-af10-2808d2d91bd4)

The image above showcases that the usage of bikes by annual members (orange line) is the greatest during the weekdays and slows down during the weekend. For casual members (blue line) the usage is the slowest during the weekays and picks up during the weekend. The graph also indicates that ridership for the annual members is much higher than that of casual members, implying a relationship to annual members using the bikes as their main source of transportation in contrast to casual members. 

### 2) Average trip duration by member type
![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/0a11798a-fc4b-4208-8b1f-c57775d86a22)

The image above showcases the average trip duration of bikes of casual vs. annual members. Casual members use the bike 2x more often to travel around than that of annual members. This implies that annual members perhaps utilize bikes for day-to-day activities, in commuting from home to work and vice versa. In comparison, the casual members probably utilize the bikes more for leisurely and sport activities in general, leading to overall increased usage time. 

### 3) Hourly Usage Diffrence between casual and annual members
We can further confirm our hypothesis by inspecting the hourly usage of bikes on weekdays (Monday through Friday). 

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/8fb52111-f577-4296-a193-3d7ce6181a3f)

The image above showcases the hourly usage of bikes from Monday through Friday. At 8AM and 5PM, the number of riders is the greatest for annual members. This coincides with a typical workday for people with jobs. As people are often getting to work at 8AM and returning from work at 5PM, it therefore explains the phenomenon of annual members using bikes to commute to and from work. 

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/30199784-ace3-4cd0-a876-9f1596b3a7a0)

In contrast, the majority of the casual riders start their rides from 10AM onwards on the weekdays (except a brief spike at 8AM), which continues until 5PM. After this, it drops in usage, as we approach the night. 

### 4) What are the most popular destinations where members (casual and annual members) start their rides?
The plots below showcase the popular stations separated by membership type (casual vs. annual members).

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/4d25bcd9-819f-40d4-a1bf-85576e55be8f)

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/f6a7bd78-b7de-4c17-9c66-fb8613f98cd9)


The frequently visited stations among annual members are concentrated in densely populated office areas and working spaces. 

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/380df86e-175f-479f-976a-05e042268324)

![image](https://github.com/pheonixmaster99/Google-Data-Analytics-Capstone---Cyclistic-Case-Study/assets/91801911/b6b07d3c-244c-4c49-b18b-7288ea093b3d)


For casual members, the popular stations are located closer along the coastline, that indicates potential sightseeing or lesiure activities carried out by the aforementioned members. 

# Act & Share
### Final Conclusions
Based on the above findings, we can conclude a  few observations.

1. There is good evidence to believe that casual members are composed of tourists and/or families who use the service for leisure activities or weekend sightseeing.
2. In comparison, there is also strong inclanation to believe that annual members are comprised of mainly working adults that utlize the service to commute to and from work.
3. Casual members travel using bikes 2x more longer than annual members, and also ride more often than annual members.

### Recommendations for Stakeholders
1. Launch marketing strategies in areas popular with casual riders. These include areas such as: Streeter Dr & Grand Ave, DuSable Lake Shore Dr & Monroe St, Millenium Park, and Shedd Aquarium. Local marketing strategies involve Digital Marketing on platforms such as Facebook or Instagram to convert casual members to annual ones.
2. In line with the first point, incentivize members to transition by attaching perks/benefits with being an annual member. This could take the form of points, similar to points cards used by several grocery chains and fast food franchises (e.g., Scene Card or Tim Hortons Points Card).
3. Raise the prices of casual passes to make it more economical for casual members to switch towards annual memberships.
   
### Next Steps to Expand Findings
1. A breakdown of pricing of casual and membership plans. Further data into this could allows us to determine the optimal price point to maximize the revenue from both plans. 
2. A  breakdown of casual memberships, as to how many use single-ride passes versus full-day passes used. This helps understand the data surrounding trip durations and allows us to make further reccomendations.
3. Additional demographic data of the rider such as age, gender, and martial status. This will allow us to improve accuracy of marketing strategies by tailoring the strategy to specific audience segments. 
