SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id WHERE Owners.state ="Virginia"	dog_kennels
SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.dog_id NOT IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs	dog_kennels
SELECT Count(*) FROM Professionals WHERE Professionals.professional_id NOT IN (SELECT Treatments.professional_id FROM Treatments)	dog_kennels
SELECT Treatments.date_of_treatment, Professionals.first_name FROM Treatments JOIN Professionals ON Treatments.professional_id = Professionals.professional_id	dog_kennels
SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Professionals.state ="Indiana"UNION SELECT Professionals.professional_id, Professionals.last_name, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) > 2	dog_kennels
SELECT Professionals.first_name, Treatment_Types.treatment_type_description FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Count(DISTINCT Treatments.professional_id) FROM Treatments	dog_kennels
SELECT Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code GROUP BY Treatments.treatment_type_code ORDER BY Sum(Treatments.cost_of_treatment) Asc LIMIT 1	dog_kennels
SELECT Dogs.age FROM Dogs ORDER BY Dogs.date_of_birth Desc LIMIT 1	dog_kennels
SELECT Dogs.date_arrived, Dogs.date_departed FROM Dogs	dog_kennels
SELECT Owners.owner_id, Owners.first_name, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id GROUP BY Owners.owner_id ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT DISTINCT Dogs.date_arrived, Dogs.date_departed FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id	dog_kennels
SELECT Treatments.date_of_treatment, Professionals.first_name FROM Treatments JOIN Professionals ON Treatments.professional_id = Professionals.professional_id	dog_kennels
SELECT Treatments.cost_of_treatment, Treatment_Types.treatment_type_description FROM Treatments JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code	dog_kennels
SELECT Owners.first_name, Owners.last_name, Dogs.size_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Dogs.date_arrived, Dogs.date_departed FROM Dogs	dog_kennels
SELECT Owners.first_name, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id WHERE Owners.state ="Virginia"	dog_kennels
SELECT Charges.charge_type, Charges.charge_amount FROM Charges	dog_kennels
SELECT Owners.owner_id, Owners.zip_code FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id GROUP BY Owners.owner_id ORDER BY Sum(Charges.charge_amount) Desc LIMIT 1	dog_kennels
SELECT Dogs.name, Dogs.age, Dogs.weight FROM Dogs WHERE Dogs.abandoned_yn = 1	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.dog_id NOT IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Professionals.email_address FROM Professionals WHERE Professionals.state ="Hawaii"OR Professionals.state ="Wisconsin"	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.first_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Count(DISTINCT Treatments.dog_id) FROM Treatments	dog_kennels
SELECT Dogs.name, Dogs.age, Dogs.weight FROM Dogs WHERE Dogs.abandoned_yn = 1	dog_kennels
SELECT Professionals.first_name, Treatment_Types.treatment_type_description FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code	dog_kennels
SELECT Owners.owner_id, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id JOIN Treatments ON Dogs.dog_id = Treatments.dog_id GROUP BY Owners.owner_id ORDER BY Sum(Owners.last_name) Desc LIMIT 1	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals EXCEPT SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Dogs.age FROM Dogs ORDER BY Dogs.date_of_birth Desc LIMIT 1	dog_kennels
SELECT Professionals.professional_id, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Owners.first_name, Owners.last_name, Owners.email_address FROM Owners WHERE Owners.state LIKE"%North%"	dog_kennels
SELECT Sum(Treatments.cost_of_treatment) FROM Treatments ORDER BY Treatments.date_of_treatment Desc LIMIT 1	dog_kennels
SELECT Owners.first_name, Owners.last_name, Owners.email_address FROM Owners WHERE Owners.state LIKE"%North%"	dog_kennels
SELECT Owners.first_name, Dogs.name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id	dog_kennels
SELECT Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id ORDER BY Dogs.age Desc LIMIT 1	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals EXCEPT SELECT Professionals.professional_id, Professionals.role_code, Professionals.email_address FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id	dog_kennels
SELECT Owners.owner_id, Owners.last_name FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id JOIN Treatments ON Dogs.dog_id = Treatments.dog_id GROUP BY Owners.owner_id ORDER BY Sum(Treatments.cost_of_treatment) Desc LIMIT 1	dog_kennels
SELECT Count(*) FROM Dogs WHERE Dogs.age < (SELECT Avg(Dogs.age) FROM Dogs)	dog_kennels
SELECT Dogs.name FROM Dogs EXCEPT SELECT Dogs.name FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id WHERE Treatments.cost_of_treatment > 1000	dog_kennels
SELECT DISTINCT Dogs.breed_code, Dogs.size_code FROM Dogs	dog_kennels
SELECT Professionals.role_code, Professionals.street, Professionals.city, Professionals.state FROM Professionals WHERE Professionals.city LIKE"%West%"	dog_kennels
SELECT Treatments.cost_of_treatment FROM Treatments ORDER BY Treatments.date_of_treatment Desc LIMIT 1	dog_kennels
SELECT Charges.charge_type, Charges.charge_amount FROM Charges	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs WHERE Dogs.dog_id IN (SELECT Treatments.dog_id FROM Treatments)	dog_kennels
SELECT Owners.owner_id, Owners.first_name, Owners.last_name FROM Owners JOIN Dogs GROUP BY Owners.owner_id ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT Professionals.role_code, Professionals.street, Professionals.city, Professionals.state FROM Professionals WHERE Professionals.city LIKE"%West%"	dog_kennels
SELECT Count(*) FROM Owners WHERE Owners.owner_id NOT IN (SELECT Dogs.owner_id FROM Dogs)	dog_kennels
SELECT Count(DISTINCT Breeds.breed_code), Count(DISTINCT Breeds.breed_name) FROM Breeds	dog_kennels
SELECT Professionals.professional_id, Professionals.cell_number FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Dogs.name, Treatments.date_of_treatment FROM Dogs JOIN Breeds ON Dogs.breed_code = Breeds.breed_code JOIN Treatments ON Dogs.dog_id = Treatments.dog_id ORDER BY Breeds.breed_name Asc LIMIT 1	dog_kennels
SELECT DISTINCT Dogs.date_arrived, Dogs.date_departed FROM Dogs JOIN Treatments ON Dogs.dog_id = Treatments.dog_id	dog_kennels
SELECT Professionals.first_name, Professionals.last_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Treatments.cost_of_treatment < (SELECT Avg(Treatments.cost_of_treatment) FROM Treatments)	dog_kennels
SELECT Breeds.breed_name FROM Breeds JOIN Dogs ON Breeds.breed_code = Dogs.breed_code GROUP BY Dogs.breed_code ORDER BY Count(*) Desc LIMIT 1	dog_kennels
SELECT DISTINCT Professionals.first_name, Professionals.last_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id WHERE Treatments.cost_of_treatment < (SELECT Avg(Treatments.cost_of_treatment) FROM Treatments)	dog_kennels
SELECT Professionals.professional_id, Professionals.role_code, Professionals.first_name FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id HAVING Count(*) >= 2	dog_kennels
SELECT Avg(Dogs.age) FROM Dogs	dog_kennels
SELECT Owners.state FROM Owners INTERSECT SELECT Professionals.state FROM Professionals	dog_kennels
