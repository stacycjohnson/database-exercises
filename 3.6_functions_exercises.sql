-- Exercise Goals
-- 1.	Copy the order by exercise and save it as 3.6_functions_exercises.sql.
USE employees;
-- 2.	Update your queries for employees whose names start and end with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT first_name, last_name, CONCAT(first_name, last_name) AS full_name
FROM employees
WHERE last_name LIKE '%E%';

-- 3.	Convert the names produced in your last query to all uppercase.
SELECT first_name, last_name, CONCAT(UPPER(first_name),UPPER(last_name)) AS full_name
FROM employees
WHERE last_name LIKE '%E%';

-- 4.	For your query of employees born on Christmas and hired in the 90s, 
-- use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT DATEDIFF(CURDATE(), hire_date) AS days_working_for_company
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';

SELECT 
first_name,
last_name,
hire_date, 
DATEDIFF(NOW(), hire_date) AS days_working_for_company,
DATEDIFF(NOW(), hire_date)/365.25 AS years_working_for_company
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';


-- 5.	Find the smallest and largest salary from the salaries table.
SELECT MIN(salary), MAX(salary) FROM salaries;
SELECT salary 
AS min_salary
FROM salaries 
ORDER BY salary LIMIT 1;

-- 6.  -- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. 
-- Below is an example of what the first 10 rows will look like:
SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),
LOWER(SUBSTR(last_name,1,4)),'_',
SUBSTR(birth_date,6,2), 
SUBSTR(birth_date,3,2)) 
AS username
FROM employees;
SELECT first_name,last_name, birth_date,LOWER(CONCAT(SUBSTR(first_name,1,1),
SUBSTR(last_name,1,4),'_', SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2)))
AS username
FROM employees;


-- +------------+------------+-----------+------------+ 
-- | username | first_name | last_name | birth_date | +------------+------------+-----------+------------+ 
-- | gface_0953 | Georgi | Facello | 1953-09-02 | | bsimm_0664 | Bezalel | Simmel | 1964-06-02 | 
-- | pbamf_1259 | Parto | Bamford | 1959-12-03 | | ckobl_0554 | Chirstian | Koblick | 1954-05-01 | 
-- | kmali_0155 | Kyoichi | Maliniak | 1955-01-21 | | apreu_0453 | Anneke | Preusig | 1953-04-20 | 
-- | tziel_0557 | Tzvetan | Zielinski | 1957-05-23 | | skall_0258 | Saniya | Kalloufi | 1958-02-19 | 
-- | speac_0452 | Sumant | Peac | 1952-04-19 | | dpive_0663 | Duangkaew | Piveteau | 1963-06-01 
-- | +------------+------------+-----------+------------+ 10 rows in set (0.05 sec)
