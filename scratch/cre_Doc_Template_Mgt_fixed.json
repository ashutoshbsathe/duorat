SELECT Ref_Template_Types.Template_Type_Code, Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Code = "AD" 	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name = "Welcome to NY" 	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Template_ID FROM Documents GROUP BY Documents.Template_ID HAVING Count(*) > 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name = "Welcome to NY" 	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types EXCEPT SELECT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING Count(*) <= 2	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Description = "Book" 	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Documents.Document_ID HAVING Count(*) >= 2	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name = "Customer reviews" 	cre_Doc_Template_Mgt
SELECT Count(*) FROM Paragraphs	cre_Doc_Template_Mgt
SELECT DISTINCT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Documents.Document_Description FROM Documents	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code, Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name = "Summer Show" 	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text LIKE "%Brazil%" INTERSECT SELECT Documents.Document_ID FROM Paragraphs JOIN Paragraphs WHERE Paragraphs.Paragraph_Text LIKE "Ireland%" 	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates WHERE Templates.Template_Type_Code = "CV" 	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Template_Type_Code FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Template_Type_Code FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text = "Brazil" INTERSECT SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Paragraphs.Paragraph_Text = "Ireland" 	cre_Doc_Template_Mgt
SELECT Count(*) FROM Templates	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Documents.Template_ID, Count(*) FROM Documents GROUP BY Documents.Template_ID	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates ORDER BY Templates.Template_Type_Code Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID, Count(*) FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Documents.Document_Name = "Data base" 	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates WHERE Templates.Template_Type_Code = "PP" OR Templates.Template_Type_Code = "PPT" 	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT DISTINCT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Other_Details FROM Paragraphs WHERE Paragraphs.Paragraph_Text = "Korea" 	cre_Doc_Template_Mgt
SELECT Count(DISTINCT Documents.Template_ID) FROM Documents	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING Count(*) BETWEEN 1 AND 2	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types WHERE Ref_Template_Types.Template_Type_Description = "Book" 	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Documents.Document_Name = "Data base" 	cre_Doc_Template_Mgt
SELECT DISTINCT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code HAVING Count(*) < 3	cre_Doc_Template_Mgt
SELECT Templates.Template_ID, Templates.Version_Number, Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Documents.Document_Name FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = "BK" 	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code HAVING Count(*) < 3	cre_Doc_Template_Mgt
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Count(*) FROM Paragraphs	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates WHERE Templates.Version_Number < 5	cre_Doc_Template_Mgt
SELECT Documents.Template_ID FROM Documents GROUP BY Documents.Template_ID HAVING Count(*) > 1	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code FROM Templates GROUP BY Templates.Template_Type_Code ORDER BY Count(*) Desc LIMIT 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Paragraph_Text FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID WHERE Documents.Document_Name = "Customer reviews" 	cre_Doc_Template_Mgt
SELECT Documents.Document_Name, Documents.Template_ID FROM Documents WHERE Documents.Document_Description LIKE "%w%" 	cre_Doc_Template_Mgt
SELECT Documents.Document_Name FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = "BK" 	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = "PPT" 	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code WHERE Ref_Template_Types.Template_Type_Description = "Presentation" 	cre_Doc_Template_Mgt
SELECT Count(*) FROM Documents	cre_Doc_Template_Mgt
SELECT Paragraphs.Document_ID, Count(*) FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY Count(*) Asc	cre_Doc_Template_Mgt
SELECT Templates.Template_ID FROM Templates EXCEPT SELECT Documents.Template_ID FROM Documents	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types EXCEPT SELECT Templates.Template_Type_Code FROM Templates	cre_Doc_Template_Mgt
SELECT Templates.Template_Type_Code, Count(*) FROM Templates GROUP BY Templates.Template_Type_Code	cre_Doc_Template_Mgt
SELECT Templates.Version_Number, Templates.Template_Type_Code FROM Templates ORDER BY Templates.Version_Number Asc LIMIT 1	cre_Doc_Template_Mgt
SELECT Paragraphs.Other_Details FROM Paragraphs WHERE Paragraphs.Paragraph_Text LIKE "%Korea%" 	cre_Doc_Template_Mgt
SELECT Documents.Document_ID, Documents.Document_Name, Count(*) FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID	cre_Doc_Template_Mgt
