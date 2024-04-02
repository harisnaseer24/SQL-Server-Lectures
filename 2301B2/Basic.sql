CREATE DATABASE HDSE1_2301B2;
use HDSE1_2301B2;

/* DELETE THE DATABASE*/

DROP DATABASE HDSE1_2301B2;

CREATE TABLE FServices(
id INT PRIMARY KEY IDENTITY(1,1),
servicename VARCHAR (50) NOT NULL,
price INT NOT NULL, 

delivery_time varchar(50)
);

INSERT INTO FServices (servicename,price, delivery_time) VALUES 
('Web Designing',80,'24 hours'),
('Web Development',400,'72 hours');

TRUNCATE TABLE FServices;

ALTER TABLE FServices ADD 
expertise VARCHAR (20);

UPDATE  FServices SET expertise_level ='INTERMEDIATE',servicename='WEB & APP DEVELOPMENT' where id=4;

ALTER TABLE FServices DROP COLUMN expertise;

/*EXEC sp_rename 'FServices.expertise', 'expertise_level', 'COLUMN';*/

SELECT * FROM FServices;
INSERT INTO FServices (servicename,price, delivery_time,expertise_level) VALUES 
('Web scrapping',55,'12 hours','expert'),
('Singing',600,'22 hours','intermediate');

/*NOT operator*/
DELETE FROM FServices WHERE NOT expertise_level='beginner';
DELETE FROM FServices WHERE NOT delivery_time ='72 hours';
DELETE FROM FServices WHERE NOT  price <= 259;

/*AND operator*/
UPDATE  FServices SET expertise_level ='expert',servicename='Voice Cloning' where NOT id=4 AND price=300;

/*OR operator*/
UPDATE  FServices SET expertise_level ='expert',servicename='Voice OVER',price='450' where NOT id=10 or price=90000;

/*BETWEEN operator*/
SELECT * FROM FServices WHERE price BETWEEN 55 AND  299;

/*IN operator*/
SELECT * FROM FServices WHERE delivery_time IN ('24 hours','12 hours','22 hours');

SELECT * FROM FServices;

-- 8/3/24
Create table Departments 
(deptId int primary key  identity(1,1),
deptName varchar(50) not null,
);

INSERT INTO Departments Values
('Sofware Quality Assurance'),
('Software Development'),
('Sales'),
('Marketing'),
('HR');

SELECT * FROM Departments;
Create table Employees 
(empId int primary key  identity(1,1),
empName varchar(50) not null,
empSalary int not null,
deptId int ,
designation varchar(50) not null,
FOREIGN KEY (deptId) REFERENCES Departments(deptID)

);
SELECT * FROM Employees;

INSERT INTO Employees (empName, empSalary, deptId, designation)
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
    ('Ivy Anderson', 53000, 5, 'HR Officer');

-- Aggregate Functions
 SELECT COUNT(deptId) as total_Departments from Departments;
 SELECT COUNT(empSalary) as Max_Salary from Employees;

  SELECT MAX(empSalary) as Max_Salary from Employees;
  SELECT * from Employees WHERE empSalary=(SELECT MAX(empSalary) from Employees);

 SELECT MIN(empSalary) as Min_Salary from Employees;
 SELECT * from Employees WHERE  empSalary > (SELECT MIN(empSalary) from Employees);

 SELECT AVG(empSalary) as Average_Salary from Employees;
 SELECT * from Employees WHERE  empSalary < (SELECT AVG(empSalary) from Employees);

 SELECT CONCAT(empName,' works as a ', designation, ' and gets a salary of Rs. ',empSalary) as NameDesignation from Employees;
 
 select CEILING(45.01);
 select Floor(45.99);
 select Round(45.99,0);

SELECT SUM(empSalary) as Total_Salary_Expense from Employees;
-- group by clause
SELECT empSalary , count(empName) from Employees group by empSalary;

UPDATE  Employees SET designation='Backend Developer' where empId=3;

SELECT designation , count(empName) as designation_wise_count from Employees group by designation;

-- Task : Find the total amount that is paid to those employees which are getting salary greater than the average salary.
-- ANS:
SELECT SUM(empSalary) as Total_Salary_Expense from Employees  WHERE  empSalary > (SELECT AVG(empSalary) from Employees);

-- 11/3/2024
-- joins
-- Inner Join

SELECT * FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId ;
Delete from Employees where empId >10;

INSERT INTO Departments Values('Finance');
INSERT INTO Employees (empName, empSalary, designation)
VALUES
    ('Shakoor Doe', 35000, 'Junior Graphic Designer');

-- Left Outer Join
SELECT * FROM Employees as e Left JOIN Departments as d ON e.deptId=d.deptId;
-- Right Outer Join

SELECT * FROM Employees as e Right JOIN Departments as d ON e.deptId=d.deptId ;

-- Full Outer Join
SELECT * FROM Employees as e FULL JOIN Departments as d ON e.deptId=d.deptId ;

-- Joins with where clauses
SELECT e.*,d.deptName FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId
where e.designation IN ('Backend Developer','Tester');

-- get data of those employees with deptName whose salary is greater than 
-- the average salary and designation not equal to Marketing Head, Sales Analyst, HR assistant

--Ans:
SELECT e.*,d.deptName FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId
where e.designation  Not IN ('Marketing Head','Sales Analyst','HR assistant') and empSalary > (SELECT AVG(empSalary) from Employees);


-- get data of those employees which are not working on any projects with their dept names.
-- 13/3/2024
SELECT * FROM Employees;
-- Group By and having clause

SELECT designation , count(empName) as designation_wise_count from Employees group by designation;
SELECT empSalary , count(empId) Salary_wise_count from Employees group by empSalary;

SELECT empName, count(empId) Name_wise_count from Employees group by empName;
insert into Employees values('Bob Johnson',34500,3,'Designer');

-- get no of employees and  sum of amount which is paid to SQA ,
-- Finance and Sales with respect to their Department and individual amount.
Select d.deptName,Count(e.empId) as No_OF_Employess, SUM(e.empSalary) Amount from Employees as e
right join Departments as d on e.deptId=d.deptId group by d.deptName having d.deptName In('Finance','Sales','Software Quality Assurance');

SELECT deptId,COUNT(empId) as No_of_employees,sum(empSalary) Amount_paid from Employees group by deptId having deptId in (1,3);

-- 15/3/2024
-- Views - we copy the important data which is mostly used in views from a table.
CREATE View [Employee_essentials] AS
SELECT empName, empSalary from Employees;
Select * from Employee_essentials;
 
CREATE VIEW [High_paying_employees]
AS 
SELECT e.empName, e.empSalary,d.deptName FROM Employees e inner join Departments d ON e.deptId=d.deptId 
WHERE empSalary >=50000;

Select * from High_paying_employees;

DROP VIEW High_paying_employees;
-- Tables and views are connected changes of data in table will also applied to views
UPDATE Departments SET deptName='SQA' WHERE deptId=1;
-- can't delete or update data in views
DELETE FROM High_Paying_employees where empName='John Doe';

-- top 
SELECT top 3 * FROM High_Paying_employees ORDER by empSalary DESC;
SELECT top 80 percent * FROM High_Paying_employees ORDER by empSalary DESC;

-- into - to copy tables for backup.
select * into backUpEmployees from Employees;
select * from backUpEmployees;

-- backup
 backup database HDSE1_2301b2
 to disk='C:\Users\harisnaseer\OneDrive\Desktop\backup';

-- check 
-- Distinct - remove duplicate records
 SELECT DISTINCT designation from Employees;

-- indexes
CREATE INDEX post_index on
Employees(designation);

CREATE INDEX salary_and_post_index on
Employees(designation, empSalary);

DROP INDEX Employees.post_index;

-- Stored Procedures
CREATE PROCEDURE showEmp
AS
SELECT * FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId;

exec showEmp;

-- with parameter
CREATE PROCEDURE showEmpByDept @dept varchar(30)
AS
SELECT * FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId where d.deptName=@dept;

-- calling with arguement
exec showEmpByDept @dept='HR';

-- with Multiple parameters
CREATE PROCEDURE showEmpByDeptSal @dept varchar(30), @salary int
AS
SELECT * FROM Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId where d.deptName=@dept And e.empSalary<=@salary;

-- calling with Multiple arguements
exec showEmpByDeptSal @dept='HR', @salary=50000;

-- task: create a stored procedure which just takes inputs to insert record in employees table and 
-- also fetch the data of employees table after insertion.

	CREATE Procedure AddEmployee @name varchar(80) ,@salary int, @desig varchar(50),@departId int
	AS
	INSERT INTO Employees (empName, empSalary, deptId, designation) values(@name, @salary, @departId, @desig)
	SELECT * from Employees;

	exec AddEmployee  @name='haris' ,@salary=540000, @desig='Designer',@departId=4; 

-- task: create a stored procedure which takes input id from user and delete that particular record having user given id.

CREATE Procedure RemoveEmployee @id int
	AS
	Delete from Employees where empId=@id
	SELECT * from Employees;

	exec RemoveEmployee  @id=1;
	SELECT * from Employees;
-- triggers

CREATE trigger add_employee_trigger
ON Employees
after INSERT
AS
Begin
print 'A new Employee has been added in employees table.';
End;
INSERT INTO Employees (empName, empSalary, deptId, designation)
VALUES
    ('Donald Duck', 150000, 2, 'Front End Developer');
	INSERT INTO Employees (empName, empSalary, deptId, designation)
VALUES
    ('Mickey Mouse', 150000, 3, 'Sales Head');
	INSERT INTO Employees (empName, empSalary, deptId, designation)
VALUES
    ('Bugs bunny', 250000, 2, 'Back End Developer');

-- Changing in the existing trigger function
ALTER trigger add_employee_trigger
ON Employees
after INSERT
AS
Begin
DECLARE @Id int
SELECT @Id=empId from inserted 
SELECT * from inserted
INSERT INTO EmpAudit VALUES('New Employee with Id = '+ Cast(@Id as nvarchar(5)) + ' is addede at '+ cast(GETDATE() as nvarchar(20)))
End;




-- Logs AuditTable;

Create Table EmpAudit (
Id Int primary key identity(1,1),
ActionPerformed varchar(255) not null);

-- Delete trigger

-- 25/03/24
--Update Trigger with logs 
ALTER Trigger Delete_emp_trigger
On Employees
After Delete
AS
BEGIN
Declare @Id int
Declare @Name varchar(50)
SELECT @Id=empId from deleted
SELECT @Name=empName from deleted

INSERT INTO EmpAudit VALUES(@Name +' having id ='+ CAST(@Id as varchar(6))+ 
' has been removed from employees at '+ CAST(GetDate() as varchar(30)))
END;
Delete from Employees where empId=7;
SELECT * from EmpAudit;
truncate table EmpAudit;

ALTER Trigger Update_emp_trigger
On Employees
for Update
AS
BEGIN
DECLARE @Id int
DECLARE @Newname varchar(60), @Oldname varchar(60)
DECLARE @Newsalary int,  @Oldsalary int
DECLARE @NewDesignation varchar(60),@OldDesignation varchar(60)
DECLARE @Newdeptid int,  @Olddeptid int
DECLARE @AuditString varchar(255)
SELECT * into #Temptable from inserted
WHILE(Exists(Select empId from #Temptable))
BEGIN
Set @AuditString=''
Select top 1 @Id=empId, @Newname=empName, @Newsalary=empSalary,@NewDesignation=designation ,@Newdeptid=deptid from #Temptable
Select @Oldname=empname, @Oldsalary=empSalary, @OldDesignation=designation, @Olddeptid=deptId from deleted where empId=@Id
Set @AuditString= 'Employee having id = '+CAST(@Id as varchar(6))+ 'on '+Cast(GETDATE() as varchar(50))+' has been changed '
if(@Newname <> @OldName)
Set @AuditString= @AuditString + ' its name from '+@Oldname+' to '+@Newname

if(@Newsalary <> @Oldsalary)
Set @AuditString= @AuditString + ' its salary from '+CAST(@Oldsalary as varchar(10))+' to '+CAST(@Newsalary as varchar(10))

if(@NewDesignation<> @OldDesignation)
Set @AuditString= @AuditString + ' its designation from '+@OldDesignation+' to '+@NewDesignation

if(@Newdeptid <> @Olddeptid)
Set @AuditString= @AuditString + ' its department id from '+CAST(@Olddeptid as varchar(10))+' to '+CAST(@Newdeptid as varchar(10))
Delete from #Temptable where empId=@Id
INSERT INTO EmpAudit Values(@AuditString)
END
END;

UPDATE  Employees SET  empName='Ghazi' where empId=2;

Alter table Employees Add status int not null default(1); 
SELECT * FROM Employees;

-- Instead of triggers
-- Soft Delete
-- Delete instead of trigger 
CREATE TRIGGER soft_delete_trigger
On Employees
INSTEAD of DELETE
AS
BEGIN
DECLARE @Id int
SELECT @Id=empId from deleted
UPDATE Employees set Employees.status=0 where empId=@Id
END;

Delete from Employees where empId=3;

-- INSERT instead of trigger 
SELECT * into Test from Employees;
SELECT * from  Test;

INSERT INTO Employees (empName,empSalary,designation,deptId,status) Values ('Sohail Alam', 80000, 'QA Engineer',1,1);
ALTER TRIGGER Add_Test_Emp 
on Employees
INSTEAD OF INSERT
AS
BEGIN
-- DECLARE @Id int, @name varchar(50), @desig varchar(50),@departId int, @status int, @sal int
-- SELECT @Id=empId,@name=empName,@sal=empSalary,@desig=designation, @departId=deptId,@status=status from Inserted
-- INSERT INTO TEST 
-- (empName,empSalary,designation,deptId,status) Values (@name,@sal, @desig,@departId,@status)

INSERT INTO TEST 
(empName,empSalary,designation,deptId,status) 
select empName,empSalary,designation,deptId,status from inserted
END;

-- 29/3/24

-- Data Control Language DCL

CREATE LOGIN empclerk WITH PASSWORD='abc';

CREATE USER  empclerk FOR LOGIN empclerk;

SELECT * from sys.sql_logins;

GRANT SELECT, INSERT on dbo.employees TO empclerk ; 

REVOKE INSERT on dbo.employees from empclerk;

GRANT ALL on dbo.employees TO empclerk;

GRANT SELECT on dbo.Departments TO empclerk ; 

-- 1/04/2024
-- transactions
-- ROLLBACK
-- COMMIt

-- A => Atomicity -- all the steps are fully completed or not a single step will execute.
-- C => Consistency -- all the nodes in a network should be aware of the transaction.
-- I => Isolation -- one transaction's info should not be known to another transaction.
-- D => Durability -- changes after transaction should be saved.

-- DDL -Definition
-- DML -Manipulation
-- DCL - Control
-- TCL(Tracnsaction Control Language)
 
Update Employees set empName='Yasir' where empName='Bugs Bunny';
SELECT * from Employees;

begin Transaction
Update Employees set empName='Farooq' where empName='Donald Duck';

Rollback transaction;-- Undo
 Commit transaction; --Save changes

-- Try catch

BEGIN TRANSACTION
begin try
Update Employees set empName='Duck' where empName='Donald Duck';
Update Employees set empName='bye' where empId=23/0;
print('Committed the transaction Successfully.')
COMMIT TRANSACTION
end try
begin catch
print('Rolled back  transaction Successfully.')
ROLLBACK TRANSACTION
end catch;



-- ENDED

