SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null -- to remove where continent is missing and we exclude them
ORDER BY 3, 4;

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3, 4;

-- Select the data that we will be using 
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2;


-- looking at the total cases vs total deaths 
-- shows the likelyhood of dying if you contract covid in your contry 
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
AND continent is not null
ORDER BY 1,2;

SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'Norway'
AND continent is not null
ORDER BY 1,2;


-- looking at the toal cases vs population 
-- shows what percentage of populaton got Covid 
SELECT location, date, population, total_cases, (total_cases/population)*100 AS InfectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%' 
AND continent is not null
ORDER BY 1,2;

SELECT location, date, population, total_cases, (total_cases/population)*100 AS InfectedPercentage
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2;


-- looking at countries with the higest infection rate compared to population
SELECT location, population, MAX(total_cases) AS higestInfectionCount, MAX((total_cases/population))*100 AS InfectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
--WHERE location like '%states%'
GROUP BY location, population
ORDER BY InfectedPercentage DESC

-- Showing the countries with the highest death count per population
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
--WHERE location like '%states%'
GROUP BY location
ORDER BY TotalDeathCount DESC




-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing the countries with the highest death count per population
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount DESC -- this is the correct way of doing it, but we will use the other way in the walkthrough

SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC 


-- showing continents with the highest deat count per population 
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC 



-- Global numbers 
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
ORDER BY 1,2




-- join the tables together ON LOCATION AND DATE
SELECT * 
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date


-- Looking at the total population vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100 -- not working 
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2,3


-- use a CTE
WITH PopvsVac(continent, Location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
	SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(convert(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
	--, (RollingPeopleVaccinated/population)*100
	FROM PortfolioProject..CovidDeaths dea
	JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location 
		AND dea.date = vac.date
	WHERE dea.continent is not null
--	ORDER BY 1,2,3
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac



-- TEMP TABLE 
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255), 
Date datetime,
Population numeric, 
New_vaccination numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null
--	ORDER BY 1,2,3

SELECT *, (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated




-- CREATE A VIEW TO STORE DATA FOR LATER VISUALIZATION
CREATE VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 1,2,3

-- you can query of the view
select * 
from PercentPopulationVaccinated
