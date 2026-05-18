USE MyDatabase


-- Create tables from scratch
CREATE TABLE FirstTable 
(
id INT NOT NULL,
Myname VARCHAR(20),
RollNumber VARCHAR(15)
)
 
-- Add data in one row
INSERT INTO FirstTable(id)
VALUES(1)

-- Add data in multiple rows  (if we run this statement multiple times, same data repeats and we will not get error)

INSERT INTO FirstTable(Myname,id,RollNumber,Grades)
VALUES 
	('Ahsan Shehzad',1,'BSDS51F25R007',98.11),
	('Azan Ali',2,'BSDS51F25R0042',90.261),
	('Ehtisham Arif',3,'BSDS51F25R023',89.23),
	('Abdullah Amir',4,'BSDS51F25S008',92.12)

-- UPODATE Table
UPDATE FirstTable
SET 
	Myname = 'Khubaib Younas',
	RollNumber = 'BSDS51F25RO19'
WHERE Myname = 'Abdullah Amir'

-- ALTER Table
ALTER TABLE FirstTable
ADD Grades DECIMAL(4,2) NULL  --(4(total digits allowd),2(digits allowed after decimal point))

-- ALTER Column (change datatype of column)
ALTER TABLE FirstTable
ALTER COLUMN Grades VARCHAR(6)

-- DROP Column
ALTER TABLE FirstTable
DROP COLUMN Grades

-- Check
SELECT 
	*
FROM FirstTable

-- DROP Table
DROP TABLE FirstTable

-- 2nd method -> CTAS (Create Table As Select)
-- Create tables from query
SELECT
	DATENAME(MONTH, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)

 -- Check
SELECT 
	* 
FROM Sales.MonthlyOrders

-- Remove Table
DROP TABLE Sales.MonthlyOrders  -- now you recreate updated table

-- CREATE
CREATE TABLE Student_Record
(
	Name VARCHAR(50) NOT NULL,
	Roll_No VARCHAR(15) NOT NULL,
	Class CHAR(6) NOT NULL,
	Semester INT NULL,
	CONSTRAINT Primary_Key_Student_Record PRIMARY KEY (Roll_No)
)


-- ALTER 
SELECT * FROM Student_Record;

ALTER TABLE Student_Record
ADD Name VARCHAR(50) NULL

-- Column will be added at the end 
--Sadly there is no way to add Column in between the table. For adding this you have to create table from scratch

SELECT * FROM Student_Record;

ALTER TABLE Student_Record
DROP COLUMN Phone 
ALTER TABLE Student_Record
DROP COLUMN Name  -- Column can be removed from any position 

SELECT * FROM Student_Record;

-- DROP 
DROP TABLE Student_Record
DROP COLUMN Name

-- RENAME

-- TRUNCATE


