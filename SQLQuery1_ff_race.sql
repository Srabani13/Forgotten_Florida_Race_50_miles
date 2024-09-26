-- Forgotten Florida Race 50 miles 
-- performing SQL on this dataset 

SELECT*
FROM sql_queries_on_race_data.dbo. race_results 

-- Q1. How many states were represented in race
SELECT  COUNT(DISTINCT State) AS Number_of_States
FROM race_results;

-- Q2. What was the avg time of men vs women
SELECT Gender,	AVG(Total_mints) AS Avg_Time 
FROM race_results 
GROUP BY Gender;

--Q3.What are the youngest and oldest ages recorded in the race?
SELECT Gender,MAX(Age) AS Oldest , MIN(Age) AS Youngest
FROM race_results 
GROUP BY Gender;

--Q4. What is avg time of each age groups

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
GROUP BY age_grp

--Q5. Top 3  males and females 
WITH gender_rank AS (
SELECT RANK() OVER(PARTITION BY Gender ORDER BY Total_mints ASC) AS gender_rank,
Full_Name, Gender, Total_mints
FROM race_results
)

SELECT *
FROM gender_rank
WHERE gender_rank <= 3  -- Select the top 3 per gender
ORDER BY Gender, gender_rank;



SELECT * FROM view_name;
