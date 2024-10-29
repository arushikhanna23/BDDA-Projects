CREATE DATABASE amazon_employee_db;
USE amazon_employee_db;

-- Table: Locations
CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100)
);

-- Table: Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INT,
    manager_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) -- Self-reference for manager
);

-- Table: Jobs
CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

-- Table: Salaries
CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    base_salary DECIMAL(10, 2),
    bonus DECIMAL(10, 2),
    total_compensation DECIMAL(10, 2) AS (base_salary + bonus) STORED
);

-- Table: Employees
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT,
    department_id INT,
    manager_id INT,
    salary_id INT,
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id), -- Self-reference for manager
    FOREIGN KEY (salary_id) REFERENCES Salaries(salary_id)
);
DROP DATABASE amazon_employee_db;
CREATE DATABASE amazon_employee_db;
USE amazon_employee_db;

-- Table: Locations
CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100)
);

-- Table: Departments (initial creation without manager_id FK)
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Table: Jobs
CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

-- Table: Salaries
CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    base_salary DECIMAL(10, 2),
    bonus DECIMAL(10, 2),
    total_compensation DECIMAL(10, 2) AS (base_salary + bonus) STORED
);

-- Table: Employees (initial creation without foreign key constraints)
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT,
    department_id INT,
    manager_id INT,
    salary_id INT
);

-- Add foreign key constraints for Employees after all tables have been created
ALTER TABLE Employees
ADD FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
ADD FOREIGN KEY (department_id) REFERENCES Departments(department_id),
ADD FOREIGN KEY (manager_id) REFERENCES Employees(employee_id), -- Self-reference for manager
ADD FOREIGN KEY (salary_id) REFERENCES Salaries(salary_id);

-- Add the manager_id foreign key to Departments after Employees table is created
ALTER TABLE Departments
ADD manager_id INT,
ADD FOREIGN KEY (manager_id) REFERENCES Employees(employee_id);
-- Insert dummy data into Locations
INSERT INTO Locations (location_id, address, city, state, zip_code, country)
VALUES
    (1, '410 Terry Ave N', 'Seattle', 'WA', '98109', 'USA'),
    (2, '1200 12th Ave S', 'Seattle', 'WA', '98144', 'USA'),
    (3, 'One Central Park', 'Hyderabad', 'Telangana', '500081', 'India');

-- Insert dummy data into Departments
INSERT INTO Departments (department_id, department_name, location_id)
VALUES
    (10, 'Engineering', 1),
    (20, 'Human Resources', 1),
    (30, 'Sales', 2),
    (40, 'Customer Service', 3);

-- Insert dummy data into Jobs
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary)
VALUES
    (1, 'Software Engineer', 70000, 120000),
    (2, 'Data Scientist', 80000, 130000),
    (3, 'Product Manager', 90000, 140000),
    (4, 'HR Specialist', 50000, 80000),
    (5, 'Customer Service Rep', 40000, 60000);

-- Insert dummy data into Salaries
INSERT INTO Salaries (salary_id, base_salary, bonus)
VALUES
    (1, 95000, 10000),
    (2, 110000, 15000),
    (3, 120000, 20000),
    (4, 60000, 5000),
    (5, 55000, 3000);

-- Insert dummy data into Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, department_id, manager_id, salary_id)
VALUES
    (101, 'John', 'Doe', 'johndoe@example.com', '555-0101', '2020-01-15', 1, 10, NULL, 1),
    (102, 'Jane', 'Smith', 'janesmith@example.com', '555-0102', '2019-03-12', 2, 10, 101, 2),
    (103, 'Mike', 'Johnson', 'mikejohnson@example.com', '555-0103', '2018-07-23', 3, 10, 101, 3),
    (104, 'Anna', 'Brown', 'annabrown@example.com', '555-0104', '2021-11-11', 4, 20, NULL, 4),
    (105, 'Chris', 'Davis', 'chrisdavis@example.com', '555-0105', '2022-02-20', 5, 40, NULL, 5);

-- Update Departments to assign manager_id for each department where applicable
UPDATE Departments SET manager_id = 101 WHERE department_id = 10;
UPDATE Departments SET manager_id = 104 WHERE department_id = 20;
SELECT * FROM Locations;
SELECT * FROM Departments;
SELECT * FROM Jobs;
SELECT * FROM Salaries;
SELECT * FROM Employees;
-- Insert a new employee into Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, department_id, manager_id, salary_id)
VALUES (106, 'Emily', 'Clark', 'emilyclark@example.com', '555-0106', '2023-05-14', 1, 10, 101, 1);
SELECT * FROM Employees;

-- Select specific columns
SELECT first_name, last_name, email FROM Employees;

-- Select employees with specific criteria (e.g., from Engineering department)
SELECT * FROM Employees WHERE department_id = 10;
UPDATE Employees
SET job_id = 2, salary_id = 2
WHERE employee_id = 106;

-- Increase the base salary in Salaries table for a specific employee's salary entry
UPDATE Salaries
SET base_salary = base_salary + 5000
WHERE salary_id = 1;
-- View contents of Salaries table
SELECT * FROM Salaries;

-- View contents of Employees table
SELECT * FROM Employees;
DELETE FROM Employees
WHERE employee_id = 106;

-- Delete all employees from a specific department (e.g., department_id = 20)
DELETE FROM Employees
WHERE department_id = 20;
SELECT * FROM Employees;