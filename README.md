# 🏃‍♂️ Forgotten Florida 50-Mile Race Dashboard 🚀
Welcome to the Forgotten Florida 50-Mile Race Dashboard! This project dives into participant data from one of the toughest endurance races in Florida. The insights gathered here uncover hidden patterns in gender, age, and geography among race participants. Let's explore how data brings this race to life! 🌟


## 🔍 Project Overview
### What’s this all about?

This project showcases the power of data analytics and interactive visualizations to track and analyze the Forgotten Florida 50-mile race. We take raw data, perform comprehensive Exploratory Data Analysis (EDA), run SQL queries, and bring it together on a dynamic Looker dashboard.
With this dashboard, you can:
- 📊 Discover how gender and age affect race completion time.
- 🌍 Uncover which states and countries have the most participants.
- 🎯 Filter and explore individual performance by name.
- 💡 Gain insights into participant demographics and average race performance.

## ⚙️ Tools and Technology
- Google Colab 🐍: EDA performed using Python libraries (Pandas, Matplotlib, numpy, Nominatim, RateLimiter, GeocoderTimedOut).
- SSMS (SQL Server Management Studio) 💻: SQL queries to extract meaningful data.
- Looker 📊: Interactive dashboard creation for clear visual insights.
  
## 🚧 Key Features of the Dashboard
- Geographical Mapping 🗺️: A world map shows the distribution of participants, helping you spot the states or regions with the most representation.
- Gender Breakdown 🚻: A bar chart provides insight into how different states’ participants are represented by gender.
- Age-Based Filters 🎂: Want to know how age impacts performance? Use the age slider to filter participants and analyze trends.
- Performance Stats ⏱️: Track the number of participants and their average race completion time with real-time updates.
- Personalized Search 🔎: Use the name search field to instantly track an individual’s race performance.

## 🛠️ How to Get Started
Followed steps 
1. 📥 Data Collection: The raw race data was obtained from [Race Dataset](https://ultrasignup.com/results_event.aspx?did=102259#). I scraped the relevant participant information and created a structured CSV file for analysis.
2. 📊 Exploratory Data Analysis (EDA) on Google Colab
The EDA was performed using Google Colab with Python libraries such as Pandas, NumPy, and Matplotlib. You can explore the cleaned and analyzed data in the Colab notebook.
- Open the Notebook on Google Colab:
  - [Colab Notebook](https://github.com/Srabani13/Forgotten_Florida_Race_50_miles/blob/main/FF_Race_50mile.ipynb)
3. 💻 SQL Queries in SSMS
After performing EDA, I used SQL Server Management Studio (SSMS) to run SQL queries for more structured insights. The SQL queries used for data extraction are located in the [SQL_Queries](https://github.com/Srabani13/Forgotten_Florida_Race_50_miles/blob/main/SQLQuery1_ff_race.sql) folder of this repository.

## Schema
Forgotten Florida Race 50 miles 
Here is the SQL schema for the `race_results` table:
1. How many states were represented in race
```SQL
SELECT  COUNT(DISTINCT State) AS Number_of_States
FROM race_results;

```
2. What was the avg time of men vs women
```SQL
SELECT Gender,	AVG(Total_mints) AS Avg_Time 
FROM race_results 
GROUP BY Gender;
```
3. What are the youngest and oldest ages recorded in the race?
```SQL 
SELECT Gender,MAX(Age) AS Oldest , MIN(Age) AS Youngest
FROM race_results 
GROUP BY Gender;
```
4. What is avg time of each age groups
```SQL
USE sql_queries_on_race_data;
with age_buckets AS(
SELECT Total_mints,
		CASE WHEN age <30 THEN 'age_20-29'
			 WHEN age <40 THEN 'age_30-39'
			 WHEN age <50 THEN 'age_40-49'
			 WHEN age <60 THEN 'age_50-59'
	    ELSE 'age_60+' END AS age_grp
FROM race_results )
SELECT age_grp,AVG(Total_mints) AS avg_race_time
FROM age_buckets
GROUP BY age_grp;
```
5. Top 3  males and females 
```SQL 
WITH gender_rank AS (
SELECT RANK() OVER(PARTITION BY Gender ORDER BY Total_mints ASC) AS gender_rank,
Full_Name, Gender, Total_mints
FROM race_results
)

SELECT *
FROM gender_rank
WHERE gender_rank <= 3  -- Select the top 3 per gender
ORDER BY Gender, gender_rank;
```
Save this data View the table 
```SQL 
SELECT * FROM view_name;
```
Now move the view table data in Google sheet to create a Dashboard in Looker 
 4. 📊 Interactive Dashboard on Looker: Finally, the visualizations were built into an interactive dashboard on Looker to present the findings in a user-friendly way. The dashboard allows you to filter data by gender, age, and state, and search for participants by name.
- View the Looker Dashboard: [Looker Dashboard Link]()
