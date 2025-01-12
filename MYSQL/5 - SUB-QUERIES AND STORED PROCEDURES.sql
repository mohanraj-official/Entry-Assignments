-- ------------------------------------ SUB QUERIES --------------------------------------------------
-- 1 ----- SINGLE SUB QUERIES -----------------

SELECT * FROM employee
	WHERE salary > (SELECT AVG(salary) FROM employee);
    
SELECT * FROM employee
	WHERE salary = (SELECT MAX(salary) FROM employee);
    
SELECT * FROM employee
	WHERE department_id = 
    (SELECT department_id FROM employee
    WHERE employee_name = "Arjun Kumar");

-- 2 ------------ MULTI ROW SUB QUERIES -----------------

SELECT * FROM employee e
WHERE department_id IN
	(SELECT department_id FROM departments
    WHERE department_name LIKE("%Development%")
);

-- ------------------------------------------------- STORE PROCEDURE -------------------------------------------------
-- 1 ------------- Stored Procedure with IN Parameter -----------------

DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartmentName(IN dept_name VARCHAR(155))
BEGIN
	SELECT e.*
    FROM employee e
    INNER JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.department_name = dept_name;
END //
DELIMITER ;

-- Retriving the Data -----------

CALL GetEmployeesByDepartmentName("IT");
CALL GetEmployeesByDepartmentName("Human Resources");

-- 2 ----------------------------- Stored Procedure with OUT Parameter ---------------------------------------

DELIMITER //
CREATE PROCEDURE FindEmployeeBirthYearByID(IN emp_id INT, OUT emp_birth INT)
BEGIN 
	DECLARE emp_age INT;
    SELECT age INTO emp_age
    FROM employee
    WHERE employee_id = emp_id;
    
    SET emp_birth = YEAR(current_date()) - emp_age;
    END //
DELIMITER ;

SET @emp_birth = 0;
CALL FindEmployeeBirthYearByID(5002, @emp_birth);
SELECT @emp_birth AS Employee_BirthYear;
    







					