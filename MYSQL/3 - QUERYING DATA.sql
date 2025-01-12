-- 1 ------------------------------------------- DISTINCT VALUES -------------------------------------------------------
SELECT DISTINCT salary FROM employee;


-- 2 ------------------------------------------------ ALIAS ------------------------------------------------------------
SELECT employee_id, age AS Employee_Age, salary AS Employee_Salary FROM employee;


-- 3 --------------------------------------- WHERE CLAUSE AND OPERATORS ------------------------------------------------
-- Finding Net Salary by Adding 10 % bonus -------------------
SELECT employee_id,
	salary,
    salary * 0.10 AS Bonus,
    salary + (salary * 0.10) AS Net_Salary
    FROM employee;
    
-- Retrieving Employee Salary Greater than "50,000" and hier beefore "2016-01-01" ---
SELECT * FROM employee
	WHERE salary > 50000 
    AND hire_date < '2016-01-01';
    
-- Listing Data Analyst and Data Scientist -------------
SELECT * FROM employee
	WHERE designation = "Data Analyst"
    OR designation = "Data Scientist";
    
    
-- 4 --------------------------------------------- OTHER OPERATORS -----------------------------------------------------
UPDATE employee 
	SET designation = "Data Scientist" 
    WHERE designation IS NULL;

SELECT * FROM employee
	WHERE department_id IN(1, 3, 4, 9, 12); 

SELECT * FROM employee	
	WHERE salary NOT BETWEEN 50000 AND 80000;
    
SELECT * FROM employee
	WHERE employee_name LIKE 'A%'
    OR employee_name LIKE 'E%'
    OR employee_name LIKE 'I%'
    OR employee_name LIKE 'O%'
    OR employee_name LIKE 'U%';
	
SELECT * FROM employee
	WHERE employee_name LIke '_sh%';
    
-- ------------------------------------------- SORTING AND GROUPING DATA ----------------------------------------------------------
-- 1 --------------- ORDER BY -------------------------------
SELECT * FROM employee
	WHERE hire_date > '2019-01-01'
    ORDER BY hire_date;
    
SELECT * FROM employee
	ORDER BY department_id ASC, salary DESC;
    
-- 2 --------------- LIMIT ----------------------------------
SELECT * FROM employee
	ORDER BY salary DESC LIMIT 10;
    
SELECT * FROM employee
	WHERE YEAR(hire_date) = 2018
    ORDER BY hire_date LIMIT 5;
    
-- 3 --------- AGGRAGATE FUNCTIONS --------------------------
SELECT SUM(salary) Sum_Of_Salary, designation 
	FROM employee
	WHERE designation = 'Financial Analyst';
    
SELECT MIN(age) Minimum_Age 
	FROM employee;

-- 4 ------------- GROUP BY -----------------------------------
SELECT MAX(salary) Maximum_Salary, location_id
	FROM employee
    GROUP BY location_id;

SELECT AVG(salary) Average_Salary, designation
	FROM employee
    WHERE designation LIKE '%Analyst%'
    GROUP BY designation;
    
-- 5 --------------------- HAVING -----------------------------------------
SELECT department_id FROM EMPLOYEE
	GROUP BY department_id
    HAVING COUNT(*) < 3;
    
SELECT location_id, avg(age) Average_Age FROM employee
	WHERE gender = "F"
    GROUP BY location_id
    HAVING AVG(age) < 30;
    