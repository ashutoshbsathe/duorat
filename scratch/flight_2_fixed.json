SELECT flights.FlightNo FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City = "Aberdeen" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.FlightNo < 200	flight_2
SELECT airports.City FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT Count(*) FROM airports	flight_2
SELECT Count(*) FROM airports JOIN flights ON flights.DestAirport = airports.AirportCode JOIN airlines ON flights.SourceAirport = airlines.uid WHERE airports.City = "Aberdeen" AND airlines.Airline = "United" 	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Airline = "JetBlue Airways" 	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.DestAirport WHERE airports.City = "Aberdeen" AND airports.AirportName = "Ashley" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.DestAirport = "AHD" 	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.Country = "ASY" AND airports.Country = "United" 	flight_2
SELECT Count(*) FROM airlines	flight_2
SELECT airports.AirportCode, airports.AirportName FROM airports WHERE airports.City = "Anthony" 	flight_2
SELECT airports.AirportName FROM airports WHERE airports.City = "Aberdeen" 	flight_2
SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE flights.SourceAirport = "APG" INTERSECT SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE flights.SourceAirport = "CVO" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.uid HAVING Count(*) >= 10	flight_2
SELECT flights.FlightNo FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode WHERE airports.City = "Aberdeen" 	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City = "Aberdeen" 	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE airports.City = "Aberdeen" 	flight_2
SELECT airports.City, airports.Country FROM airports WHERE airports.AirportName = "Alton" 	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City = "Aberdeen" AND airports.AirportName = "Ashley" 	flight_2
SELECT Count(*) FROM airlines WHERE airlines.Airline = "Jetblue Airways" 	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport = "APG" 	flight_2
SELECT airports.AirportCode, airports.AirportName FROM airports WHERE airports.City = "Anthony" 	flight_2
SELECT airlines.Country FROM airlines WHERE airlines.Airline = "JetBlue Airways" 	flight_2
SELECT airlines.Abbreviation, airlines.Country FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY flights.Airline ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airlines.Abbreviation FROM airlines WHERE airlines.Airline = "Jetblue Airways" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.FlightNo < 200	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.DestAirport = "APG" 	flight_2
SELECT airports.AirportCode FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY airports.AirportCode ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT airlines.Airline, airlines.Abbreviation FROM airlines WHERE airlines.Country = "USA" 	flight_2
SELECT airlines.Airline, airlines.Abbreviation FROM airlines WHERE airlines.Country = "USA" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport = "AHD" 	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.DestAirport WHERE airports.City = "Aberdeen" OR airports.City = "Abilene" 	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport = "APG" 	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode JOIN airlines ON flights.DestAirport = airlines.uid WHERE airlines.Airline = "ASY" AND airlines.Airline = "United" 	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City = "Aberdeen" AND airports.Country = "United Airlines" 	flight_2
SELECT Count(*) FROM airports	flight_2
SELECT airports.AirportName, airports.AirportName FROM airports WHERE airports.AirportCode NOT IN (SELECT flights.SourceAirport FROM flights)	flight_2
SELECT flights.FlightNo FROM airlines ON airlines.uid = airlines.uid JOIN airlines WHERE airlines.Airline = "United Airlines" 	flight_2
SELECT airports.AirportCode FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport GROUP BY flights.SourceAirport ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airports.AirportName FROM airports WHERE airports.AirportCode = "AKO" 	flight_2
SELECT airports.City, airports.Country FROM airports WHERE airports.AirportName = "Alton" 	flight_2
SELECT airlines.Abbreviation FROM airlines WHERE airlines.Airline = "JetBlue Airways" 	flight_2
SELECT Count(*) FROM flights WHERE flights.SourceAirport = "ATO" 	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.uid HAVING Count(*) >= 10	flight_2
SELECT airlines.Airline FROM airlines WHERE airlines.Abbreviation = "UAL" 	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.DestAirport = "APG" 	flight_2
SELECT airlines.Airline FROM airlines WHERE airlines.Abbreviation = "UAL" 	flight_2
SELECT flights.FlightNo FROM flights WHERE flights.SourceAirport = "APG" 	flight_2
SELECT airports.City FROM airports GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport = "CVO" EXCEPT SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline WHERE flights.SourceAirport = "APG" 	flight_2
SELECT airlines.Airline FROM airlines ON airlines.uid = airlines.uid JOIN flights WHERE airports.AirportCode = "CVO" EXCEPT SELECT airlines.Airline FROM airlines JOIN airports WHERE flights.SourceAirport = "APG" 	flight_2
SELECT Count(*) FROM flights	flight_2
SELECT Count(*) FROM flights	flight_2
SELECT airlines.Abbreviation, airlines.Country FROM airlines GROUP BY airlines.Abbreviation ORDER BY Count(*) Asc LIMIT 1	flight_2
SELECT Count(*) FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport WHERE airports.City = "Aberdeen" OR airports.City = "Abilene" 	flight_2
SELECT airports.City FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode GROUP BY airports.City ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline ORDER BY Count(*) Desc LIMIT 1	flight_2
SELECT Count(*) FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode WHERE flights.SourceAirport = "AHD" AND airlines.Airline = "United" 	flight_2
SELECT Count(*) FROM airlines	flight_2
