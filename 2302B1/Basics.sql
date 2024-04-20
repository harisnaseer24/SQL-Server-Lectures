CREATE DATABASE HDSE_I_2302b1;
USE  HDSE_I_2302b1;

CREATE TABLE Employees(
id INT PRIMARY KEY IDENTITY(1,1),
empName VARCHAR(60) NOT NULL,
salary INT NOT NULL,
designation VARCHAR(60) NOT NULL,
city VARCHAR(60) NOT NULL,
depID INT,
);

-- Insert Query
INSERT INTO Employees(empName,salary,designation,city) VALUES
('Waleed',600000,'Sales Head','Karachi'),
('Hafiz Faisal',500000,'Front End Developer','Hunza'),
('Haseeb Ahmed Khan',650000,'Database Administrator','Rawalpindi'),
('Ali',650000,'Database Administrator','Karachi');


-- Read Query
SELECT * FROM Employees;
SELECT designation,salary FROM Employees;

-- Delete Query
DELETE FROM Employees where id=7;

-- Update Query
UPDATE Employees SET designation='Senior DEVELOPER' WHERE city ='Karachi';
UPDATE Employees SET designation='Senior DEVELOPER' WHERE id =5;
UPDATE Employees SET designation='Team Lead',salary='100000', city='Islamabad' WHERE id =4;

-- Distinct Clause
SELECT distinct city from Employees;

-- Where clause with operators;
SELECT * from Employees where city='Karachi';

-- not operator
SELECT * from Employees where not city='Karachi';

-- and operator
SELECT * from Employees where city='Karachi' AND city='Hunza';
SELECT * from Employees where salary>500000  AND designation='Backend Developer';

-- or operator
SELECT * from Employees where city='Karachi' OR city='Hunza' ;

SELECT * from Employees where salary>500000  or not designation='Senior Developer' AND city='KARACHI';

-- between 
SELECT * FROM Employees where id between 4 And 7;

-- in 
SELECT * FROM Employees where city in ('Karachi','Islamabad','Lahore', 'New york');

-- like 
SELECT * FROM Employees where empName like '%a';

SELECT * FROM Employees where empName like 'a%';

SELECT * FROM Employees where empName like '%a%';

SELECT * FROM Employees where empName like '%a%' ANd designation like '%a%';

SELECT * FROM Employees where empName like '%a%' OR designation like '%a%';

-- task : get all the data of those employees whose salary is not greater than 400000
-- or belongs to karachi having designation not equals to Database Administrator

SELECT * FROM Employees where not salary > 400000 or city='karachi' and not designation='Database Administrator';

CREATE TABLE Departments(
deptId INT PRIMARY KEY IDENTITY(1,1),
deptName Varchar(50) NOT NULL,
);

INSERT INTO Departments VALUES('DEVELOPMENT'),('SQA'),('SALES'),('HR'),('ACCOUNTS');
SELECT * FROM DEPARTMENTS;

-- FOREIGN KEY 
DROP TABLE Employees;

CREATE TABLE Employees(
id INT PRIMARY KEY IDENTITY(1,1),
empName VARCHAR(60) NOT NULL,
salary INT NOT NULL,
designation VARCHAR(60) NOT NULL,
city VARCHAR(60) NOT NULL,
deptId INT,
FOREIGN KEY (deptId) REFERENCES Departments(deptId)
);

INSERT INTO Employees(empName,salary,designation,city,deptId) VALUES
('Waleed',600000,'Sales Head','Karachi',3),
('Hafiz Faisal',500000,'Front End Developer','Hunza',1),
('Haseeb Ahmed Khan',650000,'Database Administrator','Rawalpindi',1),
('Ali',650000,'Database Administrator','Karachi',1),
('Hamdan',450000,'HR HEAD','Karachi',4),
('Shahzaib',550000,'Accountant','Islamabad',5),
('Muslim',750000,'Tester','Islamabad',2);

SELECT * FROM Employees;

-- JOINS
INSERT INTO Departments VALUES('DESIGNING');
INSERT INTO Employees(empName,salary,designation,city,deptId) VALUES('Dumbledore',45000,'OFFICE BOY','kARACHI',NULL);

-- INNER JOIN
SELECT * From Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId;

-- LEFT OUTER JOIN 
SELECT * From Employees as e LEFT JOIN Departments as d ON e.deptId=d.deptId;

-- RIGHT OUTER JOIN 
SELECT * From Employees as e RIGHT JOIN Departments as d ON e.deptId=d.deptId;

-- FULL OUTER JOIN 
SELECT e.*,d.deptName From Employees as e FULL JOIN Departments as d ON e.deptId=d.deptId;

-- 26/3/24
-- Aggregate Functions
SELECT COUNT(id) as Total_employees FROM Employees;
SELECT MAX(salary) as Max_salary FROM Employees;
SELECT MIN(salary) as Min_salary FROM Employees;
SELECT AVG(salary) as AVG_salary FROM Employees;
SELECT sum(salary) as total_amount_paid FROM Employees;
SELECT CONCAT(empName,' works as a ', designation,' from ',city) as EMP_DETAILS FROM Employees

-- Group By Clause

SELECT city, count(id) from Employees group by city;
SELECT designation, count(id) from Employees group by designation;

SELECT deptId, count(id) from Employees group by deptId;

SELECT d.deptname,count(e.id) from Employees as e inner join Departments as d on e.deptId= d.deptId group by d.deptName;

-- Views

SELECT* from Employees;

CREATE VIEW [empDetails] as 
SELECT empName,salary,designation from Employees;

Select * from empDetails;

Select * from empDetails where salary > 500000;

insert into empDetails values('Alauddin',788888, 'Team Lead');
delete from empDetails where empName='Alauddin';


CREATE VIEW [empALL] AS
SELECT e.*,d.deptName From Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId;

SELECT * from empALL;

delete from Employees where id=6;

CREATE VIEW [HighPayingEmployees] AS
SELECT e.*,d.deptName From Employees as e INNER JOIN Departments as d ON e.deptId=d.deptId where salary > 400000;

SELECT * from [HighPayingEmployees];

-- into operator
SELECT * INTO TEST FROM Employees;
SELECT * FROM TEST;

-- 30/3/2024

-- DCL(DATA CONTROL LANGUAGE)

CREATE LOGIN abc with PASSWORD='123';
CREATE USER abc from LOGIN abc;

SELECT * FROM sys.sql_logins;

-- GRANT
GRANT SELECT, INSERT on dbo.Employees TO abc;

-- REVOKE
REVOKE INSERT on dbo.Employees from abc;

-- 2/04/24
-- Stored Procedures
--create
CREATE Procedure ShowEmployees
AS
BEGIN
SELECT * FROM Employees
END;

-- alter
ALTER Procedure ShowEmployees
AS
BEGIN
SELECT * FROM Employees where city='Karachi'
END;
-- call
ShowEmployees;
--delete
drop procedure ShowEmployees;

CREATE PROCEDURE addEmployee @empname varchar(60),@sal int, @post varchar(60),@city varchar(50),@deptId int
AS
BEGIN
INSERT INTO Employees values(@empname,@sal,@post, @city,@deptId)
SELECT * From Employees
END;

addEmployee @empname='Javaad',@sal=676776, @post='technician',@city='jhang',@deptId =2;

--INDEXES

CREATE INDEX empName_index
on Employees(empName);
 
 DROP INDEX Employees.empName_index;


 CREATE INDEX empName_index
on Employees(empName,designation);

-- TRIGGERs
-- for 
CREATE TRIGGER ADD_EMP 
ON Employees
for insert
AS
BEGIN
print('Employee inserted successfully.')
END;

-- after
ALTER TRIGGER ADD_EMP 
ON Employees
AFTER insert
AS
BEGIN
select * from inserted;
END;

--maintaining logs
ALTER TRIGGER ADD_EMP 
ON Employees
AFTER insert
AS
BEGIN
DECLARE @id int, @name varchar(50)
select @id=Id,@name=empName from inserted;
INSERT INTO EmpAudit VALUES(@name+' having id = '+ CAST(@id as varchar(6))+ 
' has been added as an employee at '+ CAST(GETDATE() as varchar(30)))
END;

INSERT INTO Employees(empName,salary,designation,city,deptId) VALUES('Fakhar',455000,'DevOps Engineer','Mardan',3);

-- Creating new table for logs
CREATE TABLE EmpAudit (
Id int Primary key identity(1,1),
LogInfo nvarchar(255) not null 
);

SELECT * FROM EmpAudit;
CREATE Trigger Update_emp_trigger
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
WHILE(Exists(Select Id from #Temptable))
BEGIN
SELECT @Id=Id,@Newname=empName, @Newsalary=salary, @NewDesignation=designation, @Newdeptid=deptId from #Temptable
SELECT @Oldname=empName, @Oldsalary=salary, @OldDesignation=designation, @Olddeptid=deptId from deleted where Id=@Id;
SET @AuditString =''
SET @AuditString ='An employee having id = '+ CAST(@Id as varchar(6))+' is changed on '+ CAST(GETDATE() as varchar(30))
if(@Newname <> @Oldname)
SET @AuditString= @AuditString + ' its name from '+@Oldname +' to '+ @Newname
if(@Newsalary <> @Oldsalary)
SET @AuditString= @AuditString + ' its salary from '+CAST(@Oldsalary as varchar(10)) +' to '+ CAST(@Newsalary as varchar(10)) 
if(@Newdeptid <> @Olddeptid)
SET @AuditString= @AuditString + ' its deptId from '+CAST(@Olddeptid as varchar(10)) +' to '+ CAST(@Newdeptid as varchar(10)) 
if(@NewDesignation <> @OldDesignation)
SET @AuditString= @AuditString + ' its salary from '+ @OldDesignation +' to '+@NewDesignation
Insert into EmpAudit Values(@AuditString)
DELETE From #Temptable where Id= @Id
END
END;
SELECT * from Employees;

UPDATE Employees SET empName='Zaheer Kalia',designation='Marketing Head',deptId=4 where id=9;

-- Instead of Triggers
Alter TABLE Employees Add emp_status int not null default(1);

ALTER Trigger Soft_Delete
On Employees
INSTEAD of DELETE
AS
BEGIN
DECLARE @Id int

SELECT * into #Temptable from DELETED
While(exists(SELECT id from #Temptable))
BEGIN
SELECT top 1 @Id=id from  #Temptable
Update Employees set emp_status=0 where id=@Id;
DELETE from #Temptable where id=@Id
END

Update Employees set emp_status=0 where id=@Id;

END;

-- DELETE from  Employees where id>5;
DELETE from  Employees where empName='Waleed';


-- Transactions ():
