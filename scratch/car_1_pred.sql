SELECT countries.CountryName, countries.CountryId FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryId HAVING Count(*) > 1	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Accelerate > (SELECT Max(cars_data.Accelerate) FROM cars_data) ORDER BY cars_data.Horsepower Desc	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 6	car_1
SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 2 INTERSECT SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 3	car_1
SELECT Min(cars_data.Weight) FROM cars_data WHERE cars_data.Cylinders ="8"AND cars_data.Year = 1974	car_1
SELECT DISTINCT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="General Motors"OR car_makers.Maker > 3500	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Horsepower > 150	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 4	car_1
SELECT Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="American Motor Company"	car_1
SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryId HAVING Count(*) > 3 UNION SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country WHERE model_list.Model ="fiat"	car_1
SELECT Count(cars_data.Cylinders) FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId WHERE car_names.Make ="volvo"ORDER BY cars_data.Accelerate Asc LIMIT 1	car_1
SELECT Count(*), car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Maker	car_1
SELECT continents.Continent, Count(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId GROUP BY continents.Continent	car_1
SELECT car_makers.Maker, model_list.Model FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker	car_1
SELECT car_makers.Country FROM car_makers GROUP BY car_makers.Country HAVING Count(*) > 2	car_1
SELECT Count(*) FROM countries	car_1
SELECT DISTINCT model_list.Model FROM model_list WHERE cars_data.Year > 1980	car_1
SELECT car_makers.Maker, car_makers.FullName, Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id GROUP BY car_makers.Maker	car_1
SELECT Count(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId WHERE countries.CountryName ="France"	car_1
SELECT car_makers.Id, car_makers.Maker FROM car_names WHERE cars_data.Horsepower > (SELECT cars_data.Horsepower FROM cars_data JOIN car_makers)	car_1
SELECT Avg(cars_data.Horsepower) FROM cars_data WHERE cars_data.Year < 1980	car_1
SELECT continents.Continent, countries.Continent, Count(*) FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY continents.Continent	car_1
SELECT DISTINCT car_makers.Maker FROM car_makers WHERE cars_data.Year = 1970	car_1
SELECT Avg(cars_data.MPG) FROM cars_data WHERE cars_data.Cylinders = 4	car_1
SELECT Avg(cars_data.Edispl) FROM cars_data	car_1
SELECT countries.CountryName FROM countries WHERE countries.CountryId NOT IN (SELECT car_makers.Country FROM car_makers)	car_1
SELECT model_list.Model FROM model_list WHERE cars_data.Weight < (SELECT Avg(cars_data.Weight) FROM cars_data)	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Year = 1980	car_1
SELECT car_names.MakeId, car_names.Make FROM car_names JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE cars_data.Cylinders BETWEEN (SELECT Min(cars_data.Horsepower) FROM cars_data) AND 4	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Year = 1980	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 6	car_1
SELECT model_list.Model FROM model_list GROUP BY model_list.Model ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT Count(*), car_makers.Maker, car_makers.Maker FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id GROUP BY car_makers.Maker	car_1
SELECT DISTINCT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="General Motors"OR car_makers.Maker > 3500	car_1
SELECT cars_data.Accelerate FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId WHERE car_names.Make ="amc hornet sportabout"	car_1
SELECT Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="American Motor"	car_1
SELECT DISTINCT countries.CountryName, countries.CountryId FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country	car_1
SELECT Max(cars_data.Accelerate), cars_data.Cylinders FROM cars_data GROUP BY cars_data.Cylinders	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Horsepower > 150	car_1
SELECT DISTINCT cars_data.Year FROM cars_data WHERE cars_data.Weight < 4000 INTERSECT SELECT cars_data.Year FROM cars_data WHERE cars_data.Weight > 3000	car_1
SELECT Avg(cars_data.Weight), cars_data.Year FROM cars_data GROUP BY cars_data.Year	car_1
SELECT cars_data.Horsepower FROM cars_data ORDER BY cars_data.Accelerate Desc LIMIT 1	car_1
SELECT Count(*) FROM continents	car_1
SELECT model_list.Model FROM model_list JOIN car_names ORDER BY cars_data.Horsepower Asc LIMIT 1	car_1
SELECT Count(*) FROM countries	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Accelerate > (SELECT Max(cars_data.Accelerate) FROM cars_data) ORDER BY cars_data.Horsepower Desc	car_1
SELECT continents.Continent, Count(*) FROM continents GROUP BY continents.Continent	car_1
SELECT car_makers.Maker FROM car_makers WHERE cars_data.Year = 1970	car_1
SELECT car_makers.Maker, car_makers.FullName, Count(*) FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Maker, car_makers.FullName	car_1
SELECT model_list.Model FROM model_list JOIN car_names ON model_list.Model = car_names.Model GROUP BY car_names.Model ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT model_list.Model FROM cars_data WHERE cars_data.Cylinders ="4"ORDER BY cars_data.Horsepower Desc LIMIT 1	car_1
SELECT countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY car_makers.Country ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT model_list.Model FROM model_list JOIN car_names ORDER BY cars_data.MPG Desc LIMIT 1	car_1
SELECT Count(*) FROM countries WHERE countries.CountryName ="usa"	car_1
SELECT countries.CountryName FROM countries WHERE countries.CountryId NOT IN (SELECT car_makers.Country FROM car_makers)	car_1
SELECT car_makers.Maker, model_list.Model FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker	car_1
SELECT continents.Continent, continents.Continent, Count(*) FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY countries.Continent	car_1
SELECT Avg(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 4	car_1
SELECT cars_data.Accelerate FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId WHERE car_names.Make ="amc hornet sportabout"	car_1
SELECT countries.CountryId FROM countries JOIN car_makers ON countries.Continent = car_makers.Country WHERE continents.Continent ="europe"GROUP BY countries.CountryId HAVING Count(*) >= 3	car_1
SELECT Count(*) FROM (SELECT car_makers.Country FROM car_makers GROUP BY car_makers.Country HAVING Count(*) > 2)	car_1
SELECT car_makers.Maker, car_makers.FullName, model_list.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY model_list.Maker HAVING Count(*) > 3	car_1
SELECT car_names.Make, cars_data.Year FROM car_names JOIN cars_data ON car_names.MakeId = cars_data.Id ORDER BY cars_data.Year Asc LIMIT 1	car_1
SELECT model_list.Model FROM cars_data WHERE cars_data.Cylinders = 4 ORDER BY cars_data.Horsepower Desc LIMIT 1	car_1
SELECT Avg(cars_data.Weight), cars_data.Year FROM cars_data GROUP BY cars_data.Year	car_1
SELECT model_list.Model FROM model_list WHERE cars_data.Weight < (SELECT Avg(cars_data.Weight) FROM cars_data)	car_1
SELECT Max(cars_data.Horsepower), Sum(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 3	car_1
SELECT Max(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980	car_1
SELECT model_list.Model FROM model_list WHERE car_makers.Maker < 3500 EXCEPT SELECT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="Ford0"	car_1
SELECT car_makers.Maker, model_list.Maker FROM model_list JOIN car_makers ON car_makers.Id = model_list.Maker GROUP BY model_list.Maker HAVING Count(*) > 3	car_1
