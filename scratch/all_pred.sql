SELECT Count(*) FROM singer	concert_singer
SELECT Count(*) FROM singer	concert_singer
SELECT singer.Name, singer.Country, singer.Age FROM singer ORDER BY singer.Age Desc	concert_singer
SELECT singer.Name, singer.Country, singer.Age FROM singer ORDER BY singer.Age Desc	concert_singer
SELECT Avg(singer.Age), Min(singer.Age), Max(singer.Age) FROM singer WHERE singer.Country ="France"	concert_singer
SELECT Avg(singer.Age), Min(singer.Age), Max(singer.Age) FROM singer WHERE singer.Country ="yes"	concert_singer
SELECT singer.Song_Name, singer.Song_release_year FROM singer ORDER BY singer.Age Asc LIMIT 1	concert_singer
SELECT singer.Song_Name, singer.Song_release_year FROM singer ORDER BY singer.Age Asc LIMIT 1	concert_singer
SELECT DISTINCT singer.Country FROM singer WHERE singer.Age > 20	concert_singer
SELECT DISTINCT singer.Country FROM singer WHERE singer.Age > 20	concert_singer
SELECT singer.Country, Count(*) FROM singer GROUP BY singer.Country	concert_singer
SELECT singer.Country, Count(*) FROM singer GROUP BY singer.Country	concert_singer
SELECT singer.Song_Name FROM singer WHERE singer.Age > (SELECT Avg(singer.Age) FROM singer)	concert_singer
SELECT singer.Song_Name FROM singer WHERE singer.Age > (SELECT Avg(singer.Age) FROM singer)	concert_singer
SELECT stadium.Location, stadium.Name FROM stadium WHERE stadium.Capacity BETWEEN 5000 AND 10000	concert_singer
SELECT stadium.Location, stadium.Name FROM stadium WHERE stadium.Capacity BETWEEN 5000 AND 10000	concert_singer
SELECT Max(stadium.Capacity), Avg(stadium.Average) FROM stadium	concert_singer
SELECT Avg(stadium.Average), Max(stadium.Capacity) FROM stadium	concert_singer
SELECT stadium.Name, stadium.Capacity FROM stadium ORDER BY Avg(stadium.Average) Desc LIMIT 1	concert_singer
SELECT stadium.Name, stadium.Capacity FROM stadium GROUP BY stadium.Highest ORDER BY Avg(stadium.Average) Desc LIMIT 1	concert_singer
SELECT Count(*) FROM concert WHERE concert.Year = 2014 OR concert.Year = 2015	concert_singer
SELECT Count(*) FROM concert WHERE concert.Year = 2014 OR concert.Year = 2015	concert_singer
SELECT stadium.Name, Count(*) FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID GROUP BY concert.Stadium_ID	concert_singer
SELECT stadium.Name, Count(*) FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID GROUP BY concert.Stadium_ID	concert_singer
SELECT stadium.Name, stadium.Capacity FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID WHERE concert.Year >= 2014 GROUP BY concert.Stadium_ID ORDER BY Count(*) Desc LIMIT 1	concert_singer
SELECT stadium.Name, stadium.Capacity FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID WHERE concert.Year > 2013 GROUP BY concert.Stadium_ID ORDER BY Count(*) Desc LIMIT 1	concert_singer
SELECT concert.Year FROM concert GROUP BY concert.Year ORDER BY Count(*) Desc LIMIT 1	concert_singer
SELECT concert.Year FROM concert GROUP BY concert.Year ORDER BY Count(*) Desc LIMIT 1	concert_singer
SELECT stadium.Name FROM stadium WHERE stadium.Stadium_ID NOT IN (SELECT concert.Stadium_ID FROM concert)	concert_singer
SELECT stadium.Name FROM stadium WHERE stadium.Stadium_ID NOT IN (SELECT concert.Stadium_ID FROM concert)	concert_singer
SELECT singer.Country FROM singer WHERE singer.Age > 40 INTERSECT SELECT singer.Country FROM singer WHERE singer.Age < 30	concert_singer
SELECT stadium.Name FROM stadium EXCEPT SELECT stadium.Name FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID WHERE concert.Year = 2014	concert_singer
SELECT stadium.Name FROM stadium EXCEPT SELECT stadium.Name FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID WHERE concert.Year = 2014	concert_singer
SELECT concert.concert_Name, concert.Theme, Count(*) FROM singer_in_concert JOIN concert ON singer_in_concert.concert_ID = concert.concert_ID GROUP BY singer_in_concert.concert_ID	concert_singer
SELECT concert.concert_Name, concert.Theme, Count(*) FROM concert JOIN singer_in_concert ON concert.concert_ID = singer_in_concert.concert_ID GROUP BY singer_in_concert.concert_ID	concert_singer
SELECT singer.Name, Count(*) FROM concert JOIN singer_in_concert ON concert.concert_ID = singer_in_concert.Singer_ID GROUP BY singer.Singer_ID	concert_singer
SELECT singer.Name, Count(*) FROM singer_in_concert JOIN singer ON singer_in_concert.Singer_ID = singer.Singer_ID GROUP BY singer_in_concert.Singer_ID	concert_singer
SELECT singer.Name FROM singer_in_concert JOIN concert ON singer_in_concert.concert_ID = concert.concert_ID JOIN singer ON singer_in_concert.Singer_ID = singer.Singer_ID WHERE concert.Year = 2014	concert_singer
SELECT singer.Name FROM singer_in_concert JOIN singer ON singer_in_concert.Singer_ID = singer.Singer_ID JOIN concert ON singer_in_concert.concert_ID = concert.concert_ID WHERE concert.Year = 2014	concert_singer
SELECT singer.Name, singer.Country FROM singer WHERE singer.Song_Name LIKE"%Hey%"	concert_singer
SELECT singer.Name, singer.Country FROM singer WHERE singer.Song_Name LIKE"%Hey%"	concert_singer
SELECT stadium.Name, stadium.Location FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID WHERE concert.Year = 2014 INTERSECT SELECT stadium.Name, stadium.Location FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID WHERE concert.Year = 2015	concert_singer
SELECT stadium.Name, stadium.Location FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID WHERE concert.Year = 2014 INTERSECT SELECT stadium.Name, stadium.Location FROM concert JOIN stadium ON concert.Stadium_ID = stadium.Stadium_ID WHERE concert.Year = 2015	concert_singer
SELECT Count(*) FROM stadium JOIN stadium ORDER BY stadium.Capacity Desc LIMIT 1	concert_singer
SELECT Count(*) FROM concert JOIN stadium ON stadium.Stadium_ID = concert.Stadium_ID ORDER BY stadium.Capacity Desc LIMIT 1	concert_singer
SELECT Count(*) FROM Pets WHERE Pets.weight > 10	pets_1
SELECT Count(*) FROM Pets WHERE Pets.weight > 10	pets_1
SELECT Pets.weight FROM Pets ORDER BY Pets.pet_age Asc LIMIT 1	pets_1
SELECT Pets.weight FROM Pets WHERE Pets.pet_age = (SELECT Min(Pets.pet_age) FROM Pets)	pets_1
SELECT Pets.PetType, Max(Pets.weight) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT Pets.PetType, Max(Pets.weight) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT Count(*) FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Pets.pet_age > 20 OR Student.Age > 20	pets_1
SELECT Count(*) FROM Has_Pet JOIN Pets ON Has_Pet.StuID = Pets.PetID JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Student.Age > 20	pets_1
SELECT Count(*) FROM Pets JOIN Has_Pet ON Pets.PetID = Has_Pet.PetID JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Student.Sex ="F"AND Pets.PetType ="dog"	pets_1
SELECT Count(*) FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Pets.PetType ="f"AND Student.Sex ="f"	pets_1
SELECT Count(DISTINCT Pets.PetType) FROM Pets	pets_1
SELECT Count(DISTINCT Pets.PetType) FROM Pets	pets_1
SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat"OR Pets.PetType ="dog"	pets_1
SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat"OR Pets.PetType ="dog"	pets_1
SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat"INTERSECT SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="dog"	pets_1
SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID WHERE Has_Pet.PetID ="f"INTERSECT SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID WHERE Has_Pet.PetID ="m"	pets_1
SELECT Student.Major, Student.Age FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat")	pets_1
SELECT Student.Major, Student.Age FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat")	pets_1
SELECT Student.StuID FROM Student EXCEPT SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat"	pets_1
SELECT Student.StuID FROM Student EXCEPT SELECT Has_Pet.StuID FROM Has_Pet	pets_1
SELECT Student.Fname, Student.Age FROM Student WHERE Student.StuID IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="dog"EXCEPT SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat")	pets_1
SELECT Student.Fname FROM Student WHERE Student.StuID IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="dog") EXCEPT SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType ="cat"	pets_1
SELECT Pets.PetType, Pets.weight FROM Pets ORDER BY Pets.pet_age Asc LIMIT 1	pets_1
SELECT Pets.PetType, Pets.weight FROM Pets ORDER BY Pets.pet_age Asc LIMIT 1	pets_1
SELECT Pets.PetID, Pets.weight FROM Pets WHERE Pets.pet_age > 1	pets_1
SELECT Pets.PetID, Pets.weight FROM Pets WHERE Pets.pet_age > 1	pets_1
SELECT Pets.PetType, Avg(Pets.pet_age), Max(Pets.pet_age) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT Pets.PetType, Avg(Pets.pet_age), Max(Pets.pet_age) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT Pets.PetType, Avg(Pets.weight) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT Pets.PetType, Avg(Pets.weight) FROM Pets GROUP BY Pets.PetType	pets_1
SELECT DISTINCT Student.Fname, Student.Age FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID	pets_1
SELECT DISTINCT Student.Fname, Student.Age FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet)	pets_1
SELECT Pets.PetID FROM Pets JOIN Has_Pet ON Pets.PetID = Has_Pet.PetID JOIN Student ON Student.StuID = Has_Pet.StuID WHERE Student.LName ="Smith"	pets_1
SELECT Pets.PetID FROM Pets JOIN Has_Pet ON Pets.PetID = Has_Pet.PetID JOIN Student ON Student.StuID = Has_Pet.StuID WHERE Student.LName ="Smith"	pets_1
SELECT Count(*), Has_Pet.StuID FROM Has_Pet GROUP BY Has_Pet.StuID	pets_1
SELECT Count(*), Has_Pet.StuID FROM Has_Pet GROUP BY Has_Pet.StuID	pets_1
SELECT Student.Fname, Student.Sex FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID GROUP BY Has_Pet.StuID HAVING Count(*) > 1	pets_1
SELECT Student.Fname, Student.Sex FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID GROUP BY Has_Pet.StuID HAVING Count(*) > 1	pets_1
SELECT Student.LName FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.pet_age = 3	pets_1
SELECT Student.LName FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.PetID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.pet_age = 3	pets_1
SELECT Avg(Student.Age) FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet)	pets_1
SELECT Avg(Student.Age) FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet)	pets_1
SELECT Count(*) FROM continents	car_1
SELECT Count(*) FROM continents	car_1
SELECT continents.Continent, continents.Continent, Count(*) FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY countries.Continent	car_1
SELECT continents.Continent, countries.Continent, Count(*) FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY continents.Continent	car_1
SELECT Count(*) FROM countries	car_1
SELECT Count(*) FROM countries	car_1
SELECT car_makers.Maker, car_makers.FullName, Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id GROUP BY car_makers.Maker	car_1
SELECT car_makers.Maker, car_makers.FullName, Count(*) FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Maker, car_makers.FullName	car_1
SELECT model_list.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId ORDER BY cars_data.Horsepower Asc LIMIT 1	car_1
SELECT model_list.Model FROM model_list JOIN car_names ORDER BY cars_data.Horsepower Asc LIMIT 1	car_1
SELECT model_list.Model FROM model_list WHERE cars_data.Weight < (SELECT Avg(cars_data.Weight) FROM cars_data)	car_1
SELECT model_list.Model FROM model_list WHERE cars_data.Weight < (SELECT Avg(cars_data.Weight) FROM cars_data)	car_1
SELECT car_makers.Maker FROM car_makers WHERE cars_data.Year = 1970	car_1
SELECT DISTINCT car_makers.Maker FROM car_makers WHERE cars_data.Year = 1970	car_1
SELECT car_names.Make, cars_data.Year FROM car_names JOIN cars_data ON car_names.MakeId = cars_data.Id ORDER BY cars_data.Year Asc LIMIT 1	car_1
SELECT car_makers.Maker, cars_data.Year FROM car_makers ORDER BY cars_data.Year Asc LIMIT 1	car_1
SELECT DISTINCT model_list.Model FROM model_list WHERE cars_data.Year > 1980	car_1
SELECT DISTINCT model_list.Model FROM model_list WHERE cars_data.Year > 1980	car_1
SELECT continents.Continent, Count(*) FROM continents GROUP BY continents.Continent	car_1
SELECT continents.Continent, Count(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId GROUP BY continents.Continent	car_1
SELECT countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryName ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY car_makers.Country ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT Count(*), car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Maker	car_1
SELECT Count(*), car_makers.Maker, car_makers.Maker FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id GROUP BY car_makers.Maker	car_1
SELECT cars_data.Accelerate FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId WHERE car_names.Make ="amc hornet sportabout"	car_1
SELECT cars_data.Accelerate FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId WHERE car_names.Make ="amc hornet sportabout"	car_1
SELECT Count(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId WHERE countries.CountryName ="france"	car_1
SELECT Count(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId WHERE countries.CountryName ="France"	car_1
SELECT Count(*) FROM countries WHERE countries.CountryName ="usa"	car_1
SELECT Count(*) FROM model_list	car_1
SELECT Avg(cars_data.MPG) FROM cars_data WHERE cars_data.Cylinders = 4	car_1
SELECT Avg(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 4	car_1
SELECT Min(cars_data.Weight) FROM cars_data WHERE cars_data.Cylinders ="8"AND cars_data.Year = 1974	car_1
SELECT Min(cars_data.Weight) FROM cars_data WHERE cars_data.Cylinders ="8"AND cars_data.Year = 1974	car_1
SELECT car_makers.Maker, model_list.Model FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker	car_1
SELECT car_makers.Maker, model_list.Model FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker	car_1
SELECT DISTINCT countries.CountryName, countries.CountryId FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country	car_1
SELECT countries.CountryName, countries.CountryId FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryId HAVING Count(*) > 1	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Horsepower > 150	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Horsepower > 150	car_1
SELECT Avg(cars_data.Weight), cars_data.Year FROM cars_data GROUP BY cars_data.Year	car_1
SELECT Avg(cars_data.Weight), cars_data.Year FROM cars_data GROUP BY cars_data.Year	car_1
SELECT countries.CountryId FROM countries JOIN car_makers ON countries.Continent = car_makers.Country WHERE continents.Continent ="europe"GROUP BY countries.CountryId HAVING Count(*) >= 3	car_1
SELECT countries.CountryName FROM countries JOIN continents ON countries.Continent = continents.ContId WHERE continents.Continent ="professor"GROUP BY countries.Continent HAVING Count(*) >= 3	car_1
SELECT Max(cars_data.Horsepower), Max(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 3	car_1
SELECT Max(cars_data.Horsepower), Sum(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 3	car_1
SELECT model_list.Model FROM model_list GROUP BY model_list.ModelId ORDER BY Sum(cars_data.Horsepower) Desc LIMIT 1	car_1
SELECT model_list.Model FROM model_list JOIN car_names ORDER BY cars_data.MPG Desc LIMIT 1	car_1
SELECT Avg(cars_data.Horsepower) FROM cars_data WHERE cars_data.Year < 1980	car_1
SELECT Avg(cars_data.Horsepower) FROM cars_data WHERE cars_data.Year < 1980	car_1
SELECT Avg(cars_data.Edispl) FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId WHERE car_names.Model ="volvo"	car_1
SELECT Avg(cars_data.Edispl) FROM cars_data	car_1
SELECT cars_data.Accelerate, Max(cars_data.Accelerate) FROM cars_data GROUP BY cars_data.Cylinders	car_1
SELECT Max(cars_data.Accelerate), cars_data.Cylinders FROM cars_data GROUP BY cars_data.Cylinders	car_1
SELECT model_list.Model FROM model_list JOIN car_names ON model_list.Model = car_names.Model GROUP BY car_names.Model ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT model_list.Model FROM model_list GROUP BY model_list.Model ORDER BY Count(*) Desc LIMIT 1	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 4	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 4	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Year = 1980	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Year = 1980	car_1
SELECT Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="American Motor Company"	car_1
SELECT Count(*) FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="American Motor"	car_1
SELECT car_makers.Maker, car_makers.FullName, model_list.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY model_list.Maker HAVING Count(*) > 3	car_1
SELECT car_makers.Maker, model_list.Maker FROM model_list JOIN car_makers ON car_makers.Id = model_list.Maker GROUP BY model_list.Maker HAVING Count(*) > 3	car_1
SELECT DISTINCT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="General Motors"OR car_makers.Maker > 3500	car_1
SELECT DISTINCT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="General Motors"OR car_makers.Maker > 3500	car_1
SELECT cars_data.Year FROM cars_data WHERE cars_data.Weight BETWEEN 3000 AND 4000	car_1
SELECT DISTINCT cars_data.Year FROM cars_data WHERE cars_data.Weight < 4000 INTERSECT SELECT cars_data.Year FROM cars_data WHERE cars_data.Weight > 3000	car_1
SELECT cars_data.Horsepower FROM cars_data ORDER BY cars_data.Accelerate Desc LIMIT 1	car_1
SELECT cars_data.Horsepower FROM cars_data ORDER BY cars_data.Accelerate Desc LIMIT 1	car_1
SELECT Count(cars_data.Cylinders) FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId WHERE car_names.Make ="volvo"ORDER BY cars_data.Accelerate Asc LIMIT 1	car_1
SELECT Count(cars_data.Cylinders) FROM cars_data WHERE cars_data.Accelerate ="volvo"ORDER BY cars_data.Accelerate Asc LIMIT 1	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Accelerate > (SELECT Max(cars_data.Accelerate) FROM cars_data) ORDER BY cars_data.Horsepower Desc	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Accelerate > (SELECT Max(cars_data.Accelerate) FROM cars_data) ORDER BY cars_data.Horsepower Desc	car_1
SELECT car_makers.Country FROM car_makers GROUP BY car_makers.Country HAVING Count(*) > 2	car_1
SELECT Count(*) FROM (SELECT car_makers.Country FROM car_makers GROUP BY car_makers.Country HAVING Count(*) > 2)	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 6	car_1
SELECT Count(*) FROM cars_data WHERE cars_data.Cylinders > 6	car_1
SELECT model_list.Model FROM cars_data WHERE cars_data.Cylinders = 4 ORDER BY cars_data.Horsepower Desc LIMIT 1	car_1
SELECT model_list.Model FROM cars_data WHERE cars_data.Cylinders ="4"ORDER BY cars_data.Horsepower Desc LIMIT 1	car_1
SELECT car_makers.Id, car_makers.Maker FROM car_names WHERE cars_data.Horsepower > (SELECT cars_data.Horsepower FROM cars_data JOIN car_makers)	car_1
SELECT car_names.MakeId, car_names.Make FROM car_names JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE cars_data.Cylinders BETWEEN (SELECT Min(cars_data.Horsepower) FROM cars_data) AND 4	car_1
SELECT Max(cars_data.Horsepower) FROM cars_data WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980	car_1
SELECT Max(cars_data.MPG) FROM cars_data WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980	car_1
SELECT model_list.Model FROM model_list WHERE car_makers.Maker < 3500 EXCEPT SELECT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName ="Ford0"	car_1
SELECT DISTINCT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName < 3500 EXCEPT SELECT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.Maker ="Ford Motor"	car_1
SELECT countries.CountryName FROM countries WHERE countries.CountryId NOT IN (SELECT car_makers.Country FROM car_makers)	car_1
SELECT countries.CountryName FROM countries WHERE countries.CountryId NOT IN (SELECT car_makers.Country FROM car_makers)	car_1
SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 2 INTERSECT SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 3	car_1
SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 2 INTERSECT SELECT car_makers.Id, car_makers.Maker FROM car_makers JOIN model_list ON car_makers.Id = model_list.Maker GROUP BY car_makers.Id HAVING Count(*) >= 3	car_1
SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryId HAVING Count(*) > 3 UNION SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country WHERE model_list.Model ="fiat"GROUP BY countries.CountryId HAVING Count(*) > 3	car_1
SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country GROUP BY countries.CountryId HAVING Count(*) > 3 UNION SELECT countries.CountryId, countries.CountryName FROM countries JOIN car_makers ON countries.CountryId = car_makers.Country WHERE model_list.Model ="fiat"	car_1
SELECT airlines.Country FROM airlines WHERE airlines.Airline ="JetBlue Airways"	flight_2
SELECT airlines.Country FROM airlines WHERE airlines.Airline ="Jetblue Airways"	flight_2
SELECT airlines.Abbreviation FROM airlines WHERE airlines.Airline ="JetBlue Airways"	flight_2
SELECT airlines.Abbreviation FROM airlines WHERE airlines.Airline ="Jetblue Airways"	flight_2
SELECT airlines.Airline, airlines.Abbreviation FROM airlines WHERE airlines.Country ="USA"	flight_2
SELECT airlines.Airline, airlines.Abbreviation FROM airlines WHERE airlines.Country ="USA"	flight_2
SELECT airports.AirportCode, airports.AirportName FROM airports WHERE airports.City ="Anthony"	flight_2
SELECT airports.AirportCode, airports.AirportName FROM airports WHERE airports.City ="Anthony"	flight_2
SELECT Count(*) FROM airlines	flight_2
SELECT Count(*) FROM airlines	flight_2
SELECT Count(*) FROM airports	flight_2
SELECT Count(*) FROM airports	flight_2
SELECT Count(*) FROM flights	flight_2
SELECT Count(*) FROM flights	flight_2
SELECT airlines.Airline FROM airlines WHERE airlines.Abbreviation ="UAL"	flight_2
SELECT airlines.Airline FROM airlines WHERE airlines.Abbreviation ="UAL"	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Country ="USA"	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Country ="USA"	flight_2
SELECT airports.City, airports.Country FROM airports WHERE airports.AirportName ="Alton"	flight_2
SELECT airports.City, airports.Country FROM airports WHERE airports.AirportName ="Alton"	flight_2
SELECT airports.AirportName FROM airports WHERE airports.AirportCode ="AKO"	flight_2
SELECT airports.AirportName FROM airports WHERE airports.AirportCode ="AKO"	flight_2
SELECT airports.AirportName FROM airports WHERE airports.City ="Aberdeen"	flight_2
SELECT airports.AirportName FROM airports WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport ="APG"	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport ="APG"	flight_2
SELECT Count(*) FROM flights WHERE flights.DestAirport ="ATO"	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport ="ATO"	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM airports JOIN flights ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.DestAirport WHERE airports.City ="Aberdeen"AND airports.AirportName ="Ashley"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City ="Aberdeen"AND airports.AirportName ="Ashley"	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Airline ="JetBlue Airways"	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Airline ="Jetblue Airways"	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode JOIN airlines ON flights.DestAirport = airlines.uid WHERE airlines.Airline ="ASY"AND airlines.Airline ="United"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.Country ="ASY"AND airports.Country ="United"	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE flights.SourceAirport ="AHD"AND airlines.Airline ="United"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.Country ="AHD"AND airports.Country ="United"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City ="Aberdeen"AND airports.Country ="United Airlines"	flight_2
SELECT Count(*) FROM airports JOIN flights ON flights.DestAirport = airports.AirportCode JOIN airlines ON flights.SourceAirport = airlines.uid WHERE airports.City ="Aberdeen"AND airlines.Airline ="United"	flight_2
SELECT airports.City FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.City FROM airports GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.City FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.City FROM airports GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT flights.SourceAirport FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY flights.SourceAirport ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.AirportCode FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY flights.SourceAirport ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.AirportCode FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY flights.SourceAirport ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airports.AirportCode FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY airports.AirportCode ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY flights.Airline ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airlines.Abbreviation, airlines.Country FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY flights.Airline ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airlines.Abbreviation, airlines.Country FROM airlines GROUP BY airlines.Abbreviation ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport ="AHD"	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport ="AHD"	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.DestAirport ="AHD"	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.DestAirport ="AHD"	flight_2
SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE flights.SourceAirport ="APG"INTERSECT SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE flights.SourceAirport ="CVO"	flight_2
SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE flights.SourceAirport ="APG"INTERSECT SELECT airlines.Airline FROM airlines JOIN flights WHERE flights.SourceAirport ="CVO"	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport ="CVO"EXCEPT SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport ="APG"	flight_2
SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE airports.AirportCode ="CVO"EXCEPT SELECT airlines.Airline FROM airlines JOIN airports WHERE flights.SourceAirport ="APG"	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.uid HAVING Count(*) >= 10	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.uid HAVING Count(*) >= 10	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.FlightNo < 200	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.FlightNo < 200	flight_2
SELECT flights.FlightNo FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE airlines.Airline ="United Airlines"	flight_2
SELECT flights.FlightNo FROM airlines ON airlines.uid = airlines.uid JOIN airlines WHERE airlines.Airline ="United Airlines"	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.SourceAirport ="APG"	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.SourceAirport ="APG"	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.DestAirport ="APG"	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.DestAirport ="APG"	flight_2
SELECT flights.FlightNo FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT flights.FlightNo FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT flights.FlightNo FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT flights.FlightNo FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City ="Aberdeen"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.DestAirport WHERE airports.City ="Aberdeen"OR airports.City ="Abilene"	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City ="Aberdeen"OR airports.City ="Abilene"	flight_2
SELECT airports.AirportName, airports.AirportName FROM airports WHERE airports.AirportCode NOT IN (SELECT flights.SourceAirport FROM flights)	flight_2
SELECT airports.AirportName FROM airports WHERE airports.AirportCode NOT IN (SELECT flights.DestAirport FROM flights)	flight_2
SELECT Count(*) FROM employee	employee_hire_evaluation
SELECT Count(*) FROM employee	employee_hire_evaluation
SELECT employee.Name FROM employee ORDER BY employee.Age Asc	employee_hire_evaluation
SELECT employee.Name FROM employee ORDER BY employee.Age Asc	employee_hire_evaluation
SELECT employee.City, Count(*) FROM employee GROUP BY employee.City	employee_hire_evaluation
SELECT Count(*), employee.City FROM employee GROUP BY employee.City	employee_hire_evaluation
SELECT employee.City FROM employee WHERE employee.Age > 30 GROUP BY employee.City HAVING Count(*) > 1	employee_hire_evaluation
SELECT employee.City FROM employee WHERE employee.Age > 30 GROUP BY employee.City HAVING Count(*) > 1	employee_hire_evaluation
SELECT shop.Location, Count(*) FROM shop GROUP BY shop.Location	employee_hire_evaluation
SELECT shop.Location, Count(*) FROM shop GROUP BY shop.Location	employee_hire_evaluation
SELECT shop.Manager_name, shop.District FROM shop GROUP BY shop.Shop_ID ORDER BY Sum(shop.Number_products) Desc LIMIT 1	employee_hire_evaluation
SELECT shop.Manager_name, shop.District FROM shop GROUP BY shop.Shop_ID ORDER BY Sum(shop.Number_products) Desc LIMIT 1	employee_hire_evaluation
SELECT Min(shop.Number_products), Max(shop.Number_products) FROM shop	employee_hire_evaluation
SELECT Min(shop.Number_products), Max(shop.Number_products) FROM shop	employee_hire_evaluation
SELECT shop.Name, shop.Location, shop.District FROM shop ORDER BY shop.Number_products Desc	employee_hire_evaluation
SELECT shop.Name, shop.Location, shop.District FROM shop ORDER BY shop.Number_products Desc	employee_hire_evaluation
SELECT shop.Name FROM shop WHERE shop.Number_products > (SELECT Avg(shop.Number_products) FROM shop)	employee_hire_evaluation
SELECT shop.Name FROM shop WHERE shop.Number_products > (SELECT Avg(shop.Number_products) FROM shop)	employee_hire_evaluation
SELECT employee.Name FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID GROUP BY evaluation.Employee_ID ORDER BY Count(*) Desc LIMIT 1	employee_hire_evaluation
SELECT employee.Name FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID GROUP BY evaluation.Employee_ID ORDER BY Count(*) Desc LIMIT 1	employee_hire_evaluation
SELECT employee.Name FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID ORDER BY evaluation.Bonus Desc LIMIT 1	employee_hire_evaluation
SELECT employee.Name FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID ORDER BY evaluation.Bonus Desc LIMIT 1	employee_hire_evaluation
SELECT employee.Name FROM employee WHERE employee.Employee_ID NOT IN (SELECT evaluation.Employee_ID FROM evaluation)	employee_hire_evaluation
SELECT employee.Name FROM employee WHERE employee.Employee_ID NOT IN (SELECT evaluation.Employee_ID FROM evaluation)	employee_hire_evaluation
SELECT shop.Name FROM hiring JOIN shop ON hiring.Shop_ID = shop.Shop_ID GROUP BY hiring.Shop_ID ORDER BY Count(*) Desc LIMIT 1	employee_hire_evaluation
SELECT shop.Name FROM hiring JOIN shop ON hiring.Shop_ID = shop.Shop_ID GROUP BY hiring.Shop_ID ORDER BY Count(*) Desc LIMIT 1	employee_hire_evaluation
SELECT shop.Name FROM shop WHERE shop.Shop_ID NOT IN (SELECT hiring.Shop_ID FROM hiring)	employee_hire_evaluation
SELECT shop.Name FROM shop WHERE shop.Shop_ID NOT IN (SELECT hiring.Shop_ID FROM hiring)	employee_hire_evaluation
SELECT shop.Name, Count(*) FROM hiring JOIN shop ON hiring.Shop_ID = shop.Shop_ID GROUP BY hiring.Shop_ID	employee_hire_evaluation
SELECT shop.Name, Count(*) FROM employee JOIN hiring ON employee.Employee_ID = hiring.Employee_ID JOIN shop ON hiring.Shop_ID = shop.Shop_ID GROUP BY hiring.Shop_ID	employee_hire_evaluation
SELECT Sum(evaluation.Bonus) FROM evaluation	employee_hire_evaluation
SELECT Sum(evaluation.Bonus) FROM evaluation	employee_hire_evaluation
SELECT * FROM hiring	employee_hire_evaluation
SELECT * FROM hiring	employee_hire_evaluation
SELECT shop.District FROM shop WHERE shop.Number_products < 3000 INTERSECT SELECT shop.District FROM shop WHERE shop.Number_products > 10000	employee_hire_evaluation
SELECT shop.District FROM shop WHERE shop.Number_products < 3000 INTERSECT SELECT shop.District FROM shop WHERE shop.Number_products > 10000	employee_hire_evaluation
SELECT Count(DISTINCT shop.Location) FROM shop	employee_hire_evaluation
SELECT Count(DISTINCT shop.Location) FROM shop	employee_hire_evaluation
SELECT Count(*) FROM Documents	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Documents.Document_Description FROM Documents	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Documents.Document_Description FROM Documents	cre_Doc_Template_Mgt
SELECT Documents.Document_Name, Documents.Template_ID FROM Documents WHERE Documents.Document_Description LIKE"%w%"	cre_Doc_Template_Mgt
SELECT Documents.Document_Name, Documents.Template_ID FROM Documents WHERE Documents.Document_Description LIKE"%w%"	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Template_ID, Documents.Document_Description FROM Documents WHERE Documents.Document_Name ="Robbin CV"	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Template_ID, Documents.Document_Description FROM Documents WHERE Documents.Document_Name ="Robbin CV"	cre_Doc_Template_Mgt
SELECT Count(DISTINCT Documents.Template_ID) FROM Documents	cre_Doc_Template_Mgt
SELECT Count(DISTINCT Documents.Template_ID) FROM Documents	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code ="PPT"	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code ="PPT"	cre_Doc_Template_Mgt
SELECT Documents.Template_ID, Count(*) FROM Documents GROUP BY Documents.Template_ID	cre_Doc_Template_Mgt
SELECT Documents.Template_ID, Count(*) FROM Documents GROUP BY Documents.Template_ID	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Template_Type_Code FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Template_Type_Code FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Template_ID FROM Documents GROUP BY Documents.Template_ID HAVING Count(*) > 1	cre_Doc_Template_Mgt
SELECT Documents.Template_ID FROM Documents GROUP BY Documents.Template_ID HAVING Count(*) > 1	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates EXCEPT SELECT Documents.Template_ID FROM Documents	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates EXCEPT SELECT Documents.Template_ID FROM Documents	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Version_Number, Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Version_Number, Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT DISTINCT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT DISTINCT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates WHERE Templates.Template_Type_Code ="PP"OR Templates.Template_Type_Code ="PPT"	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates WHERE Templates.Template_Type_Code ="PP"OR Templates.Template_Type_Code ="PPT"	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates WHERE Templates.Template_Type_Code ="CV"	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates WHERE Templates.Template_Type_Code ="CV"	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates WHERE Templates.Version_Number < 5	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates WHERE Templates.Version_Number > 5	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code HAVING Count(*) < 3	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code HAVING Count(*) < 3	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates ORDER BY Templates.Template_Type_Code Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates ORDER BY Templates.Version_Number Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Documents.Document_Name ="Data base"	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Documents.Document_Name ="Data base"	cre_Doc_Template_Mgt
SELECT Documents.Document_Name FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code ="BK"	cre_Doc_Template_Mgt
SELECT Documents.Document_Name FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code ="BK"	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types EXCEPT SELECT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types EXCEPT SELECT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code, Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code, Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Code ="AD"	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Code ="AD"	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Description ="Book"	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Description ="Book"	cre_Doc_Template_Mgt
SELECT DISTINCT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code JOIN Documents ON Templates.Template_ID = Documents.Template_ID	cre_Doc_Template_Mgt
SELECT DISTINCT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code WHERE Ref_Template_Types.Template_Type_Description ="Presentation"	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code WHERE Ref_Template_Types.Template_Type_Description ="Presentation"	cre_Doc_Template_Mgt
SELECT Count(*) FROM Paragraphs	cre_Doc_Template_Mgt
SELECT Count(*) FROM Paragraphs	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Summer Show"	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Summer Show"	cre_Doc_Template_Mgt
SELECT Paragraphs.Other_Details FROM Paragraphs WHERE Paragraphs.Paragraph_Text ="Korea"	cre_Doc_Template_Mgt
SELECT Paragraphs.Other_Details FROM Paragraphs WHERE Paragraphs.Paragraph_Text LIKE"%Korea%"	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Welcome to NY"	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Welcome to NY"	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Customer reviews"	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name ="Customer reviews"	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID, Count(*) FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID, Count(*) FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING Count(*) >= 2	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Documents.Document_ID HAVING Count(*) >= 2	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING Count(*) BETWEEN 1 AND 2	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING Count(*) <= 2	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text ="Brazil"INTERSECT SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text ="Ireland"	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text LIKE"%Brazil%"INTERSECT SELECT Documents.Document_ID FROM Paragraphs JOIN Paragraphs WHERE Paragraphs.Paragraph_Text LIKE"Ireland%"	cre_Doc_Template_Mgt
SELECT Count(*) FROM teacher	course_teach
SELECT Count(*) FROM teacher	course_teach
SELECT teacher.Name FROM teacher ORDER BY teacher.Age Asc	course_teach
SELECT teacher.Name FROM teacher ORDER BY teacher.Age Asc	course_teach
SELECT teacher.Age, teacher.Hometown FROM teacher	course_teach
SELECT teacher.Age, teacher.Hometown FROM teacher	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Hometown !="Little Lever Urban District"	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Hometown !="Little Lever Urban District"	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Age = 32 OR teacher.Age = 33	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Age = 32 OR teacher.Age = 33	course_teach
SELECT teacher.Hometown FROM teacher ORDER BY teacher.Age Asc LIMIT 1	course_teach
SELECT teacher.Hometown FROM teacher ORDER BY teacher.Age Asc LIMIT 1	course_teach
SELECT teacher.Hometown, Count(*) FROM teacher GROUP BY teacher.Hometown	course_teach
SELECT teacher.Hometown, Count(*) FROM teacher GROUP BY teacher.Hometown	course_teach
SELECT teacher.Hometown FROM teacher GROUP BY teacher.Hometown ORDER BY Count(*) Desc LIMIT 1	course_teach
SELECT teacher.Hometown FROM teacher GROUP BY teacher.Hometown ORDER BY Count(*) Desc LIMIT 1	course_teach
SELECT teacher.Hometown FROM teacher GROUP BY teacher.Hometown HAVING Count(*) >= 2	course_teach
SELECT teacher.Hometown FROM teacher GROUP BY teacher.Hometown HAVING Count(*) >= 2	course_teach
SELECT teacher.Name, course.Course FROM course_arrange JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID	course_teach
SELECT teacher.Name, course.Course FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID	course_teach
SELECT teacher.Name, course.Course FROM course_arrange JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID JOIN course ON course_arrange.Teacher_ID = course.Course_ID ORDER BY teacher.Name Asc	course_teach
SELECT teacher.Name, course.Course FROM course_arrange JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID ORDER BY teacher.Name Asc	course_teach
SELECT teacher.Name FROM course JOIN course_arrange ON course.Course_ID = course_arrange.Course_ID JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID WHERE course.Course ="math"	course_teach
SELECT teacher.Name FROM course JOIN course_arrange ON course.Course_ID = course_arrange.Course_ID JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID WHERE course.Course ="math"	course_teach
SELECT teacher.Name, Count(*) FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Name	course_teach
SELECT teacher.Name, Count(*) FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Name	course_teach
SELECT teacher.Name FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY course_arrange.Teacher_ID HAVING Count(*) >= 2	course_teach
SELECT teacher.Name FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY course_arrange.Teacher_ID HAVING Count(*) >= 2	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Teacher_ID NOT IN (SELECT course_arrange.Teacher_ID FROM course_arrange)	course_teach
SELECT teacher.Name FROM teacher WHERE teacher.Teacher_ID NOT IN (SELECT course_arrange.Teacher_ID FROM course_arrange)	course_teach
SELECT Count(*) FROM visitor WHERE visitor.Age < 30	museum_visit
SELECT visitor.Name FROM visitor WHERE visitor.Level_of_membership > 4 ORDER BY visitor.Level_of_membership Asc	museum_visit
SELECT Avg(visitor.Age) FROM visitor WHERE visitor.Level_of_membership != 4	museum_visit
SELECT visitor.Name, visitor.Level_of_membership FROM visitor WHERE visitor.Age > 4 ORDER BY visitor.Age Asc	museum_visit
SELECT museum.Museum_ID, museum.Name FROM museum GROUP BY museum.Museum_ID ORDER BY Count(*) Desc LIMIT 1	museum_visit
SELECT Avg(museum.Num_of_Staff) FROM museum WHERE museum.Open_Year < 2009	museum_visit
SELECT museum.Open_Year, museum.Num_of_Staff FROM museum WHERE museum.Name ="Plaza Museum"	museum_visit
SELECT museum.Name FROM museum WHERE museum.Num_of_Staff > (SELECT Min(museum.Num_of_Staff) FROM museum WHERE museum.Open_Year > 2010)	museum_visit
SELECT visitor.Name, visitor.Name, Count(*) FROM visit JOIN museum ON museum.Museum_ID = visit.Museum_ID GROUP BY visit.Museum_ID HAVING Count(*) > 1	museum_visit
SELECT visitor.ID, visitor.Name, visitor.Level_of_membership FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID GROUP BY visitor.ID ORDER BY Sum(visit.Total_spent) Desc LIMIT 1	museum_visit
SELECT museum.Museum_ID, museum.Name FROM museum JOIN visit ON museum.Museum_ID = visit.Museum_ID GROUP BY museum.Museum_ID ORDER BY Count(*) Desc LIMIT 1	museum_visit
SELECT museum.Name FROM museum WHERE museum.Museum_ID NOT IN (SELECT visit.Museum_ID FROM visit)	museum_visit
SELECT visitor.Name, visitor.Age FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID GROUP BY visit.visitor_ID ORDER BY Count(*) Desc LIMIT 1	museum_visit
SELECT Avg(visit.Num_of_Ticket), Max(visit.Total_spent) FROM visit	museum_visit
SELECT Sum(visit.Total_spent) FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID WHERE visitor.Level_of_membership = 1	museum_visit
SELECT visitor.Name FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID JOIN museum ON visit.Museum_ID = museum.Museum_ID WHERE museum.Open_Year < 2009 INTERSECT SELECT visitor.Name FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID JOIN museum ON visit.Museum_ID = museum.Museum_ID WHERE museum.Open_Year > 2011	museum_visit
SELECT Count(*) FROM visit WHERE visit.Museum_ID NOT IN (SELECT museum.Museum_ID FROM museum WHERE museum.Open_Year > 2010)	museum_visit
SELECT Count(*) FROM museum WHERE museum.Open_Year > 2013 OR museum.Open_Year < 2008	museum_visit
SELECT Count(*) FROM players	wta_1
SELECT Count(*) FROM players	wta_1
SELECT Count(*) FROM matches	wta_1
SELECT Count(*) FROM matches	wta_1
SELECT players.first_name, players.birth_date FROM players WHERE players.country_code ="USA"	wta_1
SELECT players.first_name, players.birth_date FROM players WHERE players.country_code ="USA"	wta_1
SELECT Avg(matches.loser_age), Avg(matches.winner_age) FROM matches	wta_1
SELECT Avg(matches.loser_age), Avg(matches.winner_age) FROM matches	wta_1
SELECT Avg(matches.winner_rank) FROM matches	wta_1
SELECT Avg(matches.winner_rank) FROM matches	wta_1
SELECT Min(matches.loser_rank) FROM matches	wta_1
SELECT Max(matches.loser_rank) FROM matches	wta_1
SELECT Count(DISTINCT players.country_code) FROM players	wta_1
SELECT Count(DISTINCT players.country_code) FROM players	wta_1
SELECT Count(DISTINCT matches.loser_name) FROM matches	wta_1
SELECT Count(DISTINCT matches.loser_name) FROM matches	wta_1
SELECT matches.tourney_name FROM matches GROUP BY matches.tourney_name HAVING Count(*) > 10	wta_1
SELECT matches.tourney_name FROM matches GROUP BY matches.tourney_name HAVING Count(*) > 10	wta_1
SELECT matches.winner_name FROM matches WHERE matches.year = 2013 INTERSECT SELECT matches.winner_name FROM matches WHERE matches.year = 2016	wta_1
SELECT players.first_name FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.year = 2013 INTERSECT SELECT players.first_name FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.year = 2016	wta_1
SELECT Count(*) FROM matches WHERE matches.year = 2013 OR matches.year = 2016	wta_1
SELECT Count(*) FROM matches WHERE matches.year = 2013 OR matches.year = 2016	wta_1
SELECT players.country_code, players.first_name FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.tourney_name ="WTA Championships"INTERSECT SELECT players.country_code, players.first_name FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.tourney_name ="Australian"	wta_1
SELECT players.first_name, players.country_code FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.tourney_name ="WTA Championships"INTERSECT SELECT players.first_name, players.country_code FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.tourney_name ="Australian"	wta_1
SELECT players.first_name, players.country_code FROM players ORDER BY players.birth_date Desc LIMIT 1	wta_1
SELECT players.first_name, players.country_code FROM players ORDER BY players.birth_date Desc LIMIT 1	wta_1
SELECT players.first_name, players.last_name FROM players ORDER BY players.birth_date Asc	wta_1
SELECT players.first_name, players.last_name FROM players ORDER BY players.birth_date Asc	wta_1
SELECT players.first_name, players.last_name FROM players WHERE players.hand ="left"ORDER BY players.birth_date Asc	wta_1
SELECT players.first_name, players.last_name FROM players WHERE players.hand ="left"ORDER BY players.birth_date Asc	wta_1
SELECT players.first_name, players.country_code FROM players JOIN rankings ON players.player_id = rankings.player_id GROUP BY rankings.player_id ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT players.first_name, players.country_code FROM players JOIN rankings ON players.player_id = rankings.player_id GROUP BY rankings.player_id ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT matches.year FROM matches GROUP BY matches.year ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT matches.year FROM matches GROUP BY matches.year ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT matches.winner_name, matches.winner_rank_points FROM matches GROUP BY matches.winner_name ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT matches.winner_name, matches.winner_rank_points FROM matches GROUP BY matches.winner_name ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT matches.winner_name FROM matches WHERE matches.tourney_name ="Australian Open"ORDER BY matches.winner_rank_points Desc LIMIT 1	wta_1
SELECT matches.winner_name FROM matches WHERE matches.tourney_name ="Australian Open"ORDER BY matches.winner_rank_points Desc LIMIT 1	wta_1
SELECT matches.loser_name, matches.winner_name FROM matches ORDER BY matches.minutes Desc LIMIT 1	wta_1
SELECT matches.winner_name, matches.loser_name FROM matches ORDER BY matches.minutes Desc LIMIT 1	wta_1
SELECT Avg(rankings.ranking), players.first_name FROM rankings JOIN players ON rankings.player_id = players.player_id GROUP BY players.first_name	wta_1
SELECT players.first_name, Avg(rankings.ranking) FROM rankings JOIN players ON rankings.player_id = players.player_id GROUP BY players.first_name	wta_1
SELECT Sum(rankings.ranking_points), players.first_name FROM rankings JOIN players ON rankings.player_id = players.player_id GROUP BY players.first_name	wta_1
SELECT players.first_name, Sum(rankings.ranking_points) FROM rankings JOIN players ON rankings.player_id = players.player_id GROUP BY players.first_name	wta_1
SELECT players.country_code, Count(*) FROM players GROUP BY players.country_code	wta_1
SELECT players.country_code, Count(*) FROM players GROUP BY players.country_code	wta_1
SELECT players.country_code FROM players GROUP BY players.country_code ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT players.country_code FROM players GROUP BY players.country_code ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT players.country_code FROM players GROUP BY players.country_code HAVING Count(*) > 50	wta_1
SELECT players.country_code FROM players GROUP BY players.country_code HAVING Count(*) > 50	wta_1
SELECT rankings.ranking_date, Count(*) FROM rankings GROUP BY rankings.ranking_date	wta_1
SELECT rankings.ranking_date, Count(*) FROM rankings GROUP BY rankings.ranking_date	wta_1
SELECT Count(*), matches.year FROM matches GROUP BY matches.year	wta_1
SELECT matches.year, Count(*) FROM matches GROUP BY matches.year	wta_1
SELECT matches.winner_name, matches.winner_rank FROM matches ORDER BY matches.winner_age Asc LIMIT 3	wta_1
SELECT matches.winner_name, matches.winner_rank FROM matches ORDER BY matches.winner_age Asc LIMIT 3	wta_1
SELECT Count(*) FROM (SELECT matches.winner_hand FROM players JOIN matches ON players.player_id = matches.winner_id WHERE players.hand ="WTA"INTERSECT SELECT matches.winner_hand FROM players JOIN matches ON players.player_id = matches.winner_id WHERE matches.tourney_name ="left")	wta_1
SELECT Count(*) FROM players JOIN matches ON players.player_id = matches.winner_id WHERE players.hand ="left"AND matches.tourney_name ="WTA"	wta_1
SELECT players.first_name, players.country_code, players.birth_date FROM matches JOIN players ON matches.winner_id = players.player_id ORDER BY matches.winner_rank_points Desc LIMIT 1	wta_1
SELECT players.first_name, players.country_code, players.birth_date FROM players JOIN matches ON players.player_id = matches.winner_id GROUP BY matches.winner_rank_points ORDER BY Count(*) Desc LIMIT 1	wta_1
SELECT players.hand, Count(*) FROM players GROUP BY players.hand	wta_1
SELECT players.hand, Count(*) FROM players GROUP BY players.hand	wta_1
SELECT Count(*) FROM ship WHERE ship.disposition_of_ship ="Captured"	battle_death
SELECT ship.name, ship.tonnage FROM ship ORDER BY ship.name Desc	battle_death
SELECT battle.name, battle.date, battle.result FROM battle	battle_death
SELECT Max(death.killed), Min(death.killed), Min(death.killed) FROM death GROUP BY death.killed	battle_death
SELECT Avg(death.injured), death.injured FROM death GROUP BY death.injured	battle_death
SELECT death.killed, death.injured FROM death JOIN ship ON death.caused_by_ship_id = ship.id WHERE ship.tonnage ="t"	battle_death
SELECT battle.name, battle.result FROM battle WHERE battle.bulgarian_commander !="Boril"	battle_death
SELECT DISTINCT battle.id, battle.name FROM battle JOIN ship ON battle.id = ship.lost_in_battle WHERE ship.ship_type ="Brig"	battle_death
SELECT battle.id, battle.name FROM battle JOIN death ON battle.id = death.id GROUP BY battle.id HAVING Sum(death.killed) > 10	battle_death
SELECT ship.id, ship.name FROM death JOIN ship ON death.caused_by_ship_id = ship.id GROUP BY ship.id ORDER BY Sum(death.injured) Desc LIMIT 1	battle_death
SELECT DISTINCT battle.name FROM battle WHERE battle.bulgarian_commander ="Kaloyan"AND battle.latin_commander ="Baldwin"	battle_death
SELECT Count(DISTINCT battle.result) FROM battle	battle_death
SELECT Count(*) FROM battle WHERE battle.id NOT IN (SELECT ship.lost_in_battle FROM ship WHERE ship.tonnage ="225")	battle_death
SELECT battle.name, battle.date FROM battle JOIN ship ON battle.id = ship.lost_in_battle WHERE ship.name ="Lettice"INTERSECT SELECT battle.name, battle.date FROM battle JOIN ship ON battle.id = ship.lost_in_battle WHERE ship.name ="HMSlanta"	battle_death
SELECT battle.name, battle.result, battle.bulgarian_commander FROM battle EXCEPT SELECT battle.name, battle.result, battle.bulgarian_commander FROM battle JOIN ship ON battle.id = ship.lost_in_battle WHERE ship.location ="English Channel"	battle_death
SELECT death.note FROM death WHERE death.note LIKE"%East%"	battle_death
SELECT Addresses.line_1 FROM Addresses WHERE Addresses.line_1 LIKE"%and%"	student_transcripts_tracking
SELECT Addresses.line_1, Addresses.line_2 FROM Addresses	student_transcripts_tracking
SELECT Count(*) FROM Courses	student_transcripts_tracking
SELECT Count(*) FROM Courses	student_transcripts_tracking
SELECT Courses.course_description FROM Courses WHERE Courses.course_name ="math"	student_transcripts_tracking
SELECT Courses.course_description FROM Courses WHERE Courses.course_name ="math"	student_transcripts_tracking
SELECT Addresses.zip_postcode FROM Addresses WHERE Addresses.city ="Port Chelsea"	student_transcripts_tracking
SELECT Addresses.zip_postcode FROM Addresses WHERE Addresses.city ="Port Chelsea"	student_transcripts_tracking
SELECT Departments.department_name, Departments.department_id FROM Departments JOIN Degree_Programs ON Departments.department_id = Degree_Programs.department_id GROUP BY Departments.department_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Departments.department_name, Degree_Programs.department_id FROM Departments JOIN Degree_Programs ON Departments.department_id = Degree_Programs.department_id GROUP BY Degree_Programs.department_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Count(DISTINCT Degree_Programs.department_id) FROM Degree_Programs	student_transcripts_tracking
SELECT Count(DISTINCT Departments.department_name) FROM Departments	student_transcripts_tracking
SELECT Count(DISTINCT Degree_Programs.degree_summary_name) FROM Degree_Programs	student_transcripts_tracking
SELECT Count(DISTINCT Degree_Programs.department_id) FROM Degree_Programs	student_transcripts_tracking
SELECT Count(*) FROM Departments JOIN Degree_Programs ON Departments.department_id = Degree_Programs.department_id WHERE Departments.department_name ="m"	student_transcripts_tracking
SELECT Count(*) FROM Departments JOIN Degree_Programs ON Departments.department_id = Degree_Programs.department_id WHERE Departments.department_name ="m"	student_transcripts_tracking
SELECT Sections.section_name, Sections.section_description FROM Sections	student_transcripts_tracking
SELECT Sections.section_name, Sections.section_description FROM Sections	student_transcripts_tracking
SELECT Courses.course_name, Courses.course_id FROM Courses JOIN Sections ON Courses.course_id = Sections.course_id GROUP BY Sections.course_id HAVING Count(*) <= 2	student_transcripts_tracking
SELECT Courses.course_name, Courses.course_id FROM Courses JOIN Sections ON Courses.course_id = Sections.course_id GROUP BY Sections.course_id HAVING Count(*) < 2	student_transcripts_tracking
SELECT Sections.section_name FROM Sections ORDER BY Sections.section_name Desc	student_transcripts_tracking
SELECT Sections.section_name FROM Sections ORDER BY Sections.section_name Desc	student_transcripts_tracking
SELECT Semesters.semester_name, Student_Enrolment.semester_id FROM Student_Enrolment JOIN Semesters ON Student_Enrolment.semester_id = Semesters.semester_id GROUP BY Student_Enrolment.semester_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Semesters.semester_name, Student_Enrolment.semester_id, Count(*) FROM Student_Enrolment JOIN Semesters ON Student_Enrolment.semester_id = Semesters.semester_id GROUP BY Student_Enrolment.semester_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Departments.department_description FROM Departments WHERE Departments.department_name LIKE"%computer%"	student_transcripts_tracking
SELECT Departments.department_description FROM Departments WHERE Departments.department_name LIKE"%computer%"	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Student_Enrolment JOIN Students ON Student_Enrolment.semester_id = Students.student_id GROUP BY Student_Enrolment.semester_id HAVING Count(*) = 2	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Student_Enrolment JOIN Students ON Student_Enrolment.student_id = Students.student_id GROUP BY Student_Enrolment.student_id HAVING Count(*) = 2	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Student_Enrolment JOIN Degree_Programs ON Student_Enrolment.degree_program_id = Degree_Programs.degree_program_id JOIN Students ON Student_Enrolment.degree_program_id = Students.student_id WHERE Degree_Programs.degree_summary_name ="Bachelor"	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Student_Enrolment JOIN Students ON Student_Enrolment.student_id = Students.student_id WHERE Student_Enrolment.degree_program_id ="f"	student_transcripts_tracking
SELECT Courses.course_name FROM Student_Enrolment_Courses JOIN Courses ON Student_Enrolment_Courses.course_id = Courses.course_id JOIN Student_Enrolment ON Student_Enrolment_Courses.student_enrolment_id = Student_Enrolment.student_enrolment_id GROUP BY Student_Enrolment_Courses.course_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Degree_Programs.degree_summary_name FROM Student_Enrolment_Courses JOIN Student_Enrolment ON Student_Enrolment_Courses.student_enrolment_id = Student_Enrolment.student_enrolment_id JOIN Degree_Programs ON Degree_Programs.degree_program_id = Student_Enrolment.degree_program_id GROUP BY Degree_Programs.degree_summary_name ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Student_Enrolment_Courses.course_id, Student_Enrolment_Courses.student_enrolment_id FROM Student_Enrolment_Courses JOIN Student_Enrolment ON Student_Enrolment_Courses.student_enrolment_id = Student_Enrolment.student_enrolment_id GROUP BY Student_Enrolment_Courses.course_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Student_Enrolment.degree_program_id, Degree_Programs.degree_summary_name FROM Student_Enrolment JOIN Degree_Programs ON Student_Enrolment.degree_program_id = Degree_Programs.degree_program_id GROUP BY Student_Enrolment.degree_program_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Student_Enrolment.student_id, Students.first_name, Students.last_name, Count(*) FROM Student_Enrolment JOIN Students ON Student_Enrolment.student_id = Students.student_id GROUP BY Student_Enrolment.student_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Student_Enrolment JOIN Students ON Student_Enrolment.student_id = Students.student_id GROUP BY Student_Enrolment.student_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Semesters.semester_name FROM Semesters WHERE Semesters.semester_id NOT IN (SELECT Student_Enrolment.semester_id FROM Student_Enrolment)	student_transcripts_tracking
SELECT Semesters.semester_name FROM Semesters WHERE Semesters.semester_id NOT IN (SELECT Student_Enrolment.semester_id FROM Student_Enrolment)	student_transcripts_tracking
SELECT Courses.course_name FROM Courses JOIN Student_Enrolment_Courses ON Courses.course_id = Student_Enrolment_Courses.course_id JOIN Student_Enrolment ON Student_Enrolment_Courses.student_enrolment_id = Student_Enrolment.student_enrolment_id	student_transcripts_tracking
SELECT Courses.course_name FROM Courses JOIN Student_Enrolment_Courses ON Courses.course_id = Student_Enrolment_Courses.course_id JOIN Student_Enrolment ON Student_Enrolment_Courses.student_enrolment_id = Student_Enrolment.student_enrolment_id	student_transcripts_tracking
SELECT Courses.course_name FROM Student_Enrolment_Courses JOIN Courses ON Courses.course_id = Student_Enrolment_Courses.course_id GROUP BY Student_Enrolment_Courses.course_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Courses.course_name FROM Courses JOIN Student_Enrolment_Courses ON Courses.course_id = Student_Enrolment_Courses.course_id GROUP BY Courses.course_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Students.last_name FROM Students WHERE Students.student_id NOT IN (SELECT Student_Enrolment.student_id FROM Student_Enrolment JOIN Degree_Programs WHERE Addresses.state_province_county ="North")	student_transcripts_tracking
SELECT Students.last_name FROM Students WHERE Students.student_id NOT IN (SELECT Student_Enrolment.student_id FROM Student_Enrolment JOIN Degree_Programs ON Student_Enrolment.degree_program_id = Degree_Programs.degree_program_id WHERE Addresses.state_province_county ="North")	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcripts.transcript_id FROM Transcripts JOIN Transcript_Contents ON Transcripts.transcript_id = Transcript_Contents.transcript_id GROUP BY Transcripts.transcript_id HAVING Count(*) >= 2	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcripts.transcript_id FROM Transcripts JOIN Transcript_Contents ON Transcripts.transcript_id = Transcript_Contents.transcript_id GROUP BY Transcripts.transcript_id HAVING Count(*) >= 2	student_transcripts_tracking
SELECT Students.cell_mobile_number FROM Students WHERE Students.first_name ="Timmothy"AND Students.last_name ="Ward"	student_transcripts_tracking
SELECT Students.cell_mobile_number FROM Students WHERE Students.first_name ="Timmothy"AND Students.last_name ="Ward"	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Students ORDER BY Students.date_first_registered Asc LIMIT 1	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Students ORDER BY Students.date_first_registered Asc LIMIT 1	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Students ORDER BY Students.date_first_registered Asc LIMIT 1	student_transcripts_tracking
SELECT Students.first_name, Students.middle_name, Students.last_name FROM Students ORDER BY Students.last_name Asc LIMIT 1	student_transcripts_tracking
SELECT DISTINCT Students.first_name FROM Students WHERE Students.current_address_id = (SELECT Max(Students.current_address_id) FROM Students)	student_transcripts_tracking
SELECT DISTINCT Students.first_name FROM Students WHERE Students.permanent_address_id > (SELECT Min(Students.permanent_address_id) FROM Students)	student_transcripts_tracking
SELECT Addresses.address_id, Count(*) FROM Addresses JOIN Students ON Addresses.address_id = Students.current_address_id GROUP BY Students.current_address_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Addresses.address_id, Addresses.line_1, Addresses.line_2 FROM Addresses JOIN Students ON Addresses.address_id = Students.permanent_address_id GROUP BY Addresses.address_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Avg(Transcripts.transcript_date) FROM Transcripts	student_transcripts_tracking
SELECT Avg(Transcripts.transcript_date) FROM Transcripts	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcripts.other_details FROM Transcripts ORDER BY Transcripts.transcript_date Asc LIMIT 1	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcripts.other_details FROM Transcripts ORDER BY Transcripts.transcript_date Asc LIMIT 1	student_transcripts_tracking
SELECT Count(*) FROM Transcripts	student_transcripts_tracking
SELECT Count(*) FROM Transcripts	student_transcripts_tracking
SELECT Transcripts.transcript_date FROM Transcripts ORDER BY Transcripts.transcript_date Desc LIMIT 1	student_transcripts_tracking
SELECT Transcripts.transcript_date FROM Transcripts ORDER BY Transcripts.transcript_date Desc LIMIT 1	student_transcripts_tracking
SELECT Transcript_Contents.transcript_id, Count(*) FROM Transcripts GROUP BY Transcripts.transcript_id ORDER BY Count(*) Desc LIMIT 1	student_transcripts_tracking
SELECT Count(*), Transcript_Contents.transcript_id FROM Student_Enrolment_Courses GROUP BY Transcript_Contents.transcript_id	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcript_Contents.transcript_id FROM Transcripts JOIN Transcript_Contents ON Transcripts.transcript_id = Transcript_Contents.transcript_id GROUP BY Transcript_Contents.transcript_id ORDER BY Count(*) Asc LIMIT 1	student_transcripts_tracking
SELECT Transcripts.transcript_date, Transcript_Contents.transcript_id FROM Transcripts JOIN Transcript_Contents ON Transcripts.transcript_id = Transcript_Contents.transcript_id GROUP BY Transcript_Contents.transcript_id ORDER BY Count(*) Asc LIMIT 1	student_transcripts_tracking
SELECT Student_Enrolment.semester_id FROM Student_Enrolment WHERE Student_Enrolment.student_id ="Master"INTERSECT SELECT Student_Enrolment.semester_id FROM Student_Enrolment WHERE Student_Enrolment.student_id ="Bachelor"	student_transcripts_tracking
SELECT Student_Enrolment.semester_id FROM Student_Enrolment WHERE Student_Enrolment.student_id ="f"INTERSECT SELECT Student_Enrolment.semester_id FROM Student_Enrolment WHERE Student_Enrolment.student_id ="y"	student_transcripts_tracking
SELECT Count(DISTINCT Students.current_address_id) FROM Students	student_transcripts_tracking
SELECT DISTINCT Addresses.other_address_details FROM Addresses JOIN Students ON Addresses.address_id = Students.current_address_id	student_transcripts_tracking
SELECT Students.other_student_details FROM Students ORDER BY Students.other_student_details Desc	student_transcripts_tracking
SELECT Students.other_student_details FROM Students ORDER BY Students.other_student_details Desc	student_transcripts_tracking
SELECT Sections.section_description FROM Sections WHERE Sections.other_details ="h"	student_transcripts_tracking
SELECT Sections.section_description FROM Sections WHERE Sections.section_name ="h"	student_transcripts_tracking
SELECT Students.first_name FROM Students JOIN Addresses ON Students.permanent_address_id = Addresses.address_id WHERE Addresses.country ="Haiti"OR Students.cell_mobile_number ="09700166582"	student_transcripts_tracking
SELECT Students.first_name FROM Students JOIN Addresses ON Students.permanent_address_id = Addresses.address_id WHERE Addresses.country ="Haiti"AND Students.cell_mobile_number ="09700166582"UNION SELECT Students.first_name FROM Students JOIN Addresses ON Students.permanent_address_id = Addresses.address_id WHERE Addresses.country ="09700166582"AND Students.cell_mobile_number ="09700166582"	student_transcripts_tracking
SELECT Cartoon.Title FROM Cartoon ORDER BY Cartoon.Title Asc	tvshow
SELECT Cartoon.Title FROM Cartoon ORDER BY Cartoon.Title Asc	tvshow
SELECT Cartoon.Title FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT Cartoon.Title FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT Count(*) FROM Cartoon WHERE Cartoon.Written_by ="Joseph Kuhr"	tvshow
SELECT Count(*) FROM Cartoon WHERE Cartoon.Written_by ="Joseph Kuhr"	tvshow
SELECT Cartoon.Title, Cartoon.Directed_by FROM Cartoon ORDER BY Cartoon.Original_air_date Asc	tvshow
SELECT Cartoon.Title, Cartoon.Directed_by FROM Cartoon ORDER BY Cartoon.Directed_by Asc	tvshow
SELECT Cartoon.Title FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"OR Cartoon.Directed_by ="Brandon Viet"	tvshow
SELECT Cartoon.Title FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"OR Cartoon.Directed_by ="Brandon Viet"	tvshow
SELECT TV_Channel.Country, Count(*) FROM TV_Channel GROUP BY TV_Channel.Country ORDER BY Count(*) Desc LIMIT 1	tvshow
SELECT TV_Channel.Country, Count(*) FROM TV_Channel GROUP BY TV_Channel.Country ORDER BY Count(*) Desc LIMIT 1	tvshow
SELECT Count(DISTINCT TV_Channel.series_name), Count(DISTINCT TV_Channel.Content) FROM TV_Channel	tvshow
SELECT Count(DISTINCT TV_Channel.series_name), Count(DISTINCT TV_Channel.Content) FROM TV_Channel	tvshow
SELECT TV_Channel.Content FROM TV_Channel WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT TV_Channel.Content FROM TV_Channel WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT TV_Channel.Package_Option FROM TV_Channel WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT TV_Channel.Package_Option FROM TV_Channel WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT Count(*) FROM TV_Channel WHERE TV_Channel.Language ="English"	tvshow
SELECT Count(*) FROM TV_Channel WHERE TV_Channel.Language ="English"	tvshow
SELECT TV_Channel.Language, Count(*) FROM TV_Channel GROUP BY TV_Channel.Language ORDER BY Count(*) Asc LIMIT 1	tvshow
SELECT TV_Channel.Language, Count(*) FROM TV_Channel GROUP BY TV_Channel.Language ORDER BY Count(*) Asc LIMIT 1	tvshow
SELECT TV_Channel.Language, Count(*) FROM TV_Channel GROUP BY TV_Channel.Language	tvshow
SELECT TV_Channel.Language, Count(*) FROM TV_Channel GROUP BY TV_Channel.Language	tvshow
SELECT TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Title ="The Rise of the Blue Beetle Beetle"	tvshow
SELECT TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Title ="The Rise of the Blue Beetle Beetle"	tvshow
SELECT Cartoon.Title FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT Cartoon.Title FROM TV_Channel JOIN TV_Channel WHERE TV_Channel.series_name ="Sky Radio Radio"	tvshow
SELECT TV_series.Episode FROM TV_series ORDER BY TV_series.Rating Asc	tvshow
SELECT TV_series.Episode FROM TV_series ORDER BY TV_series.Rating Asc	tvshow
SELECT TV_series.Episode, TV_series.Rating FROM TV_series ORDER BY TV_series.Rating Desc LIMIT 3	tvshow
SELECT TV_series.Episode, TV_series.Rating FROM TV_series ORDER BY TV_series.Rating Desc LIMIT 3	tvshow
SELECT Min(TV_series.Share), Max(TV_series.Share) FROM TV_series	tvshow
SELECT Max(TV_series.Share), Min(TV_series.Share) FROM TV_series	tvshow
SELECT TV_series.Air_Date FROM TV_series WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_series.Air_Date FROM TV_series WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_series.Weekly_Rank FROM TV_series WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_series.Weekly_Rank FROM TV_series WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_Channel.series_name FROM TV_Channel JOIN TV_series ON TV_Channel.id = TV_series.Channel WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_Channel.series_name FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_series.Episode ="A Love of a Lifetime"	tvshow
SELECT TV_series.Episode FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT TV_series.Episode FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name ="Sky Radio"	tvshow
SELECT Count(*), Cartoon.Directed_by FROM Cartoon GROUP BY Cartoon.Directed_by	tvshow
SELECT Cartoon.Directed_by, Count(*) FROM Cartoon GROUP BY Cartoon.Directed_by	tvshow
SELECT Cartoon.Production_code, Cartoon.Channel FROM Cartoon ORDER BY Cartoon.Original_air_date Desc LIMIT 1	tvshow
SELECT Cartoon.Production_code, Cartoon.Channel FROM Cartoon ORDER BY Cartoon.Channel Desc LIMIT 1	tvshow
SELECT TV_Channel.Package_Option, TV_Channel.series_name FROM TV_Channel WHERE TV_Channel.Hight_definition_TV ="TV"	tvshow
SELECT TV_Channel.Package_Option, TV_Channel.series_name FROM TV_Channel WHERE TV_Channel.Hight_definition_TV ="yes"	tvshow
SELECT TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Written_by ="Todd Casey"	tvshow
SELECT TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Written_by ="Todd Casey"	tvshow
SELECT TV_Channel.Country FROM TV_Channel EXCEPT SELECT TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Written_by ="Todd Casey"	tvshow
SELECT TV_Channel.Country FROM TV_Channel EXCEPT SELECT TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Written_by ="Todd Casey"	tvshow
SELECT TV_Channel.series_name, TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Ben Jones"INTERSECT SELECT TV_Channel.series_name, TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Michael"	tvshow
SELECT TV_Channel.series_name, TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Ben Jones"INTERSECT SELECT TV_Channel.series_name, TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Michael"	tvshow
SELECT TV_Channel.Pixel_aspect_ratio_PAR, TV_Channel.Country FROM TV_Channel WHERE TV_Channel.Language !="English"	tvshow
SELECT TV_Channel.Pixel_aspect_ratio_PAR, TV_Channel.Country FROM TV_Channel WHERE TV_Channel.Language !="English"	tvshow
SELECT TV_Channel.id FROM TV_Channel GROUP BY TV_Channel.id HAVING Count(*) > 2	tvshow
SELECT TV_Channel.id FROM TV_Channel GROUP BY TV_Channel.id HAVING Count(*) > 2	tvshow
SELECT TV_Channel.id FROM TV_Channel EXCEPT SELECT Cartoon.Channel FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT TV_Channel.id FROM TV_Channel EXCEPT SELECT Cartoon.Channel FROM Cartoon WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT TV_Channel.Package_Option FROM TV_Channel EXCEPT SELECT TV_Channel.Package_Option FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT TV_Channel.Package_Option FROM TV_Channel EXCEPT SELECT TV_Channel.Package_Option FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by ="Ben Jones"	tvshow
SELECT Count(*) FROM poker_player	poker_player
SELECT Count(*) FROM poker_player	poker_player
SELECT poker_player.Earnings FROM poker_player ORDER BY poker_player.Earnings Desc	poker_player
SELECT poker_player.Earnings FROM poker_player ORDER BY poker_player.Earnings Desc	poker_player
SELECT poker_player.Final_Table_Made, poker_player.Best_Finish FROM poker_player	poker_player
SELECT poker_player.Final_Table_Made, poker_player.Best_Finish FROM poker_player	poker_player
SELECT Avg(poker_player.Earnings) FROM poker_player	poker_player
SELECT Avg(poker_player.Earnings) FROM poker_player	poker_player
SELECT poker_player.Money_Rank FROM poker_player ORDER BY poker_player.Earnings Desc LIMIT 1	poker_player
SELECT poker_player.Money_Rank FROM poker_player ORDER BY poker_player.Earnings Desc LIMIT 1	poker_player
SELECT Count(*) FROM poker_player WHERE poker_player.Earnings < 200000	poker_player
SELECT Max(poker_player.Final_Table_Made) FROM poker_player WHERE poker_player.Earnings < 200000	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE poker_player.Earnings > 300000	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE poker_player.Earnings > 300000	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Final_Table_Made Asc	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID GROUP BY people.Name ORDER BY Count(*) Asc	poker_player
SELECT people.Birth_Date FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings Asc LIMIT 1	poker_player
SELECT people.Birth_Date FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings Asc LIMIT 1	poker_player
SELECT poker_player.Money_Rank FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY people.Height Desc LIMIT 1	poker_player
SELECT poker_player.Money_Rank FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY people.Height Desc LIMIT 1	poker_player
SELECT Avg(poker_player.Earnings) FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200	poker_player
SELECT Avg(poker_player.Earnings) FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings Desc	poker_player
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings Desc	poker_player
SELECT people.Nationality, Count(*) FROM people GROUP BY people.Nationality	poker_player
SELECT people.Nationality, Count(*) FROM people GROUP BY people.Nationality	poker_player
SELECT people.Nationality FROM people GROUP BY people.Nationality ORDER BY Count(*) Desc LIMIT 1	poker_player
SELECT people.Nationality FROM people GROUP BY people.Nationality ORDER BY Count(*) Desc LIMIT 1	poker_player
SELECT people.Nationality FROM people GROUP BY people.Nationality HAVING Count(*) >= 2	poker_player
SELECT people.Nationality FROM people GROUP BY people.Nationality HAVING Count(*) >= 2	poker_player
SELECT people.Name, people.Birth_Date FROM people ORDER BY people.Name Asc	poker_player
SELECT people.Name, people.Birth_Date FROM people ORDER BY people.Name Asc	poker_player
SELECT people.Name FROM people WHERE people.Nationality !="Russia"	poker_player
SELECT people.Name FROM people WHERE people.Nationality !="Russia"	poker_player
SELECT people.Name FROM people WHERE people.People_ID NOT IN (SELECT poker_player.People_ID FROM poker_player)	poker_player
SELECT people.Name FROM people WHERE people.People_ID NOT IN (SELECT poker_player.People_ID FROM poker_player)	poker_player
SELECT Count(DISTINCT people.Nationality) FROM people	poker_player
SELECT Count(DISTINCT people.Nationality) FROM people	poker_player
SELECT Count(*) FROM AREA_CODE_STATE	voter_1
SELECT CONTESTANTS.contestant_number, CONTESTANTS.contestant_name FROM CONTESTANTS ORDER BY CONTESTANTS.contestant_name Desc	voter_1
SELECT VOTES.vote_id, VOTES.phone_number, VOTES.state FROM VOTES	voter_1
SELECT Max(AREA_CODE_STATE.area_code), Min(AREA_CODE_STATE.area_code) FROM AREA_CODE_STATE	voter_1
SELECT VOTES.created FROM VOTES WHERE VOTES.state ="CA"	voter_1
SELECT CONTESTANTS.contestant_name FROM CONTESTANTS WHERE CONTESTANTS.contestant_name !="Jessie Alloway"	voter_1
SELECT DISTINCT VOTES.state, VOTES.created FROM VOTES	voter_1
SELECT CONTESTANTS.contestant_number, CONTESTANTS.contestant_name FROM CONTESTANTS JOIN VOTES ON CONTESTANTS.contestant_number = VOTES.contestant_number GROUP BY CONTESTANTS.contestant_number HAVING Count(*) >= 2	voter_1
SELECT CONTESTANTS.contestant_number, CONTESTANTS.contestant_name FROM CONTESTANTS JOIN VOTES ON CONTESTANTS.contestant_number = VOTES.contestant_number ORDER BY VOTES.vote_id Asc LIMIT 1	voter_1
SELECT Count(*) FROM VOTES WHERE VOTES.state ="NY"OR VOTES.state ="CA"	voter_1
SELECT Count(*) FROM CONTESTANTS WHERE CONTESTANTS.contestant_number NOT IN (SELECT VOTES.contestant_number FROM VOTES)	voter_1
SELECT AREA_CODE_STATE.area_code FROM AREA_CODE_STATE GROUP BY AREA_CODE_STATE.area_code ORDER BY Count(*) Desc LIMIT 1	voter_1
SELECT VOTES.created, VOTES.state, VOTES.phone_number FROM CONTESTANTS JOIN VOTES ON CONTESTANTS.contestant_number = VOTES.contestant_number WHERE CONTESTANTS.contestant_name ="Tabatha Gehling"	voter_1
SELECT AREA_CODE_STATE.area_code FROM AREA_CODE_STATE JOIN VOTES ON AREA_CODE_STATE.state = VOTES.state JOIN CONTESTANTS ON VOTES.contestant_number = CONTESTANTS.contestant_number WHERE CONTESTANTS.contestant_name ="Tabatha Ges"INTERSECT SELECT AREA_CODE_STATE.area_code FROM AREA_CODE_STATE JOIN VOTES ON AREA_CODE_STATE.state = VOTES.state JOIN CONTESTANTS ON VOTES.contestant_number = CONTESTANTS.contestant_number WHERE CONTESTANTS.contestant_name ="Kellyhlis"	voter_1
SELECT CONTESTANTS.contestant_name FROM CONTESTANTS WHERE CONTESTANTS.contestant_name LIKE"%Al%"	voter_1
SELECT country.Name FROM country WHERE country.IndepYear > 1950	world_1
SELECT country.Name FROM country WHERE country.IndepYear > 1950	world_1
SELECT Count(*) FROM country WHERE country.GovernmentForm ="republic"	world_1
SELECT Count(*) FROM country WHERE country.GovernmentForm =""	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Region ="Caribbean countries"	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Continent ="m"	world_1
SELECT country.Continent FROM country WHERE country.Name ="Anguilla"	world_1
SELECT country.Continent FROM country WHERE country.Name ="Anguilla"	world_1
SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name ="Kabul Kabul"	world_1
SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name ="Kabul"	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba"	world_1
SELECT country.Population, country.LifeExpectancy FROM country WHERE country.Name ="Brazil"	world_1
SELECT country.Population, country.LifeExpectancy FROM country WHERE country.Name ="Brazil"	world_1
SELECT country.Region, country.Population FROM country WHERE country.Name ="Angola"	world_1
SELECT country.Region, country.Population FROM country WHERE country.Name ="Angola"	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Region ="Central Africa"	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Continent ="Central Africa"	world_1
SELECT country.Name FROM country WHERE country.Continent ="Asia"ORDER BY country.LifeExpectancy Asc LIMIT 1	world_1
SELECT country.Name FROM country WHERE country.Continent ="Asia"ORDER BY country.LifeExpectancy Asc LIMIT 1	world_1
SELECT Sum(country.Population), Max(country.GNP) FROM country WHERE country.Continent ="Asia"	world_1
SELECT Count(*), country.GNP FROM country WHERE country.Continent ="Asia"ORDER BY country.GNP Desc LIMIT 1	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Continent ="f"	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Continent ="Africa"	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Continent ="Asia"OR country.Continent ="Europe"	world_1
SELECT Sum(country.SurfaceArea) FROM country WHERE country.Continent ="Asia"OR country.Continent ="Europe"	world_1
SELECT Count(*) FROM city WHERE city.District ="Gelderland"	world_1
SELECT Sum(city.Population) FROM city WHERE city.District ="Gelderland"	world_1
SELECT Avg(country.GNP), Sum(country.Population) FROM country WHERE country.GovernmentForm ="US"	world_1
SELECT Avg(country.GNP), Sum(country.Population) FROM country WHERE country.GovernmentForm ="US"	world_1
SELECT Count(DISTINCT countrylanguage.Language) FROM countrylanguage	world_1
SELECT Count(DISTINCT countrylanguage.Language) FROM countrylanguage	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Africa"	world_1
SELECT Count(DISTINCT country.GovernmentForm) FROM country WHERE country.Continent ="Africa"	world_1
SELECT Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Aruba"	world_1
SELECT Count(*) FROM country WHERE country.Name ="Ar"	world_1
SELECT Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Afghanistan"	world_1
SELECT Count(DISTINCT countrylanguage.IsOfficial) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Name ="Afghanistan"	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Continent FROM country GROUP BY country.Continent ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Continent FROM country GROUP BY country.Continent ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Count(*) FROM (SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="Dutch")	world_1
SELECT Count(*) FROM (SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="Dutch")	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="French"	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="French"	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="French"	world_1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"INTERSECT SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="French"	world_1
SELECT Count(DISTINCT country.Continent) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="Chinese"	world_1
SELECT Count(DISTINCT country.Continent) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="Chinese"	world_1
SELECT country.Region FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT country.Region FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language ="Dutch"OR countrylanguage.Language ="English"	world_1
SELECT countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"OR countrylanguage.Language ="Dutch"	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Continent ="y"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Continent ="f"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.GovernmentForm ="republic"GROUP BY countrylanguage.Language HAVING Count(*) = 1	world_1
SELECT countrylanguage.Language FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.GovernmentForm ="republic"GROUP BY countrylanguage.Language HAVING Count(*) = 1	world_1
SELECT city.Name FROM city WHERE city.Population ="English English"ORDER BY city.Population Desc LIMIT 1	world_1
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code WHERE countrylanguage.Language ="English"GROUP BY city.Name ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent ="f"ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent ="f"ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT Avg(country.LifeExpectancy) FROM country WHERE country.Code NOT IN (SELECT countrylanguage.IsOfficial FROM countrylanguage WHERE countrylanguage.Language ="English")	world_1
SELECT Avg(country.LifeExpectancy) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language !="English"	world_1
SELECT Sum(country.Population) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language !="English"	world_1
SELECT Count(*) FROM country WHERE country.Code NOT IN (SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="English")	world_1
SELECT countrylanguage.Language, countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.HeadOfState ="Beatrix"	world_1
SELECT countrylanguage.IsOfficial FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.HeadOfState ="Beatrix"	world_1
SELECT Count(DISTINCT countrylanguage.Language) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.GNPOld < 1930	world_1
SELECT Count(DISTINCT countrylanguage.IsOfficial) FROM countrylanguage WHERE countrylanguage.IsOfficial < 1930	world_1
SELECT country.Name FROM country WHERE country.SurfaceArea > (SELECT Max(country.SurfaceArea) FROM country WHERE country.Continent ="Europe")	world_1
SELECT country.Name FROM country WHERE country.SurfaceArea > (SELECT Max(country.SurfaceArea) FROM country WHERE country.Continent ="Europe")	world_1
SELECT country.Continent FROM country WHERE country.Population < (SELECT Max(country.Population) FROM country WHERE country.Continent ="African")	world_1
SELECT country.Name FROM country WHERE country.Population < (SELECT Max(country.Population) FROM country WHERE country.Continent ="African")	world_1
SELECT country.Name FROM country WHERE country.Population > (SELECT Max(country.Population) FROM country WHERE country.Continent =""Africa")	world_1
SELECT country.Name FROM country WHERE country.Population > (SELECT Max(country.Population) FROM country WHERE country.Continent =""Africa")	world_1
SELECT countrylanguage.CountryCode FROM country EXCEPT SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="English"	world_1
SELECT countrylanguage.CountryCode FROM country WHERE countrylanguage.Language !="English"	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language !="English"	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language !="English"	world_1
SELECT country.Code FROM country WHERE countrylanguage.Language ="English"AND country.GovernmentForm !="Republic"	world_1
SELECT country.Code FROM country WHERE countrylanguage.Language !="English"EXCEPT SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="y"	world_1
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE countrylanguage.Language ="English"AND country.Continent !="y"	world_1
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE country.Continent ="Europe"AND countrylanguage.Language !="English"	world_1
SELECT DISTINCT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE countrylanguage.Language ="Chinese"AND countrylanguage.IsOfficial ="y"	world_1
SELECT DISTINCT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = countrylanguage.CountryCode WHERE country.Continent ="Asia"AND countrylanguage.IsOfficial ="Chinese"	world_1
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population Asc LIMIT 1	world_1
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population Asc LIMIT 1	world_1
SELECT country.Population, country.Name, country.HeadOfState FROM country ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.Name, country.Population, country.HeadOfState FROM country ORDER BY country.SurfaceArea Desc LIMIT 1	world_1
SELECT country.Name, Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.CountryCode HAVING Count(*) >= 3	world_1
SELECT country.Name, Count(*) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY countrylanguage.Language HAVING Count(*) > 2	world_1
SELECT Count(*), city.District FROM city WHERE city.Population > (SELECT Avg(city.Population) FROM city) GROUP BY city.District	world_1
SELECT Count(*), city.District FROM city WHERE city.Population > (SELECT Avg(city.Population) FROM city) GROUP BY city.District	world_1
SELECT country.GovernmentForm, Avg(country.LifeExpectancy) FROM country GROUP BY country.GovernmentForm HAVING Avg(country.LifeExpectancy) > 72	world_1
SELECT country.GovernmentForm, Avg(country.Population) FROM country GROUP BY country.GovernmentForm HAVING Avg(country.LifeExpectancy) > 72	world_1
SELECT Avg(country.LifeExpectancy), Sum(country.Population), country.Continent FROM country GROUP BY country.Continent HAVING Avg(country.Population) < 72	world_1
SELECT country.Continent, Avg(country.LifeExpectancy), Min(country.LifeExpectancy) FROM country GROUP BY country.Continent HAVING Avg(country.LifeExpectancy) < 72	world_1
SELECT country.Name, country.SurfaceArea FROM country ORDER BY country.SurfaceArea Desc LIMIT 5	world_1
SELECT country.Name, country.SurfaceArea FROM country ORDER BY country.SurfaceArea Desc LIMIT 5	world_1
SELECT country.Name FROM country ORDER BY country.Population Desc LIMIT 3	world_1
SELECT country.Name FROM country ORDER BY city.Population Desc LIMIT 3	world_1
SELECT country.Name FROM country ORDER BY country.Population Asc LIMIT 3	world_1
SELECT country.Name FROM country ORDER BY country.Population Asc LIMIT 3	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Asia"	world_1
SELECT Count(*) FROM country WHERE country.Continent ="Asia"	world_1
SELECT country.Name FROM country WHERE country.Continent ="Europe"AND country.Population = 80000	world_1
SELECT country.Name FROM country WHERE country.Continent ="Europe"AND country.Population > 80000	world_1
SELECT Sum(country.Population), Avg(country.SurfaceArea) FROM country WHERE country.Continent ="North America"AND country.SurfaceArea > 3000	world_1
SELECT Sum(country.Population), Avg(country.SurfaceArea) FROM country WHERE country.Continent ="North America"AND country.SurfaceArea > 3000	world_1
SELECT city.Name FROM city WHERE city.Population BETWEEN 160000 AND 900000	world_1
SELECT city.Name FROM city WHERE city.Population BETWEEN 160000 AND 900000	world_1
SELECT countrylanguage.Language FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.Language, Avg(countrylanguage.Percentage) FROM countrylanguage GROUP BY countrylanguage.Language ORDER BY Sum(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT countrylanguage.CountryCode, Max(countrylanguage.Percentage) FROM countrylanguage GROUP BY countrylanguage.CountryCode ORDER BY Max(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT Count(*) FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.IsOfficial ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Count(*) FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.Language ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.CountryCode ORDER BY Count(countrylanguage.Percentage) Desc LIMIT 1	world_1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language ="Spanish"GROUP BY countrylanguage.CountryCode ORDER BY Count(*) Desc LIMIT 1	world_1
SELECT Count(*) FROM conductor	orchestra
SELECT Count(*) FROM conductor	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Age Asc	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Age Asc	orchestra
SELECT conductor.Name FROM conductor WHERE conductor.Nationality !="USA"	orchestra
SELECT conductor.Name FROM conductor WHERE conductor.Nationality !="USA USA"	orchestra
SELECT orchestra.Record_Company FROM orchestra ORDER BY orchestra.Year_of_Founded Desc	orchestra
SELECT orchestra.Record_Company FROM orchestra ORDER BY orchestra.Year_of_Founded Desc	orchestra
SELECT Avg(show.Attendance) FROM show	orchestra
SELECT Avg(show.Attendance) FROM show	orchestra
SELECT Max(performance.Share), Min(performance.Share) FROM performance WHERE performance.Type !="Live final"	orchestra
SELECT Max(performance.Share), Min(performance.Share) FROM performance WHERE performance.Type !="Live final"	orchestra
SELECT Count(DISTINCT conductor.Nationality) FROM conductor	orchestra
SELECT Count(DISTINCT conductor.Nationality) FROM conductor	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Year_of_Work Desc	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Year_of_Work Desc	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Year_of_Work Desc LIMIT 1	orchestra
SELECT conductor.Name FROM conductor ORDER BY conductor.Year_of_Work Desc LIMIT 1	orchestra
SELECT conductor.Name, conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID	orchestra
SELECT conductor.Name, conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID GROUP BY orchestra.Conductor_ID HAVING Count(*) > 1	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON conductor.Conductor_ID = orchestra.Conductor_ID GROUP BY orchestra.Conductor_ID HAVING Count(*) > 1	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID GROUP BY orchestra.Conductor_ID ORDER BY Count(*) Desc LIMIT 1	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID GROUP BY orchestra.Conductor_ID ORDER BY Count(*) Desc LIMIT 1	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID WHERE orchestra.Year_of_Founded > 2008	orchestra
SELECT conductor.Name FROM orchestra JOIN conductor ON orchestra.Conductor_ID = conductor.Conductor_ID WHERE orchestra.Year_of_Founded > 2008	orchestra
SELECT orchestra.Record_Company, Count(*) FROM orchestra GROUP BY orchestra.Record_Company	orchestra
SELECT orchestra.Record_Company, Count(*) FROM orchestra GROUP BY orchestra.Record_Company	orchestra
SELECT orchestra.Major_Record_Format FROM orchestra GROUP BY orchestra.Major_Record_Format ORDER BY Count(*) Asc	orchestra
SELECT orchestra.Major_Record_Format FROM orchestra GROUP BY orchestra.Major_Record_Format ORDER BY Count(*) Asc	orchestra
SELECT orchestra.Record_Company FROM orchestra GROUP BY orchestra.Record_Company ORDER BY Count(*) Desc LIMIT 1	orchestra
SELECT orchestra.Record_Company FROM orchestra GROUP BY orchestra.Record_Company ORDER BY Count(*) Desc LIMIT 1	orchestra
SELECT orchestra.Orchestra FROM orchestra WHERE orchestra.Orchestra_ID NOT IN (SELECT performance.Orchestra_ID FROM performance)	orchestra
SELECT orchestra.Orchestra FROM orchestra WHERE orchestra.Orchestra_ID NOT IN (SELECT performance.Orchestra_ID FROM performance)	orchestra
SELECT orchestra.Record_Company FROM orchestra WHERE orchestra.Year_of_Founded < 2003 INTERSECT SELECT orchestra.Record_Company FROM orchestra WHERE orchestra.Year_of_Founded > 2003	orchestra
SELECT orchestra.Record_Company FROM orchestra WHERE orchestra.Year_of_Founded < 2003 INTERSECT SELECT orchestra.Record_Company FROM orchestra WHERE orchestra.Year_of_Founded > 2003	orchestra
SELECT Count(*) FROM orchestra WHERE orchestra.Major_Record_Format ="CD"OR orchestra.Major_Record_Format ="DVD"	orchestra
SELECT Count(*) FROM orchestra WHERE orchestra.Major_Record_Format ="CD"OR orchestra.Major_Record_Format ="DVD"	orchestra
SELECT orchestra.Year_of_Founded FROM orchestra JOIN performance ON orchestra.Orchestra_ID = performance.Orchestra_ID GROUP BY performance.Orchestra_ID HAVING Count(*) > 1	orchestra
SELECT orchestra.Year_of_Founded FROM orchestra JOIN performance ON orchestra.Orchestra_ID = performance.Orchestra_ID GROUP BY performance.Orchestra_ID HAVING Count(*) > 1	orchestra
SELECT Count(*) FROM Highschooler	network_1
SELECT Count(*) FROM Highschooler	network_1
SELECT Highschooler.name, Highschooler.grade FROM Highschooler	network_1
SELECT Highschooler.name, Highschooler.grade FROM Highschooler	network_1
SELECT DISTINCT Highschooler.grade FROM Highschooler	network_1
SELECT DISTINCT Highschooler.grade FROM Highschooler	network_1
SELECT Highschooler.grade FROM Highschooler WHERE Highschooler.name ="Kyle"	network_1
SELECT Highschooler.grade FROM Highschooler WHERE Highschooler.name ="Kyle"	network_1
SELECT Highschooler.name FROM Highschooler WHERE Highschooler.grade = 10	network_1
SELECT Highschooler.name FROM Highschooler WHERE Highschooler.grade = 10	network_1
SELECT Highschooler.ID FROM Highschooler WHERE Highschooler.name ="Kyle"	network_1
SELECT Highschooler.ID FROM Highschooler WHERE Highschooler.name ="Kyle"	network_1
SELECT Count(*) FROM Highschooler WHERE Highschooler.grade = 9 OR Highschooler.grade = 10	network_1
SELECT Count(*) FROM Highschooler WHERE Highschooler.grade = 9 OR Highschooler.grade = 10	network_1
SELECT Highschooler.grade, Count(*) FROM Highschooler GROUP BY Highschooler.grade	network_1
SELECT Highschooler.grade, Count(*) FROM Highschooler GROUP BY Highschooler.grade	network_1
SELECT Highschooler.grade FROM Highschooler GROUP BY Highschooler.grade ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.grade FROM Highschooler GROUP BY Highschooler.grade ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.grade FROM Highschooler GROUP BY Highschooler.grade HAVING Count(*) >= 4	network_1
SELECT Highschooler.grade FROM Highschooler GROUP BY Highschooler.grade HAVING Count(*) >= 4	network_1
SELECT Friend.student_id, Count(*) FROM Friend GROUP BY Friend.student_id	network_1
SELECT Count(*) FROM Friend	network_1
SELECT Highschooler.name, Count(*) FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.name	network_1
SELECT Highschooler.name, Count(*) FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.name	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Friend.student_id ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Friend.student_id ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Friend.student_id HAVING Count(*) >= 3	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Friend.student_id HAVING Count(*) >= 3	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.name ="Kyle"	network_1
SELECT Highschooler.name FROM Friend JOIN Highschooler ON Friend.friend_id = Highschooler.ID AND Friend.student_id = Highschooler.ID JOIN Highschooler WHERE Highschooler.name ="Kyle"	network_1
SELECT Count(*) FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.name ="Kyle"	network_1
SELECT Count(*) FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.name ="Kyle"	network_1
SELECT Highschooler.ID FROM Highschooler EXCEPT SELECT Friend.student_id FROM Friend	network_1
SELECT Highschooler.ID FROM Highschooler EXCEPT SELECT Friend.student_id FROM Friend	network_1
SELECT Highschooler.name FROM Highschooler WHERE Highschooler.ID NOT IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Highschooler.name FROM Highschooler WHERE Highschooler.ID NOT IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Friend.student_id FROM Highschooler INTERSECT SELECT Likes.student_id FROM Likes	network_1
SELECT Friend.student_id FROM Friend INTERSECT SELECT Likes.student_id FROM Likes	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id INTERSECT SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend INTERSECT SELECT Highschooler.name FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id WHERE Likes.liked_id ="null"	network_1
SELECT Count(*), Likes.student_id FROM Likes GROUP BY Likes.student_id	network_1
SELECT Likes.student_id, Count(*) FROM Likes GROUP BY Likes.student_id	network_1
SELECT Highschooler.name, Count(*) FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Highschooler.name	network_1
SELECT Highschooler.name, Count(*) FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Highschooler.name	network_1
SELECT Highschooler.name FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Highschooler.ID ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.name FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Likes.student_id ORDER BY Count(*) Desc LIMIT 1	network_1
SELECT Highschooler.name FROM Likes JOIN Highschooler ON Likes.student_id = Highschooler.ID GROUP BY Likes.student_id HAVING Count(*) >= 2	network_1
SELECT Highschooler.name FROM Likes JOIN Highschooler ON Highschooler.ID = Highschooler.ID GROUP BY Likes.student_id HAVING Count(*) >= 2	network_1
SELECT DISTINCT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.grade > 5 GROUP BY Friend.student_id ORDER BY Count(*) Desc	network_1
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.grade > 5 GROUP BY Friend.student_id HAVING Count(*) >= 2	network_1
SELECT Count(*) FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id WHERE Highschooler.name ="Kyle"	network_1
SELECT Count(*) FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id WHERE Highschooler.name ="Kyle"	network_1
SELECT Avg(Highschooler.grade) FROM Highschooler WHERE Highschooler.ID IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Avg(Highschooler.grade) FROM Highschooler WHERE Highschooler.ID IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Min(Highschooler.grade) FROM Highschooler WHERE Highschooler.ID NOT IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Min(Highschooler.grade) FROM Highschooler WHERE Highschooler.ID NOT IN (SELECT Friend.student_id FROM Friend)	network_1
SELECT Owners.state FROM Owners INTERSECT SELECT Professionals.state FROM Professionals	dog_kennels
SELECT Owners.state FROM Owners INTERSECT SELECT Professionals.state FROM Professionals	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs WHERE Dogs.dog_id IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs WHERE Dogs.dog_id IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Professionals.state ="Indiana"UNION SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) > 2	dog_kennels
SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Professionals.state ="Indiana"UNION SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) > 2	dog_kennels
SELECT Dogs.name FROM Dogs EXCEPT SELECT Dogs.name FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id WHERE Treatments.cost_of_treatment > 1000	dog_kennels
SELECT Dogs.name FROM Dogs EXCEPT SELECT Dogs.name FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id WHERE Treatments.cost_of_treatment > 1000	dog_kennels
SELECT Professionals.first_name FROM Professionals EXCEPT SELECT Professionals.first_name FROM Professionals JOIN Dogs ON Professionals.professional_id = Dogs.owner_id	dog_kennels
SELECT Professionals.first_name FROM Professionals EXCEPT SELECT Professionals.first_name FROM Professionals JOIN Dogs ON Professionals.professional_id = Dogs.owner_id	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals EXCEPT SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals EXCEPT SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Owners.owner_id, Owners.first_name, Owners.last_name FROM Owners JOIN Dogs GROUP BY Owners.owner_id ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT Owners.owner_id, Owners.first_name, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id GROUP BY Owners.owner_id ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.first_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.first_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Breeds.breed_name FROM Breeds JOIN Dogs ON Breeds.breed_code = Dogs.breed_code GROUP BY Dogs.breed_code ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT Breeds.breed_name FROM Breeds JOIN Dogs ON Breeds.breed_code = Dogs.breed_code GROUP BY Dogs.breed_code ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT Owners.owner_id, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id JOIN Treatments ON Dogs.dog_id = Treatments.dog_id GROUP BY Owners.owner_id ORDER BY Sum(Treatments.cost_of_treatment) Desc LIMIT 1	dog_kennels
SELECT Owners.owner_id, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id JOIN Treatments ON Dogs.dog_id = Treatments.dog_id GROUP BY Owners.owner_id ORDER BY Sum(Owners.last_name) Desc LIMIT 1	dog_kennels
SELECT Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code GROUP BY Treatments.treatment_type_code ORDER BY Sum(Treatments.cost_of_treatment) Asc LIMIT 1	dog_kennels
SELECT Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatment_Types.treatment_type_code = Treatment_Types.treatment_type_code GROUP BY Treatments.treatment_type_code ORDER BY Sum(Treatments.cost_of_treatment) Asc LIMIT 1	dog_kennels
SELECT Owners.owner_id, Owners.zip_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id GROUP BY Owners.owner_id ORDER BY Sum(Charges.charge_amount) Desc LIMIT 1	dog_kennels
SELECT Owners.owner_id, Owners.zip_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id GROUP BY Owners.owner_id ORDER BY Sum(Owners.zip_code) Desc LIMIT 1	dog_kennels
SELECT Professionals.professional_id, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Professionals.professional_id, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT DISTINCT Professionals.first_name, Professionals.last_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Treatments.cost_of_treatment < (SELECT Avg(Treatments.cost_of_treatment) FROM Treatments)	dog_kennels
SELECT Professionals.first_name, Professionals.last_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Treatments.cost_of_treatment < (SELECT Avg(Treatments.cost_of_treatment) FROM Treatments)	dog_kennels
SELECT Treatments.date_of_treatment, Professionals.first_name FROM Treatments JOIN Professionals ON Treatments.professional_id = Professionals.professional_id	dog_kennels
SELECT Treatments.date_of_treatment, Professionals.first_name FROM Treatments JOIN Professionals ON Treatments.professional_id = Professionals.professional_id	dog_kennels
SELECT Treatments.cost_of_treatment, Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code	dog_kennels
SELECT Treatments.cost_of_treatment, Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code	dog_kennels
SELECT Owners.first_name, Owners.last_name, Dogs.size_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Owners.first_name, Owners.last_name, Dogs.size_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Dogs.name, Treatments.date_of_treatment FROM Dogs JOIN Breeds ON Dogs.breed_code = Breeds.breed_code ORDER BY Treatments.date_of_treatment Asc LIMIT 1	dog_kennels
SELECT Dogs.name, Treatments.date_of_treatment FROM Dogs JOIN Breeds ON Dogs.breed_code = Breeds.breed_code JOIN Treatments ON Dogs.dog_id = Treatments.dog_id ORDER BY Breeds.breed_name Asc LIMIT 1	dog_kennels
SELECT Owners.first_name, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id WHERE Owners.state ="Virginia"	dog_kennels
SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id WHERE Owners.state ="Virginia"	dog_kennels
SELECT DISTINCT Dogs.date_arrived, Dogs.date_departed FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id	dog_kennels
SELECT DISTINCT Dogs.date_arrived, Dogs.date_departed FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id	dog_kennels
SELECT Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id ORDER BY Dogs.age Desc LIMIT 1	dog_kennels
SELECT Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id ORDER BY Dogs.age Desc LIMIT 1	dog_kennels
SELECT Professionals.email_address FROM Professionals WHERE Professionals.state ="Hawaii"UNION SELECT Professionals.email_address FROM Professionals WHERE Professionals.state ="Wisconsin"	dog_kennels
SELECT Professionals.email_address FROM Professionals WHERE Professionals.state ="Hawaii"OR Professionals.state ="Wisconsin"	dog_kennels
SELECT Dogs.date_arrived, Dogs.date_departed FROM Dogs	dog_kennels
SELECT Dogs.date_arrived, Dogs.date_departed FROM Dogs	dog_kennels
SELECT Count(DISTINCT Treatments.dog_id) FROM Treatments	dog_kennels
SELECT Count(DISTINCT Treatments.dog_id) FROM Treatments	dog_kennels
SELECT Count(DISTINCT Treatments.professional_id) FROM Treatments	dog_kennels
SELECT Count(DISTINCT Treatments.professional_id) FROM Treatments	dog_kennels
SELECT Professionals.role_code, Professionals.street, Professionals.city, Professionals.state FROM Professionals WHERE Professionals.city LIKE"%West%"	dog_kennels
SELECT Professionals.role_code, Professionals.street, Professionals.city, Professionals.state FROM Professionals WHERE Professionals.city LIKE"%West%"	dog_kennels
SELECT Owners.first_name, Owners.last_name, Owners.email_address FROM Owners WHERE Owners.state LIKE"%North%"	dog_kennels
SELECT Owners.first_name, Owners.last_name, Owners.email_address FROM Owners WHERE Owners.state LIKE"%North%"	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.age < (SELECT Avg(Dogs.age) FROM Dogs)	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.age < (SELECT Avg(Dogs.age) FROM Dogs)	dog_kennels
SELECT Sum(Treatments.cost_of_treatment) FROM Treatments ORDER BY Treatments.date_of_treatment Desc LIMIT 1	dog_kennels
SELECT Treatments.cost_of_treatment FROM Treatments ORDER BY Treatments.date_of_treatment Desc LIMIT 1	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.dog_id NOT IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.dog_id NOT IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Count(*) FROM Owners WHERE Owners.owner_id NOT IN (SELECT Dogs.owner_id FROM Dogs)	dog_kennels
SELECT Count(*) FROM Owners WHERE Owners.owner_id NOT IN (SELECT Dogs.owner_id FROM Dogs)	dog_kennels
SELECT Count(*) FROM Professionals WHERE Professionals.professional_id NOT IN (SELECT Treatments.professional_id FROM Treatments)	dog_kennels
SELECT Count(*) FROM Professionals WHERE Professionals.professional_id NOT IN (SELECT Treatments.professional_id FROM Treatments)	dog_kennels
SELECT Dogs.name, Dogs.age, Dogs.weight FROM Dogs WHERE Dogs.abandoned_yn = 1	dog_kennels
SELECT Dogs.name, Dogs.age, Dogs.weight FROM Dogs WHERE Dogs.abandoned_yn = 1	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs	dog_kennels
SELECT Dogs.age FROM Dogs ORDER BY Dogs.date_of_birth Desc LIMIT 1	dog_kennels
SELECT Dogs.age FROM Dogs ORDER BY Dogs.date_of_birth Desc LIMIT 1	dog_kennels
SELECT Charges.charge_type, Charges.charge_amount FROM Charges	dog_kennels
SELECT Charges.charge_type, Charges.charge_amount FROM Charges	dog_kennels
SELECT Charges.charge_type FROM Charges ORDER BY Charges.charge_type Desc LIMIT 1	dog_kennels
SELECT Charges.charge_amount FROM Charges ORDER BY Charges.charge_type Desc LIMIT 1	dog_kennels
SELECT Professionals.email_address, Professionals.cell_number, Professionals.home_phone FROM Professionals	dog_kennels
SELECT Professionals.email_address, Professionals.cell_number, Professionals.home_phone FROM Professionals	dog_kennels
SELECT Count(DISTINCT Breeds.breed_code), Count(DISTINCT Breeds.breed_name) FROM Breeds	dog_kennels
SELECT DISTINCT Dogs.breed_code, Dogs.size_code FROM Dogs	dog_kennels
SELECT Professionals.first_name, Treatment_Types.treatment_type_description FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Professionals.first_name, Treatment_Types.treatment_type_description FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code	dog_kennels
SELECT Count(*) FROM singer	singer
SELECT Count(*) FROM singer	singer
SELECT singer.Name FROM singer ORDER BY singer.Net_Worth_Millions Asc	singer
SELECT singer.Name FROM singer ORDER BY singer.Net_Worth_Millions Asc	singer
SELECT singer.Birth_Year, singer.Citizenship FROM singer	singer
SELECT singer.Birth_Year, singer.Citizenship FROM singer	singer
SELECT singer.Name FROM singer WHERE singer.Citizenship !="France"	singer
SELECT singer.Name FROM singer WHERE singer.Citizenship !="usa"	singer
SELECT singer.Name FROM singer WHERE singer.Birth_Year = 1948 OR singer.Birth_Year = 1949	singer
SELECT singer.Name FROM singer WHERE singer.Birth_Year = 1948 OR singer.Birth_Year = 1949	singer
SELECT singer.Name FROM singer ORDER BY singer.Net_Worth_Millions Desc LIMIT 1	singer
SELECT singer.Name FROM singer ORDER BY singer.Net_Worth_Millions Desc LIMIT 1	singer
SELECT singer.Citizenship, Count(*) FROM singer GROUP BY singer.Citizenship	singer
SELECT singer.Citizenship, Count(*) FROM singer GROUP BY singer.Citizenship	singer
SELECT singer.Citizenship FROM singer GROUP BY singer.Citizenship ORDER BY Count(*) Desc LIMIT 1	singer
SELECT singer.Citizenship FROM singer GROUP BY singer.Citizenship ORDER BY Count(*) Desc LIMIT 1	singer
SELECT singer.Citizenship, Max(singer.Net_Worth_Millions) FROM singer GROUP BY singer.Citizenship	singer
SELECT singer.Citizenship, Max(singer.Net_Worth_Millions) FROM singer GROUP BY singer.Citizenship	singer
SELECT song.Title, singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID	singer
SELECT song.Title, singer.Name FROM song JOIN singer ON song.Singer_ID = singer.Singer_ID	singer
SELECT DISTINCT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Sales > 300000	singer
SELECT DISTINCT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Sales > 300000	singer
SELECT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name HAVING Count(*) > 1	singer
SELECT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name HAVING Count(*) > 1	singer
SELECT singer.Name, Sum(song.Sales) FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name	singer
SELECT Sum(song.Sales), singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name	singer
SELECT singer.Name FROM singer WHERE singer.Singer_ID NOT IN (SELECT song.Singer_ID FROM song)	singer
SELECT singer.Name FROM singer WHERE singer.Singer_ID NOT IN (SELECT song.Singer_ID FROM song)	singer
SELECT singer.Citizenship FROM singer WHERE singer.Birth_Year < 1945 INTERSECT SELECT singer.Citizenship FROM singer WHERE singer.Birth_Year > 1955	singer
SELECT singer.Citizenship FROM singer WHERE singer.Birth_Year < 1945 INTERSECT SELECT singer.Citizenship FROM singer WHERE singer.Birth_Year > 1955	singer
SELECT Count(*) FROM Other_Available_Features	real_estate_properties
SELECT Ref_Feature_Types.feature_type_name FROM Ref_Feature_Types JOIN Other_Available_Features ON Ref_Feature_Types.feature_type_code = Other_Available_Features.feature_type_code WHERE Other_Available_Features.feature_name ="AirCon"	real_estate_properties
SELECT Ref_Property_Types.property_type_description FROM Ref_Property_Types	real_estate_properties
SELECT Properties.property_name FROM Properties WHERE Properties.room_count ="f"OR Properties.room_count > 1	real_estate_properties
