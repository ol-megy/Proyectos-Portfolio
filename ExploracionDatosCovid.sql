--Exploración de datos con SQL.

SELECT * FROM COVID..CovidDeaths
ORDER BY 3, 4;


--Se aplica el comando SELECT para seleccionar las columnas que se utilizarán de la tabla CovidDeaths.

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM COVID..CovidDeaths
ORDER BY 1,2;

--Analizando Casos totales vs Muertes totales
--La última columna expresa en porcentaje la tasa de mortalidad estimada del virus.
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS MORTALIDAD
FROM COVID..CovidDeaths
ORDER BY 1,2;

--A continuación se hace el mismo cálculo, pero exclusivamente en relación a la cantidad de casos y de muertes en Argentina.
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS MORTALIDAD
FROM COVID..CovidDeaths
WHERE location LIKE 'Argentina'
ORDER BY 1,2;

--Analizando Población vs Casos totales en Argentina
--En este caso la última columna, llamada incidencia, expresa cuál es el porcentaje de la población argentina que recibió un diagnóstico positivo de COVID-19.
SELECT location, date, population, total_cases, (total_cases/population)*100 AS INCIDENCIA
FROM COVID..CovidDeaths
WHERE location LIKE 'Argentina'
ORDER BY 1,2;


--Buscando los países con la tasa de infección más elevada (ordenados de mayor a menor).
SELECT location, population, MAX(total_cases) as maximo_casos, MAX((total_cases/population))*100 AS INCIDENCIA
FROM COVID..CovidDeaths
GROUP BY Location, population
ORDER BY INCIDENCIA DESC;

--Buscando los países con la mayor tasa de mortalidad por COVID.-
SELECT location, population, MAX(total_deaths) as muertes_totales, MAX((total_deaths/population))*100 AS tasa_mortalidad
FROM COVID..CovidDeaths
GROUP BY Location, population
ORDER BY tasa_mortalidad DESC;


--La columna 'location' del dataset contiene no solo a los distintos países sino las distintas regiones/continentes y la categoría "World" (siendo NULL la columna 'continent' en dichos casos)
--La siguiente query arroja las muertes a nivel global y por región.
SELECT location, max(total_deaths) as muertes_totales
FROM COVID..CovidDeaths
WHERE continent is NULL
GROUP BY location
ORDER BY muertes_totales DESC;

--Analizando los números (casos, muertes, tasa de mortalidad) a nivel global por fecha:
SELECT date as fecha, SUM(total_cases) as casos_totales, SUM(total_deaths) as muertes_totales, SUM(total_deaths)/SUM(total_cases) *100 as mortalidad_global
FROM COVID..CovidDeaths
GROUP BY date
ORDER BY date;

--Número de casos, muertes y tasa de mortalidad a nivel global:
SELECT SUM(total_cases) as casos_totales, SUM(total_deaths) as muertes_totales, SUM(total_deaths)/SUM(total_cases) *100 as mortalidad_global
FROM COVID..CovidDeaths;

--Incorporando los datos relativos a la vacunación, se hace un JOIN con la tabla CovidVaccinations
SELECT * FROM COVID..CovidDeaths dea
JOIN COVID..CovidVaccinations vac
ON dea.location=vac.location
and dea.date=vac.date;

--Analizando la relación población vs personas vacunadas en cada país (Usando CTE)

WITH PobvsVac (continente, pais, fecha, poblacion, nuevas_vacunaciones, vacunados_acumulado)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location order by dea.location, dea.date) as vacunados_acumulado
FROM COVID..CovidDeaths dea 
JOIN COVID..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
WHERE dea.continent is not null 
)
SELECT *, (vacunados_acumulado/poblacion)*100 as porcentaje_vacunados
FROM PobvsVac;

--Ahora se seleccionan los mismos datos, pero usando una TABLA TEMPORAL:

DROP TABLE if exists #PorcentajePoblacionVacunada
CREATE TABLE #PorcentajePoblacionVacunada
(
continente nvarchar(255),
pais nvarchar(255),
fecha datetime,
poblacion numeric,
nuevos_vacunados numeric,
vacunados_acumulado numeric
)
INSERT INTO #PorcentajePoblacionVacunada
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location order by dea.location, dea.date) 
FROM COVID..CovidDeaths dea 
JOIN COVID..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
WHERE dea.continent is not null 

SELECT *, (vacunados_acumulado/poblacion)*100 as porcentaje_vacunados
FROM #PorcentajePoblacionVacunada
ORDER BY pais, fecha;


--Creando VIEW para almacenar datos y utilizarlos en futuras visualizaciones

CREATE VIEW PorcentajePoblacionVacunada as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location order by dea.location, dea.date) as vacunados_acumulado
FROM COVID..CovidDeaths dea 
JOIN COVID..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
WHERE dea.continent is not null;


