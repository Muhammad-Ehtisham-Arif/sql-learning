-- Perfomance Optimization

-- HEAP
-- Table wihtout any index is called Heap

-- Indexes (Data Structure providing quick access to data, optimizing speed)

-- Index Types

-- On the basis of Structure:

-- Clustered Index  -> we can only create one clustered index for one table
-- B(Balence)-Tree (Root node   ->   intermediate node   ->   leaf node)
CREATE CLUSTERED INDEX idx_DBCustomer_CustomerID ON Sales.DBCustomers (CustomerID)

DROP INDEX idx_DBCustomer_CustomerID ON Sales.DBCustomers

-- Non-Clustered Index  -> we can create multpiple non-clusteres index for the same table
CREATE NONCLUSTERED INDEX idx_DBCustomer_LastName ON Sales.DBCustomers (LastName)  -- Single index

DROP INDEX idx_DBCustomer_LastName ON Sales.DBCustomers

CREATE INDEX idx_DBCustomer_CountryScore ON Sales.DBCustomers (Country,Score)  -- Composite index
-- by default it will be non-clusterered

DROP INDEX idx_DBCustomer_CountryScore ON Sales.DBCustomers

-- Left most Rule: left indexes will be used e.g., A,B,C,D
-- Case-I: A or A,B or A,B,C  or A,C,B  or C,B,A -> in all cases indexes will be used
-- Case-II: B or B,C or A,B,D -> in all cases indexes will not be used

-- On the basis of Storage:

-- ColumnStore Index
-- Best for OLAP(Online Analytical Processing) -> Data warehouses, BI, Reporting, Analytics 
-- You can create only one either clustered or non-clustered index in SQL Server
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomer_CS ON Sales.DBCustomers 

DROP INDEX idx_DBCustomer_CS ON Sales.DBCustomers 

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomer_CS_FirstName ON Sales.DBCustomers (FirstName)

DROP INDEX idx_DBCustomer_CS_FirstName ON Sales.DBCustomers 

-- RowStore Index
-- Best for OLTP(Online Transactional Processing) -> commerece, banking, finance, order processing
-- No keyword, defualt is ROWSTORE index
-- You can create mutiple clustered and non clustered index on one table
CREATE CLUSTERED INDEX idx_DBCustomer1 ON Sales.DBCustomers (LastName)

DROP INDEX idx_DBCustomer1 ON Sales.DBCustomers 

CREATE NONCLUSTERED INDEX idx_DBCustomer2 ON Sales.DBCustomers (CustomerID)

DROP INDEX idx_DBCustomer2 ON Sales.DBCustomers 

-- Practice
USE AdventureWorksDW2025

-- HEAP -- Storage used : 9.633 MB
SELECT	
	*
INTO FactInternetSales_HP 
FROM FactInternetSales

-- RowStore -- Storage used :  9.633 MB
SELECT	
	*
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)


-- ColumnStore -- Storage used : 1.461 MB -- Highly efficient due to compression
SELECT	
	*
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS

-- Unique Index
-- Default is Non-Unique
CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product 
ON Sales.Products (Product) -- Now it will prevent adding duplicates in the Product Column

-- Filtered Index
-- You cannot create filtered index on clustered index or columnstore index
CREATE NONCLUSTERED INDEX idx_Customers_Country 
ON Sales.DBCustomers (Country)
WHERE Country = 'USA'

-- List all indexes on specific table
sp_helpindex 'Sales.DBCustomers'

-- Moniter Index Usage
SELECT 
	idx.object_id,
	idx.name,
	tbl.object_id,
	tbl.name,
	idx.type_desc,
	idx.is_disabled
FROM Sys.indexes idx 
JOIN Sys.tables tbl
ON idx.object_id = tbl.object_id
ORDER BY tbl.name, idx.name

-- Dynamic Managment View (DMV)
SELECT * FROM sys.dm_db_index_usage_stats 

-- Missing indexes
SELECT * FROM sys.dm_db_missing_index_details
