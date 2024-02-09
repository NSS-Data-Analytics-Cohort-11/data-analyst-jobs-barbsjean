--1.	How many rows are in the data_analyst_jobs table?

Select *
FROM data_analyst_jobs;

-- ANSWER: 3586

**************************************

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- ANSWER: ExxonMobil

**************************************

--3a.	How many postings are in Tennessee?
--3b.   How many are there in either Tennessee or Kentucky?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';

--3a ANSWER: 42

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY');

--3b ANSWER: 54

**************************************

--4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE star_rating > 4;

--ANSWER: 832

**************************************

--5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--ANSWER: 302

**************************************

--6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) as avg_rating
FROM data_analyst_jobs
GROUP BY location, star_rating
ORDER BY star_rating DESC;

--ANSWER: WI, VA, MD, TN, CA, NY, GA and MA all show 5 as their average ratings.

**************************************

--7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

ANSWER: 881

**************************************

--8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

ANSWER: 230

**************************************

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT DISTINCT company, AVG(star_rating) AS avg_star_rating, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY review_count, location, company;   --may have to rework this query to get the right answer... something to do with adding in the companies

--ANSWER: 83

**************************************

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT DISTINCT company, AVG(star_rating) AS avg_star_rating, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY review_count, company
ORDER BY AVG(star_rating) DESC;

--ANSWER: American Express, 4.1999 rating

**************************************

--11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--ANSWER: 3272

**************************************

--12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT *
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%'
AND title NOT LIKE '%Analytics%'
AND title NOT LIKE '%analyst%'
AND title NOT LIKE '%analytics%'
AND title NOT LIKE '%ANALYST%'
AND title NOT LIKE '%ANALYTICS%';

--ANSWER: 8. Data.

**************************************

--**BONUS:**
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
-- Disregard any postings where the domain is NULL. 
-- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT domain, COUNT(*)
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
AND domain IS NOT NULL
AND days_since_posting > 21
GROUP BY domain
ORDER BY COUNT(*) DESC;

--ANSWER: Internet and Software (124), Banks and Financial Services (122), & Consulting and Business Services (114)
