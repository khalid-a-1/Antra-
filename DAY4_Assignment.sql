/* Write queries for following scenarios
Use Northwind database. All questions are based on assumptions described 
by the Database Diagram sent to you yesterday. When inserting, make up info if necessary. 
Write query for each step. 
Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
*/

/* 1. Create a view named “view_product_order_[your_last_name]”, list all products 
and total ordered quantity for that product.
*/

CREATE VIEW [view_product_order_Khalid] AS
SELECT Products.ProductID, Products.ProductName, SUM(OD.Quantity) AS Ordered_Quantity 
FROM Products JOIN [Order Details] OD ON Products.ProductID = OD.ProductID 
GROUP BY Products.ProductID, Products.ProductName

/* 2. Create a stored procedure “sp_product_order_quantity_[your_last_name]” 
that accept product id as an input and total quantities of order as output parameter.
*/

SELECT * FROM view_product_order_Khalid

DROP PROCEDURE sp_product_order_quantity_Khalid
GO
-----

CREATE PROCEDURE sp_product_order_quantity_Khalid @ProdID INT AS
SELECT Ordered_Quantity FROM view_product_order_Khalid 
WHERE ProductID = @ProdID
GO

EXEC sp_product_order_quantity_Khalid @ProdID = 11

/* 3. Create a stored procedure “sp_product_order_city_[your_last_name]” 
that accept product name as an input and top 5 cities that ordered most that 
product combined with the total quantity of that product ordered from that city as output.
*/

SELECT Products.ProductID, Products.ProductName, SUM(OD.Quantity) AS Total_Ordered_Quantity, Orders.ShipCity 
FROM Products JOIN [Order Details] OD ON Products.ProductID = OD.ProductID 
JOIN Orders ON OD.OrderID = Orders.OrderID 
GROUP BY Products.ProductID, Products.ProductName, Orders.ShipCity 
-----

CREATE PROCEDURE sp_product_order_city_Khalid @ProdName nvarchar(100) AS
SELECT TOP 5 Orders.ShipCity, SUM(OD.Quantity) AS Total_Ordered_Quantity
FROM Products JOIN [Order Details] OD ON Products.ProductID = OD.ProductID 
JOIN Orders ON OD.OrderID = Orders.OrderID 
WHERE Products.ProductName = @ProdName
GROUP BY Orders.ShipCity ORDER BY Total_Ordered_Quantity DESC
GO

EXEC sp_product_order_city_Khalid @ProdName = 'Ipoh Coffee'

/* 4. Create 2 new tables: “people_your_last_name”, “city_your_last_name”. 
City table has two records: 
{Id:1, City: Seattle}, 
{Id:2, City: Green Bay}. 
People has three records: 
{id:1, Name: Aaron Rodgers, City: 2}, 
{id:2, Name: Russell Wilson, City:1}, 
{Id: 3, Name: Jody Nelson, City:2}. 
Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. 
Create a view “Packers_your_name” lists all people from Green Bay. 
If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
*/

DROP TABLE city_Khalid
DROP TABLE people_Khalid

CREATE TABLE city_Khalid(
    Id INT,
    City varchar(255)
)

INSERT INTO city_Khalid (Id, City)
VALUES (1, 'Seattle')
INSERT INTO city_Khalid (Id, City)
VALUES (2, 'Green Bay')

SELECT * FROM city_Khalid

CREATE TABLE people_Khalid(
    Id INT,
    Name varchar(255),
    City INT
)

INSERT INTO people_Khalid (Id, Name, City)
VALUES (1, 'Aaron Rodgers', 2)
INSERT INTO people_Khalid (Id, Name, City)
VALUES (2, 'Russell Wilson', 1)
INSERT INTO people_Khalid (Id, Name, City)
VALUES (3, 'Jody Nelson', 2)

SELECT * FROM people_Khalid

UPDATE city_Khalid
SET City = 'Madison'
WHERE Id = 1

CREATE VIEW Packers_Khalid AS 
SELECT Name FROM people_Khalid WHERE City = 2

DROP TABLE city_Khalid
DROP TABLE people_Khalid
DROP VIEW Packers_Khalid 

/* 5. Create a stored procedure “sp_birthday_employees_[you_last_name]” 
that creates a new table “birthday_employees_your_last_name” and fill it with all employees 
that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.
*/


CREATE PROCEDURE sp_birthday_employees_Khalid AS
SELECT * INTO birthday_employees_Khalid FROM Employees WHERE MONTH(BirthDate) = 2
GO

EXEC sp_birthday_employees_Khalid

SELECT * FROM birthday_employees_Khalid

DROP TABLE birthday_employees_Khalid

/* 6. How do you make sure two tables have the same data?
*/

/*Below will return all rows that are in one table but not the other
 (so 0 rows if the tables have identical data): */
(TABLE a EXCEPT TABLE b)
UNION ALL
(TABLE b EXCEPT TABLE a) 