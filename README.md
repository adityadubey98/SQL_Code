# SQL_Code


# SQL Queries for Employee Management

This repository contains SQL scripts to create and manage an employee database, execute various queries, and analyze employee data.

## Database Setup
```sql
-- Create Database
CREATE DATABASE ORG123;
SHOW DATABASES;
USE ORG123;
```

## Table Creation
```sql
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
```

## Insert Data
```sql
INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) 
VALUES 
    (001, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
    (002, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
    (003, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
    (004, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
    (005, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
    (006, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
    (007, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
    (008, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');
```

## Query Examples

### Basic Queries
```sql
SELECT * FROM Worker WHERE SALARY > 100000 AND DEPARTMENT = 'HR';
SELECT * FROM Worker WHERE SALARY > 200000;
SELECT * FROM Worker WHERE SALARY BETWEEN 100000 AND 200000;
SELECT * FROM Worker WHERE WORKER_ID IN (2,4,6,8);
```

### Aggregation & Sorting
```sql
SELECT * FROM Worker WHERE DEPARTMENT = 'HR' ORDER BY SALARY ASC;
SELECT MIN(SALARY) FROM Worker WHERE DEPARTMENT = 'HR';
```

### Finding Min/Max Salaries
```sql
SELECT FIRST_NAME, LAST_NAME FROM Worker WHERE DEPARTMENT = 'HR' AND SALARY = (SELECT MIN(SALARY) FROM Worker WHERE DEPARTMENT = 'HR');
SELECT DEPARTMENT, FIRST_NAME, LAST_NAME, SALARY FROM Worker w WHERE SALARY = (SELECT MAX(SALARY) FROM Worker WHERE DEPARTMENT = w.DEPARTMENT);
```

### Counting Employees per Department
```sql
SELECT DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker GROUP BY DEPARTMENT ORDER BY DEPARTMENT;
```

### UNION Queries
```sql
SELECT 'HR' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'HR' 
UNION 
SELECT 'Admin' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'Admin' 
UNION 
SELECT 'Account' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'Account' 
ORDER BY DEPARTMENT;
```

### Finding Departments with Min & Max Employees
```sql
(SELECT DEPARTMENT, COUNT(DEPARTMENT) AS TOTAL_EMPLOYEES FROM Worker GROUP BY DEPARTMENT ORDER BY TOTAL_EMPLOYEES ASC LIMIT 1)
UNION ALL
(SELECT DEPARTMENT, COUNT(DEPARTMENT) AS TOTAL_EMPLOYEES FROM Worker GROUP BY DEPARTMENT ORDER BY TOTAL_EMPLOYEES DESC LIMIT 1);
```
### Union and Union All
```sql
SELECT WORKER_ID FROM Worker UNION SELECT FIRST_NAME FROM Worker;
SELECT DEPARTMENT, WORKER_ID FROM Worker WHERE DEPARTMENT = 'HR' UNION SELECT DEPARTMENT, WORKER_ID FROM Worker WHERE DEPARTMENT = 'Account' ORDER BY WORKER_ID;
```
### Case Statement
```sql
SELECT WORKER_ID, FIRST_NAME, DEPARTMENT,
CASE
    WHEN SALARY > 300000 THEN 'Rich people'
    WHEN SALARY BETWEEN 100000 AND 300000 THEN 'Middle stage'
    ELSE 'Poor people'
END AS People_stage_wise
FROM Worker;
```

### Additional Queries
```sql
-- Exclude certain first names
SELECT * FROM Worker WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');

-- First name ending with 'a'
SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a';

-- Workers with first names ending in 'h' and exactly 6 characters long
SELECT * FROM Worker WHERE FIRST_NAME LIKE '_____h' AND LENGTH(FIRST_NAME) = 6;

-- Count workers per department in descending order
SELECT DEPARTMENT, COUNT(*) AS Worker_Count FROM Worker GROUP BY DEPARTMENT ORDER BY Worker_Count DESC;
```

### Additional Tables

## vitBhopal Table
```sql
CREATE TABLE vitBhopal (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(25) NOT NULL
);
INSERT INTO vitBhopal VALUES (104, 'Karthik', 'cs'), (103, 'Arun', 'cs');
```

## vit Table
```sql
CREATE TABLE vit (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    college VARCHAR(25) NOT NULL
);
INSERT INTO vit VALUES (104, 'Karthik', 'chennai'), (103, 'Arun', 'bhopal');
```

## Fetch Winner of the Year
```sql
SELECT name AS WinnerOfTheYear FROM vitBhopal WHERE id IN (SELECT id FROM vit WHERE college = 'bhopal');
```

## Show One Row Twice
```sql
(SELECT * FROM Worker WHERE WORKER_ID = 1) UNION ALL (SELECT * FROM Worker WHERE WORKER_ID = 1);
```

