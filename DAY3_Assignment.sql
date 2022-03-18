/* Write queries for following scenarios

All scenarios are based on Database NORTHWND.
*/

/* 1. List all cities that have both Employees and Customers.
*/

SELECT Employees.City FROM Employees WHERE Employees.City IN
(SELECT Customers.City FROM Customers WHERE Customers.City = Employees.City)
GROUP BY Employees.City

SELECT Employees.City FROM Employees, Customers WHERE Customers.City = Employees.City GROUP BY Employees.City

/* 2. List all cities that have Customers but no Employee.
    a. Use sub-query
    b. Do not use sub-query
*/

SELECT Customers.City FROM Customers WHERE Customers.City NOT IN
(SELECT Employees.City FROM Employees)
GROUP BY Customers.City

SELECT Customers.City FROM Customers, Employees WHERE Customers.City != Employees.City GROUP BY Customers.City

/*
3. List all products and their total order quantities throughout all orders.
*/

SELECT ODE.ProductName, COUNT(ODE.OrderID) AS Quantity FROM [Order Details Extended] ODE WHERE ODE.OrderID IN 
(SELECT Orders.OrderID FROM Orders)
GROUP BY ODE.ProductName

/* 4. List all Customer Cities and total products ordered by that city.
*/

SELECT Customers.City, COUNT(Customers.CustomerID) AS Quantity FROM Customers WHERE Customers.CustomerID IN
(SELECT Orders.CustomerID FROM Orders)
GROUP BY Customers.City

/* 5. List all Customer Cities that have at least two customers.
    a. Use union
    b. Use sub-query and no union
*/

SELECT Customers.CustomerID, Customers.City FROM Customers 
GROUP BY Customers.City, Customers.CustomerID HAVING COUNT(Customers.CustomerID) >= 2
UNION 
SELECT Orders.CustomerID, Orders.ShipCity FROM Orders 
GROUP BY Orders.CustomerID, Orders.ShipCity HAVING COUNT(Orders.CustomerID) >= 2

SELECT Customers.CustomerID, Customers.City FROM Customers WHERE Customers.CustomerID IN
(SELECT Orders.CustomerID FROM Orders)
GROUP BY Customers.City, Customers.CustomerID HAVING COUNT(Customers.CustomerID) >= 2

/* 6. List all Customer Cities that have ordered at least two different kinds of products.
*/

SELECT Orders.OrderID, Orders.ShipCity FROM Orders WHERE Orders.OrderID IN
(SELECT ODE.OrderID FROM [Order Details Extended] ODE GROUP BY ODE.OrderID HAVING COUNT(ODE.ProductID) > 2)
GROUP BY Orders.OrderID, Orders.ShipCity

/* 7. List all Customers who have ordered products, but have the ‘ship city’ on the order 
different from their own customer cities.
*/

SELECT Orders.CustomerID, Orders.ShipCity FROM Orders WHERE Orders.ShipCity NOT IN
(SELECT Customers.City FROM Customers)

/* 8. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
*/

SELECT ODE.ProductName, ODE.UnitPrice, Customers.City
FROM [Order Details Extended] ODE, Customers 


/* 9. List all cities that have never ordered something but we have employees there.
    a. Use sub-query
    b. Do not use sub-query
*/

/* 10. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
and also the city of most total quantity of products ordered from. (tip: join  sub-query)
*/

/* 11. How do you remove the duplicates record of a table?
*/
/*
Find duplicate rows using GROUP BY clause or ROW_NUMBER() function.
Use DELETE statement to remove the duplicate rows.
*/