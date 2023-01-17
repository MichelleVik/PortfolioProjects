'''The possum data frame consists of nine morphometric measurements on each of 104 mountain brushtail possums, trapped at seven sites from Southern Victoria to central Queensland.

https://public.tableau.com/app/profile/michelle.vik.myrvold/viz/PossumDataOverview/Dashboard1?publish=yes
'''

-- LOOK AT THE DATA 

SELECT * 
FROM PortfolioProject2..possum_stats

SELECT * 
FROM PortfolioProject2..possum_body

-- see if there are any null values 
SELECT *
FROM PortfolioProject2..possum_stats
WHERE site IS NULL OR pop IS NULL OR sex IS NULL OR age IS NULL


SELECT age, COUNT(*)
FROM PortfolioProject2..possum_stats
WHERE age IS NULL
GROUP BY age -- there is 2 NULL value in age 

SELECT *
FROM PortfolioProject2..possum_body
WHERE skullw IS NULL OR totlngth IS NULL OR taill IS NULL OR earconch IS NULL OR eye IS NULL OR chest IS NULL OR belly IS NULL


SELECT footlgth, COUNT(*)
FROM PortfolioProject2..possum_body
GROUP BY footlgth
HAVING COUNT(footlgth) = 0;

-- 2 values in age is missing and 1 footlength

-- FILL IN THE MISSING VALUES
-- check if the null value is still there
SELECT * 
FROM PortfolioProject2..possum_body 
WHERE footlgth IS NULL;

-- it is, so lets calculate the average of the columns so we can add the mean for the missing value 
select AVG(footlgth)
from PortfolioProject2..possum_body
-- the mean is 92.60

-- fill in the value 
UPDATE PortfolioProject2..possum_body 
SET footlgth = 68.46 
WHERE footlgth IS NULL;

SELECT * 
FROM PortfolioProject2..possum_body 
WHERE footlgth IS NULL;
-- nothing shows up so the null value is now removed!

-- do the same thing for the age column

-- calculate the average age
select avg(age)
from PortfolioProject2..possum_stats

-- add the average age 3.8 rounded up to 4 to the 2 missing values 
UPDATE PortfolioProject2..possum_stats
SET age = 4
WHERE age IS NULL;

-- check that there are no more missing values
SELECT * FROM PortfolioProject2..possum_stats 
WHERE age IS NULL;



-- JOIN THE TABLES 
-- join the two tables 
SELECT *
FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 



-- averages of all the body stats 

-- AVERAGE SIZE BY AGE 
SELECT stats.age,  AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.age


-- AVERAGE SIZE BY WHERE THEY ARE TRAPPED 
SELECT stats.Pop, AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.Pop


-- AVERAGE SIZE BY SEX
SELECT stats.sex,  AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.sex





-- HOW MANY FEMALES VS MALES 
SELECT sex, COUNT(*)/2
FROM PortfolioProject2..possum_stats
GROUP BY sex


-- WHAT ARE THE AGES 
SELECT age, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY age 

-- HOW MANY WHERE TRAPPED AT EACH LOCATION
SELECT pop, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY pop



-- How many m/f where trapped in Victoria and other
SELECT pop, COUNT(*)/2 as count, sex
FROM PortfolioProject2..possum_stats
GROUP BY pop, sex

-- what are the ages of m/f
SELECT sex, COUNT(*)/2 as count, avg(age) as age
FROM PortfolioProject2..possum_stats
WHERE sex = 'f'
GROUP BY sex, age

SELECT sex, COUNT(*)/2 as count, avg(age) as age
FROM PortfolioProject2..possum_stats
WHERE sex = 'm'
GROUP BY sex, age

-- what are the ages of possum trapped in Victoria vs other
SELECT avg(age) as age, pop, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
WHERE pop = 'other'
GROUP BY age, Pop 

SELECT avg(age) as age, pop, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
WHERE pop = 'vic'
GROUP BY age, Pop




-- CREATE VIEWS 

-- HOW MANY FEMALES VS MALES 
USE PortfolioProject2;
GO

DROP VIEW IF EXISTS FemaleVsMale
CREATE VIEW FemaleVsMale
AS 
SELECT sex, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY sex


-- WHAT ARE THE AGES 
CREATE VIEW possumAge
AS 
SELECT age, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY age 

-- HOW MANY WHERE TRAPPED AT EACH LOCATION
CREATE VIEW locationTrapped
AS 
SELECT pop, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY pop


-- How many m/f where trapped in Victoria and other
CREATE VIEW mf_vic_other
AS 
SELECT pop, COUNT(*)/2 as count, sex
FROM PortfolioProject2..possum_stats
GROUP BY pop, sex

-- what are the ages of m/f
CREATE VIEW mf_age
AS 
SELECT sex, COUNT(*)/2 as count, avg(age) as age
FROM PortfolioProject2..possum_stats
GROUP BY sex, age


-- what are the ages of possum trapped in Victoria vs other
CREATE VIEW age_trapped
AS 
SELECT avg(age) as age, pop, COUNT(*)/2 as count
FROM PortfolioProject2..possum_stats
GROUP BY age, Pop 


-- AVERAGE SIZE BY AGE 
CREATE VIEW avg_size_age
AS 
SELECT stats.age,  AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.age


-- AVERAGE SIZE BY WHERE THEY ARE TRAPPED 
CREATE VIEW avg_size_trapped
AS 
SELECT stats.Pop, AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.Pop


-- AVERAGE SIZE BY SEX
CREATE VIEW avg_size_sex
AS 
SELECT stats.sex,  AVG(body.hdlngth) AS head_length, AVG(body.skullw) AS skull_width, AVG(body.totlngth) AS total_length, AVG(body.taill) AS tail_length, AVG(body.footlgth) AS foot_length, AVG(body.earconch) AS ear_conch, AVG(body.eye) AS eye_width, AVG(body.chest) AS chest_girth, AVG(body.belly) AS belly_girth

FROM PortfolioProject2..possum_stats stats
INNER JOIN PortfolioProject2..possum_body body
ON stats.stats_case_id = body.case_body_id 

group by stats.sex