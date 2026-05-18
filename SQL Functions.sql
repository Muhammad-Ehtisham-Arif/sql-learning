  -- Row Level Functions 
 
 USE MyDatabase

-- Single Row Functions

-- String Functions

-- CONCAT ( Combine multiple strings into one ) 
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ',country) AS name_country
FROM customers

-- UPPER ( Capitalize everything )  
SELECT 
	UPPER(first_name) AS NAMES		
FROM customers

-- LOWER ( Uncapitalize everything )
SELECT 
	LOWER(first_name) AS names
FROM customers

-- TRIM ( Remove Leading and Trailing spaces )
SELECT 
	TRIM(first_name) AS Employees
FROM customers
-- Checking if there are Traling or Leading Spaces
SELECT 
	first_name
FROM customers
WHERE first_name != TRIM(first_name) -- Returned Values have Trailing or Leading spaces

-- LEN ( Determine the length of the world )
Select
	first_name,
	LEN(first_name) AS Length
FROM customers

-- SQL MINI TASK
SELECT 
	first_name AS Names,
	LEN(first_name) AS 'Names Before Triming',   -- With AS
	LEN(TRIM(first_name)) 'Names After Triming', -- Without AS
	LEN(first_name) -  LEN(TRIM(first_name)) FLAG
FROM customers
-- WHERE LEN(first_name) != LEN(TRIM(first_name))

-- REPLACE
SELECT 
	'08-04-2006' AS Date_Of_Birth,
	REPLACE( '08-04-2006', '-', '/' ) AS 'Date/Of/Birth'

SELECT
	'report.txt' AS 'File.txt',
	REPLACE ( 'report.txt', 'txt', 'csv' ) AS 'File.csv'

-- LEFT
-- Extract specific number of characters from start from string
SELECT
	first_name,
	LEFT(TRIM(first_name),02) AS FirstTwoCharacters,
	LEFT(first_name,02) AS  First2Characters
FROM customers

-- RIGHT
-- Extract specific number of characters from end of string
SELECT
	first_name,
	RIGHT(TRIM(first_name),02) AS LastTwoCharacters,
	RIGHT(first_name,02) AS  Last2Characters
FROM customers

-- SUBSTRING
-- Extract a part of string
SELECT 
	'Maria',
	SUBSTRING('Maria',3,2) AS Substring

SELECT 
	first_name,
	SUBSTRING (TRIM((first_name)),3,LEN(first_name)) AS sub_name
FROM customers

-- Number Functuions

-- ROUND (Rounding the decimal places)
SELECT 
	3.1456 AS round_0,
	ROUND(3.1456,1) AS round_01,
	ROUND(3.1456,2) AS round_02,
	ROUND(3.1456,3) AS round_03

-- ABS (Convert any negative number to positive number)
SELECT 
	-10 AS '-ve',
	ABS(-10) AS '+ve',
	ABS(10) AS '+ve'

USE SalesDB
-- Date & time Function
-- 3 ways to get them 
SELECT 
	OrderID,
	-- Date from Table (1st Method)
	CreationTime,
	-- Date & Time as String Value (2nd Way)
	'2026-02-12' AS Hard_Coded_Constnat_String_Date,
	-- Date & Time from GETDATE (3st Way)
	GETDATE() AS CurrentTime
FROM Sales.Orders

-- Date & Time Manipulation
SELECT 
	OrderID ,
	CreationTime MFG,
	YEAR(CreationTime) Year,
	MONTH(CreationTime) Month,
	DAY(CreationTime) Day,
	EOMONTH(CreationTime) 'End Of Month',
	CAST(DATETRUNC(MONTH,CreationTime) AS DATE) 'Start Of Month'
FROM Sales.Orders

-- Data & Time Extraction
-- DATEPART (Always return INT)
SELECT 
	DATEPART(YEAR,CreationTime) AS Year_dp,   -- Return number as an int
	DATEPART(MONTH,CreationTime) AS Month_dp,
	DATEPART(DAY,CreationTime) AS Day_dp,     -- Return number as an int 
	DATEPART(HOUR,CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	DATEPART(WEEK,CreationTime) AS Week_dp,
	DATEPART(WEEKDAY,CreationTime) AS Weekday_dp
FROM Sales.Orders 

-- DATENAME (Always return STRING)
-- Used in reports of months  
SELECT 
	DATENAME(YEAR,CreationTime) AS Year_dn,    -- Return number as a string 
	DATENAME(MONTH,CreationTime) AS Month_dn,
	DATENAME(ISO_WEEK,CreationTime) AS IsoWeek_dn,
	DATENAME(WEEKDAY,CreationTime) AS WeekDay_dn,
	DATENAME(DAY,CreationTime) AS day_dn       -- Return number as a string 
FROM Sales.Orders 

-- DATETRUNC (Custom Precision to extract date & time) ( Always return DATETIME)
-- Used for Data Analysis
SELECT 
	DATETRUNC(YEAR,CreationTime) AS Year_dt,
	DATETRUNC(MONTH,CreationTime) AS Month_dt,
	DATETRUNC(DAY,CreationTime) AS Day_dt,
	DATETRUNC(HOUR,CreationTime) AS Hour_dt,
	DATETRUNC(MINUTE,CreationTime) AS Minute_dt,
	DATETRUNC(SECOND,CreationTime) AS Second_dt
FROM Sales.Orders
-- Usecase:
SELECT 
	DATETRUNC(MONTH,CreationTime) AS Creation,
	COUNT(*) 
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,CreationTime)
SELECT 
	DATETRUNC(YEAR,CreationTime) AS Creation,
	COUNT(*) 
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR,CreationTime)

-- Usecase of Part Extraction from Date & Time
-- Data Aggregation & Reports
-- SQL TASK : How many Orders wered Placed in years and months? 
SELECT 
	YEAR(OrderDate) OrderDate,
	COUNT(*) NrOfOrdersPlaced
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

SELECT 
	MONTH(OrderDate) OrderDate,
	COUNT(*) NrOfOrdersPlaced
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT 
	DATENAME(MONTH,OrderDate) OrderDate,
	COUNT(*) NrOfOrdersPlaced
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)

-- SQL TASK : How many Orders wered Placed in February?
SELECT * 
FROM Sales.Orders
WHERE MONTH(Sales.Orders.OrderDate) = 2  -- You can Specify Path as DB.Schema.table

-- Date Formats
-- yyyy - For Year, MM - For Month, dd - For Day
-- Time Formats
-- HH - For Hour, mm - For Minutes, ss - For Second

-- Date Standereds
-- yyyy-MM-dd  -> (International Standered (ISO 8601))  -> SQL Server Follow this Standered
-- MM-dd-yyyy  -> USA Standered 
-- dd-MM-yyyy  -> European Standered

-- FORMATING (Formte Date and Time to way that i want it to look like)
-- FORMAT (Change Any Data Type to String, Format Number + Date and Time)

SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime,'') 'Empty_String',

	FORMAT(CreationTime,'t') t,
	FORMAT(CreationTime,'tt') tt,
	FORMAT(CreationTime,'tt') ttt,

	FORMAT(CreationTime,'f') f,
	FORMAT(CreationTime,'ff') ff,
	FORMAT(CreationTime,'fff') fff,

	FORMAT(CreationTime,'s') s,
	FORMAT(CreationTime,'ss') ss,

	FORMAT(CreationTime,'m') m,
	FORMAT(CreationTime,'mm') mm,

	FORMAT(CreationTime,'H') H,
	FORMAT(CreationTime,'h') h,
	FORMAT(CreationTime,'HH') HH,
	FORMAT(CreationTime,'hh') hh,


	FORMAT(CreationTime,'D') D,
	FORMAT(CreationTime,'d') d,
	FORMAT(CreationTime,'dd') dd,
	FORMAT(CreationTime,'ddd') ddd,
	FORMAT(CreationTime,'dddd') dddd, 

	FORMAT(CreationTime,'M') M,
	FORMAT(CreationTime,'MM') MM,
	FORMAT(CreationTime,'MMM') MMM,
	FORMAT(CreationTime,'MMMM') MMMM,

	FORMAT(CreationTime,'y') y,
	FORMAT(CreationTime,'yy') yy,
	FORMAT(CreationTime,'yyy') yyy,
	FORMAT(CreationTime,'yyyy') yyyy,

	FORMAT(CreationTime,'hh mm ss tt') Time1,  
	FORMAT(CreationTime,'hh mm ss tt') Time2,  
	FORMAT(CreationTime,'hh:mm:ss') Time3, 
	FORMAT(CreationTime,'ss:mm:hh') Time4, 
	FORMAT(CreationTime,'tt:ss:hh:mm') Time5,

	FORMAT(CreationTime,'MM-dd-yyyy') Format1,
	FORMAT(CreationTime,'MM/dd/yyyy') Format2,
	FORMAT(CreationTime,'MM.dd.yyyy') Format3,
	FORMAT(CreationTime,'MM dd yyyy') Format4,

	FORMAT(CreationTime,'MM-dd-yyyy') USA_Format,
	FORMAT(CreationTime,'dd-MM-yyyy') Europe_Format,
	FORMAT(CreationTime,'dd-MM-yyyy','ja-JP') Japanese_Format,
	FORMAT(CreationTime,'dd-MM-yyyy','fr-FR') France_Format,
	FORMAT(CreationTime,'dd-MM-yyyy','en-US') US_Format  -- By Default this culture (en-US) is followed
FROM Sales.Orders

-- SQL TASK
SELECT 
	OrderID,
	CreationTime,
	'Day ' + FORMAT(CreationTime,'ddd MMM') + ' Q' +
	DATENAME(QUARTER,CreationTime) + ' '  + FORMAT(CreationTime,'yyyy hh:mm:ss tt') AS CustomFormat 
FROM Sales.Orders

SELECT 
	FORMAT(OrderDate,'MM yy') OrderDate,
	COUNT(*) 
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MM yy')

-- Number Format Specifiers
SELECT 
	FORMAT(1234.56,'N')  N,
	FORMAT(1234.56,'P')  P,
	FORMAT(1234.56,'C')  C,
	FORMAT(1234.56,'E')  E,
	FORMAT(1234.56,'F')  F,
	FORMAT(1234.56,'N0')  N0,
	FORMAT(1234.56,'N1')  N1,
	FORMAT(1234.56,'N2')  N2,
	FORMAT(1234.56,'N','de_DE')  de_DE, -- Numeric (German)
	FORMAT(1234.56,'N','en_US')  en_US  -- Numeric (US)

SELECT 'N' FormatType, FORMAT(1234.56,'N') FormattedValue
UNION ALL
SELECT 'P',FORMAT(1234.56,'P')
UNION ALL
SELECT 'C',FORMAT(1234.56,'C')
UNION ALL
SELECT 'E',FORMAT(1234.56,'E')
UNION ALL
SELECT 'F',FORMAT(1234.56,'F')
UNION ALL
SELECT 'N0',FORMAT(1234.56,'N0')
UNION ALL
SELECT 'N1',FORMAT(1234.56,'N1')
UNION ALL
SELECT 'N2',FORMAT(1234.56,'N2')  
UNION ALL
SELECT 'N,de_DE',FORMAT(1234.56,'N','de_DE')  -- Numeric (German)
UNION ALL
SELECT 'N,de_US',FORMAT(1234.56,'N','en_US')  -- Numeric (US)

-- CASTING (Change Data Type)
-- CAST (Change Data Type, No Formatting) 
SELECT 
	CAST('132' AS INT) 'STRING to INT',
	CAST(123 AS VARCHAR) 'INT to VARCHAR/STRING',
	CAST('1234' AS VARCHAR) 'STRING to VARCHAR',
	CAST('2025-08-06' AS DATE) 'STRING to DATE',
	CAST('2025-08-06' AS DATETIME) 'STRING to DATETIME',
	CAST('2025-08-06' AS DATETIME2) 'STRING to DATETIME2',
	CAST(CreationTime AS DATE) 'DATETIME to DATE'
FROM Sales.Orders

-- CONVERT (Change Data Type, Format Data & Time) 
SELECT 
	CONVERT(INT,'124') 'STRING to INT',
	CONVERT(DATE,'2006-06-04') 'STRING to DATE',  -- Must follow yyyy-MM-dd format to avoid SyntaxError
	CONVERT(DATE,CreationTime) 'DATETIME to DATE',
	CONVERT(VARCHAR,CreationTime,32) 'USA Std. Style:32',
	CONVERT(VARCHAR,CreationTime,34) 'USA Std. Style:34'
FROM Sales.Orders

-- Date Calculation
-- DATEADD (Add or Subtract specific time interval from a Date)
SELECT 
	FORMAT(DATEADD(YEAR,3,'2025-06-04'),'yyyy-MM-dd') 'AddYear', 
	FORMAT(DATEADD(MONTH,3,'2025-06-04'),'yyyy-MM-dd') 'AddMonth',
	FORMAT(DATEADD(DAY,3,'2025-06-04'),'yyyy-MM-dd') 'AddDay',

	FORMAT(DATEADD(YEAR,-3,'2025-06-04'),'yyyy-MM-dd') 'SubYear', 
	FORMAT(DATEADD(MONTH,-3,'2025-06-04'),'yyyy-MM-dd') 'SubMonth',
	FORMAT(DATEADD(DAY,-3,'2025-06-04'),'yyyy-MM-dd') 'SubDay'

-- DATEDIFF (Find the difference between two dates) 
SELECT 
		DATEDIFF(YEAR,'2025-08-20','2026-01-05') 'Years', 
		DATEDIFF(MONTH,'2025-08-20','2026-01-05') 'Months' ,
		DATEDIFF(DAY,'2025-08-20','2026-01-05') 'Days' 

-- SQL TASK
SELECT 
		*,
		DATEDIFF(YEAR,BirthDate,GETDATE()) AS Age
FROM Sales.Employees

SELECT
		MONTH(OrderDate) AS OrderDate,
		AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- Time Gap Analysis
SELECT 
	OrderID,
	OrderDate CurrentOrderDate,
	LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
	DATEDIFF(day,LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) NrOfDays
FROM Sales.Orders

-- Date Validation
-- ISDATE (Check that value is a valid date or not)
SELECT 
	ISDATE('2025-08-04') Validity,
	ISDATE('2025') Validity,
	ISDATE('2025-08-04') Validity,
	ISDATE(123) Validity,
	ISDATE('04-06-2025') Validity,
	ISDATE('2025-08') Validity,
	ISDATE(1111) Validity,
	ISDATE('1111') Validity

   
-- SQL TASK 
-- Data Cleaning 
SELECT 
	OrderDate,
	ISDATE(OrderDate) QualityCheck, 
	CASE 
		WHEN ISDATE(OrderDate) = 1 
		THEN CAST(OrderDate AS DATE)
		ELSE '9999-01-01'
	END AS NewOrderDate
FROM 
(
	SELECT '2025-08' AS OrderDate UNION
	SELECT '2025-02-22' UNION
	SELECT '25-01-15' UNION
	SELECT '2025-03' UNION 
	SELECT '2025-05-07' 
) AS t

-- NULL FUNCTION (It is nothing, Not equal to anything, Not equal to 0, NULL is something that we don't know)
-- Issue: 0 + 5 = 5, NULL + 5 = NULL, '' + 'A' = A, NULL + 'A' = NULL

-- Nulls are checked before the Data Aggregation 
-- ISNULL (Check nulls in and replace it with another value,Limited to 2 values,Slow, Available in all databases) 
SELECT 
	CustomerID,
	Score Score1,
	AVG(Score) OVER() AVG1,
	ISNULL(Score,0) Score2,
	AVG(ISNULL(Score,0)) OVER() AVG2
FROM Sales.Customers
/* Used in JOINS to handle nulls
SELECT 
	a.year,b.type,a.orders,a.sales
FROM TABLE a
JOIN TABLE b
ON a.year = b.year AND ISNULL(a.type,'') = ISNULL(b.type,'')   */

-- COALESCE (Return the first non-null value from a list, Unlimited, Fast, Different Syntax in different langauges)  
SELECT 
	CustomerID,
	FirstName,
	LastName,
	FirstName + ' ' + LastName AS 'FullName(incorrect)',
	FirstName + ' ' + COALESCE(LastName,'') AS 'FullName(correct)',
	Score,
	Score + 10 AS 'ScoreWithBonus(incorrect)', 
	COALESCE(Score,0) + 10 AS 'ScoreWithBonus(correct)' 
FROM Sales.Customers

-- IS NULL (Check nulls and return 1 or 0) 
-- Filtering Data
SELECT * 
FROM Sales.Customers
WHERE Score IS NULL

-- Nulls in Sorting
SELECT 
	CustomerID,
	Score,
	CASE 
		WHEN Score IS NULL 
		THEN 1
		ELSE 0
		END flag
FROM Sales.Customers
ORDER BY CASE 
		WHEN Score IS NULL 
		THEN 1
		ELSE 0
		END, Score

-- Got LEFT ANTI JOIN using IS NULL
SELECT 
	Customers.*,
	Orders.OrderID
FROM Sales.Customers 
LEFT JOIN Sales.Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL

-- Got RIGHT ANTI JOIN using IS NULL
SELECT 
	Customers.*,
	Orders.OrderID
FROM Sales.Orders
RIGHT JOIN Sales.Customers 
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL

-- IS NOT NULL (Check nulls and return 1 or 0) 
SELECT * 
FROM Sales.Customers
WHERE Score IS NOT NULL

-- NULLIF (Compare 2 Values and Return NULL when two values are equal otherwise return first value)
SELECT 
	NULLIF(LastName,NULL) AS 'nullif' 
FROM Sales.Customers 

-- SQL TASK (Preventing DivisionByZeroError)
SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity,0) AS Price
FROM Sales.Orders

/*Data Policy
"Set of Rules that handles how data should be handled"
Data Ploicy1 = Remove extra spaces
Data Policy2 = Replace empty strings, blanck spaces with nulls
Data Policy3 = Replace empty strings, blank spaces, nulls with unknown         */

-- NULL VS Empty String '' VS Blank Spaces '    ' '
WITH Sales.Orders AS (
SELECT 1 AS ID, 'A' AS Category 
UNION
SELECT 2, NULL
UNION
SELECT 3, ''
UNION
SELECT 4, ' '
)
SELECT 
	*,
	DATALENGTH(Category) AS CategoryLength,
	DATALENGTH(TRIM(Category)) AS ApplyingPolicy1,
	NULLIF(TRIM(Category),'') AS ApplyingPolicy2,  -- Use when you are doing data preparation for storing data in database 
	COALESCE(NULLIF(TRIM(Category),''),'unknow') AS ApplyingPolicy3   -- Use when you have to display data to users in reports or survey
FROM Sales.Orders

-- CASE STATEMENT (Can be used anywhere in the Query)
-- Used for data transmission, data aggrgation and categorizing data
-- SQL TASK
SELECT 
	OrderID,               -- Without Speicifying SubQuery Name
	SubQuery.Quantity,     -- With Specifiying SubQuery Name
	SubQuery.CustomerID,
	SubQuery.Sales_Category,
	SUM(SubQuery.Sales) AS Total_Sales -- this you don't need to write in GROPY BY bcz here you are performing operation
FROM 
(
	SELECT 
		SalesDB.Sales.Orders.OrderID, -- Specify DB.Schema.Table.Column 
		Sales.Orders.Quantity,        -- Specify Schema.Table.Column
		Orders.Sales,                 -- Specify Table.Column
	    CustomerID,                   -- Specify Column
		-- Spcifying their name is totally upto, depends upon your ease and readablity bcz scripts are generally readed by you not others
	CASE 
		WHEN Sales > 50 THEN 'High'  -- Data types of all results must be same either all int, strings, floats, bools etc.
		WHEN Sales > 30 THEN 'Medium'
		ELSE 'Low'
	END Sales_Category
	FROM Sales.Orders
)SubQuery
GROUP BY Sales_Category, OrderID, Quantity, CustomerID
ORDER BY Total_Sales DESC
 
-- Mapping (Transform data from one form to another for more readablity
-- SQL TASK
SELECT
	SubQuery.EmployeeID,
	SubQuery.FirstName,
	SubQuery.LastName,
	SubQuery.Gender,
	SubQuery.Gen
FROM 
(
	SELECT
		EmployeeID,
		FirstName,
		LastName, 
		Gender,
	CASE
		WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
		ELSE 'Not Availabe'
	END Gen
	FROM Sales.Employees
) AS SubQuery  -- SubQuery is name of subquery (we can access its columns using SubQuery.)
GROUP BY Gen, EmployeeID, FirstName, LastName, Gender  

-- SQL TASK
SELECT 
	CustomerID,
	FirstName,
	LastName,
CASE Country -- (Quick Format) -> Condition: Can be used onlywhen we use one column with same operator in each case  
	WHEN 'German' THEN 'GE'
	WHEN 'USA' THEN 'US'
	ELSE 'n/a'
END CountryCode
FROM  Sales.Customers

-- Retrieve all possible values from a column
SELECT DISTINCT
	Country
FROM Sales.Customers  

-- Handling Nulls using case statement
SELECT 
	CustomerID AS ID,
	CONCAT(FirstName,' ',LastName) AS FullName,
	Score,
	AVG  -- In this way score is calculated for cleaned score not for original score 
	(
		CASE
			WHEN Score IS NULL THEN 0
			ELSE Score
		END
	)
	OVER() AS CleanedScoreAvg,
	AVG(Score) OVER() AS OrginalScoreAvg 
FROM Sales.Customers 

-- SQL TASK (Creating Counter)
SELECT 
	Count(*) AS 'Counter'
FROM Sales.Orders
WHERE Sales > 30 
-- OR
SELECT 
	SUM
	(
		CASE
			WHEN Sales > 30 THEN 1
			ELSE 0
		END
	) AS 'Counter'
FROM Sales.Orders
-- OR
DECLARE @count INT = 0
SELECT
	@count = @count + CASE
						WHEN Sales > 30 THEN 1
						ELSE 0
					  END
FROM Sales.Orders
SELECT @count AS 'Counter' -- We have to display this 

-- SQL TASK
SELECT 
	CustomerID,
	SUM
	(
		CASE 
			WHEN Sales > 30 THEN 1
			ELSE 0
		END
	) AS TotalOrderHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID


-- Aggregation & Analytical Functions
-- Use Case: Overall Analysis
--			 Total Per Group Analysis
--			 Part-to-Whole Analysis
--			 Comparison Analysis (Average, Current to Extreme)
--			 Identify Duplicates
--			 Outlier Detection
--			 Running Total 
--			 Rolling Total
--			 Moving Average

-- Aggregate Functions

SELECT 
	CustomerID,
	COUNT(*) TotalNumberOfOrders,
	SUM(Sales) TotalSales,
	AVG(Sales) AverageSales,
	MAX(Sales) HighestSales,
	MIN(Sales) LowestSales
FROM Sales.Orders
GROUP BY CustomerID

SELECT 
	OrderID,
	ProductID,
	OrderDate,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY    -- All Columns in the GROUP BY must also be the part of SELECT 
	OrderID,
	ProductID,
	OrderDate
-- Limitation of GROUP BY: Can't Do aggregation and provide details at the same GROUP BY	

-- Window Functions
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS	TotalSalesByProduct
FROM Sales.Orders

-- SQL Task
-- Partion Clause
SELECT 
	ProductID,
	OrderID,
	OrderDate,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS TotalSales
FROM Sales.Orders

-- Order Clause
SELECT  
	OrderID,
	OrderDate,
	RANK() OVER(ORDER BY Sales) AS TotalSales,
    RANK() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS TotalSales,
	RANK() OVER(PARTITION BY ProductID,OrderDate ORDER BY Sales ASC) AS TotalSales
FROM Sales.Orders

-- Frame Clause
SELECT 
	ProductID,
	OrderID,
	OrderDate,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TotalSales
FROM Sales.Orders

SELECT 
	ProductID,
	SUM(Sales) OVER(PARTITION BY OrderStatus) AS TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)

SELECT 
	CustomerID,
	RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomer,  -- In ORDER BY, only Columns of SELECT Statement can be used
	RANK() OVER(ORDER BY CustomerID DESC) AS RankCustomer
FROM Sales.Orders
GROUP BY CustomerID

SELECT
	COUNT(*) OVER() TotalRows,
	COUNT(1) OVER() TotalRows
FROM Sales.Customers

SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) AS CheckPrimaryKeys
FROM Sales.Orders
SELECT
	*
FROM
	(
		SELECT 
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) AS CheckPrimaryKeys
	FROM Sales.OrdersArchive
	)t WHERE CheckPrimaryKeys > 1

-- Comparison Analysis
-- Part-to-Whole Analysis
-- SUM()
PRINT 'Calculating Percentage Contribution'
SELECT 
	'Hello World' AS PrintStatement,
	OrderID,
	PRoductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	-- Type Casting
	Cast(Sales AS FLOAT) / SUM(Sales) Over() * 100 AS PercentageContribution, -- Change Data Type of Sales
	ROUND(Cast(Sales AS FLOAT) / SUM(Sales) Over() * 100, 2) AS PercentageContribution_Rounding
FROM Sales.Orders

-- AVG()
SELECT 
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AS AvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS AvgSales
FROM Sales.Orders

-- SQL TASK
DECLARE @n VARCHAR = '/'
SELECT 
	CustomerID,
	FirstName + LastName AS FullName,
	Score,
	COALESCE(CAST(Score AS VARCHAR),@n) AS CustomerScore, -- COALESCE is used to replace Nulls
	-- COALESCE replace value of same data type INT with INT , VARCHAR with VARCHAR
	AVG(Score) OVER() AS AvgScore,
	AVG(COALESCE(Score,0)) OVER() AS AvgScoreWithoutNulls
FROM Sales.Customers

SELECT 
	*
FROM
	(
	SELECT 
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AS AvgSales
	FROM Sales.Orders
	) AS SubQuery  WHERE Sales > AvgSales


SELECT 
	OrderID,
	ProductID,
	Sales,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSales
FROM Sales.Orders

-- Compare to Extreme Analysis
SELECT 
	OrderID,
	ProductID,
	Sales,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	Sales - MIN(Sales) OVER() AS DeviationFromMin,
	MIN(Sales) OVER() - Sales AS DeviationFromMin,
	Sales - MAX(Sales) OVER() AS DeviationFromMax,
	MAX(Sales) OVER() - Sales AS DeviationFromMax
FROM Sales.Orders

-- Analysis Over Time

-- Tracking       -- Tracking Current Sales with Target Sales
-- Trend Analysis -- Providing insights into historical Pattterns

-- Running Total -- Aggregate values from begining to current point 
-- Rolling Total -- Aggregate values within a fixed interval of time 
SELECT 
	OrderID,
	ProductID,
	Sales,
	OrderDate,
	AVG(Sales) OVER(PARTITION BY ProductID) AS AvgByProduct,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY Orderdate DESC) AS MovingAvg,
	-- Running Total
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY Orderdate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvg,
	-- Rolling Total 
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY Orderdate DESC ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS RollingAvg
FROM Sales.Orders	

-- Window Rankling Functions

-- Integer-based Ranking

-- RANK() & DENSE_RANK()
SELECT 
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales) AS TieRankingWithGap,
	DENSE_RANK() OVER(ORDER BY Sales) AS TieRankingWihoutGap
FROM Sales.Orders

-- ROW_NUMBER()
-- Genertae Unique IDs
SELECT
	ROW_NUMBER() OVER(ORDER BY OrderID ASC) AS UniqueID,
	*
FROM Sales.OrdersArchive

-- Paginating -- "The process of breaking down a Large Data into smaller, more managebale chunks"

-- Identify and Remove Duplicates Rows ( Producing Good Data )
SELECT 
	*
FROM
	(
	SELECT 
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) CheckingDuplicates,
		*
	FROM Sales.OrdersArchive
	)SubQuery WHERE CheckingDuplicates = 1

-- Identify Duplicate Rows ( Identifying Bad Data and report Sources )
SELECT 
	*
FROM
	(
	SELECT 
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) CheckingDuplicates,
		*
	FROM Sales.OrdersArchive
	)SubQuery WHERE CheckingDuplicates > 1 -- here is difference froim prev query

-- Top/Bottom N Analysis
SELECT 
	-- Top-N Analysis
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS UniqueRanking,
	-- Bottom-N Analysis
	ROW_NUMBER() OVER(ORDER BY Sales ASC) AS UniqueRanking
FROM Sales.Orders

-- NTILE(n)
SELECT
	-- Larger Groups come first 
	-- Bucket size = number of rows / number of buckets
	NTILE(2) OVER(ORDER BY Sales) AS DivisonIntoSpecifiedRows, 
	NTILE(5) OVER(ORDER BY Sales) AS DivisonIntoSpecifiedRows,
	NTILE(8) OVER(ORDER BY Sales) AS DivisonIntoSpecifiedRows
FROM Sales.Orders

-- Data Segmentation ( Divide data into distinct subset based on certain criteria )
SELECT 
	*, 
	CASE 
		WHEN Buckets = 1 THEN 'High'
		WHEN Buckets = 2 THEN 'Medium'
		WHEN Buckets = 3 THEN 'Low'
	END SalesSegmentation
FROM 
	(
	SELECT
		NTILE(3) OVER(ORDER BY Sales DESC) AS Buckets
	FROM Sales.Orders
	)t 


-- Equalizing Load Processing ( In exporting large data from one DB into another DB, divide data into groups to avoide network stress and issues )
-- 1st Chunk
SELECT 
	*
FROM 
	(
	SELECT 
		NTILE(2) OVER(ORDER BY Sales DESC) AS Chunks
	FROM Sales.ORders
	)t WHERE Chunks = 1
-- 2nd Chunk
SELECT 
	*
FROM 
	(
	SELECT 
		NTILE(3) OVER(ORDER BY Sales DESC) AS Chunks
	FROM Sales.ORders
	)t WHERE Chunks = 2

-- Percentage-based Ranking

-- Data Distribution Analysis

-- CUME_DIST() -- CUME_DIST = Position Number / Number of rows
-- Position Nr in Tie  = The position of last occurence of the same value is considered like 80 on 2 & 80 on 3, so 3 is considered as Position Nr
-- Inclusive - The current row is included
SELECT 
	*, 
	CONCAT(CummulativeDistribution * 100,'%')  AS CummulativeDistributionPercent
FROM
	(
	SELECT 
		CUME_DIST() OVER(Order BY Sales) AS CummulativeDistribution
	FROM Sales.Orders
	)t 

-- PERCENT_RANK() -- PERCENT_RANK = Position Number - 1 / Number of rows - 1
-- Position Nr in Tie  = The position of first occurence of the same value is considered like 80 on 2 & 80 on 3, so 3 is considered as Position Nr
-- Exclusive - The current row is excluded
SELECT 
	*, 
	CONCAT(PercntileRanking * 100,'%')  AS PercentilleRankingPercent
FROM
	(
	SELECT 
		ROUND(PERCENT_RANK() OVER(Order BY Sales), 02) AS PercntileRanking
	FROM Sales.Orders
	)t
	
-- Window Value(Analytical) Functions
-- Use Case: Time Series Analysis
--			 Time Gap Analysis (Customer Retention)
--			 Comparison Analysis

-- LEAD
DECLARE @m VARCHAR = '/'
SELECT
[LEAD],
LEAD as [lead]
FROM(
SELECT  
	LEAD(CAST(Sales AS VARCHAR),2,@m) OVER(ORDER BY OrderID) AS [LEAD]
FROM Sales.Orders) AS t

-- LAG()
SELECT  
	LAG(Sales,2,1) OVER(ORDER BY OrderID) AS 'LAG'
FROM Sales.Orders

-- Customer Retention Analysis
SELECT 
	CustomerID,
	OrderID,
	OrderDate CurrentOrder,
	LEAD(CAST(OrderDate AS VARCHAR),1,'0000-00-00') OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder
FROM Sales.Orders
ORDER BY CustomerID , OrderDate

-- FIRST_VALUE() -- Range between unboounded preceding and current row
-- LAST_VALUE() -- Range between unboounded preceding and current row 
-- Finding lowest and highest sales
SELECT
	OrderID,
	Sales,
	CustomerID,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSales2,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS HighestSales2,
	MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSales3,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders
