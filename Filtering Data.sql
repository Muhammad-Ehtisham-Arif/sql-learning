use MyDatabase

-- Comparison Operators
-- Equal Operator ( = )
SELECT *
FROM customers
WHERE country = 'Germany'
-- Not Equal Operator ( <> )
SELECT *
FROM customers
WHERE country <> 'Germany'
-- Not Equal Operator ( != )
SELECT *
FROM customers
WHERE country != 'Germany'
-- Greater Than Operator ( > )
SELECT *
FROM customers
WHERE score > 500
-- Greater Than or Equal to Operator ( >= )
SELECT *
FROM customers
WHERE score >= 500
-- Less Than Operator ( < )
SELECT *
FROM customers
WHERE score < 500
-- Less Than or Equal to Operator ( <= )
SELECT *
FROM customers
WHERE score <= 500

-- Logical Operators 
-- AND
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500
-- OR
SELECT *
FROM customers
WHERE country = 'USA' OR score > 750
-- NOT
SELECT *
FROM customers
WHERE NOT country = 'Germany'
-- Combining Operators
SELECT *
FROM customers
WHERE NOT country = 'Germany' AND NOT country = 'UK' OR score > 500 

-- Range Operator 
-- BETWEEN 
SELECT * 
FROM customers
WHERE score BETWEEN 100 AND 500
-- Other way ( Same Results )
SELECT * 
FROM customers
WHERE score >= 100 AND score <= 500

-- Membership Operator 
-- IN
SELECT * 
FROM customers
WHERE country IN ('Germany', 'USA')
-- Other way ( Same Results ) -- Through Logical Operators
SELECT * 
FROM customers
WHERE country = 'Germany' OR country = 'USA'
-- NOT IN 
SELECT * 
FROM customers
WHERE country NOT IN ('Germany', 'USA')
-- Other way ( Same Results ) -- Through Logical Operators
SELECT * 
FROM customers
WHERE NOT country = 'Germany' AND NOT country = 'USA'

-- Search Operator
-- LIKE
SELECT *
FROM customers
WHERE first_name LIKE 'M%' --  Case Insensitive ( You can use m as well )

SELECT *
FROM customers
WHERE first_name LIKE '%n' 

SELECT *
FROM customers
WHERE first_name LIKE '%r%'

SELECT *
FROM customers
WHERE first_name LIKE '__r%'

SELECT *
FROM customers
WHERE first_name LIKE '__r' -- 2 characters at first two index and r at third index and no character after that  ( Size must be 3 )

