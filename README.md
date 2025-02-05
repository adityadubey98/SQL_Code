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


