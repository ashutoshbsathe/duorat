SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name = "Kabul Kabul"	world_1
SELECT country.Name FROM country WHERE country.Continent = "Europe" AND country.Population > 80000	world_1
SELECT Count(*) FROM (SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "English" INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "Dutch")	world_1
SELECT DISTINCT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE countrylanguage.Language = "Chinese"AND countrylanguage.IsOfficial = "y"	world_1
SELECT country.Name, country.SurfaceArea FROM country ORDER BY country.SurfaceArea Desc LIMIT 5	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "English" INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "French"	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "English" INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "French"	world_1
SELECT countrylanguage.CountryCode, Max(countrylanguage.Percentage) FROM countrylanguage GROUP BY countrylanguage.CountryCode ORDER BY Max(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT country.Code FROM country WHERE countrylanguage.Language = "English" AND country.GovernmentForm != "Republic"	world_1
SELECT Count(DISTINCT countrylanguage.IsOfficial) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name = "Afghanistan"	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba" GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Continent = "Asia" OR country.Continent = "Europe"	world_1
SELECT Count(DISTINCT country.Continent) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "Chinese"	world_1
SELECT country.Region FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Asia"	world_1
SELECT Count(*), city.District FROM city WHERE city.Population > (SELECT Avg(city.Population) FROM city) GROUP BY city.District	world_1
SELECT country.Population, country.LifeExpectancy FROM country WHERE country.Name ="Brazil"	world_1
SELECT countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT Count(*), country.GNP FROM country WHERE country.Continent ="Asia"ORDER BY country.GNP Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Continent FROM country WHERE country.Population < (SELECT Max(country.Population) FROM country WHERE country.Continent ="African")	world_1
SELECT country.Name, Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language HAVING Count(*) > 2	world_1
SELECT Count(*) FROM country WHERE country.Name ="Ar"	world_1
SELECT country.Name FROM country WHERE country.Continent ="Asia"ORDER BY country.LifeExpectancy Asc LIMIT 1	world_1
SELECT country.Continent FROM country WHERE country.Name ="Anguilla"	world_1
SELECT country.Name FROM country ORDER BY country.Population Asc LIMIT 3	world_1
SELECT country.GovernmentForm, Avg(country.Population) FROM country GROUP BY country.GovernmentForm HAVING Avg(country.LifeExpectancy) > 72	world_1
SELECT Sum(country.Population), Max(country.GNP) FROM country WHERE country.Continent ="Asia"	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.CountryCode ORDER BY Count(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT countrylanguage.Language, Avg(countrylanguage.Percentage) FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Sum(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT Avg(country.GNP), Sum(country.Population) FROM country WHERE country.GovernmentForm ="US"	world_1
SELECT Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba"	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Continent ="y"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Population, country.Name, country.HeadOfState FROM country ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.GovernmentForm, Avg(country.LifeExpectancy) FROM country GROUP BY country.GovernmentForm HAVING Avg(country.LifeExpectancy) > 72	world_1
SELECT country.Region, country.Population FROM country WHERE country.Name ="Angola"	world_1
SELECT country.Region, country.Population FROM country WHERE country.Name ="Angola"	world_1
SELECT Sum(country.Population), Avg(country.SurfaceArea) FROM country WHERE country.Continent ="North America"AND country.SurfaceArea > 3000	world_1
SELECT city.Name FROM city WHERE city.Population ="English English"ORDER BY city.Population Desc LIMIT 1	world_1
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE country.Continent ="Europe"AND countrylanguage.Language !="English"	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Region ="Caribbean countries"	world_1
SELECT country.Code FROM country WHERE countrylanguage.Language !="English"EXCEPT SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="y"	world_1
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"AND country.Continent !="y"	world_1
SELECT country.Continent FROM country GROUP BY country.Continent ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Count(DISTINCT countrylanguage.Language) FROM countrylanguage	world_1
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population Asc LIMIT 1	world_1
SELECT Avg(country.LifeExpectancy) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language !="English"	world_1
SELECT country.Name FROM country WHERE country.IndepYear > 1950	world_1
SELECT city.Name FROM city WHERE city.Population BETWEEN 160000 AND 900000	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba"	world_1
SELECT country.Name FROM country WHERE country.IndepYear > 1950	world_1
SELECT Count(*), city.District FROM city WHERE city.Population > (SELECT Avg(city.Population) FROM city) GROUP BY city.District	world_1
SELECT country.Continent FROM country WHERE country.Name ="Anguilla"	world_1
SELECT Count(*) FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.IsOfficial ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language, countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.HeadOfState ="Beatrix"	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.GovernmentForm ="republic"GROUP BY countrylanguage.Language HAVING Count(*) = 1	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.CountryCode ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name FROM country WHERE country.SurfaceArea > (SELECT Max(country.SurfaceArea) FROM country WHERE country.Continent ="Europe")	world_1
SELECT Count(*) FROM city WHERE city.District ="Gelderland"	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language !="English"	world_1
SELECT country.Continent FROM country GROUP BY country.Continent ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Continent ="f"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Asia"	world_1
SELECT country.Name, country.Population, country.HeadOfState FROM country ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.Name FROM country WHERE country.SurfaceArea > (SELECT Max(country.SurfaceArea) FROM country WHERE country.Continent ="Europe")	world_1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent ="f"ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT Count(*) FROM (SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="Dutch")	world_1
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population Asc LIMIT 1	world_1
SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name ="Kabul"	world_1
SELECT Count(*) FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name FROM country WHERE country.Continent ="Asia"ORDER BY country.LifeExpectancy Asc LIMIT 1	world_1
SELECT countrylanguage.CountryCode FROM country WHERE countrylanguage.Language !="English"	world_1
SELECT country.Name, Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.CountryCode HAVING Count(*) >= 3	world_1
SELECT Count(DISTINCT countrylanguage.Language) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.GNPOld < 1930	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Africa"	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language !="English"	world_1
SELECT country.Population, country.LifeExpectancy FROM country WHERE country.Name ="Brazil"	world_1
SELECT Avg(country.LifeExpectancy), Sum(country.Population), country.Continent FROM country GROUP BY country.Continent HAVING Avg(country.Population) < 72	world_1
SELECT country.Name FROM country ORDER BY city.Population Desc LIMIT 3	world_1
SELECT Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Afghanistan"	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Continent ="Central Africa"	world_1
SELECT Sum(country.Population) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language !="English"	world_1
SELECT Sum(city.Population) FROM city WHERE city.District ="Gelderland"	world_1
SELECT country.Name FROM country WHERE country.Population > (SELECT Max(country.Population) FROM country WHERE country.Continent =""Africa")	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="French"	world_1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent ="f"ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name FROM country WHERE country.Continent ="Europe"AND country.Population = 80000	world_1
SELECT country.Name FROM country ORDER BY country.Population Desc LIMIT 3	world_1
SELECT country.Region FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language ="Dutch"OR countrylanguage.Language ="English"	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Code NOT IN (SELECT countrylanguage.IsOfficial FROM countrylanguage WHERE countrylanguage.Language ="English")	world_1
SELECT Count(*) FROM country WHERE country.Code NOT IN (SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="English")	world_1
SELECT Count(DISTINCT country.GovernmentForm) FROM country WHERE country.Continent ="Africa"	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Continent ="m"	world_1
SELECT countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT countrylanguage.Language FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Continent, Avg(country.LifeExpectancy), Min(country.LifeExpectancy) FROM country GROUP BY country.Continent HAVING Avg(country.LifeExpectancy) < 72	world_1
SELECT Count(DISTINCT country.Continent) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "Chinese"	world_1
