select * 
from PortfolioProject..Sharks

------------------------------------------------------------------------------------------
-- Drop columns that I do not need 
ALTER TABLE PortfolioProject..Sharks
DROP COLUMN Name, [Investigator or Source], pdf, [href formula], href, [original order]


ALTER TABLE PortfolioProject..Sharks
DROP COLUMN [Case Number1], [Case Number2]



-----------------------------------------------------------------------------------
-- change year from varchar to int

BEGIN TRANSACTION

ALTER TABLE Sharks
ALTER COLUMN Year int

COMMIT

--ALTER TABLE Sharks
--ADD new_year_column AS CONVERT(INT, Year);

----------------------------------------------------------------------------
-- change age to int 

-- change age to int 

-- check the other ages that are longer than 2 characters 
SELECT Age, LEN(Age) AS 'Length', Year
from PortfolioProject..Sharks
where date is not null 
order by Length desc, Year

-- Age is currently a float number, but stored as a varchar

-- remove the trailing .0
UPDATE Sharks
SET Age = REPLACE(Age, '.0','')

-- remove s like 50s
UPDATE Sharks
SET Age = REPLACE(Age, 's','')

UPDATE Sharks
SET Age = REPLACE(Age, '!6','6')


UPDATE Sharks
SET Age = REPLACE(Age, '''', '')



UPDATE Sharks
SET Age = 
  CASE 
	WHEN Age = 'N/A' THEN NULL
	WHEN Age = '!!' THEN NULL
	WHEN Age = 'X' THEN NULL
	WHEN Age = 'MAKE LINE GREEN' THEN NULL
	WHEN Age = 'M' THEN NULL
	WHEN Age = 'F' THEN NULL
	WHEN Age = 'Elderly' THEN '60'
	WHEN Age = 'Ca. 33' THEN NULL
	WHEN Age = 'Both 11' THEN '11'
	WHEN Age = 'A.M' THEN NULL
	WHEN Age = 'a minor' THEN '15'
    WHEN Age = '%adult%' THEN '25'
	WHEN Age = 'Young' THEN '20'
	WHEN Age = 'Teen%' THEN '15'
	WHEN Age = 'middle-age' THEN '40'
	WHEN Age = 'mid-30s' THEN '35'
	WHEN Age = 'mid-20s' THEN '25'
    WHEN Age = '>50' THEN '50'
	WHEN Age = '!!' THEN NULL
	WHEN Age = '(adult)' THEN '25'
	WHEN Age = '? % 14' THEN '14'
	WHEN Age = '?& 19' THEN '19'
	WHEN Age = 'Teen' THEN '15'
	WHEN Age = 'mid-30' THEN '35'
	WHEN Age = 'mid-20' THEN '25'
	WHEN Age = 'adult' THEN '25'
	WHEN Age = 'A.M' THEN NULL
	WHEN Age = '9 or 10' THEN '10'
	WHEN Age = '9 month' THEN '1'
	WHEN Age = '9 or 12' THEN '11'
	WHEN Age = '8 or 10' THEN '9'
	WHEN Age = '7 or 8' THEN '8'
	WHEN Age = '7 and 31' THEN '19'
	WHEN Age = '6½' THEN '7'
	WHEN Age = '50 & 30' THEN '40'
	WHEN Age = '46 & 34' THEN '40'
	WHEN Age = '45 & 15' THEN '30'
	WHEN Age = '37, 67, 35, 27,  ? & 27' THEN '40'
	WHEN Age = '36 & 26' THEN '30'
	WHEN Age = '36 & 23' THEN '30'
	WHEN Age = '34 & 19' THEN '25'
	WHEN Age = '33 & 37' THEN '35'
	WHEN Age = '33 & 26' THEN '27'
	WHEN Age = '33 or 37' THEN '30'
	WHEN Age = '32 & 30' THEN '31'
	WHEN Age = '31 or 33' THEN '30'
	WHEN Age = '30 or 36' THEN '33'
	WHEN Age = '30 & 32' THEN '31'
	WHEN Age = '28, 23 & 30' THEN '30'
	WHEN Age = '28 & 26' THEN '27'
	WHEN Age = '28 & 22' THEN '24'
	WHEN Age = '25 to 35' THEN '30'
	WHEN Age = '25 or 28' THEN '26'
	WHEN Age = '22, 57, 31' THEN '35'
	WHEN Age = '21, 34,24 & 35' THEN '30'
	WHEN Age = '21 or 26' THEN '23'
	WHEN Age = '21 & ?' THEN '21'	
	WHEN Age = '2½' THEN '2'
	WHEN Age = '20?' THEN '20'
	WHEN Age = '2 to 3 month' THEN '1'	
	WHEN Age = '18 to 22' THEN '20'
	WHEN Age = '18 or 20' THEN '19'
	WHEN Age = '18 month' THEN '1'	
	WHEN Age = '17 & 35' THEN '25'
	WHEN Age = '17 & 16' THEN '16'	
	WHEN Age = '16 to 18' THEN '17'	
	WHEN Age = '13 or 18' THEN '15'	
	WHEN Age = '13 or 14' THEN '14'	
	WHEN Age = '12 or 13' THEN '13'
	WHEN Age = '10 or 12' THEN '11'	
	WHEN Age = '? & 19' THEN '19'
	WHEN Age = '?    &   14' THEN '14'
	WHEN Age = '9 & 12' THEN '11'	
	WHEN Age = '9 & 60' THEN '45'
	WHEN Age = 'A.M.' THEN NULL
	WHEN Age = '7      &    31' THEN '22'
	WHEN Age = '45 and 15' THEN '38'	
	WHEN Age = '23 & 26' THEN '25'
	WHEN Age = '23 & 20' THEN '22'
    ELSE Age
  END

-- change the column from varchar to int
BEGIN TRANSACTION

ALTER TABLE Sharks
ALTER COLUMN Age int

COMMIT

-- comments 
-- After looking at all the values I changed, there are a lot of them that contains 2 ages, and 'or' and '&'. There is a shorter and more effective way to do this. If the dataset was much larger than this, it would be impossible or extremely time consuming to do it this way. 


-------------------------------------------------------------------------------------------
-- CHANGE DATATYPES
-- DATE from varchar to DATE 

-- change the date column 
select * 
from PortfolioProject..Sharks
-- look at the current data in the column, is there enough values

select Date
from PortfolioProject..Sharks
where date is not null

-- check if there is enough characters in the date. one says 202 and the other say 144
SELECT Date, LEN(Date) AS 'Length'
from PortfolioProject..Sharks
where date is not null 
order by Length 


select min(date)
from PortfolioProject..Sharks
-- the earliest date is 1018-06-01

select date 
from PortfolioProject..Sharks
order by Date desc
-- the latest date is 3022

----- CHANGE 144, 202 AND 3022
UPDATE Sharks
SET Date = REPLACE(Date, '202', '2020')
WHERE date_column LIKE '20%'

-- See what other dates are aroung 144
select Date
from PortfolioProject..Sharks
where date is not null AND DATE like '%144%'
-- it says 1944 in the year so change it to that year 

UPDATE Sharks
SET Date = REPLACE(Date, '144', '1944')


-- check the other dates that are longer than 10 characters 
SELECT Date, LEN(Date) AS 'Length', Year
from PortfolioProject..Sharks
where date is not null 
order by Length desc, Year

-- there are several dates from 2020, but typed 20200. change these to 2020
UPDATE Sharks
SET Date = REPLACE(Date, '20200', '2020')

-- 20201 = 2021
UPDATE Sharks
SET Date = REPLACE(Date, '20201', '2021')

-- 20202 = 2022
UPDATE Sharks
SET Date = REPLACE(Date, '20202', '2022')

-- 20203 = 2023
UPDATE Sharks
SET Date = REPLACE(Date, '20203', '2023')

SELECT Date, LEN(Date) AS 'Length', Year
from PortfolioProject..Sharks
--where date is not null 
order by Length desc, Year

select count(year) as year, Date, Type
from PortfolioProject..Sharks
where date is not null
group by year, Date, Type
order by year desc

-- see if i can change the datatype now from varchar to date
BEGIN TRANSACTION

ALTER TABLE Sharks
ALTER COLUMN date date

COMMIT TRANSACTION


---------------------------------------------------------------------------------------------------
-- CHANGE type to sort the types of attacks

-- see what different attack types are there now
select type, count(*) as attack_count
from PortfolioProject..Sharks
group by Type
order by attack_count desc


-- change misspellings and other common words to the same 

-- unconfirmed, unvertifies, ?, under investigation, questionable to invalid 
BEGIN TRANSACTION

UPDATE Sharks
SET Type = 
  CASE 
	WHEN Type = 'Unconfirmed' THEN 'Invalid'
	WHEN Type = 'Unverified' THEN 'Invalid'
	WHEN Type = '?' THEN 'Invalid'
	WHEN Type = 'Under investigation' THEN 'Invalid'
	WHEN Type = 'Questionable' THEN 'Invalid'
	WHEN Type = 'Boat' THEN 'Watercraft'
    ELSE Type
  END

COMMIT 

-- fill in the NULL values to invalid
BEGIN TRANSACTION

UPDATE Sharks
SET Type = 'Invalid'
WHERE Type IS NULL;

COMMIT

--------------------------------------------------------------------------------
-- Clean up the fatal Y, N, and Unknown 

BEGIN TRANSACTION

UPDATE Sharks
SET [Fatal (Y/N)] = 
  CASE 
	WHEN [Fatal (Y/N)] = 'y X 2' THEN 'Y'
	WHEN [Fatal (Y/N)] = 'F' THEN 'Y'
	WHEN [Fatal (Y/N)] = 'Nq' THEN 'N'
	WHEN [Fatal (Y/N)] = '2017.0' THEN 'Y'
    ELSE [Fatal (Y/N)]
  END

select [Fatal (Y/N)], count(*)
from PortfolioProject..Sharks
group by [Fatal (Y/N)]

COMMIT

-----------------------------------------------------------------------------
-- change the gender column 
BEGIN TRANSACTION

UPDATE Sharks
SET Sex = 
  CASE 
	WHEN Sex = 'N' THEN 'Unknown'
	WHEN Sex = 'M x 2' THEN 'M'
	WHEN Sex = 'lli' THEN 'Unknown'
	WHEN Sex = '.' THEN 'Unknown'
    ELSE Sex
  END

select Sex, count(*)
from PortfolioProject..Sharks
group by Sex

COMMIT 

-- fill in the NULL values to invalid
BEGIN TRANSACTION

UPDATE Sharks
SET Sex = 'Unknown'
WHERE Sex IS NULL;

select Sex, count(*)
from PortfolioProject..Sharks
group by Sex

COMMIT


---------------------------------------------------------------
-- ACTIVITY 
select Activity, count(*) AS Activity_count
from PortfolioProject..Sharks
group by Activity
--having activity LIKE '%foil%'
order by Activity_count desc

BEGIN TRANSACTION

UPDATE Sharks
SET Activity = 
  CASE 
	WHEN Activity LIKE '%swimming%' THEN 'Swimming'
	WHEN Activity LIKE '%Swmming%' THEN 'Swimming'
	WHEN Activity LIKE '%Dive%' THEN 'Diving'
	WHEN Activity LIKE '%Fihing%' THEN 'Fishing'
	WHEN Activity LIKE '%Spear%' THEN 'Spearfishing'
	WHEN Activity LIKE '%Surf%' THEN 'Surfing'
	WHEN Activity LIKE '%Fish%' THEN 'Fishing'
	WHEN Activity LIKE '%Washing%' THEN 'Cleaning'
	WHEN Activity LIKE '%Washed%' THEN 'Washed'
	WHEN Activity LIKE '%Paddle%' THEN 'Paddleboarding'
	WHEN Activity LIKE '%paddling%' THEN 'Paddling'
	WHEN Activity LIKE '%Standing%' THEN 'Standing'
	WHEN Activity LIKE '%Snork%' THEN 'Snorkling'
	WHEN Activity LIKE '%foil%' THEN 'Foil Board'
	WHEN Activity LIKE '%sitting%' THEN 'Sitting'
	WHEN Activity LIKE '%disaster%' THEN 'Sea Disaster'
	WHEN Activity LIKE '%row%' THEN 'Rowing'
	WHEN Activity LIKE '%sailing%' THEN 'Sailing'
	WHEN Activity LIKE '%play%' THEN 'Playing'
	WHEN Activity LIKE '%murde%' THEN 'Murder Victim'
	WHEN Activity LIKE '%jump%' THEN 'Suicide'
	WHEN Activity LIKE '%float%' THEN 'Floating'
	WHEN Activity LIKE '%resc%' THEN 'Rescuing'
	WHEN Activity LIKE '%fell%' THEN 'Fall'
	WHEN Activity LIKE '%feed%' THEN 'Feeding Sharks'
	WHEN Activity LIKE '%.%' THEN 'Unknown'
	WHEN Activity LIKE '%boat%' THEN 'Boat'
	WHEN Activity LIKE '%wreck%' THEN 'Ship Wreck'
	WHEN Activity LIKE '%shark%' THEN 'Close contact with Shark'
	WHEN Activity LIKE '%airc%' THEN 'Aircraft'
	WHEN Activity LIKE '%bath%' THEN 'Bathing'
	WHEN Activity LIKE '%film%' THEN 'Filming'
	WHEN Activity LIKE '%plane%' THEN 'Aircraft'
	WHEN Activity LIKE '%clean%' THEN 'Cleaning'
	WHEN Activity LIKE '%ship%' THEN 'Ship'
	WHEN Activity LIKE '%hunt%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%crab%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%shrimp%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%scal%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%prawn%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%opi%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%line%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%net%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%collect%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%oys%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%lob%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%clam%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%sard%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%turtle%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%croc%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%wha%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%fish%' THEN 'Hunting, fishing, clams, crabs'
	WHEN Activity LIKE '%scull%' THEN 'boat'
	WHEN Activity LIKE '%wad%' THEN 'Wading'
	WHEN Activity LIKE '%Water%' THEN 'Hunting fish, clams, crabs'
	WHEN Activity LIKE '%board%' THEN 'Foil, paddle, kite boards'
	WHEN Activity LIKE '%Wal%' THEN 'Walking'
	WHEN Activity LIKE '%yach%' THEN 'Yacht'
	WHEN Activity LIKE '%swim%' THEN 'Swimming'
	WHEN Activity LIKE '%splash%' THEN 'Splashing'
	WHEN Activity LIKE '%riv%' THEN 'River'
	WHEN Activity LIKE '%fish%' THEN 'Hunting, fishing, clams, crabs'
	WHEN Activity LIKE '%kay%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%row%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%kay%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%diving%' THEN 'Diving'
	WHEN Activity LIKE '%bath%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%play%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%float%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%snork%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%wading%' THEN 'Bathing, Playing, floating, snorking, eading'
	WHEN Activity LIKE '%splashing%' THEN 'Bathing, Playing, floating, snorking, eading'
	WHEN Activity LIKE '%fall%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%sitting%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%standing%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%walk%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%exerc%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Paddleboarding%' THEN 'Foil, paddle, kite boards'
	WHEN Activity LIKE '%paddling%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%Canoeing%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%sailing%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%fall%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%ship%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%sea%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%shark%' THEN 'Feeding and close contact with shark'
	WHEN Activity LIKE '%Yacht%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Bathing, Playing, floating, snorking, eading%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%Boat%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Kayak, rowing, boat, Yacht, canoe, sailing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%canoe%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Lifesaving drill%' THEN 'Rescuing'
	WHEN Activity LIKE '%Lifesaving exhibition%' THEN 'Rescuing'
	WHEN Activity LIKE '%Kayak, rowing, Yacht, canoe, sailing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Ocean racing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Cruising%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Jet skiing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Pulling raft out to ride to shore%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Attempting to fix motor%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Jet skiing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Pulling raft out to ride to shore%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Attempting to fix motor%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%Hiking on the beach%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Riding horseback across the creek%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Crawling%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Sightseeing%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Sight-seeing%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Bending over%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Gathering shells%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Stamding%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Attempting to attract dolphins%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Photo shoot%' THEN 'Filming'
	WHEN Activity LIKE '%Batin%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%Kayak, rowing, boat, yatch, canoe, sailing%' THEN 'Kayak, rowing, Yacht, canoe, sailing'
	WHEN Activity LIKE '%the%' THEN 'Boat, ship, Yacht, sea disaster'
    ELSE Activity
  END


select Activity, count(*) AS Activity_count
from PortfolioProject..Sharks
group by Activity
--having activity LIKE '%foil%'
order by Activity_count desc


Commit


BEGIN TRANSACTION
UPDATE Sharks
SET Activity = 
  CASE 
	WHEN Activity LIKE '%Columbian petrol barge Rio Atrato burned and sank%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Escaping from blackbirding vessel%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%American schooner Orator capsized%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%A dhow capsized%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Schooner sank during a storm%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%3,909-ton Panamanian freighter Chieh Lee sank in a typhoon%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%HBM Magpie foundered in a squall%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Arsinoe, a French tanker%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Argentine Air Force C-54%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%43-ton schooner Irene capsized & sank%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Ferry capsized%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%German raider Kormoran was sunk in an engagement with HMAS Sydney%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Torpedoed & burning British  light cruiser with a crew of 450 men%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%NSB Meshing%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Japanese freighter Bokuyo Maru burned & sank%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Adrift on raft%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift on life raft%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift after wave swamped engine%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift on a raft%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%A group of survivors on a raft for 17-days%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift on a 4  raft for 32 days%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift on refugee raft%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift, hanging onto cushion, after his 17 skiff ran out of gas & capsized 3 miles from shore%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Spent 8 days in dinghy%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Adrift in a life jacket%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Rolled off raft%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Trying to catch a wounded bird%' THEN 'Rescuing'
	WHEN Activity LIKE '%Pulling anchor%' THEN 'Bathing, Playing, floating, snorking, raft'
	WHEN Activity LIKE '%Disappeared 11 days earlier, probable homicide victim%' THEN 'Murder Victim'
	WHEN Activity LIKE '%Riding a horse%' THEN 'Fall, standing, walking, exercise'
	WHEN Activity LIKE '%Racing ski%' THEN 'Kayak, rowing, boat, yatch, canoe, sailing'
	WHEN Activity LIKE '%SUP%' THEN 'Foil, paddle, kite boards'
	WHEN Activity LIKE '%Washed%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%On inflatable raft%' THEN 'Bathing, Playing, floating, snorking'
	WHEN Activity LIKE '%CAdrift on a 4%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Adrift, hanging onto cushion%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Cutter capsized%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Overturned skiff%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Coming ashore on a hawser%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Attempting to retreive a dinghy%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%3-masted steel barque Glenbank foundered during a cyclone%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%pêcheur de bichiques%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Leicester abandoned in a hurricane%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Towing rubber dinghy%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Gigging for flounder%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Steinhart Aquarium%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Hurricane & Tidal Wave%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Parachuted from balloon%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Parachuted into Pacific%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Angling%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Hand lining for shad%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Dropping anchor%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Dry shelling%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%No details%' THEN 'Unknown'
	WHEN Activity LIKE '%River%' THEN 'Boat, ship, Yacht, sea disaster, washed'
	WHEN Activity LIKE '%male%' THEN 'Unknown'
	WHEN Activity LIKE '%Washed%' THEN 'Boat, ship, Yacht, sea disaster, washed'
	WHEN Activity LIKE '%Hilo%' THEN 'Foil, paddle, kite boards'
	WHEN Activity LIKE '%Reaching for life preserver%' THEN 'Rescuing'
	WHEN Activity LIKE '%Dropping anchor%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%A junk foundered%' THEN 'Boat, ship, Yacht, sea disaster'
	WHEN Activity LIKE '%Filming%' THEN 'Fall, standing, walking, exercise, taking photos, cleaning'
	WHEN Activity LIKE '%Cleaning%' THEN 'Fall, standing, walking, exercise, taking photos, cleaning'
	WHEN Activity LIKE '%Adrift%' THEN 'Bathing, Playing, floating, snorking, raft'
    ELSE Activity
  END

select Activity, count(*) as count_activity
from PortfolioProject..Sharks
group by Activity
order by count_activity desc

COMMIT 

-- fill in the NULL values to invalid
BEGIN TRANSACTION

UPDATE Sharks
SET Activity = 'Unknown'
WHERE Activity IS NULL;

select Activity, count(*)
from PortfolioProject..Sharks
group by Activity

COMMIT



-- CHECK THE OTHER COLUMNS
select *
from PortfolioProject..Sharks

select Species, count(*) as country_num
from PortfolioProject..Sharks
group by Species 
order by country_num desc

-- there are 1530 results for Species 

select Injury, count(*) as country_num
from PortfolioProject..Sharks
group by Injury 
order by country_num desc

-- there are 3921 results for Injury 

select Injury, count(*) as country_num
from PortfolioProject..Sharks
group by Injury 
order by country_num desc


-- create a new column so that it can hold the body category
ALTER TABLE sharks
ADD injury_category VARCHAR(255)

UPDATE Sharks
SET injury_category = injury


select injury_category, count(*) as Injury_count
from PortfolioProject..Sharks
group by injury_category 
order by Injury_count desc


begin transaction

UPDATE Sharks
SET injury_category = 
  CASE 
	WHEN injury_category LIKE '%foot%' THEN 'Foot'
	WHEN injury_category LIKE '%hand%' THEN 'Hand'
	WHEN injury_category LIKE '%thig%' THEN 'Thigh'
	WHEN injury_category LIKE '%calf%' THEN 'Calf'
	WHEN injury_category LIKE '%Arm%' THEN 'Arm'
	WHEN injury_category LIKE '%leg%' THEN 'Leg'
	WHEN injury_category LIKE '%ankle%' THEN 'Ankle'
	WHEN injury_category LIKE '%heel%' THEN 'Heel'
	WHEN injury_category LIKE '%knee%' THEN 'Knee'
	WHEN injury_category LIKE '%heel%' THEN 'Heel'
	WHEN injury_category LIKE '%forearm%' THEN 'Arm'
	WHEN injury_category LIKE '%hip%' THEN 'Hip'
	WHEN injury_category LIKE '%finger%' THEN 'Finger'
	WHEN injury_category LIKE '%elbow%' THEN 'Elbow'
	WHEN injury_category LIKE '%buttoc%' THEN 'Buttocs'
	WHEN injury_category LIKE '%torso%' THEN 'Torso'
	WHEN injury_category LIKE '%No injury%' THEN 'Bitten equipment'
	WHEN injury_category LIKE '%abdomen%' THEN 'Abdomen'
	WHEN injury_category LIKE '%shin%' THEN 'Shin'
	WHEN injury_category LIKE '%toe%' THEN 'Toe'
	WHEN injury_category LIKE '%head%' THEN 'Head'
	WHEN injury_category LIKE '%FATAL x 2%' THEN 'FATAL'
	WHEN injury_category LIKE '%body not recovered%' THEN 'Body not recovered'
	WHEN injury_category LIKE '%shoulder%' THEN 'Shoulder'
	WHEN injury_category LIKE '%wrist%' THEN 'Wrist'
	WHEN injury_category LIKE '%chest%' THEN 'Chest'
	WHEN injury_category LIKE '%back%' THEN 'Back'
	WHEN injury_category LIKE '%mortem%' THEN 'Post Mortem'
	WHEN injury_category LIKE '%feet%' THEN 'Feet'
	WHEN injury_category LIKE '%face%' THEN 'Face'
	WHEN injury_category LIKE '%side%' THEN 'Side'
	WHEN injury_category LIKE '%lip%' THEN 'Lip'
	WHEN injury_category LIKE '%abdom%' THEN 'Abdomen'
	WHEN injury_category LIKE '%Flank%' THEN 'Flank'
	WHEN injury_category LIKE '%Presumed FATAL%' THEN 'FATAL'
	WHEN injury_category LIKE '%FATAL, PROVOKED INCIDENT%' THEN 'FATAL'
	WHEN injury_category LIKE '%FATAL, body was not recovered%' THEN 'Body not recovered'
	WHEN injury_category LIKE '%FATAL?%' THEN 'FATAL'
	WHEN injury_category LIKE '%EYE%' THEN 'Eye'
	WHEN injury_category LIKE '%neck%' THEN 'Neck'
	WHEN injury_category LIKE '%Major injuries%' THEN 'Major injuries'
	WHEN injury_category LIKE '%Severe injury%' THEN 'Severe injury'
	WHEN injury_category LIKE '%Minor injury%' THEN 'Minor injury'
	WHEN injury_category LIKE '%calves%' THEN 'Calves'
	WHEN injury_category LIKE '%remains%' THEN 'Human remains found'
	WHEN injury_category LIKE '%Hamstring%' THEN 'Hamstring'
	WHEN injury_category LIKE '%Severe injury%' THEN 'Severe injury'
	WHEN injury_category LIKE '%forearm%' THEN 'Forearm'
	WHEN injury_category LIKE '%FATAL%' THEN 'FATAL'
	WHEN injury_category LIKE '%scavenged%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Probable drowning%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Abrasion%' THEN 'Abrasions'
	WHEN injury_category LIKE '%Probable drowning / scavenging%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Unknown%' THEN 'No detail'
	WHEN injury_category LIKE '%Drowned, body scavenged by shark%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Drowned%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Drown%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Minor injuries%' THEN 'Minor injury'
	WHEN injury_category LIKE '%groin%' THEN 'buttocks'
	WHEN injury_category LIKE '%Right thumb bitten%' THEN 'Finger'
	WHEN injury_category LIKE '%Left thumb severed%' THEN 'Finger'
	WHEN injury_category LIKE '%Right cakf bitten when he fell overboard%' THEN 'Calf'
	WHEN injury_category LIKE '%Cheek%' THEN 'Face'
	WHEN injury_category LIKE '%Left thumb lacerated PROVOKED INCIDENT%' THEN 'Finger'
	WHEN injury_category LIKE '%Possible drowning / scavenging%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%Possible drowning and scavenging%' THEN 'Probable drowning & scavenging'
	WHEN injury_category LIKE '%survived%' THEN 'Survived'
    ELSE injury_category
  END

select injury_category, count(*) as count_Injury
from PortfolioProject..Sharks
group by injury_category
order by count_Injury desc

COMMIT 

UPDATE Sharks
SET injury_category = 'No details'
WHERE injury_category IS NULL;
