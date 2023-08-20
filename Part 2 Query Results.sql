SHOW TABLES;

# 1. Retrieve all country languages that are official and spoken in either Spain or France.
 
WITH language_IsOfficial AS (
SELECT c.Name AS country_Name, c.code, cl.countrycode, cl.IsOfficial, cl.language
FROM country AS c
LEFT JOIN countrylanguage AS cl
ON cl.countrycode = c.code
WHERE cl.IsOfficial = "T")

SELECT country_Name, language, IsOfficial
FROM language_IsOfficial
WHERE country_Name = "Spain"
OR country_Name = "France";


#2. Retrieve all country languages where the percentage of speakers is unknown (NULL).

SELECT Name AS country, Language, percentage AS PercentSpeakers_Null
FROM country AS c
LEFT JOIN countrylanguage AS cl
ON cl.countrycode = c.code
WHERE percentage IS NULL;
	# No known country languages where the percentage of Speakers are unknown


# 3. Retrieve all country languages that are spoken in countries where the official language is not English.

SELECT Name AS country, Language, IsOfficial AS official_language
FROM country
LEFT JOIN countrylanguage 
ON countrycode = code
WHERE code IN (
	SELECT countrycode
	FROM countrylanguage
	WHERE IsOfficial = 'T'
	AND language != 'English')
LIMIT 10;


# 4. Retrieve all country languages that are not official languages of any country.

SELECT Name AS country, Language, IsOfficial AS official_language
FROM country
LEFT JOIN countrylanguage
ON countrycode = code
WHERE IsOfficial != 'T'
LIMIT 10;


# 5. Retrieve all countries with their corresponding capital city and official language.

SELECT c.Name AS country, n.Name AS capital_city, l.Language, IsOfficial AS official_language
FROM country AS c
LEFT JOIN countrylanguage AS l
ON c.code = l.countrycode
LEFT JOIN city as n
ON l.countrycode = n.countrycode
WHERE IsOfficial = 'T'
LIMIT 10;


# 6. Show the number of countries in each continent.

SELECT continent, COUNT(Name) AS country_count
FROM country
GROUP BY continent
LIMIT 10;


#7. Which cities have a population greater than the average population of their corresponding countries? List the cities along with their corresponding countries and populations indescending order of their populations

SELECT c.Name AS country, 
n.Name AS city, 
c.population AS Country_pop, 
AVG(c.population) AS country_popAVG,
n.population AS city_pop, 
AVG(n.population) AS city_popAVG
FROM country AS c
LEFT JOIN city as n
ON c.code = n.countrycode
GROUP BY n.Name, c.Name
HAVING AVG(n.population) > AVG(c.population)
LIMIT 10;












