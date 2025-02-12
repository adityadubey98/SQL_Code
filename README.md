# SQL_Code


# SQL Queries for Employee Management


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
# SQL Queries and Database Schema

## 1. Grouping and Aggregations
### Counting Employees by Department
```sql
SELECT DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees
FROM Worker
GROUP BY DEPARTMENT
ORDER BY DEPARTMENT;
```

### Alternative Approach Using Subquery
```sql
SELECT DISTINCT DEPARTMENT,
(SELECT COUNT(*) FROM Worker AS W2 WHERE W2.DEPARTMENT = W1.DEPARTMENT) AS Total_Employees
FROM Worker AS W1
ORDER BY DEPARTMENT;
```

### Aggregation Using UNION
```sql
SELECT 'HR' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'HR'
UNION
SELECT 'Admin' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'Admin'
UNION
SELECT 'Account' AS DEPARTMENT, COUNT(WORKER_ID) AS Total_Employees FROM Worker WHERE DEPARTMENT = 'Account'
ORDER BY DEPARTMENT;
```

## 2. Finding Departments with Minimum and Maximum Employees
```sql
(SELECT DEPARTMENT, COUNT(DEPARTMENT) AS total_employees
FROM Worker
GROUP BY DEPARTMENT
ORDER BY total_employees ASC
LIMIT 1)
UNION ALL
(SELECT DEPARTMENT, COUNT(DEPARTMENT) AS total_employees
FROM Worker
GROUP BY DEPARTMENT
ORDER BY total_employees DESC
LIMIT 1);
```

---

## 3. Creating and Managing Tables
### Creating Category Table
```sql
CREATE TABLE category (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(25) NOT NULL UNIQUE,
    c_decrp VARCHAR(250) NOT NULL
);
```

### Inserting Data into Category
```sql
INSERT INTO category VALUES (102, 'furnitures', 'it stores all set of wooden items');
SELECT * FROM category;
DESC category;
```

### Creating Products Table
```sql
CREATE TABLE Products (
    P_ID INT PRIMARY KEY,
    p_Name VARCHAR(250) NOT NULL,
    c_id INT,
    CONSTRAINT c_id FOREIGN KEY (c_id)
    REFERENCES category(c_id)
);
```

### Inserting Data into Products
```sql
INSERT INTO products VALUES (904, 'Wooden table', NULL);
SELECT * FROM products;
```

### Deleting and Dropping Tables
```sql
delete from category where c_id=101;
drop table category;
```

---

## 4. Creating and Managing Worker Database
### Creating Worker Table
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

### Inserting Data into Worker Table
```sql
INSERT INTO Worker
    (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
    (002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
    (003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
    (004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
    (005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
    (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
    (007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
    (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
```

### Creating Bonus Table
```sql
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);
```

### Inserting Data into Bonus Table
```sql
INSERT INTO Bonus
    (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    (001, 5000, '16-02-20'),
    (002, 3000, '16-06-11'),
    (003, 4000, '16-02-20'),
    (001, 4500, '16-02-20'),
    (002, 3500, '16-06-11');
```

### Creating Title Table
```sql
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);
```

### Inserting Data into Title Table
```sql
INSERT INTO Title
    (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (001, 'Manager', '2016-02-20 00:00:00'),
    (002, 'Executive', '2016-06-11 00:00:00'),
    (008, 'Executive', '2016-06-11 00:00:00'),
    (005, 'Manager', '2016-06-11 00:00:00'),
    (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    (007, 'Executive', '2016-06-11 00:00:00'),
    (006, 'Lead', '2016-06-11 00:00:00'),
    (003, 'Lead', '2016-06-11 00:00:00');
```

---

## 5. Working with VIT Bhopal Data
### Creating VIT Bhopal Table
```sql
CREATE TABLE vitBhopal (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(25) NOT NULL
);
```

### Inserting Data into VIT Bhopal Table
```sql
INSERT INTO vitbhopal VALUES (104,'Karthik','cs'),(103,'Arun','cs');
```

### Creating VIT Table
```sql
CREATE TABLE vit (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    college VARCHAR(25) NOT NULL
);
```

### Inserting Data into VIT Table
```sql
INSERT INTO vit VALUES (104,'Karthik','chennai'),(103,'Arun','bhopal');
```

### Selecting Winner of the Year
```sql
SELECT name AS WinnerOfTheYear FROM vitbhopal
WHERE id = (SELECT id FROM vit WHERE college='bhopal');
```


