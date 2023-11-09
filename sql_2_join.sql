# SQL Join exercise
#

# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT city.Name
FROM city
WHERE city.Name
LIKE 'ping%'
ORDER BY city.Population
ASC;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT city.Name
FROM city
WHERE city.Name
LIKE 'ran%'
ORDER BY city.Population
DESC;

# 3: Count all cities

SELECT COUNT(city.Id)
FROM city;

# 4: Get the average population of all cities

SELECT AVG(city.Population)
FROM city;

# 5: Get the biggest population found in any of the cities

SELECT MAX(city.Population)
FROM city;

# 6: Get the smallest population found in any of the cities

SELECT MIN(city.Population)
FROM city;

# 7: Sum the population of all cities with a population below 10000

SELECT SUM(city.Population)
FROM city
WHERE city.Population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM

SELECT COUNT(city.Id)
FROM city
WHERE city.CountryCode = 'moz'
OR city.CountryCode = 'vnm';

# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT COUNT(city.Name)
FROM city
WHERE city.CountryCode ='moz'
UNION
SELECT COUNT(city.Name)
FROM city
WHERE city.CountryCode ='vnm';

# 10: Get average population of cities in MOZ and VNM

SELECT AVG(city.Population)
FROM city
WHERE city.CountryCode = 'moz'
UNION
SELECT AVG(city.Population)
FROM city
WHERE city.CountryCode = 'moz';

# 11: Get the countrycodes with more than 200 cities

SELECT city.CountryCode
FROM city
GROUP BY city.CountryCode
HAVING COUNT(city.ID) > 200;

# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT city.CountryCode
FROM city
GROUP BY city.CountryCode
HAVING COUNT(city.ID) > 200
ORDER BY COUNT(city.ID) ASC;

# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

SELECT countrylanguage.Language
FROM city
INNER JOIN countrylanguage
ON countrylanguage.CountryCode = city.CountryCode
WHERE city.Population
BETWEEN 400 AND 500;

# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT city.Name, countrylanguage.Language
FROM city
INNER JOIN countrylanguage
ON countrylanguage.CountryCode = city.CountryCode
WHERE city.Population
BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT city.Name
FROM city
WHERE city.CountryCode = 
(SELECT city.CountryCode
FROM city
WHERE city.Population = '122199');

# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT city.Name
FROM city
WHERE city.CountryCode = 
(SELECT city.CountryCode
FROM city
WHERE city.Population = '122199')
AND city.Population != '122199';

# 17: What are the city names in the country where Luanda is capital?

SELECT city.Name
FROM city
INNER JOIN country
ON country.Code = city.CountryCode
WHERE city.CountryCode = 
(SELECT country.Code
FROM country
WHERE country.Capital = (SELECT city.Id
							FROM city
							WHERE city.Name = 'Luanda'));

# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT city.Name
FROM city
INNER JOIN country
ON country.Code = city.CountryCode
WHERE city.CountryCode IN 
(SELECT country.Code
FROM country
WHERE country.Capital IN (SELECT city.Id
							FROM city
							WHERE city.CountryCode IN (SELECT country.Code
														FROM country
                                                        WHERE country.Region = (SELECT country.Region
																				FROM country
                                                                                WHERE country.Code = (SELECT city.CountryCode
																									FROM city
                                                                                                    WHERE city.ID = (SELECT city.Id
																														FROM city
                                                                                                                        WHERE city.Name = 'Yaren'))))))
                                                                                                                        AND country.Capital = city.ID;

# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT DISTINCT(countrylanguage.Language)
FROM countrylanguage
INNER JOIN city
ON city.CountryCode = countrylanguage.CountryCode
WHERE city.CountryCode IN 
(SELECT country.Code
							FROM country
                            WHERE country.Region = (SELECT country.Region
													FROM country
                                                    WHERE country.Code = (SELECT city.CountryCode
																			FROM city
                                                                            WHERE city.ID = (SELECT city.Id
																							FROM city
                                                                                            WHERE city.Name = 'Riga'))));

# 20: Get the name of the most populous city

SELECT city.Name
FROM city
WHERE city.Population =
(SELECT MAX(city.Population)
FROM city);

