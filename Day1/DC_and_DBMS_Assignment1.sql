-- Database Creation
create database CompanyDB;

use CompanyDB;

-- Table Creation
create Table Employees(
	emp_id INT(5) NOT NULL auto_increment,
    first_name VARCHAR(50) Not Null,
    last_name VARCHAR(50) Not Null,
    email VARCHAR(100) not null unique,
    phone varchar(15) null,
    hire_date date not null,
    salary decimal(10,2) not null,
    department varchar(50) not null,
    primary key(emp_id)
    );
    
desc Employees;


-- Data Insertion
insert into Employees values 
	(1, 'John', 'Clark', 'jclark1@company.com', 
    '4984984871', STR_TO_DATE('17-DEC-2010', '%d-%b-%Y'), 30000, 'IT');

insert into Employees values
	(2, 'Allen', 'Smith', 'asmith2@company.com', 
    '4198749416', STR_TO_DATE('20-FEB-2023', '%d-%b-%Y'), 55500, 'Finance');

insert into Employees values
	(3, 'Ward', 'Jones', 'wjones3@company.com', 
    '1634592673', STR_TO_DATE('2-APR-2022', '%d-%b-%Y'), 63870, 'IT');
    
insert into Employees values
	(4, 'Martin', 'Blake', 'mblake4@company.com', 
    '7653489124', STR_TO_DATE('28-SEP-2021', '%d-%b-%Y'), 77200, 'Security');
    
insert into Employees values
	(5, 'Scott', 'King', 'sking5@company.com', 
    '5689412357', STR_TO_DATE('9-JUN-2023', '%d-%b-%Y'), 39400, 'IT');


-- Assignment Queries (Data Manipulation)
-- 1. Retrieve all records from the Employees table.
select * from Employees;

-- 2. Retrieve employees whose salary is greater than 50,000.
select emp_id, concat(first_name, ' ',last_name) as employee from Employees where salary>50000;

-- 3. Retrieve employees who were hired after January 1, 2022.
select emp_id, concat(first_name, ' ', last_name) as employee from Employees where hire_date>STR_TO_DATE('1-JAN-2022', '%d-%b-%Y');

-- 4. Retrieve employees working in the "IT" department.
select emp_id, concat(first_name, ' ', last_name) as employee from Employees where department='IT';

-- 5. Retrieve the total number of employees in the database.
select count(*) from Employees;

-- 6. Update the salary of an employee withemp_id = 3by increasing it by 10%.
select * from Employees where emp_id=3;

update Employees set salary=salary*110/100 where emp_id=3;

select * from Employees where emp_id=3;

-- 7. Delete an employee record whoseemp_id = 5.
delete from Employees where emp_id=5;

select * from Employees;