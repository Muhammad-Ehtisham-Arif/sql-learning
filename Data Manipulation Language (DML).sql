USE MyDatabase
-- INSERT 
INSERT INTO customers (id,first_name,country,score)
VALUES (6,'Sahra','USA',NULL)

INSERT INTO customers (id,first_name) -- other columns will be automatically NULL ( but ket value can't be escaped )
VALUES (7,'John')
-- Skip only NULLABLE Columns

INSERT INTO customers  -- All Columns will be selected
VALUES (9,'Salkini','UK',1200)

SELECT * FROM customers

INSERT INTO Student_Record (Roll_No,Name,Class)
SELECT 
id,
first_name,
'BSDS'
FROM customers

SELECT * FROM Student_Record

-- Update Value with condition
UPDATE customers
SET score = 0
WHERE id = 6
-- If you don't put any condition all values of columns will be updated
SELECT * 
FROM customers
WHERE id = 6

-- SQL Mini Task
UPDATE customers 
SET score = 1000, country = 'Germany'
WHERE id = 7
SELECT * 
FROM customers
WHERE id = 7

UPDATE Student_Record
SET Phone = '92+ 300 122****'
SELECT *
FROM Student_Record

UPDATE Student_Record
SET Semester = 2
SELECT *
FROM Student_Record

ALTER TABLE Student_Record
ADD Age INT NULL 
                                                   -- Clear DOUBT
INSERT INTO Student_Record (Age)
VALUES (18), (17), (21), (19), (20), (18), (18), (18)

-- DELECT ROWS
DELETE FROM customers 
WHERE id > 7

SELECT * FROM customers

/* Delete all Data from Table and make it empty 
DELETE FROM orders    -- Slower
TRUNCATE TABLE orders -- Faster (Preferred)              */

 