--Creating the Database
CREATE DATABASE ORG;
USE ORG;


-- Worker Table

CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);


-- Inserting Data into Worker Table

INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    (001, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
    (002, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
    (003, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
    (004, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
    (005, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
    (006, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
    (007, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
    (008, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');


-- Bonus Table

CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);


-- Inserting Data into Bonus Table

INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    (001, 5000, '2016-02-20'),
    (002, 3000, '2016-06-11'),
    (003, 4000, '2016-02-20'),
    (001, 4500, '2016-02-20'),
    (002, 3500, '2016-06-11');


-- Title Table

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);


-- Inserting Data into Title Table

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (001, 'Manager', '2016-02-20 00:00:00'),
    (002, 'Executive', '2016-06-11 00:00:00'),
    (008, 'Executive', '2016-06-11 00:00:00'),
    (005, 'Manager', '2016-06-11 00:00:00'),
    (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    (007, 'Executive', '2016-06-11 00:00:00'),
    (006, 'Lead', '2016-06-11 00:00:00'),
    (003, 'Lead', '2016-06-11 00:00:00')

-- SQL Queries

 --1. Print all Worker details ordered by FIRST_NAME ascending

SELECT * FROM Worker ORDER BY FIRST_NAME ASC;


--2. Print all Worker details ordered by FIRST_NAME ascending and DEPARTMENT descending

SELECT * FROM Worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;


-- 3. Exclude workers with first names "Vipul" and "Satish"

SELECT * FROM Worker WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');


-- 4. Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets

SELECT * FROM Worker WHERE FIRST_NAME LIKE '_____h';


-- 5. Count of employees in the 'Admin' department

SELECT COUNT(*) FROM Worker WHERE DEPARTMENT = 'Admin';


-- 6. Worker names with salaries between 50,000 and 100,000

SELECT FIRST_NAME, LAST_NAME FROM Worker WHERE SALARY BETWEEN 50000 AND 100000;


-- 7. Number of workers in each department in descending order

SELECT DEPARTMENT, COUNT(*) AS WorkerCount FROM Worker GROUP BY DEPARTMENT ORDER BY WorkerCount DESC;


-- 8. Find the 5th highest salary without using TOP or LIMIT

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 4;


-- 9. Fetch employees with the same salary

SELECT W1.FIRST_NAME, W1.LAST_NAME, W1.SALARY FROM Worker W1 
JOIN Worker W2 ON W1.SALARY = W2.SALARY AND W1.WORKER_ID != W2.WORKER_ID;


-- 10. Departments with less than three employees

SELECT DEPARTMENT FROM Worker GROUP BY DEPARTMENT HAVING COUNT(*) < 3;



