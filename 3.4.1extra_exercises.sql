-- 1.	Create a file named 3.5.1_where_exercises.sql. Make sure to use the employeesdatabase
-- 2.	Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
-- 3.	Find all employees whose last name starts with 'E' — 7,330 rows.
-- 4.	Find all employees hired in the 90s — 135,214 rows.
-- 5.	Find all employees born on Christmas — 842 rows.
-- 6.	Find all employees with a 'q' in their last name — 1,873 rows.
--  
-- 1.	Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
-- 2.	Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
-- 3.	Find all employees whose last name starts or ends with 'E' — 30,723 rows.
-- 4.	Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
-- 5.	Find all employees hired in the 90s and born on Christmas — 362 rows.
-- 6.	Find all employees with a 'q' in their last name but not 'qu' — 547 rows.

USE employees;

SELECT * FROM employees WHERE
first_name IN ('Irina', 'Vidya', 'Maya');

SELECT * FROM employees;

SELECT * FROM employees 
WHERE first_name IN ('Irena', 'Vidya','Maya');

SELECT * FROM employees 
WHERE last_name LIKE 'e%';

SELECT hire_date FROM employees 
WHERE hire_date BETWEEN '1990-01-01'AND '1999-12-31';
SELECT * FROM employees WHERE hire_date LIKE '199%';

SELECT birth_date FROM employees 
WHERE birth_date LIKE '_____12-25';
SELECT * FROM employees WHERE birth-date LIKE '%-12-25';

SELECT last_name FROM employees 
WHERE last_name LIKE '%q%';

SELECT first_name FROM employees 
WHERE first_name ='Irena' OR first_name = 'Vidya' OR first_name ='Maya';

SELECT first_name FROM employees 
WHERE (first_name ='Irena' OR first_name = 'Vidya' OR first_name ='Maya')
 AND gender = 'M';
SELECT * FROM employees WHERE
first_name IN ('Irina', 'Vidya', 'Maya') AND gender = 'M';

SELECT last_name FROM employees 
WHERE last_name LIKE 'e%' OR last_name LIKE'%e';

SELECT last_name FROM employees 
WHERE last_name LIKE 'E%' OR last_name LIKE'%e';
SELECT * FROM employees WHERE last_name LIKE 'E%e';

SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';

SELECT * FROM employees 
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

