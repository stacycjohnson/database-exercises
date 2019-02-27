-- 1.	Create a new file named 3.5.2_order_by_exercises.sql 
-- and copy in the contents of your exercise from the previous lesson.USE employees;
USE employees;

SELECT * FROM employees WHERE
first_name IN ('Irena', 'Vidya', 'Maya');

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

-- 2.	Modify your first query to order by first name. 
SELECT * FROM employees WHERE
first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY first_name;
-- The first result should be Irena Reutenauer and the last result should be Vidya Simmen.

-- 3.	Update the query to order by first name and then last name. 
-- The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT * FROM employees WHERE
first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY first_name,last_name;
 
-- 4.	Change the order by clause so that you order by last name before first name. 
-- Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT * FROM employees WHERE
first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY last_name,first_name;
 
-- 5.	Update your queries for employees with 'E' in their last name to sort the results by their employee number. 
-- Your results should not change!
SELECT * FROM employees 
WHERE last_name LIKE '%E%';
SELECT * FROM employees 
WHERE last_name LIKE '%E%'
ORDER BY emp_no;
-- Will fall back to emp_no because it's the primary key.

-- 6.	Now reverse the sort order for both queries.
SELECT * FROM employees 
WHERE last_name LIKE '%e%' ORDER BY last_name DESC;
SELECT * FROM employees 
WHERE last_name LIKE '%e%' ORDER BY last_name DESC, emp_no DESC;

-- 7.	Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. 
-- It should be Khun Bernini.
SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' ORDER BY birth_date, hire_date DESC;

