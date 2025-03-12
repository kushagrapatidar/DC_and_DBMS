-- Use Database
use companydb;

-- 
-- 1. STORED PROCEDURES
--
-- 1. Create a stored procedure sp_add_employee that inserts a new employee into the Employees table.
-- The procedure should accept first name, last name, email, hire date, salary, and department ID as parameters. 
DELIMITER //
create procedure sp_add_employee(
	in first_name varchar(50),
    in last_name varchar(50),
    in email varchar(100),
    in hire_date date,
    in salary decimal(10,2),
    in dept_id int(10)
    )
begin

insert into employees (first_name, last_name, email, dob, hire_date, salary, dept_id)
values (first_name, last_name, email, null,hire_date, salary, dept_id);

end //

DELIMITER ;

call sp_add_employee('Raj', 'Kumar', 'raj.kumar@example.com', '2023-08-10', 70000, 1);
select * from employees;

-- 
-- 2. Create a stored procedure sp_update_salary that increases an employee's salary by a given percentage.
-- The procedure should accept employee ID and percentage increment as parameters. 
DELIMITER //
create procedure sp_update_salary(
	in employee_id int,
    in percent_increment decimal(10,2)
    )
begin

update employees
set salary=salary+(salary*percent_increment/100)
where emp_id=employee_id;

end //

DELIMITER ;

select * from employees;
call sp_update_salary(1,10);
select * from employees;


--
-- 4. Create a stored procedure sp_delete_employee that removes an employee from the Employees table
-- and logs the deleted employee's details into a separate table called DeletedEmployees.

-- First, create the DeletedEmployees table
create table DeletedEmployees(
	emp_id INT PRIMARY KEY, 
	first_name VARCHAR(50), 
	last_name VARCHAR(50), 
	email VARCHAR(100),
    dob date,
	hire_date DATE, 
	salary DECIMAL(10,2), 
	dept_id INT, 
	deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foreign key (dept_id) references departments(dept_id)
);

-- Then, create the procedure
DELIMITER //
create procedure sp_delete_employee(
	in employee_id int
    )
begin

-- Insert into DeletedEmployee table
insert into DeletedEmployees
select *
from Employees
where emp_id=employee_id;

-- Delete from Employees table
delete from employees where emp_id=employee_id;

end //

DELIMITER ;


--
-- 2. TRIGGER
--
-- 5. Create an AFTER UPDATE trigger after_salary_update that records changes in salary into a table SalaryHistory.

-- First, create the SalaryHistory table
create table SalaryHistory(
	emp_id INT, 
	old_salary DECIMAL(10,2), 
	new_salary DECIMAL(10,2), 
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- Then, create a trigger that logs the previous and updated salary whenever an employee’s salary is changed
DELIMITER //
create trigger after_salary_update
after update on Employees
for each row

begin

    insert into SalaryHistory (emp_id, old_salary, new_salary)
    values (old.emp_id, old.salary, new.salary);

end //

DELIMITER ;


--
-- 3. VIEWS
--
-- 6. Create a View high_salary_employees to display employees earning above 75,000, along with their department name.
create view high_salary_employees as
select emp_id, first_name, last_name, salary, dept_name
from employees as emp, departments as dept
where emp.dept_id=dept.dept_id and salary>75000;
select * from high_salary_employees;

-- 7. View for Salespersons Handling Most Orders
-- SKIPPED

-- 8. Create a View employees_without_dept to display employees who do not belong to any department.
create view employees_without_dept as
select emp_id, first_name, last_name, salary
from employees
where isnull(dept_id);
select * from employees_without_dept;