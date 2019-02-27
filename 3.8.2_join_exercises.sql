-- Employees Database
-- 1.	Use the employees database.
USE employees;
-- 2.	Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM departments JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no;

SELECT departments.dept_name AS 'Department Name',CONCAT(first_name,' ',last_name) AS 'Department Manager'
FROM employees 
JOIN dept_manager 
ON employees.emp_no = dept_manager.emp_no 
JOIN departments 
ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date >NOW()
ORDER BY departments.dept_name;


--  Department Name    | Department Manager
-- --------------------+--------------------
-- Customer Service   | Yuchang Weedman
-- Development        | Leon DasSarma
-- Finance            | Isamu Legleitner
-- Human Resources    | Karsten Sigstam
-- Marketing          | Vishwani Minakawa
-- Production         | Oscar Ghazalie
-- Quality Management | Dung Pesch
-- Research           | Hilary Kambil
-- Sales              | Hauke Zhang

-- 3. Find the name of all departments currently managed by women.
SELECT departments.dept_name AS 'Department Name',CONCAT(first_name,' ',last_name) AS 'Department Manager'
FROM employees 
JOIN dept_manager 
ON employees.emp_no = dept_manager.emp_no 
JOIN departments 
ON dept_manager.dept_no = departments.dept_no
WHERE to_date = '9999-01-01' AND gender = 'F'
ORDER BY departments.dept_name;

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT  titles.title AS 'Title' , 
COUNT(titles.title) AS 'Count'
FROM titles
JOIN dept_emp
ON titles.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name LIKE 'Customer Service' AND titles.to_date = '9999-01-01'
GROUP BY title;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- 5. Find the current salary of all current managers.

SELECT departments.dept_name AS 'Department Name',CONCAT(first_name,' ',last_name) AS 'Department Manager', salaries.salary
FROM employees 
JOIN salaries
ON employees.emp_no = salaries.emp_no
JOIN dept_manager 
ON salaries.emp_no = dept_manager.emp_no 
JOIN departments 
ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name;

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- 6. Find the number of employees in each department.


SELECT  departments.dept_no, departments.dept_name, COUNT(dept_emp.dept_no) AS 'Count'
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_no;
-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- 7. Which department has the highest average salary?

SELECT departments.dept_name, AVG(salaries.salary)AS 'average_salary'
FROM salaries
JOIN dept_emp
	ON salaries.emp_no = dept_emp.emp_no
JOIN  departments
	ON dept_emp.dept_no = departments.dept_no
    GROUP BY dept_name
    ORDER BY AVG(salaries.salary) DESC
    LIMIT 1;

    
-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- 8. Who is the highest paid employee in the Marketing department?
SELECT employees.first_name, last_name
FROM employees
JOIN salaries
	ON employees.emp_no = salaries.emp_no
JOIN dept_emp
	ON salaries.emp_no = dept_emp.emp_no
JOIN departments
	ON dept_emp.dept_no= departments.dept_no
WHERE departments.dept_name LIKE 'Marketing'
ORDER BY salaries.salary DESC
LIMIT 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- 9. Which current department manager has the highest salary?
SELECT employees.first_name,last_name, salaries.salary, departments.dept_name
FROM employees
JOIN salaries
	ON employees.emp_no = salaries.emp_no
JOIN dept_manager
	ON salaries.emp_no = dept_manager. emp_no
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date = '9999-01-01'
ORDER BY salaries.salary  DESC 
LIMIT 1;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- Bonus: Find the names of all current employees, their department name, and their current manager's name.

SELECT a.first_name,a.last_name, d.dept_name, b.first_name,a.last_name
FROM employees a
JOIN dept_emp de
	ON a.emp_no = de.emp_no
JOIN departments d
	ON de.dept_no = d.dept_no
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees b
	ON dm.emp_no = b.emp_no
WHERE  dm.to_date >NOW()
ORDER BY dept_name
LIMIT 10;


-- 240,124 Rows
-- 
-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
-- Huan Lortz   | Customer Service | Yuchang Weedman
-- 
-- .....
-- Bonus: Find the highest paid employee in each department.
