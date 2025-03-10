--
-- Databse Creation
create database companydb;
use companydb;

--
-- Table Creation
create table departments(
dept_id int primary key auto_increment,
dept_name varchar(50) unique not null
);

create table employees(
emp_id int primary key auto_increment,
first_name varchar (50) not null,
last_name varchar (50) not null,
email varchar(100) unique not null,
hire_date date not null,
salary decimal(10,2) not null,
dept_id int,
foreign key (dept_id) references departments(dept_id) on delete set null
);

create table projects(
project_id int primary key auto_increment,
project_name varchar(100) not null,
dept_id int,
foreign key (dept_id) references departments(dept_id) on delete cascade
);

--
-- Data Insertion
insert into departments(dept_name) values
('IT'),
('HR'),
('Finance'),
('Marketing'),
('Operations');

insert into Employees (first_name, last_name, email, hire_date, salary, dept_id) values
('Amit', 'Sharma', 'amit.sharma@example.com', '2022-01-15', 60000.00, 1),
('Priya', 'Verma', 'priya.verma@example.com', '2021-07-20', 75000.00, 2),
('Rohit', 'Patel', 'rohit.patel@example.com', '2020-03-12', 80000.00, 3),
('Sneha', 'Iyer', 'sneha.iyer@example.com', '2019-06-25', 90000.00, 1),
('Vikram', 'Singh', 'vikram.singh@example.com', '2023-02-10', 55000.00, null);

insert into Projects (project_name, dept_id) values
('E-Governance System', 1),
('Campus Hiring Drive', 2),
('Budget Planning & Analysis', 3),
('Social Media Outreach', 4),
('Logistics Automation', 5);


--
-- Queries
-- Joins

-- 1. Retrieve a list of employees along with their department names (INNER JOIN).
select * 
from employees as emp
inner join departments as dept
using (dept_id);

-- 2. Retrieve all departments, including those that do not have employees (LEFT JOIN).
select *
from departments as dept
left join employees as emp
using (dept_id);

-- 3. Retrieve all employees, including those who are not assigned to any department (RIGHT JOIN).
select *
from departments as dept
right join employees as emp
using (dept_id);

-- 4. Retrieve employees who work on projects along with the project name (JOIN with 3 tables).
select *
from employees as emp
inner join departments as dept
inner join projects as prj
on emp.dept_id=dept.dept_id and dept.dept_id=prj.dept_id;

--
-- Subqueries

-- 1. Find the employees earning the highest salary in each department.
select *
from employees
where salary in (select max(salary) from emp group by dept_id);

-- 2. Retrieve the names of employees who work in the "IT" department.
select concat(first_name, ' ', last_name) as employee_name
from employees
where dept_id=(select dept_id from departments where dept_name='IT');

-- 3. Find the department with the highest number of employees.
-- Subpart
-- join
select dept_name, count(*) as dept_count from departments right join employees using (dept_id) group by dept_name;
-- dept_id with max number of employees
select dept_id, count(*) as dept_count
from employees
group by dept_id
having dept_count=(select max(dept_count) from (select count(*) as dept_count from employees group by dept_id) as dept_counts);

-- Final query
select dept_name, count(*) as dept_count
from departments
right join employees
using (dept_id)
group by dept_id
having dept_count=(select max(dept_count) from (select count(*) as dept_count from employees group by dept_id) as dept_counts);

-- 4. Retrieve employees who earn more than the average salary of all employees.
select *
from employees as emp
where emp.salary>(select avg(salary) from employees);