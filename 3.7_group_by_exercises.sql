-- Exercise Goals
-- 	Use the GROUP BY clause to create more complex queries
--  
-- 1.	Create a new file named 3.7_group_by_exercises.sql
-- 2.	In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:
USE employees;
SELECT * FROM titles;
SELECT DISTINCT title FROM titles;
-- Senior Engineer
-- Staff
-- Engineer
-- Senior Staff
-- Assistant Engineer
-- Technique Leader
-- Manager

-- 3.	Find your query for employees whose last names start and end with 'E'. 
-- Update the query find just the unique last names that start and end with 'E' using GROUP BY. 
SELECT last_name FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY last_name;
-- The results should be:
-- Eldridge
-- Erbe
-- Erde
-- Erie
-- Etalle

-- 4. Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. 
SELECT first_name, last_name FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY first_name, last_name;

-- You should get 846 rows.

-- -- 5. Find the unique last names with a 'q' but not 'qu'. 
SELECT last_name FROM employees 
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- Your results should be:
-- -- Chleq
-- -- Lindqvist
-- -- Qiwen

-- 6. Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT last_name, COUNT(last_name) 
FROM employees 
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*);

-- NEW 6. Which (across all employees) name is the most common, the least common? Find this for both first name, last name, and the combination of the two
SELECT first_name, COUNT(first_name)
FROM employees
GROUP BY first_name
ORDER BY COUNT(first_name) DESC;

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

SELECT  DISTINCT first_name, last_name, CONCAT(first_name, last_name) AS first_last
FROM employees;

SELECT first_name,last_name, COUNT(first_name) AS first_name_count, COUNT(last_name) AS last_name_count
FROM employees
GROUP BY first_name, last_name;

-- Most common last name: Baba
-- Most common first name: Shahab
-- Most common first, last name:
-- Least common last name:
-- Least common last name:
-- Least common first, last name: 


-- 7. Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
SELECT COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- Your results should be:
-- -- 441 M
-- -- 268 F

-- 8. Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
-- Yes

SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(last_name,1,4)),'_',SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2)) 
AS username
FROM employees;
SELECT COUNT(DISTINCT CONCAT(LOWER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(last_name,1,4)),'_',SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2)))
AS username
FROM employees;
SELECT COUNT(CONCAT(LOWER(SUBSTR(first_name,1,1)),
LOWER(SUBSTR(last_name,1,4)),'_',
SUBSTR(birth_date,6,2), 
SUBSTR(birth_date,3,2)))
AS username
FROM employees;

-- Bonus: how many duplicate usernames are there?
-- Yes, there are 14,152 duplicate usernames(300,024 - 285,872).