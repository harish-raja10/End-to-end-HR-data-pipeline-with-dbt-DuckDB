-- init.sql

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS 06_hr;
USE 06_hr;

-- Create employees table
CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    join_date DATE,
    dept VARCHAR(255)
);

-- Create payroll table
CREATE TABLE IF NOT EXISTS payroll (
    id INT PRIMARY KEY,
    employee_id INT,
    month VARCHAR(7), -- YYYY-MM format
    gross DECIMAL(10, 2),
    net DECIMAL(10, 2),
    tds DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Create leaves table
CREATE TABLE IF NOT EXISTS leaves (
    id INT PRIMARY KEY,
    employee_id INT,
    date DATE,
    type VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Load data into employees table
LOAD DATA INFILE '/docker-entry-point-initdb.d/data/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip header row

-- Load data into payroll table
LOAD DATA INFILE '/docker-entry-point-initdb.d/data/payroll.csv'
INTO TABLE payroll
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip header row

-- Load data into leaves table
LOAD DATA INFILE '/docker-entry-point-initdb.d/data/leaves.csv'
INTO TABLE leaves
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip header row