-- Data Architecture

-- Accessing Metadata 
USE SalesDB
SELECT 
	*
FROM INFORMATION_SCHEMA.COLUMNS

SELECT 
	DISTINCT CATALOG_NAME
FROM INFORMATION_SCHEMA.SCHEMATA

SELECT 
	DISTINCT TABLE_CATALOG
FROM INFORMATION_SCHEMA.TABLES

-- Subquery

-- Result Types:

-- Scaler Query
SELECT
	AVG(Sales) AS average
FROM Sales.Orders

-- Row Query
SELECT
	Sales AS [sales]
FROM Sales.Orders

-- Table Query
SELECT
	* 
FROM Sales.Orders

-- Location / Clause Types:

-- FROM subquery
SELECT 
	*
FROM (SELECT AVG(Sales) OVER() AS AvgSales  FROM Sales.Orders) AS t  -- aliases are comlusory

-- SQL TASK
SELECT 
	*
FROM (SELECT ProductID, Price, AVG(Price) OVER() AS AvgPrice FROM Sales.Products) AS t
WHERE Price > AvgPrice
 
-- SELECT Subquery
SELECT 
	ProductID,
	Product,
	Price, 
	(SELECT	COUNT(*) Orders FROM Sales.Orders)	 -- Must be Scaler query and aliases are not comlusory
FROM Sales.Products

-- JOINS Subquery
SELECT 
	*
FROM Sales.Customers AS c
LEFT JOIN (SELECT CustomerID, COUNT(*) TotalOrders FROM Sales.Customers GROUP BY CustomerID) AS o
ON c.CustomerID =  o.CustomerID

-- WHERE Subquery

-- Comparison Operators ( >, <, =, >=, <= )
-- They compare two values
SELECT 
	ProductID,
	Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) AS AvgPrice FROM Sales.Products)   -- Must be Scaler query and aliases are not comlusory

-- Logical Operators ( IN, ANY, ALL, EXISTS )

-- IN
SELECT 
	*
FROM Sales.Orders
WHERE CustomerID IN (1,4) -- can return multiple values and aliases are not compulosry

SELECT 
	*
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany') 
-- Opposite Case
SELECT 
	*
FROM Sales.Orders
WHERE CustomerID  NOT IN (1,4) 

-- ANY 
SELECT 
	EmployeeID,
	Gender,
	FirstName AS EmployeName,
	Salary
FROM Sales.Employees	
WHERE Gender = 'F' AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M') 

-- ALL 
SELECT 
	EmployeeID,
	Gender,
	FirstName AS EmployeName,
	Salary
FROM Sales.Employees	
WHERE Gender = 'M' AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender = 'F') 

-- EXISTS (check if subquery returns anything(TRUE) or not(FALSE))
SELECT 
	* 
FROM Sales.Orders AS o
WHERE EXISTS (SELECT * FROM Sales.Customers AS c WHERE Country = 'Germany' AND c.CustomerID = o.CustomerID)

SELECT 
	* 
FROM Sales.Orders AS o
WHERE NOT EXISTS (SELECT * FROM Sales.Customers AS c WHERE Country = 'Germany' AND c.CustomerID = o.CustomerID)

-- Dependency Types:

-- Correlated Subquery (Dependent on Main query, can't run on its on)
-- Non-Correlated Subquery (Dependent on Main query, can't run on its on) -- Used for Filtering with constants
SELECT 
	*,
	(SELECT COUNT(*) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID) AS TotalSales
FROM Sales.Customers AS c

-- Non-Correlated Subquery (Independent of Main query, can run on its on) -- Used for Dynamic Filtering
SELECT 
	*,
	(SELECT COUNT(*) FROM Sales.Orders AS o WHERE o.CustomerID = 1) AS TotalSales
FROM Sales.Customers AS c


-- CTE (Common Table Expression)
-- Temporary Virtual Table, can be used multiple times to simplify and organize complex query
-- Differnce b/w Sub query and CTE is that Subquery can be used only once and CTE can be used multiple times
-- Subquery might cause redundancy so we use CTE to avoid redundancy
-- Main query can retrieve data from CTE as well as Database

-- "ORDER BY (Sorting Clause can't be used in Subqueries, Viwes, CTE, Inline Function, Derived Tables."

-- CTE Types

-- None-Recursive CTE

-- Standalone CTE ( Independent CTE & Dependent Main Query )
WITH CTE_TotalSales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
SELECT
-- Aliases must be used when same column does exist in CTE and Main Query, otherwise SQL will be confused and give ERROR
	main.CustomerID, -- if you don't use alias, SQL will be confused and give ERROR bcz same column does esist in CTE
	FirstName,
	LastName,
	cte.TotalSales -- this is column from CTE, better to use CTE alias but will not give error if u not use alias
FROM Sales.Customers main
LEFT JOIN CTE_TotalSales AS cte
ON main.CustomerID = cte.CustomerID

-- Mutiple Standalone CTE
WITH CTE_TotalSales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_LastOrder AS
(
SELECT 
	CustomerID,
	MAX(OrderDate) AS LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)
SELECT
	main.CustomerID, 
	FirstName,
	LastName,
	cte1.TotalSales, 
	COALESCE(cte2.LastOrder,'2020-01-01') AS LAstOrder
FROM Sales.Customers main
LEFT JOIN CTE_TotalSales AS cte1
ON main.CustomerID = cte1.CustomerID
LEFT JOIN CTE_LastOrder AS cte2
ON main.CustomerID = cte2.CustomerID

-- Nested CTE (CTE within CTE)
-- First CTE is standalone CTE and all nested CTE depends upon latest CTE & Main Query can use any CTE data and dependent upon CTE
WITH CTE_TotalSales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_LastOrder AS
(
SELECT 
	CustomerID,
	MAX(OrderDate) AS LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_CustomerRank AS
(
SELECT  -- Depend on CTE_TotalSales
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) AS CusttomerRank
FROM CTE_TotalSales
)
SELECT
	main.CustomerID, 
	FirstName,
	COALESCE(LastName,'e.g John') AS LastName,
	COALESCE(cte1.TotalSales,00) AS TotalSales, 
	COALESCE(cte2.LastOrder,'2020-01-01') AS LAstOrder,
	COALESCE(CAST(cte3.CusttomerRank AS VARCHAR),'NILL') AS CustomerRank
FROM Sales.Customers main
LEFT JOIN CTE_TotalSales AS cte1
ON main.CustomerID = cte1.CustomerID
LEFT JOIN CTE_LastOrder AS cte2
ON main.CustomerID = cte2.CustomerID
LEFT JOIN CTE_CustomerRank as cte3
ON cte3.CustomerID = main.CustomerID

-- Recursive CTE (self referencing query that repeat processes data untill specific condition is met)
-- Use if u are navigating through hierarchical structure

WITH CTE_Series AS
(
-- Anchor query (executed only once)
SELECT 
	1 AS MyNumber
UNION ALL	
-- Recursive query (executed repeatedly untill condition met)
SELECT
	MyNumber + 1
FROM CTE_Series
WHERE Mynumber < 20  -- use > to get 20 iteration not = that will 21 iteration
)
SELECT
	*
FROM CTE_Series
OPTION(MAXRECURSION 28) -- set number of iterations, Default iterations is set to 100 times

-- SQL TASK
WITH CTE_EempHierarchical AS
(
SELECT 
	EmployeeID,
	FirstName,
	ManagerID,
	1 AS level
FROM Sales.Employees
WHERE ManagerID IS NULL
UNION ALL 
SELECT 
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	level + 1
FROM Sales.Employees AS e
INNER JOIN CTE_EempHierarchical AS cte4
ON e.ManagerID = cte4.EmployeeID
)
SELECT 
	*
FROM CTE_EempHierarchical


-- VIEWS
CREATE VIEW VIEW_MonthlySummary  AS  -- It will go in a default Schema dbo
(
SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate) 
)

CREATE VIEW Sales.VIEW_MonthSummary AS -- here we have specified Schema as well 
(
SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate) 
)

-- Using view tp create table 
SELECT 
	*
FROM VIEW_MonthlySummary

-- Ways to alter View
-- first way (execute both steps one by one, in one go it will give error)
DROP VIEW Sales.VIEW_MonthSummary  -- first drop
CREATE VIEW Sales.VIEW_MonthSummary AS -- now recreate
(
SELECT
	SUM(Sales) TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate) 
)
-- Second way (using T-SQL)
-- T-SQL (Transact-SQL) -> only in SQL Server
-- It is an extension of SQL that adds programing features
IF OBJECT_ID('VIEW_MonthSummary', 'V') IS NOT NULL
	DROP VIEW VIEW_MonthSummary ;
GO
CREATE VIEW VIEW_MonthSummary AS -- now recreate
(
SELECT
	SUM(Sales) TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate) 
)		-- You can execute this many times, it will not produce ERROR because we handle the ERROR using T-SQL



-- Table Types:

-- Permanent Tables
-- Using DDL
-- Do study in DDL File 

-- CTAS
IF OBJECT_ID('Sales.MonthlyOrders','U') IS NOT NULL
DROP TABLE Sales.MonthlyOrders
GO 
SELECT
	DATENAME(MONTH, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)

-- Using as a Snapshot
SELECT 
	*
INTO SnashotTable
FROM Sales.Orders

-- Check
SELECT 
	*
FROM SnashotTable

-- Temp Tables
SELECT
	DATENAME(MONTH, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO #MonSales
FROM Sales.Orders
GROUP BY  DATENAME(MONTH, OrderDate)

-- Check
SELECT 
	* 
FROM #MonSales