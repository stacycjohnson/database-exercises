-- Create a file named 3.8.3_subqueries_exercises.sql and craft queries to return the results for the following criteria:
-- 1.	Find all the employees with the same hire date as employee 101010 using a sub-query.
USE employees;
SELECT * FROM salaries;


SELECT hire_date, first_name, last_name
FROM employees
WHERE hire_date = ( 
	SELECT hire_date
    FROM employees
    WHERE emp_no = '101010');
    
-- 69 Rows
-- 2.	Find all the titles held by all employees with the first name Aamod.
SELECT  title
FROM titles
WHERE emp_no IN(
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod');

-- 314 total titles, 6 unique titles

-- How many people in the employees table are no longer working for the company?
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN( 
	SELECT emp_no
    FROM salaries
    WHERE to_date = '9999-01-01'
);
-- 59,900 

-- 4.	Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN(
	SELECT emp_no
    FROM dept_manager
    WHERE to_date > NOW())
AND gender = 'F';

-- +------------+------------+
-- | first_name | last_name  |
-- +------------+------------+
-- | Isamu      | Legleitner |
-- | Karsten    | Sigstam    |
-- | Leon       | DasSarma   |
-- | Hilary     | Kambil     |
-- +------------+------------+

-- 5.	Find all the employees that currently have a higher than average salary.


SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
	WHERE salary > ( 
	SELECT AVG(s.salary) FROM salaries s)
AND s.to_date > NOW()
    LIMIT 10;
    

-- 154543 rows in total. Here is what the first 5 rows will look like:
-- +------------+-----------+--------+
-- | first_name | last_name | salary |
-- +------------+-----------+--------+
-- | Georgi     | Facello   | 88958  |
-- | Bezalel    | Simmel    | 72527  |
-- | Chirstian  | Koblick   | 74057  |
-- | Kyoichi    | Maliniak  | 94692  |
-- | Tzvetan    | Zielinski | 88070  |
-- +------------+-----------+--------+
-- 6.	How many current salaries are within 1 standard deviation of the highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
SELECT COUNT(*)
FROM salaries 
WHERE salary >= ( 
	SELECT MAX(salary) - STDDEV(salary)
    FROM salaries
) AND to_date > NOW();

-- What percentage of all salaries is this?
SELECT COUNT(*)/ 
(SELECT COUNT(*) FROM salaries WHERE to_date > NOW()) *100
FROM salaries 
WHERE salary >= ( 
	SELECT MAX(salary) - STDDEV(salary)
    FROM salaries
) AND to_date > NOW();

-- 78 salaries
-- BONUS
-- **1** Find all the department names that currently have female managers. (Find all the current department managers that are female.) 
-- (Find all the current department managers that are female.
SELECT dept_name
FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no
JOIN departments d
ON dm.dept_no = d.dept_no
WHERE to_date = '9999-01-01' AND gender = 'F'
ORDER BY dept_name;

SELECT dept_name
FROM departments d
WHERE dept_no IN(
	SELECT dept_no
    FROM dept_manager dm
    WHERE to_date >NOW() AND emp_no IN(
		SELECT emp_no
        FROM employees e
        WHERE gender = 'F'));
    
--  +-----------------+
-- | dept_name       |
-- +-----------------+
-- | Development     |
-- | Finance         |
-- | Human Resources |
-- | Research        |
-- +-----------------+
-- **2**Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees 
WHERE emp_no =(
	SELECT emp_no FROM salaries 
WHERE salary = ( 
	SELECT MAX(salary) 
    FROM salaries
) 
);
SELECT first_name, last_name
FROM employees 
WHERE emp_no =(
	SELECT emp_no FROM salaries 
ORDER BY salary DESC
LIMIT 1
);

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Tokuyasu   | Pesch     |
-- +------------+-----------+

-- **3**Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no = (
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = (
		SELECT emp_no
		FROM employees
		WHERE emp_no = (
			SELECT emp_no
			FROM salaries
			ORDER BY salary DESC
			LIMIT 1
	)));
-- +-----------+
-- | dept_name |
-- +-----------+
-- | Sales     |
-- +-----------+


