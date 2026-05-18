USE MyDatabase;
-- BASIC JOINS
-- Key Column for Matching columns from LEFT and RIGHT Tables

-- NO JOIN ( Fetching data from 2 different tables )
SELECT * 
FROM customers;

SELECT * 
FROM orders;

-- INNER JOIN 
-- Uses: Recombine Data
SELECT 
    id,
    first_name,
    score,
    sales,
    customer_id  -- Enlist all columns which you want in combined table
FROM customers
INNER JOIN orders
ON customer_id = id; -- if condition match columns of the tablle will be combined 

SELECT 
    customers.id, 
    customers.first_name, 
    orders.sales,
    orders.customer_id  -- table_name.column_name is best practice and compulsory if  2 columns have same name
FROM customers
JOIN orders -- If you does not speccify JOIN TYPE Default will be INNER ( But best to mention )
ON customer_id= id; 

-- BEST APPROACH
SELECT 
    c.id, 
    c.first_name, 
    o.sales,
    o.customer_id 
FROM orders AS o -- Position of Names of tables is random in INNER JOIN
INNER JOIN customers AS c  -- For ease you can use alias
ON customer_id = id;

-- LEFT JOIN 
-- Left Table is Primary Source of Data and RIGHT Table is Secondary Source of Data 
-- Uses: Recombine Data, Data Enrichment
SELECT 
    c.id, 
    c.first_name, 
    o.sales,
    o.customer_id
FROM customers as c  --  Position of Names of tables is fixed in LEFT JOIN
LEFT JOIN orders as o
ON c.id = o.customer_id;
-- Same Result using RIGHT JOIN and shuffle tables position ( Alternative )
SELECT 
    c.id, 
    c.first_name, 
    o.sales,
    o.customer_id
FROM orders as o  --  Position of Names of tables is fixed in LEFT JOIN
RIGHT JOIN customers as c
ON c.id = o.customer_id;

-- RIGHT JOIN 
-- RIGHT Table is Primary Source of Data and LEFT Table is Secondary Source of Data 
-- Uses: Recombine Data, Data Enrichment
SELECT 
    c.id, 
    c.first_name, 
    o.sales,
    o.customer_id
FROM customers as c  --  Position of Names of tables is fixed in RIGHT JOIN
RIGHT JOIN orders as o
ON c.id = o.customer_id;
-- Same Result using LEFT JOIN and shuffle tables position ( Alternative )
SELECT 
    c.id, 
    c.first_name, 
    o.sales,
    o.customer_id
FROM orders as o  --  Position of Names of tables is fixed in RIGHT JOIN
LEFT JOIN customers as c
ON c.id = o.customer_id;

-- SQL MINI TASK
SELECT 
    first_name, 
    country, 
    order_date
FROM customers AS c
LEFT JOIN orders AS o
ON customer_id = id;

-- FULL JOIN
-- Uses: Recombine Data
SELECT 
    id, 
    first_name,
    country,
    customer_id, 
    sales, 
    order_date
FROM customers AS c --  Position of Names of tables is random in FULL JOIN
FULL JOIN orders AS o
ON customer_id = id;

-- ADVANCED JOINS 

-- LEFT ANTI JOIN 
-- Uses: Filter Data
-- LEFT TABLE is Primary Source of data which will be filtered and RIGHT TABLE is Lookup Table and no data will be taken from it 
SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id 
WHERE o.customer_id is NULL
-- Same Result using LEFT JOIN and shuffle tables position ( Alternative )
SELECT * 
FROM orders AS o
RIGHT JOIN customers AS c
ON c.id = o.customer_id 
WHERE o.customer_id is NULL 

-- RIGHT ANTI JOIN 
-- Uses: Filter Data
-- RIGHT TABLE is Primary Source of data which will be filtered and LEFT TABLE is Lookup Table and no data will be taken from it 
SELECT * 
FROM customers AS customer
RIGHT JOIN orders AS myorder
ON customer.id = myorder.customer_id
WHERE customer.id is NULL 
-- Same Result using LEFT JOIN and shuffle tables position ( Alternative )
SELECT * 
FROM orders AS myorder 
LEFT JOIN customers AS customer
ON customer.id = myorder.customer_id
WHERE customer.id is NULL 

-- FULL ANTI JOIN 
-- Uses: Filter Data
-- Show totally Unmatched Data from RIGHT and LEFT TABLE
SELECT * 
FROM customers AS c -- Position of tables are random and you will got same results from both cases
FULL JOIN orders as o
ON customer_id = id
WHERE customer_id is NULL OR id is NULL

-- SQL MINI TASK
SELECT *
FROM customers
LEFT JOIN orders
ON customer_id = id 
WHERE customer_id IS NOT NULL 

-- CROSS JOIN ( CARTERSIAN PRODUCT )
-- Uses: To see All Possible Combinations
SELECT * 
FROM customers
CROSS JOIN orders
-- Same Results by shuffling the table 
SELECT * 
FROM orders
CROSS JOIN customers

USE SalesDB
SELECT * FROM Sales.Customers

SELECT * FROM Sales.Employees

SELECT * FROM Sales.Orders

SELECT * FROM Sales.OrdersArchive

SELECT * FROM Sales.Products

-- MULTI JOINS
SELECT	
	o.OrderID,
	o.Quantity AS Amount,
	o.Sales AS 'No of Sales',
	o.OrderDate,
	o.OrderStatus
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON O.CustomerID = C.CustomerID
LEFT JOIN Sales.Products AS p
ON O.CustomerID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON O.CustomerID = e.EmployeeID
-- WHERE < CONDITION > -- You can put condition for above Joining ( it will be checked for every joining )


-- SET OPERATORS

-- Rule # 01 SET Operator can be used with all SQL Clauses Except ORDER BY
-- Rule # 02 The number of Columns in each TABLE must be the same
-- Rule # 03 Data Types of Columns in each Query must be the same 
-- Rule # 04 The order of Columns in each Query must be the same
-- Rule # 05 The column name in the result set are determined by the Column names specified in the first Query 
-- Rule # 06 Incorrect Columns Selection may leads to inaccurate results

-- UNION
-- Remove Duplicates, No Repetition of Data is allowed
-- Order of Queries does not matter
SELECT 
    FirstName AS 'Name', 
    LastName AS 'Father Name' 
FROM Sales.Customers
UNION 
SELECT FirstName, LastName 
FROM Sales.Employees;

-- UNION ALL
-- Faster than UNION, Allow Duplicates, Return all rows as it as, just combine tables including duplicates
-- Order of Queries does not matter
SELECT 
    FirstName AS 'Name', 
    LastName AS 'Father Name' 
FROM Sales.Customers
UNION ALL
SELECT FirstName, LastName 
FROM Sales.Employees;

-- EXCEPT ( MINUS )
-- Return all distinct rows from First Query Table that are not found in the Second Query Table
-- Order of Queries does matter
SELECT 
    FirstName AS 'Name', 
    LastName AS 'Father Name' 
FROM Sales.Customers
EXCEPT
SELECT FirstName, LastName 
FROM Sales.Employees;

-- INTERSECT
-- Return only those Rows which are common in both Queries Tables, Remove Duplicate ( This makes it different from INNER JOIN )
-- Order of Queries does not matter
SELECT 
    FirstName AS 'Name', 
    LastName AS 'Father Name' 
FROM Sales.Customers
INTERSECT
SELECT FirstName, LastName 
FROM Sales.Employees;

-- MINI TASK
SELECT 
'Orders' AS SourceTable, -- Mention sourcen TABLE
       OrderID
      ,ProductID
      ,CustomerID
      ,SalesPersonID
      ,OrderDate
      ,ShipDate
      ,OrderStatus
      ,ShipAddress
      ,BillAddress
      ,Quantity
      ,Sales
      ,CreationTime
FROM Sales.Orders
UNION
SELECT  
'OrdersArchive' AS SourceTable, -- Mention sourcen TABLE
       OrderID
      ,ProductID
      ,CustomerID
      ,SalesPersonID
      ,OrderDate
      ,ShipDate
      ,OrderStatus
      ,ShipAddress
      ,BillAddress
      ,Quantity
      ,Sales
      ,CreationTime
FROM Sales.OrdersArchive

-- IMP POINT 
SELECT 
    [CustomerID], 
    [OrderID],
    [ProductID] -- You can also Put Square Brackets around them ( Totally Acceptable )
FROM Sales.Orders

SELECT   
    [Quantity] AS Amount,
    [Sales] AS 'My Sales', 
    [CreationTime] AS MFG
FROM Sales.Orders



