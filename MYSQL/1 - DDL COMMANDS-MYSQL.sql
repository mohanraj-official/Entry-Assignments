-- ------------------- Creation of Database------------------------------
CREATE DATABASE employee_db;

-- -------------use the database to create a table-----------------------
USE employee_db;

-- - 1 ----------------------creation of table--------------------------

-- --------------------- table for department --------------------------
CREATE TABLE departments(
	departmnet_id INT,
    department_name VARCHAR(100)
);

-- ----------------------- table for location --------------------------
CREATE TABLE location(
	location_id INT,
    location VARCHAR(30)
);

-- ----------------------- table for employees --------------------------
CREATE TABLE employees(
	employee_id INT,
    employee_name VARCHAR(50),
    gender ENUM("M", "F"),
    age INT,
    hier_date DATE,
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10, 2)
);

-- 2 ------------Now altering the table using ddl commands---------------
ALTER TABLE employees
	ADD COLUMN email VARCHAR(100);
    
ALTER TABLE employees
	MODIFY COLUMN designation VARCHAR(300);
    
ALTER TABLE employees 
	DROP COLUMN age;
    
ALTER TABLE employees
	RENAME COLUMN hier_date TO date_of_joining;
    
-- 3 ---------------------Table renaming--------------------------------
 RENAME TABLE departments TO departments_info;
 RENAME TABLE location TO locations;
 
-- 4 -------------TRUNCATE the employees table--------------------------
 TRUNCATE TABLE employees;
 
-- 5 --------------DATABASE AND TABLE DROPPING-------------------------
 DROP TABLE employees;
 DROP DATABASE employee_db;
 
 
 




