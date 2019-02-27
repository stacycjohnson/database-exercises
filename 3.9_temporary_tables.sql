-- Create a file named 3.9_temporary_tables.sql to do your work for this exercise.
-- 1.	Using the example from the lesson, re-create the employees_with_departments table.
USE ada_684; 

SELECT * FROM employees.employees LIMIT 100;
 
CREATE TEMPORARY TABLE employees_with_departments AS 
SELECT emp_no, first_name, last_name, dept_no, dept_name 
FROM employees.employees e
JOIN employees.dept_emp USING(emp_no) 
JOIN employees.departments USING(dept_no)
LIMIT 100;
SELECT * FROM employees_with_departments;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(50);
SELECT * FROM employees_with_departments;

UPDATE employees_with_departments SET full_name = 
CONCAT(first_name,' ', last_name);
SELECT * FROM employees_with_departments;
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
SELECT * FROM employees_with_departments;
-- a.	Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- b.	Update the table so that full name column contains the correct data
-- c.	Remove the first_name and last_name columns from the table.
-- d.	What is another way you could have ended up with this same table?

-- 2.	Create a temporary table based on the payments table from the sakila database.
SELECT * FROM sakila.payment LIMIT 100;
CREATE TEMPORARY TABLE sakila_payment_3 
(amount INT)
AS 
SELECT amount
FROM sakila.payment;
SELECT * FROM sakila_payment_3;
UPDATE sakila_payment_3 SET amount = amount * 100;
SELECT * FROM sakila_payment_3;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

-- 3.	Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, 
-- you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?
SELECT AVG( salary), STDDEV(salary)
FROM employees.salaries
WHERE to_date > NOW();

SELECT emp_no, salary
FROM employees.salaries
WHERE to_date > NOW();

SELECT emp_no, salary, ((salary-72012)/17310) AS z_salary
FROM employees.salaries
WHERE to_date > NOW();

SELECT d.dept_name, s.emp_no, s.salary, ((salary-72012)/17310) AS z_salary
FROM employees.salaries s
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW();

-- get ave z by dept
SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM(
	SELECT d.dept_name, s.emp_no, s.salary, ((salary-72012)/17310) AS z_salary
	FROM employees.salaries s
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN employees.departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
)a
GROUP BY a.dept_name;

-- create a temp table
CREATE TEMPORARY TABLE agg AS
SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS stdev_salary
FROM employees.salaries
WHERE to_date > NOW();
SELECT * FROM agg;
-- 	+--------------------+-----------------+
-- 	| dept_name          | salary_z_score  | 
-- 	+--------------------+-----------------+
-- 	| Customer Service   | -0.065641701345 | 
-- 	| Development        | -0.060466339473 | 
--  | Finance            | 0.090924841177  | 
-- 	| Human Resources    | -0.112346685678 | 
-- 	| Marketing          | 0.111739523864  | 
-- 	| Production         | -0.057892021023 | 
-- 	| Quality Management | -0.091237862268 | 
-- 	| Research           | -0.056918950432 | 
-- 	| Sales              | 0.233859335317  | 
-- 	+--------------------+-----------------+
-- 4.	What is the average salary for an employee based on the number of years they have been with the company? 
-- Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.
SELECT hire_date,
DATEDIFF(NOW(), hire_date) AS days_working_for_company,
DATEDIFF(NOW(), hire_date)/365.25 AS years_working_for_company
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';
-- +--------------------+-----------------+
-- | years_with_company | salary_z_score  | 
-- +--------------------+-----------------+
-- | 0                  | -0.120126024615 | 
-- | 1                  | -0.191233079206 | 
-- | 2                  | -0.171645037241 | 
-- | 3                  | -0.156153559059 | 
-- | 4                  | -0.131917218919 | 
-- | 5                  | -0.115528505398 | 
-- | 6                  | -0.092492800591 | 
-- | 7                  | -0.068094840473 | 
-- | 8                  | -0.051630370714 | 
-- | 9                  | -0.030267415113 | 
-- | 10                 | -0.006900796634 | 
-- | 11                 | 0.01443330816   | 
-- | 12                 | 0.030400295561  | 
-- | 13                 | 0.054596508615  | 
-- | 14                 | 0.075180034951  | 
-- | 15                 | 0.095192818408  | 
-- +--------------------+-----------------+




