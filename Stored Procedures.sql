-- Stored Procedures
CREATE PROCEDURE GetCustomerSummaryUSA AS 
BEGIN
SELECT 
	AVG(Score) AS AvgScore,
	COUNT(*) TotalCustomers
FROM Sales.Customers
WHERE Country = 'USA'
END

EXEC GetCustomerSummaryUSA 

DROP PROCEDURE GetCustomerSummaryUSA

CREATE PROCEDURE GetCustomerSummaryGermany AS 
BEGIN
SELECT 
	AVG(Score) AS AvgScore,
	COUNT(*) TotalCustomers
FROM Sales.Customers
WHERE Country = 'Germany'
END

EXEC GetCustomerSummaryGermany

DROP PROCEDURE GetCustomerSummaryGermany


-- Profession way of writing Query
-- Topics covered: Parameters, Variable, Concatenation, Printing, Control Flow, Error Handling

CREATE PROCEDURE GetCustomerSummary @Country NVARCHAR(20) = 'USA' AS  -- Default parameter is used when no paramter will be provided
BEGIN
	BEGIN TRY  -- Error Handling
		-- Declare Varaibles

		DECLARE @AvgScore FLOAT, @TotalCustomers INT
		-- ==========================================================
		-- Step 1: Prepare & Clean Data  using Control Flow (IF ELSE) 
		-- ==========================================================
		IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score is NULL AND Country = @Country)
		BEGIN
			PRINT('Updating NULLS Score to 0') -- Printing with ( )
			PRINT 'Updating' -- Print without ( )
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country
		END

		ELSE
		BEGIN
			PRINT 'No NULL Score found' 
		END

		-- ==================================
		-- Step 2: Generating Summary Reports
		-- ==================================
		SELECT 
		-- Add Values
			@AvgScore = AVG(Score),
			@TotalCustomers = COUNT(*)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT ('Total Customers from ') + @Country + ':' + CAST(@TotalCustomers AS VARCHAR);
		PRINT 'Total Score from ' + @Country + ':' + CAST(@AvgScore AS VARCHAR);

		SELECT 
			COUNT(OrderID) AS TotalCustomers,
			SUM(Score) AS TotalScore,
			1 / 0 AS toCheckError
		FROM Sales.Orders AS o
		JOIN Sales.Customers AS c
		ON o.CustomerID = c.CustomerID
		WHERE c.Country = @Country

		-- ==============
		-- Error Handling	
		-- ==============
	END TRY
	BEGIN CATCH
		-- Using error messagees functions
		PRINT ('Error Message: ' + ERROR_MESSAGE())
		PRINT ('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR))
		PRINT ('Error Line: ' + CAST(ERROR_LINE() AS VARCHAR))
		PRINT ('Error Procedure: ' + ERROR_PROCEDURE())
	END CATCH
END

-- Passing parameters 
EXEC GetCustomerSummary @Country = 'USA'
EXEC GetCustomerSummary @Country = 'Germany'

-- Default parameter is used
EXEC GetCustomerSummary

DROP PROCEDURE GetCustomerSummary


-- Creating EmployeeLog Table
CREATE TABLE Sales.EmployeeLogs(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)

-- Types of Triggres:

-- DML Triggers

-- (1) AFTER Triggers
-- It triggers when event is happening
CREATE TRIGGER tri_AfterInsertingEmployee ON Sales.Employees
AFTER INSERT 
AS 
BEGIN
	INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	SELECT 
		EmployeeID,
		'New Employee Added: ' + CAST(EmployeeID AS VARCHAR),
		GETDATE()  -- to get current time
	FROM INSERTED -- (It holds all new data inserted into table which cause trigger, and is available only during execution)

END

-- Add Data 
INSERT INTO Sales.Employees
VALUES
	(6, 'Maria', 'Arshad', 'HR', '1998-01-12', 'F', 80000, 3)

-- Check Log Table after trigger
SELECT 
	*
FROM Sales.EmployeeLogs

-- (2) INSTEAD OF
-- It triggers when event is happening
-- DDL Triggers
-- Triggers on Command like Alter, Update etc

-- LOGGON