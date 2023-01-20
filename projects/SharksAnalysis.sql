--------------------------------------------------------------------------------------------------
-- DO THE ANALYSIS 
-- one Dashboard for the World and one for USA

select *
from PortfolioProject..Sharks



-- count all attacks types  
select Type, count(*)
from PortfolioProject..Sharks
group by Type

-- count all faltal 
select [Fatal (Y/N)], count(*) as Fatalities
from PortfolioProject..Sharks
group by [Fatal (Y/N)]

-- count all ages 
select Age, count(*) AS age_count
from PortfolioProject..Sharks
group by age
order by age_count desc

-- count all genders
select Sex, count(*) AS sex_count
from PortfolioProject..Sharks
group by Sex
order by sex_count desc

-- count all activity
select Activity, count(*) AS Activity_count, Area
from PortfolioProject..Sharks
group by Activity, Area
having activity LIKE '%foil%'
order by Activity_count desc




-- see the countries with the highest attacs 
select country, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
group by Country, [Fatal (Y/N)]
order by count(*) desc

select country, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Country = 'USA'
group by Country, [Fatal (Y/N)]
order by count(*) desc





----------------------------------------------------------------------------------------------------------
-- 1. What countries has the most attacks WORLD 
select country, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
group by Country, [Fatal (Y/N)]
having count(*) > 50 and [Fatal (Y/N)] >= 'Y'
order by count(*) desc, [Fatal (Y/N)]

select country, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
group by Country, [Fatal (Y/N)]
having count(*) > 50 and [Fatal (Y/N)] = 'N'
order by count(*) desc, [Fatal (Y/N)]

select country, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
group by Country, [Fatal (Y/N)]
having count(*) > 50 and [Fatal (Y/N)] = 'UNKNOWN'
order by count(*) desc, [Fatal (Y/N)]


----------------------------------------------------------------------------------------------------------
-- 2. What activity had the most attacks 
SELECT Activity, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Activity is not null
group by Activity, [Fatal (Y/N)]
having [Fatal (Y/N)] = 'N'
order by count(*) desc

SELECT Activity, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Activity is not null
group by Activity, [Fatal (Y/N)]
having [Fatal (Y/N)] = 'Y'
order by count(*) desc

SELECT Activity, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Activity is not null
group by Activity, [Fatal (Y/N)]
order by count(*) desc

----------------------------------------------------------------------------------------------------------
-- 3. What sex has the most fatal attacks 
SELECT Sex, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Sex is not null
group by Sex, [Fatal (Y/N)]
order by count(*) desc, Sex

SELECT Sex, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Sex is not null 
group by Sex, [Fatal (Y/N)]
--having [Fatal (Y/N)] = 'N'
order by count(*) desc


----------------------------------------------------------------------------------------------------------
-- 4. What age had the most attacks 
SELECT Age, count(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Age is not null 
group by Age, [Fatal (Y/N)]
having [Fatal (Y/N)] = 'Y' and count(*) > 20
order by count(*) desc, Age



-----------------------------------------------------------------------------------------------------------
-- 5. What year has the most registrered attacks 

-- Attacks
select Year, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Year is not null
group by Year, [Fatal (Y/N)]
having [Fatal (Y/N)] >= 'N' and count(*) > 100
order by count(*) desc, [Fatal (Y/N)]

-- Fatal attacks
select Year, COUNT(*) as count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where Year is not null
group by Year, [Fatal (Y/N)]
having [Fatal (Y/N)] >= 'Y' and count(*) > 15
order by count(*) desc, [Fatal (Y/N)]

-----------------------------------------------------------------------------------------------------------
-- 6. What type (provoked) was fatal 

-- see what different attack types are there now
select type, count(*) as attack_count, [Fatal (Y/N)]
from PortfolioProject..Sharks
where [Fatal (Y/N)] IN ('Y', 'N')
group by Type, [Fatal (Y/N)]
order by attack_count desc, [Fatal (Y/N)]

SELECT type, count(*) as attack_count, country, Area, [Fatal (Y/N)], injury_category, Activity
from PortfolioProject..Sharks
where [Fatal (Y/N)] IN ('Y', 'N') and [Fatal (Y/N)] >= 'Y'
group by Type, [Fatal (Y/N)], Country, area, injury_category, Activity
order by attack_count desc, [Fatal (Y/N)]

-- downloaded 
SELECT type, count(*) as attack_count, country, Area, [Fatal (Y/N)], injury_category, Activity
from PortfolioProject..Sharks
where [Fatal (Y/N)] IN ('Y', 'N')
group by Type, [Fatal (Y/N)], Country, area, injury_category, Activity
order by attack_count desc, [Fatal (Y/N)]


-- 7. Most common injuries 
SELECT injury_category, count(*) as attack_count
from PortfolioProject..Sharks
where [Fatal (Y/N)] IN ('Y', 'N')
group by injury_category
having count(*) > 15
order by attack_count desc

-- 8. years and attacks 

select Year, count(*) as Fatalities
from PortfolioProject..Sharks
group by Year


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

-- ANALYSIS ON THE US ONLY 

-- map 
-- 1. What area has the most attacks USA 
select Area, COUNT(*) as count, Country, [Fatal (Y/N)]
from PortfolioProject..Sharks 
group by Country, Area, [Fatal (Y/N)]
having country = 'USA'
order by count(*) desc, [Fatal (Y/N)]


-- gender and what is attacked
-- male 
select injury_category, COUNT(*) as count_injury, Sex, [Fatal (Y/N)], Country
from PortfolioProject..Sharks 
group by injury_category, Sex, [Fatal (Y/N)], Country
having country = 'USA' and count(*) > 50 and Sex = 'M'
order by COUNT(*) desc, [Fatal (Y/N)]

-- female
select injury_category, COUNT(*) as count_injury, Sex, [Fatal (Y/N)], Country
from PortfolioProject..Sharks 
group by injury_category, Sex, [Fatal (Y/N)], Country
having country = 'USA' and count(*) > 20 and Sex = 'F'
order by COUNT(*) desc, [Fatal (Y/N)]


-- type and gender
select injury_category, COUNT(*) as count_injury, type, Sex, [Fatal (Y/N)], Country
from PortfolioProject..Sharks 
group by injury_category, Sex, [Fatal (Y/N)], Country, Type
having country = 'USA' and count(*) > 20 and Sex = 'F'
order by COUNT(*) desc, [Fatal (Y/N)]

select injury_category, COUNT(*) as count_injury, type, Sex, [Fatal (Y/N)], Country
from PortfolioProject..Sharks 
group by injury_category, Sex, [Fatal (Y/N)], Country, Type
having country = 'USA' and count(*) > 20 and Sex = 'F'
order by COUNT(*) desc, [Fatal (Y/N)]

-- provoked vs unprovoked
select type, COUNT(*) as attack_count, Country
from PortfolioProject..Sharks
group by Type,Country
having country = 'USA'
order by COUNT(*) desc


-- fatal attacks a year
select Year, count(*) as Fatalities, Country
from PortfolioProject..Sharks
group by Year, Country
having country = 'USA'
order by COUNT(*) desc