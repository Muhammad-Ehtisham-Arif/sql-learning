USE MyDatabase -- Used to choose any database in which we want to work 
use MYDATABASE	

-- Retrieve all columns
select * from customers  -- Allowed but non professional way
SELECT * FROM orders  -- Use upper case for SQL Keywords 

-- Retreive few columns
SELECT
	score,
	first_name
FROM customers

SELECT
	id * 2,
	score * 2
FROM customers

-- Filter Data
SELECT 
	first_name, score
FROM customers
WHERE score != '0' --  You can use both 0 or '0' both will work same way
-- WHERE score != 0 or WHERE score  != '0'

SELECT 
	first_name, country
FROM customers
WHERE country = 'germany' -- Single Qoutes for string value

-- Sorting in  Ascending or Descending order \
-- ORDER BY is only used once at the end of the Query
SELECT score 
FROM customers
ORDER BY score ASC

SELECT score
FROM customers
ORDER BY score DESC

-- Sorting of Next column is added when there is repetition in first column value to avoid any uncertainity 
SELECT first_name
FROM customers
ORDER BY first_name -- By default data will be sorted in ascending order
-- ORDER  BY score -- if value does not presen, no sorting, no error occur

SELECT score, first_name
FROM customers 
ORDER BY score, first_name DESC -- score will be sorted in Ascending bcz it is by default  

SELECT score, first_name
FROM customers 
ORDER BY score DESC, first_name -- first_name will be sorted in Descending 
 
SELECT score, first_name
FROM customers 
ORDER BY score DESC, first_name DESC -- both sorted in descending

SELECT score, first_name
FROM customers 
ORDER BY score, first_name -- both sorted in Ascending

/* ( Sorting mein first col ki value ki sorting ko priority di jati he aur " Order of row " ko kabhi bhi kharab nai kiya jata
he lekn jahan second col ki values same hun aur " Order of rows" bhi kharab na hu raha hu tab uinki bhi sorting huti he and same for other cols) */
-- "Column order in ORDER BY is crucial, as sorting is Sequential"

-- Aggregate your data 
SELECT
	country,  -- included 
	SUM(score) -- Aggregated ( Executed only for those rows having same values of first column )
FROM customers 
GROUP BY country -- Group or merge repeated values of this Colum and also execute aggregession formula for these values

SELECT
	country,  
	first_name,
	SUM(score) AS total_score, -- AS ( ALIAS ) To assign name to this column
	COUNT(id)  AS total_id
FROM customers 
GROUP BY country, first_name -- multiple columns can be included
-- "All Columns in the SELECT must be either aggregated or included in the GROUP BY, otherwise you will got an error

-- Filter Aggregated Data 
SELECT
	sum(score),
	country
FROM customers 
GROUP BY country
HAVING sum(score) > 800

SELECT
	first_name,
	sum(score),
	count(id)
FROM customers 
GROUP BY first_name
HAVING sum(score) > 700 AND count(id) = 1

SELECT
	first_name,
	country, 
	sum(score),
	count(id)
FROM customers 
GROUP BY first_name, country
HAVING sum(score) > 500 AND count(id) = 1

--  WHERE filters rows
--  HAVING filters groups 

SELECT
	country,
	sum(score)
FROM customers 
WHERE score > 400        -- Used for filtering data after Aggregation 
GROUP BY country
HAVING sum(score) > 800  -- Used for filtering data after Aggregation

-- SQL TASK
SELECT 
	country,
	AVG(score)
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

-- Remove Duplicates
SELECT DISTINCT 
	country
FROM customers

-- Limit your Data
SELECT TOP 03 * 
FROM customers

-- SQL TASK
SELECT TOP 03 *
FROM customers
ORDER BY score DESC

-- SQL TASK
SELECT TOP 02 *
FROM customers
ORDER BY score ASC

-- SQL TASK
SELECT * 
FROM orders
ORDER BY order_date DESC

-- Order of execution:
-- FROM -> WHERE -> GROUP -> BY -> HAVING -> SELECTED -> DISTINCT -> ORDERED -> TOP

-- Multi Queries ( Best Practice )

-- 1st Query
SELECT * 
FROM customers; -- Use ; semi - colon is a best practice to separate different Queries 

-- 2nd Query
SELECT * 
FROM orders;

-- Static(Fixed) Values

SELECT 123 AS 'static numbers';
SELECT 'Hello World' AS static_string;

SELECT id, first_name AS Names, ' NEW Customer' AS 'Customer Status'
FROM customers;

-- Highlight and Execute
SELECT * 
FROM customers  -- Highlight Desired lines of code and then execute it for easiness 
WHERE country = 'Germany' 

-- Variables 
DECLARE @age1 INT; -- Variable Declaration 
SET @age1 = 1;    -- Value Assign to Variable  
DECLARE @age2 INT = 2; 
DECLARE @Ag2 INT = 4;
-- DECLARE @aG2 INT = 2;
SELECT 
	@age1 MyAge,
	@age2 YourAge,
	@Age2 OtherAge,
	@aG2 SomeOneAge

