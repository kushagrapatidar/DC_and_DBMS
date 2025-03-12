--
-- Databse Creation
create database companydb;
use companydb;

-- 
-- Table Creation
create table departments(
	dept_id int primary key auto_increment,
    dept_name varchar(50) not null unique
);

create table employees(
	emp_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null unique,
    dob date not null,
    hire_date date not null,
    salary decimal(10,2) not null,
    dept_id int(10),
    foreign key (dept_id) References departments(dept_id)
);

create table projects(
	project_id int primary key auto_increment,
    project_name varchar(100) not null,
    dept_id int null,
    foreign key (dept_id) references departments(dept_id)
);

create table salespersons(
	salesman_id int primary key auto_increment,
    salesman_name varchar(100) not null,
    commission decimal(5,2) not null
);

create table customers(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    city varchar(50) not null,
    salesman_id int(10),
    foreign key (salesman_id) references salespersons(salesman_id)
);

-- 
-- Data Insertion
insert into departments values
(dept_id,     'it'),
(dept_id,'finance'),
(dept_id,'manager');
select* from departments;

insert into employees values
(emp_id, 'john',   'clark',  'jclark@company.com',    STR_TO_DATE('17-DEC-1980', '%d-%b-%Y'), STR_TO_DATE('14-OCT-2004', '%d-%b-%Y'), 80000, 2),
(emp_id, 'allen',  'path',   'apath@company.com',     STR_TO_DATE( '3-MAR-1997', '%d-%b-%Y'),  STR_TO_DATE('8-JAN-2021', '%d-%b-%Y'), 40000, 3),
(emp_id, 'ohm',    'jane',   'ojane@company.com',     STR_TO_DATE('17-DEC-1990', '%d-%b-%Y'), STR_TO_DATE('10-AUG-2010', '%d-%b-%Y'), 50000, 3),
(emp_id, 'cooper', 'field',  'fcooper@company.com',   STR_TO_DATE('17-DEC-1993', '%d-%b-%Y'), STR_TO_DATE('16-OCT-2013', '%d-%b-%Y'), 90000, 1),
(emp_id, 'tim',    'brown',  'tbrown@company.com',    STR_TO_DATE('17-DEC-1995', '%d-%b-%Y'), STR_TO_DATE('19-NOV-2017', '%d-%b-%Y'), 30000, 2),
(emp_id, 'john',   'smith',  'jsmith@company.com',    STR_TO_DATE('17-DEC-1999', '%d-%b-%Y'), STR_TO_DATE('12-JUL-2019', '%d-%b-%Y'), 45000, 1),
(emp_id, 'peter',  'england', 'pengland@company.com', STR_TO_DATE('17-DEC-1970', '%d-%b-%Y'), STR_TO_DATE('13-MAY-2021', '%d-%b-%Y'), 15000, 3),
(emp_id, 'peter',  'parker',  'ppeter@company.com',   STR_TO_DATE('17-DEC-1996', '%d-%b-%Y'), STR_TO_DATE('30-APR-2016', '%d-%b-%Y'), 21000, 2),
(emp_id, 'ben',    'park',    'bpark@company.com',    STR_TO_DATE('17-DEC-1994', '%d-%b-%Y'), STR_TO_DATE('25-FEB-2014', '%d-%b-%Y'), 95000, 1),
(emp_id, 'emilia', 'clark',   'eclark@company.com',   STR_TO_DATE('17-DEC-1986', '%d-%b-%Y'), STR_TO_DATE('18-DEC-2008', '%d-%b-%Y'), 85000, 2);
select * from employees;


insert into projects values
(project_id, 'Project 1',    1),
(project_id, 'Project 2',    3),
(project_id, 'Project 3',    2),
(project_id, 'Project 4',    2),
(project_id, 'Project 5', null);
select* from projects;
truncate projects;

insert into salespersons values
(salesman_id, 'Salesman A', 140.00),
(salesman_id, 'Salesman B', 250.00),
(salesman_id, 'Salesman C', 120.00),
(salesman_id, 'Salesman D', 580.40),
(salesman_id, 'Salesman E', 125.50);
select * from salespersons;

insert into customers values
(customer_id, 'Customer A', 'Loc A',  6),
(customer_id, 'Customer B', 'Loc B',  8),
(customer_id, 'Customer C', 'Loc A',  9),
(customer_id, 'Customer D', 'Loc C', 10),
(customer_id, 'Customer E', 'Loc B',  7),
(customer_id, 'Customer F', 'Loc B',  6),
(customer_id, 'Customer G', 'Loc A',  8),
(customer_id, 'Customer H', 'Loc A',  7),
(customer_id, 'Customer I', 'Loc C',  7),
(customer_id, 'Customer J', 'Loc B', 10);
select * from customers;