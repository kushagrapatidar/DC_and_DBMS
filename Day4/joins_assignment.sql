-- Joins (EMP-DB)
use emp_db;
-- 1.	List  deptno, dname along with total salary in each department.
select deptno,dname, sum(sal) as salary
from dept
right join emp
using (deptno)
group by deptno
order by deptno;

-- 2.	List details from emp, dept and salgrade table excluding clerks and employees with grade 1. Order on their names.
select EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO, DNAME, LOC, SAL, GRADE
from emp
left join dept
using (deptno)
join salgrade
on emp.sal between salgrade.losal and salgrade.hisal
where job!='CLERK' and grade!=1
order by empno;

-- 3.	List employee with grade 3 or 4.
select *
from emp
join salgrade
on emp.sal between salgrade.losal and salgrade.hisal
where grade=3 or grade=4
order by empno;

-- 4.	List employees located in dallas.
select DEPTNO,DNAME,EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM
from dept
left join emp
using (deptno)
where loc='DALLAS'
order by empno;

-- 5.	List employee and department details for department 30 and 40.
select EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,DNAME
from emp
left join dept
using (deptno)
where deptno=30 or deptno=40;

-- 6.	List all employees who earn less than their managers. List their managers details also.
select e1.EMPNO, e1.ENAME, e1.JOB as EJOB, e1.HIREDATE as EHIREDATE, e1.SAL as ESAL, e1.COMM as ECOMM, e1.DEPTNO as EDEPTNO, e1.MGR, 
		e2.EMPNO as MGR_EMPNO, e2.ENAME as MRG_NAME, e2.JOB as MGR_JOB, e2.HIREDATE as MGR_HIREDATE, e2.SAL as MGR_SAL, e2.COMM as MGR_COMM, e2.DEPTNO as MGR_DEPTNO, e2.MGR as MGR_o_MGR
from emp as e1
left join emp as e2
on e1.mgr=e2.empno
where e1.sal<e2.sal;

-- 7.	Find all employees who joined the company before their manager.
select e1.EMPNO, e1.ENAME, e1.JOB as EJOB, e1.HIREDATE as EHIREDATE, e1.DEPTNO as EDEPTNO, e1.MGR, 
		e2.EMPNO as MGR_EMPNO, e2.ENAME as MRG_NAME, e2.JOB as MGR_JOB, e2.HIREDATE as MGR_HIREDATE, e2.DEPTNO as MGR_DEPTNO
from emp as e1
left join emp as e2
on e1.mgr=e2.empno
where e1.hiredate<e2.hiredate;


-- Joins (RTU-DB)
use rtudb;
-- 1.	Display RTU details alongwith sensor details for all RTU's
select *
from rtu
left join sensors
using (rtu_id)
order by rtu_id;

-- 2.	Display user details and sensor details controlled by each user.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id
from controllers as cntlr
right join users using (user_id)
left join sensors using (sensor_id)
order by user_id;

-- 3.	Display user details and sensor details controlled by each user alongwith RTU details.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id, location, ip_address
from controllers as cntlr
join users using (user_id)
join sensors using (sensor_id)
join rtu using (rtu_id)
order by user_id;

-- 4.	List how many sensors are controlled by each user. Display user_name and count. Sort on count.
select user_name, count(*) as sensor_count
from controllers
right join users using (user_id)
group by user_name
order by sensor_count;

-- 5.	Display user details who are controlling sensor_type TEMPERATURE
select users.*, sensor_id
from controllers
right join users using (user_id)
left join sensors using (sensor_id)
where sensor_type ='TEMPERATURE'
order by user_id;

-- 6.	Display user details that is controlling sensor S801 along with sensor details and location.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id, location, ip_address
from controllers as cntlr
join users using (user_id)
join sensors using (sensor_id)
join rtu using (rtu_id)
where sensor_id='S801'
order by user_id;