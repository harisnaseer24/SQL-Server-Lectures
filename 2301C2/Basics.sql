CREATE DATABASE HDSE1_2301C2;
USE HDSE1_2301C2;

CREATE TABLE cellphones(
id INT PRIMARY KEY identity(1,1),
cell_name VARCHAR(50) NOT NULL,
price INT NOT NULL,
brand VARCHAR(50),
);

INSERT INTO cellphones(price,brand,cell_name) VALUES 
(50000,'SAMSUNG','A32'),
(70000,'OPPO','F22'),
(65000,'TECHNO','SPARK 20 PRO +');

SELECT * FROM cellphones;

ALTER TABLE cellphones ADD ram varchar(10);

UPDATE cellphones SET ram ='8+8 GB' WHERE id=3;
 
 ALTER TABLE cellphones DROP COLUMN ram;

Delete from cellphones WHERE id=3;

SELECT brand as br FROM cellphones;

Drop table cellphones;
Drop database HDSE1_2301C2;
truncate table cellphones;

INSERT INTO cellphones VALUES 
('A32',50000,'SAMSUNG','8gb'),
('F22',70000,'OPPO','16gb'),
('SPARK 20 PRO +',65000,'TECHNO','12gb'),
('iphone 15 plus',255000,'Apple','8gb'),
('edge plus',65000,'motorolla','12gb');

/* Not */
SELECT * FROM cellphones WHERE NOT cell_name='a32' ;

/* AND all conditions are needed to be true */
SELECT * FROM cellphones WHERE NOT cell_name='a32' AND price >= 66000;

/* OR */
SELECT * FROM cellphones WHERE NOT cell_name='a32' OR price >= 46000;

/* BETWEEN*/
SELECT * FROM cellphones WHERE  price  BETWEEN 100000 AND 20000;
SELECT * FROM cellphones WHERE  id  BETWEEN 2 AND 4;

/* IN */
SELECT * FROM cellphones WHERE not brand IN ('Apple','OPPO','techno');

/* ORDER BY */
SELECT * FROM cellphones  order by price desc;
SELECT * FROM cellphones  order by price asc;

/* LIKE operator */
SELECT * FROM cellphones WHERE cell_name like '%2%' AND brand like '%o%';
SELECT * FROM cellphones WHERE cell_name like '%2%' or brand like '%o%';

-- 8/3/24
CREATE TABLE Departments (
deptId int PRIMARY KEY IDENTITY(1,1),
deptName varchar(60)
);

INSERT INTO Departments Values
('Sofware Quality Assurance'),
('Software Development'),
('Sales'),
('Marketing'),
('HR'),
('Finance');

select * from Departments;

Create table Employees
(empId int PRIMARY KEY IDENTITY(1000,1),
empName varchar(100) not null,
salary int not null,
designation varchar(60)not null,
deptId int,
--		(this table column)		another table(primary key of that table)		
FOREIGN KEY (deptId) REFERENCES Departments(deptId)
);
select * from Employees;

INSERT INTO Employees (empName, Salary, deptId, designation)
VALUES
    ('John Doe', 50000, 1, 'Tester'),
    ('Jane Smith', 60000, 2, 'Backend Developer'),
    ('Bob Johnson', 55000, 3, 'Sales Manager'),
    ('Alice Williams', 70000, 4, 'Marketing Head'),
    ('Charlie Brown', 48000, 5, 'HR assistant'),
    ('Eva Davis', 65000, 1, 'SQA Engineer'),
    ('Frank Wilson', 52000, 2, 'Frontend Developer'),
    ('Grace Taylor', 58000, 3, 'Sales Analyst'),
    ('Henry Miller', 62000, 4, 'Graphic Designer'),
    ('Ivy Anderson', 53000, 5, 'HR Officer'),
	('Naveed Ahmed', 150000, 6, 'Finance Manager'),
	('Owais Khan', 53000, 5, 'Finance Assistant');

	-- Aggregate Functions

	Select COUNT(deptId) as No_of_Departments from Departments;
	Select COUNT(empId)as No_of_Employees from Employees;

	
	Select MAX(salary) as MAX_SALARY from Employees;
	-- Sub queries
	Select * from Employees where  salary < (Select MAX(salary) from Employees);

	Select MIN(salary) as MIN_SALARY from Employees;
	Select * from Employees where  salary = (Select MIN(salary) from Employees);
		
	Select AVG(salary) as Average_SALARY from Employees;

	Select * from Employees where  salary = (Select AVG(salary) from Employees);

	Select SUM(salary) as Total_Salary_Expenditure from Employees;

	Select *,CONCAT(empName,' works as a ' ,designation,' gets a salary of RS. ',salary) as EMP_Details from Employees;

	--11/3/2024
	Insert into Employees (empName, Salary,  designation,deptId)
VALUES
    ('Shahzad Ahmed', 67000, 'Tester',1);
		Insert into Departments
VALUES
    ('UI/UX');
-- Task : Find the total amount that is paid to those employees which are getting salary greater than the average salary.

-- JOINS

-- INNER JOIN
	SELECT * FROM Employees AS e INNER JOIN Departments as d on e.deptId=d.deptId;

-- LEFT OUTER JOIN
	SELECT * FROM Employees AS e LEFT JOIN Departments as d on e.deptId=d.deptId;

-- RIGHT OUTER JOIN
	SELECT * FROM Employees AS e RIGHT JOIN Departments as d on e.deptId=d.deptId;

-- FULL OUTER JOIN
	SELECT * FROM Employees AS e FULL JOIN Departments as d on e.deptId=d.deptId;

	-- JOINS with where clause
	SELECT e.*,d.deptName FROM Employees AS e INNER JOIN Departments as d on e.deptId=d.deptId 
	where d.deptName IN ('Sofware Quality Assurance','Sales','HR') AND e.salary>50000;

	-- 15/3/24
-- get data of those employees with deptName whose salary is greater than 
-- the average salary and designation not equal to Marketing Head, Sales Analyst, HR assistant,Tester.

-- get empName,Salary,Designation,deptName of employees which are working as a 'Junior Developer','HR Officer','SQA Engineer'
-- and dept should not be Sofware Quality Assurance in desc order.

-- Group By and Having Clause

SELECT * FROM Employees;
SELECT designation, COUNT(empId) No_OF_EMPLOYEES from Employees group by designation;

SELECT Salary, COUNT(empId) No_OF_EMPLOYEES from Employees group by Salary;

-- get no of employees and  sum of amount which is paid to finance,HR,Ui/UX
-- with respect to their Department and individual amount.

SELECT deptId, SUM(salary) Amount_Paid from Employees group by deptId Having deptId in (1,5,6);

-- 18/3/24
-- views
CREATE VIEW [Emp_Details]
AS 
SELECT empName, designation, Salary from Employees;

SELECT * FROM Emp_Details;

CREATE VIEW [Highly_paid_employees]
AS 
SELECT empName, designation, Salary from Employees WHERE Salary > (SELECT Avg(Salary) from Employees);

SELECT * FROM Emp_Details;

SELECT * FROM Highly_paid_employees;

Drop View Emp_Details;

CREATE VIEW [Emp_Details]
AS 
SELECT e.empName, e.designation, e.Salary, d.deptName from Employees e INNER JOIN Departments d ON e.deptId=d.deptId;

SELECT * FROM Emp_Details;

UPDATE Departments SET deptName='SQA' where deptId=1;

-- final products view

-- top 
SELECT top 2 * FROM Emp_Details;

-- to fetch top 3 highest paying emp
SELECT top 3 * FROM Highly_paid_employees ORDER BY salary DESC;
SELECT top 20 percent * FROM Emp_Details;

-- into 
SELECT * into testEmployees from Employees;
SELECT * FROM testEmployees;

-- backup 
backup database HDSE1_2301C2 
to disk='C:\backup db';

-- 18/3/2024
-- distinct clause - to get distinct or unique values
SELECT DISTINCT designation FROM Employees;

-- Indexes
CREATE INDEX postIndex
on Employees(designation);

CREATE INDEX post_Sal_Index
on Employees(designation, salary);

DROP index Employees.postIndex;

-- Stored Procedures
CREATE PROCEDURE showEmp
AS
SELECT * FROM Employees AS e INNER JOIN Departments as d on e.deptId=d.deptId;

exec showEmp;
-- with parameters
CREATE PROCEDURE showEmpByDept @deptname varchar (30)
AS
SELECT * FROM Employees AS e INNER JOIN Departments as d on e.deptId=d.deptId where d.deptName=@deptname;
-- calling by passing arguement
exec showEmpByDept @deptname='HR';
-- with multiple parameters
CREATE PROCEDURE showEmpByDeptSal @deptname varchar (30), @sal int
AS
SELECT * FROM Employees AS e INNER JOIN Departments as d on e.deptId=d.deptId where d.deptName=@deptname AND e.salary>=@sal;
-- calling by passing multiple arguements
exec showEmpByDeptSal @deptname='Software Development', @sal=56000;

drop procedure showEmpByDeptSal;

-- task: create a stored procedure which just takes inputs to insert record in 
-- employees table and also fetch the data of employees table after insertion.

CREATE PROCEDURE addEmployee @name varchar(60), @salary int , @post varchar (60), @departId int
AS
INSERT INTO Employees Values(@name, @salary, @post, @departId)
SELECT * FROM Employees;

exec addEmployee @name='Dumbledore', @salary=196000, @post='Senior Backend Developer', @departId=2;

-- task: create a stored procedure which takes input id from user and delete that particular record having user given id.

-- 20/3/24

-- triggers 
CREATE TRIGGER addEmployee_Trigger
ON Employees
AFTER INSERT
AS
BEGIN
print('A New employee is added in Employees table.');

END;
INSERT INTO Employees Values('haroon', 67000,'Designer',4);

-- changing the existing trigger

ALTER TRIGGER addEmployee_Trigger
ON Employees
AFTER INSERT
AS
BEGIN
SELECT * FROM INSERTED;
END;


INSERT INTO Employees Values('Jahanzaib', 82000,'Asst. Lead',2);
INSERT INTO Employees Values('aliyan', 92000,'Accounts Manager',6);
INSERT INTO Employees Values('ayan', 92000,'Sales Manager',3);

-- 22/3/24
 
SELECT * FROM EmpLogs;

ALTER TRIGGER addEmployee_Trigger
ON Employees
AFTER INSERT
AS
BEGIN
Declare @Id int
Declare @Name Varchar(50)
SELECT @Id=empId,@Name=empName from INSERTED
INSERT Into EmpLogs Values(@Name +' having id = '+ CAST(@Id as varchar(6))+
' has been registered as an employee on '+  CAST(GETDATE() as varchar(30)))
END;

CREATE TRIGGER delete_Employee_Trigger
ON Employees
AFTER DELETE
AS
BEGIN
Declare @Id int
Declare @Name Varchar(50)
SELECT @Id=empId,@Name=empName from DELETED
INSERT Into EmpLogs Values(@Name +' having id = '+ CAST(@Id as varchar(6))+
' has been deleted from employees on '+  CAST(GETDATE() as varchar(30)))
END;
DELEte from Employees where empId=1010;

CREATE TRIGGER update_Employee_Trigger
ON Employees
FOR UPDATE
AS
BEGIN
SELECT * FROM DELETED
SELECT * FROM INSERTED
END;
Update Employees set empName='hareeq',designation='Tester' where empId=1011;


-- 25/03/2024

ALTER TRIGGER update_Employee_Trigger
ON Employees
FOR UPDATE
AS
BEGIN
DECLARE @Id int
DECLARE @Newname varchar(60),@Oldname varchar(60)
DECLARE @Newsalary int, @Oldsalary int
DECLARE @Newdesignation varchar(60) , @Olddesignation varchar(60) 
DECLARE @Newdeptid int, @Olddeptid int
DECLARE @Logstring varchar (255)

SELECT * into #Temptable from inserted;
WHILE(EXISTS(SELECT empId from #Temptable))
BEGIN
Set @Logstring=''
SELECT top 1 @Id=empId,@Newname=empName, @Newsalary=salary, @Newdesignation=designation, @Newdeptid=deptid  from #Temptable
SELECT @Oldname=empName, @Oldsalary=salary, @Olddesignation=designation, @Olddeptid=deptid  from deleted where empId=@Id
Set @Logstring='An employee having id = '+CAST(@Id as varchar(6))+' on '+ CAST(GETDATE() as varchar(30))+' has been changed '

if(@Oldname <> @Newname)
Set @Logstring= @Logstring + ' its name from '+@Oldname+' to '+ @Newname
if(@Oldsalary <> @Newsalary)
Set @Logstring= @Logstring + ' its salary from '+CAST(@Oldsalary as varchar(10))+' to '+ CAST(@Newsalary as varchar(10))
if(@Olddesignation <> @Newdesignation)
Set @Logstring= @Logstring + ' its designation from '+@Olddesignation+' to '+ @Newdesignation
if(@Olddeptid <> @Newdeptid)
Set @Logstring= @Logstring + ' its deptid from '+CAST(@Olddeptid as varchar(10))+' to '+ CAST(@Newdeptid as varchar(10))

DELETE from #Temptable where empID=@Id;
INSERT INTO EmpLogs values(@Logstring);
END
END;
Update Employees set empName='Haris',designation='Faculty' where empId=1011;

-- 27/03/2024
-- INSTEAD of Triggers
-- Instead of DELETE TRIGGER
-- Soft Delete
Alter table Employees ADD empStatus int default(1);
update Employees set empStatus = 1 where empId>0;
SELECT * FROM EMPLOYEES;
CREATE TRIGGER soft_delete_trigger
ON employees
Instead of DELETE
AS
BEGIN
DECLARE @ID int
SELECT @ID=empId from deleted
UPDATE Employees set empStatus =0 where empId=@ID
END;

DELETE From Employees where empId = 1013;

-- Instead of INSERT TRIGGER
SELECT * into TEST from Employees;
SELECT * FROM TEST;
INSERT INTO Employees(empName, salary, designation,deptId,empStatus) Values
('Shahzaib Ahmed', 42000, 'Marketing Intern',4,1);

ALTER TRIGGER add_Test_employee
ON Employees
INSTEAD OF INSERT
AS
BEGIN
--DECLARE @ID int, @name varchar(50),@sal int,@desig varchar(50),@deptid int,@status int
--SELECT @ID=empId, @name=empName, @sal=salary, @desig=designation, @deptid=deptId,@status=empStatus from inserted
--INSERT INTO TEST(empName, salary, designation,deptId,empStatus) Values
--(@name, @sal, @desig,@deptid,@status);

INSERT INTO TEST(empName, salary, designation,deptId,empStatus)
Select empName,salary,designation,deptId,empStatus from inserted
END;


-- 29/3/2024

-- Data Control Language

CREATE LOGIN Clerk with Password='123';

CREATE USER Clerk for Login Clerk;

Select * from sys.sql_logins;

-- GRANT
GRANT SELECT, INSERT ON dbo.Employees To Clerk;

GRANT DELETE ON dbo.Employees To Clerk;

-- GRANT ALL ON dbo.Employees To Clerk;

-- REVOKE
REVOKE DELETE ON dbo.Employees from Clerk;

-- 1/4/2024 

-- transactions

-- ROLLBACK -- UNDO
-- COMMIt	-- SAVE Changes

-- A => Atomicity -- all the steps are fully completed or not a single step will execute.
-- C => Consistency -- all the nodes in a network should be aware of the transaction.
-- I => Isolation -- one transaction's info should not be known to another transaction.
-- D => Durability -- changes after transaction should be saved.

-- DDL - Definition
-- DML - Manipulation
-- DCL - Control
-- TCL(Tracnsaction Control Language) 


SELECT * FROM EMPLOYEES;

UPDATE Employees SET empName = 'Yasir Khan' WHERE empName='Charlie Brown';


BEGIN TRANSACTION
UPDATE Employees SET empName = 'javeed khan' WHERE empName='Yasir Khan';

ROLLBACK TRANSACTION;
COMMIT TRANSACTION;

--TRANSACTION IN A TRY CATCH BLOCK

BEGIN TRANSACTION 
BEGIN TRY

UPDATE Employees SET empName = 'kamran' WHERE empName='yasir Khan'
DELETE FROM Employees WHERE empId=1011;
print('Commited the transaction successfully...!')
COMMIT TRANSACTION;
END TRY

BEGIN CATCH
print('Rollbacked the transaction successfully...!')
ROLLBACK TRANSACTION;
END CATCH


-- ENDED