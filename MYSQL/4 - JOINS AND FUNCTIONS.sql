-- ---------------------------------------------- JOINS ------------------------------------------------------------------
-- 1 ------------- INNER JOIN ----------------------------------

SELECT employee_name, designation, department_name
FROM employee
INNER JOIN departments
ON employee.department_id = departments.department_id;

-- 2 ------------- LEFT JOIN ------------------------------------

SELECT department_name, COUNT(employee_id) Number_Of_Employees 
FROM departments
LEFT JOIN employee
ON departments.department_id = employee.department_id
GROUP BY department_name;

-- 3 ------------ RIGHT JOIN ------------------------------------

SELECT location, employee_name
FROM employee
RIGHT JOIN location
ON employee.location_id = location.location_id;

-- ------------------------------------------------------ FUNCTIONS ------------------------------------------------------------------
-- 1 ------------- BUILT IN NUMERIC FUNCTION ----------------------

SELECT ROUND(AVG(age)) Average_Age_of_employees
FROM employee;

SELECT *, CEIL(SQRT(salary)) Bonus 
FROM employee;

-- 2 ------------  BuILT IN STRING FUNCTIONS ----------------------

SELECT location_id, location,
SUBSTRING(location, 1, 3) AS SHORT_NAME
FROM location;

SELECT employee_id, employee_name, designation,
CONCAT(employee_name, " - ", designation) Designation_with_name
FROM employee;

-- 3 ------------- BUILT IN DATE-TIME FUNTION ---------------------

SELECT employee_id, employee_name, hire_date,
YEAR(hire_date) Hire_Year
FROM employee;

SELECT employee_id, employee_name, hire_date,
DATEDIFF(CURDATE(), hire_date) Day_Difference
FROM employee;

SELECT employee_id, employee_name, hire_date,
DATE_FORMAT(hire_date, "%d-%m-%Y") Formatted_Date
FROM employee;

SELECT employee_id, employee_name, hire_date,
DATE_ADD(hire_date, INTERVAL 3 MONTH) Employment_Confirmation
FROM employee;

-- 4 ------------- USER DEFINED FUNCTION ---------------------------

DELIMITER //

CREATE FUNCTION EmployCount(location VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE empCount INT;
    SELECT COALESCE(COUNT(*), 0) INTO empCount
    FROM employee
    JOIN location 
    ON employee.location_id = location.location_id
    WHERE location.location = location;
    RETURN empCount;
END //

DELIMITER ;

SELECT EmployCount('Chennai');
