CREATE DATABASE HDSE1_2302C2;
USE HDSE1_2302C2;

CREATE TABLE Employees(
id INT PRIMARY KEY IDENTITY(1,1),
empName VARCHAR(255) NOT NULL,
designation VARCHAR(255) NOT NULL,
salary INT NOT NULL,
city VARCHAR(255) NOT NULL,
deptId INT,
);

-- INSERT
INSERT INTO Employees(empName,designation,salary,city,deptId) VALUES
('Naseer','Faculty',787887, 'Lahore',null),
('OWAIS','CO-ORDINATOR',5656556, 'LAHORE',null),
('AHMED','SRO',898988, 'Istanbul',null),
('EBAD','Faculty',7878787, 'Sogut',null),
('AHSAN kazim','CAH',9101010, 'Karachi',null),
('Haris Ahmed','Faculty',142121, 'PESHAWAR',null);

-- READ
SELECT * FROM Employees;

-- DISTINCT
SELECT DISTINCT city from Employees;

-- UPDATE
UPDATE Employees SET empName='SHAHRUKH', city='LAHORE' WHERE id=7;
UPDATE Employees SET salary=454545 WHERE city='Karachi';

-- DELETE
DELETE From Employees WHERE empName='Shahrukh';

-- get data of those employees which are getting salary not greater than
-- 9 lacs and belongs to lahore and peshawar not  working in the designation of co-ordinator.

-- WHERE CLAUSE AND OPERATORS
SELECT empName, designation FROM Employees where designation='Faculty';

-- Not
SELECT empName, designation FROM Employees where not designation='Faculty';

-- And
SELECT * FROM Employees where not designation='Faculty' and salary>=200000;
SELECT * FROM Employees where not designation='Faculty' and salary<200000;

-- Or
SELECT * FROM Employees where not designation='Faculty' or salary>=200000;
SELECT * FROM Employees where not designation='Faculty' or salary<200000;

-- Between
SELECT * FROM Employees where id between 8 AND 12;

-- IN 
SELECT * FROM Employees where city  IN ('Karachi','Lahore');

-- LIKE 
SELECT * FROM Employees where designation like '%a%';

SELECT * FROM Employees where city like '%a%' and designation like 'f%';

SELECT * FROM Employees where city like '%k%' or designation like '%f';

-- ORDER  BY 
SELECT * FROM Employees Order By empName asc;

SELECT * FROM Employees Order By id desc;


-- top 
SELECT top 4 * FROM Employees ;
SELECT top 50 percent * FROM Employees Order By id desc;

-- get data of those employees which are getting salary not greater than
-- 9 lacs and belongs to lahore and peshawar not as a working in the  designation of co-ordinator.

-- AGREGATE FUNCTIONS
SELECT Count(city) as total_emp from Employees;

SELECT MIN(salary) as minimum_salary from Employees;

SELECT MAX(salary) as maximum_salary from Employees;


SELECT SUM(salary) as total_salary from Employees;

SELECT SUM(id) as total_salary from Employees;

SELECT CONCAT(empName,' works as a ', designation,' gets a amount of  Rs. ' ,salary) as emp_details from Employees;

SELECT * from Employees where salary < (SELECT AVG(salary)from Employees);

-- GROUP BY CLAUSE
SELECT city , COUNT(id) workers from Employees GROUP BY city;
SELECT city , Max(salary) Maximum_salary_paid from Employees GROUP BY city;
SELECT city , SUM(salary) total_salary_paid from Employees GROUP BY city;


SELECT city , SUM(salary) total_salary_paid from Employees GROUP BY city;


SELECT designation , count(id)  from Employees GROUP BY designation having designation ='Faculty';


-- get average salary  of CAH , FACULTY and Admin from Employees table; 

-- 28/3/24
-- Department table
CREATE table Departments (
deptId int PRIMARY KEY IDENTITY(1,1),
DName nvarchar(40) not null,
 );
 INSERT INTO Departments Values('HR'),('Academics'),('Accounts'),('SRO');
 SELECT * FROM Departments;
  SELECT * FROM Employees;

  truncate table Employees;
  drop table Employees;

CREATE TABLE Employees(
id INT PRIMARY KEY IDENTITY(1,1),
empName VARCHAR(255) NOT NULL,
designation VARCHAR(255) NOT NULL,
salary INT NOT NULL,
city VARCHAR(255) NOT NULL,
deptId INT,
FOREIGN KEY (deptId) REFERENCES Departments(deptId),
);

INSERT INTO Employees(empName,designation,salary,city,deptId) VALUES
('Jameel','guard',78788, 'Lahore',null);
('OWAIS','CO-ORDINATOR',56565, 'LAHORE',2),
('AHMED','SRO',898988, 'Istanbul',4),
('EBAD','Admin Assistant',78787, 'Sogut',1),
('AHSAN kazim','CAH',91010, 'Karachi',2),
('Haris Ahmed','Accountant',142121, 'PESHAWAR',3);

-- JOINS
-- INNER 
SELEcT * from Employees as emp INNER JOIN Departments as d ON emp.deptId=d.deptId;

-- LEFT OUTER
SELEcT * from Employees as emp LEFT JOIN Departments as d ON emp.deptId=d.deptId;

SELEcT * from Departments as emp LEFT JOIN Employees as d ON emp.deptId=d.deptId;

-- RIGHT OUTER
SELEcT * from Employees as emp RIGHT JOIN Departments as d ON emp.deptId=d.deptId;

-- FULL OUTER
SELEcT emp.*,d.DName from Employees as emp FULL OUTER JOIN Departments as d ON emp.deptId=d.deptId;

-- 30/3/2024
-- Views

SELECT * FROM Employees;
CREATE View [empDetails]
AS
SELECT id,empName,designation from Employees;

SELECT * from empDetails;

CREATE View [empDetailswithDept]
AS
SELEcT emp.*,d.DName from Employees as emp INNER JOIN Departments as d ON emp.deptId=d.deptId;

SELECT * from [empDetailswithDept];

UPDATE Employees SET empName ='Haris Naseer' WHERE id=1;

DELETE FROM Employees WHERE id=6;

-- DATA CONTROL LANGUAGE  DCL

 CREATE LOGIN EMP_CLERK with Password='456';
 CREATE USER EMP_CLERK from LOGIN EMP_CLERK;

 SELECT * FROM sys.sql_logins;

 -- GRANT (to give permission)
 GRANT SELECT, INSERT on dbo.Employees TO EMP_CLERK;
 GRANT DELETE on dbo.Employees TO EMP_CLERK;

-- REVOKE (to take back the given permission)
 REVOKE DELETE on dbo.Employees FROM EMP_CLERK;









