use companydb;

-- 
-- Queries

-- 1. Grouping and Sorting

-- Group By and Having
-- Find the total number of employees in each department from the Employees and Departments tables.
select emp.dept_id, dept.dept_name, count(*) as employee_count
from employees as emp, departments as dept
where emp.dept_id=dept.dept_id
group by emp.dept_id;

-- Retrieve the average salary of each department but only display departments where the average salary is above 50,000.
select emp.dept_id, dept.dept_name, avg(salary) as dept_avg_sal
from employees as emp, departments as dept
where emp.dept_id=dept.dept_id
group by emp.dept_id
having dept_avg_sal>50000;

-- 2. Order By
-- Retrieve all employees and sort them by salary in descending order.
select *
from employees
order by salary desc;

-- Retrieve all employees sorted by hire date in ascending order.
select *
from employees
order by hire_date;

--
-- 3. Subqueries and Joins

-- Correlated Subqueries
-- Find employees who earn more than the average salary of their department.
select emp.*, dept_avg_sal 
from employees as emp,(select emp.dept_id, avg(salary) as dept_avg_sal
						from employees as emp
						group by emp.dept_id) as dept_avg_sals
where emp.dept_id=dept_avg_sals.dept_id and emp.salary>dept_avg_sals.dept_avg_sal;

-- Retrieve employees who have joined the company earlier than their department’s oldest employee. *
select * 
from employees as emp, (select emp.dept_id, hire_date as oldest_emp_hire_date
							from employees as emp, (select dept_id,MAX(CEILING(DATEDIFF(current_date(),dob)/365)) as dept_max_age 
														from employees 
														group by dept_id) as dept_max_ages
														where emp.dept_id=dept_max_ages.dept_id and CEILING(DATEDIFF(current_date(),emp.dob)/365)=dept_max_age) as oldest_emp
where emp.dept_id=oldest_emp.dept_id and datediff(oldest_emp.oldest_emp_hire_date,emp.hire_date)>0;


-- 4. Outer Joins
-- Retrieve all employees along with their department names (even if they don’t belong to any department).
select *
from employees
left join departments
using (dept_id);

-- Retrieve all projects and their respective departments, including those that don’t have assigned departments.
select *
from projects
left join departments
using (dept_id);

--
-- Real-World Scenarios

-- 5. Employee Search Query
-- Print employee names where first letter is ‘A’ and last letter is ‘N’.
select concat(first_name,' ',last_name) as Employee_Name
from employees
where first_name like 'A%' and first_name like '%N';

-- 6. Customer and Salesperson Query
-- Using Customers and Salesperson tables, write an SQL query to find the salespersons and the customers they handle.
select *
from salespersons
left join customers
using (salesman_id)
order by salesman_id;

-- Display customer name, city, salesman name, and commission.
select customer_name, city, salesman_name, commission
from customers
left join salespersons
using (salesman_id);

