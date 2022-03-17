/* Write queries for following scenarios
*/

/* 1. How many products can you find in the Production.Product table?
*/

SELECT COUNT(DISTINCT ProductId) AS No_of_Products FROM Production.Product

/* 2. Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
*/

SELECT COUNT(DISTINCT ProductId) AS No_of_Products, ProductSubcategoryID FROM Production.Product 

/* 3. How many Products reside in each SubCategory? Write a query to display the results with the following titles.
ProductSubcategoryID     CountedProducts
*/

SELECT ProductSubcategoryID, COUNT(DISTINCT ProductId) AS CountedProducts
FROM Production.Product GROUP BY ProductSubcategoryID

/* 4. How many products that do not have a product subcategory.
*/

SELECT COUNT(DISTINCT ProductId) AS Null_Products FROM Production.Product
WHERE ProductSubCategoryID IS NULL

/* 5. Write a query to list the sum of products quantity in the Production.ProductInventory table.
*/

SELECT SUM(Quantity) AS Sum_ProductQuantity FROM Production.ProductInventory

/* 6. Write a query to list the sum of products in the Production.ProductInventory table and LocationID 
set to 40 and limit the result to include just summarized quantities less than 100.
ProductID       TheSum
*/

SELECT ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory WHERE LocationID = 40 AND Quantity < 100
GROUP BY ProductID

/* 7. Write a query to list the sum of products with the shelf information in the Production.ProductInventory 
table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
Shelf      ProductID    TheSum
*/

SELECT Shelf, ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory WHERE LocationID = 40 AND Quantity < 100
GROUP BY ProductID, Shelf

/* 8. Write the query to list the average quantity for products where column LocationID has the value of 10 
from the table Production.ProductInventory table.
*/

SELECT ProductID, AVG(Quantity) AS Avg_Quantity FROM Production.ProductInventory WHERE LocationID = 10 GROUP BY ProductID

/* 9. Write query to see the average quantity of products by shelf from the table Production.ProductInventory
ProductID     Shelf      TheAvg
*/

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg FROM Production.ProductInventory GROUP BY ProductID, Shelf

/* 10. Write query  to see the average quantity  of  products by shelf excluding rows that has 
the value of N/A in the column Shelf from the table Production.ProductInventory
ProductID   Shelf      TheAvg
*/

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg FROM Production.ProductInventory 
GROUP BY ProductID, Shelf HAVING Shelf != 'N/A'

/* 11.  List the members (rows) and average list price in the Production.Product table. 
This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
Color       Class       TheCount       AvgPrice
*/

SELECT Color, Class, COUNT(ProductID) AS TheCount, AVG(ListPrice) AS AvgPrice FROM  Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL GROUP BY Color, Class

/* Joins: */

/* 12. Write a query that lists the country and province names from person. 
CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
Country     Province
*/

SELECT Person.CountryRegion.Name AS COUNTRY, Person.StateProvince.Name AS Province 
FROM Person.StateProvince JOIN Person.CountryRegion 
ON Person.StateProvince.CountryRegionCode = Person.CountryRegion.CountryRegionCode

/* 13.  Write a query that lists the country and province names from person. 
CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. 
Join them and produce a result set similar to the following.
Country              Province
*/

SELECT Person.CountryRegion.Name  AS Country, Person.StateProvince.Name AS Province
FROM Person.StateProvince JOIN Person.CountryRegion
ON Person.StateProvince.CountryRegionCode = Person.CountryRegion.CountryRegionCode 
WHERE Person.CountryRegion.Name IN ('GERMANY', 'CANADA')

/*  Using Northwnd Database: (Use aliases for all the Joins) */

/* 14. List all Products that has been sold at least once in last 25 years.
*/

SELECT ODE.ProductName, Orders.OrderDate, YEAR(GETDATE()) AS Year FROM [Order Details Extended] ODE JOIN Orders
ON ODE.OrderID = Orders.OrderID WHERE (YEAR(Orders.OrderDate) >= YEAR(GETDATE())-25) 

/* 15. List top 5 locations (Zip Code) where the products sold most.
*/

SELECT TOP 5 Orders.ShipPostalCode FROM Customers JOIN Orders ON
Customers.customerID = Orders.customerID WHERE Customers.PostalCode IS NOT NULL

/* 16. List top 5 locations (Zip Code) where the products sold most in last 25 years.
*/

SELECT TOP 5 Customers.PostalCode FROM [Order Details Extended] ODE
JOIN Orders ON ODE.OrderID = Orders.OrderID 
JOIN Customers ON Customers.customerID = Orders.customerID WHERE Customers.PostalCode IS NOT NULL 
GROUP BY Customers.PostalCode

/* 17. List all city names and number of customers in that city. 
*/

SELECT Customers.City, COUNT(Customers.CustomerID) AS Number_of_Customers
FROM Orders LEFT JOIN customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.City

/* 18. List city names which have more than 2 customers, and number of customers in that city
*/

SELECT Customers.City, COUNT(Customers.CustomerID) AS Number_of_Customers FROM Orders RIGHT JOIN Customers ON
Orders.CustomerID = Customers.CustomerID GROUP BY Customers.City HAVING COUNT(Customers.CustomerID) > 2

/* 19. List the names of customers who placed orders after 1/1/98 with order date.
*/

SELECT Customers.ContactName, Orders.OrderDate FROM customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.orderdate > '01-01-1998'

/* 20. List the names of all customers with most recent order dates
*/

SELECT TOP 5 Customers.ContactName, Orders.OrderDate FROM Customers JOIN Orders ON
Customers.CustomerID = Orders.CustomerID ORDER by Orders.OrderDate DESC

/* 21. Display the names of all customers  along with the  count of products they bought
*/

SELECT Customers.ContactName, COUNT(ODE.ProductID) AS Product_Count FROM Customers JOIN Orders ON
Customers.CustomerID = Orders.CustomerID JOIN [Order Details Extended] ODE ON ODE.OrderID = Orders.OrderID
GROUP BY Customers.ContactName

/* 22. Display the customer ids who bought more than 100 Products with count of products.
*/

SELECT Customers.ContactName, COUNT(ODE.productID) AS Product_Count
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details Extended] ODE ON ODE.OrderID = Orders.OrderID 
GROUP BY Customers.ContactName HAVING COUNT(ODE.ProductID) > 100

/* 23. List all of the possible ways that suppliers can ship their products. Display the results as below
Supplier Company Name         Shipping Company Name
*/

SELECT Suppliers.CompanyName, Shippers.CompanyName FROM Suppliers CROSS JOIN Shippers

/* 24. Display the products order each day. Show Order date and Product Name.
*/

SELECT Orders.OrderDate, Products.ProductName
FROM Orders JOIN [Order Details Extended] ODE
on Orders.OrderID = ODE.OrderID JOIN Products ON
Products.productID = ODE.ProductID

/* 25. Displays pairs of employees who have the same job title.
*/

SELECT Employees.EmployeeID, Employees.FirstName + ' ' + Employees.LastName 
AS Employee_Name, Employees.Title FROM Employees ORDER BY Employees.Title 

/* 26. Display all the Managers who have more than 2 employees reporting to them.
*/

SELECT Employees.EmployeeID, Employees.FirstName + ' ' + Employees.LastName AS Manager_Name, 
Employees.ReportsTo AS Employees_Reporting_to_Them
FROM Employees WHERE ReportsTo > 2 AND ReportsTo IS NOT NULL

/* 27. Display the customers and suppliers by city. The results should have the following columns
City
Name
Contact Name
Type (Customer or Supplier)
*/

SELECT Customers.City, Customers.ContactName AS Customer_ContactName, Suppliers.ContactName AS Suppliers_ContactName
FROM Customers FULL OUTER JOIN Suppliers ON Customers.City = Suppliers.City




