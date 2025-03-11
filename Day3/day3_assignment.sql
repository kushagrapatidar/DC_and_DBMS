use emp_db;

-- GroupBy (Emp-DB)

-- 1.	List all aggregates on salary columns for each department excluding dept 10.
select deptno, sum(sal)
from emp
group by deptno
having deptno!=10;

-- 2.	List departments where number of employees are more than 4
select deptno, count(*)
from emp
group by deptno
having count(*)>4;

-- 3.	Display jobs with average salary greater than 2000. Order on average salary.
select job, avg(sal)
from emp
group by job
having avg(sal)>2000
order by avg(sal);

-- 4.	List how many employees are their under each manager.
select mgr, count(*)
from emp
group by mgr;

-- 5.	Display the manager number and the salary of the lowest paid employee for that manager.
   --   Exclude anyone whose manager is not known. Exclude any groups where the minimum salary is $800 or less.
   --   Sort the output in descending order of salary.
select mgr, min(sal)
from emp
group by mgr
having isnull(mgr)=0 and min(sal)>800
order by min(sal) desc;


-- GroupBy (RTU-DB)
use rtudb;

-- 1.	List how many sensors are present of type PRESSURE.
select count(*) as pressure_sensorcount
from sensors
group by sensor_type
having sensor_type='PRESSURE';

-- 2.	Display number of sensors enabled and disabled. Sort on number of sensors
select sensor_status, count(*) as status_count
from sensors
group by sensor_status
order by status_count;

-- 3.	List how many sensors are present in each sensor type.
select sensor_type, count(*) as type_count
from sensors
group by sensor_type
order by type_count;

-- 4.	Display how many sensors are controlled by each user. Exclude users who are controlling less than 3 sensors and also restrict users with id “U503”. Sort on user_id.
select user_id, count(*) as sensor_count
from controllers
group by user_id
having sensor_count>=3 and user_id!='U503'
order by user_id;