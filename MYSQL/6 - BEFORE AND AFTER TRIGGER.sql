-- ---------------------------------------------------- TRIGGER -------------------------------------------------------
-- ------------------------- Before Insert Trigger --------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER set_salary_before_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary IS NULL THEN
        SELECT AVG(salary) INTO @avg_salary FROM employee;
        SET NEW.salary = @avg_salary;
    END IF;
END //
DELIMITER ;

-- ----------------------------- INSERTING SOME EMPLOYEE DATA --------------------------------------------------

INSERT INTO employee (employee_id, employee_name, salary) VALUES (1, 'John Doe', 5000);
INSERT INTO employee (employee_id, employee_name, salary) VALUES (2, 'Jane Smith', 6000);
INSERT INTO employee (employee_id, employee_name) VALUES (3, 'Alice Brown');

-- ------------------------------ CHECKING THE TRIGGER REACTIONS ------------------------------------------------

SELECT * FROM employee;



-- ----------------------------------------------- After Delete Trigger ----------------------------------------

DELIMITER //
CREATE TRIGGER prevent_recent_join_delete
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    DECLARE recent_year INT;
    SET recent_year = YEAR(CURDATE());
    IF YEAR(OLD.hire_date) = recent_year THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete employees who joined in the most recent year';
    END IF;
END //
DELIMITER ;

-- ---------------- INSERTING DATA -----------------------------

INSERT INTO employee 
	(employee_id, employee_name, salary, hire_date) VALUES 
    (1, 'John Doe', 5000, '2024-01-15');
    
DELETE FROM employee WHERE employee_id = 1;



