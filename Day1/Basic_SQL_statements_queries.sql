-- Tables
create emp_db;

use emp_db;

CREATE TABLE EMP (
    EMPNO INT(4) NOT NULL,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR INT(4),
    HIREDATE DATE,
    SAL DECIMAL(7, 2),
    COMM DECIMAL(7, 2),
    DEPTNO INT(2),
    PRIMARY KEY (EMPNO)
);

INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        STR_TO_DATE('17-DEC-1980', '%d-%b-%Y'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        STR_TO_DATE('20-FEB-1981', '%d-%b-%Y'), 1600,  300, 30);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        STR_TO_DATE('22-FEB-1981', '%d-%b-%Y'), 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        STR_TO_DATE('2-APR-1981', '%d-%b-%Y'),  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        STR_TO_DATE('28-SEP-1981', '%d-%b-%Y'), 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        STR_TO_DATE('1-MAY-1981', '%d-%b-%Y'),  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        STR_TO_DATE('9-JUN-1981', '%d-%b-%Y'),  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        STR_TO_DATE('09-DEC-1982', '%d-%b-%Y'), 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        STR_TO_DATE('17-NOV-1981', '%d-%b-%Y'), 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        STR_TO_DATE('8-SEP-1981', '%d-%b-%Y'),  1500,    0, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        STR_TO_DATE('12-JAN-1983', '%d-%b-%Y'), 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        STR_TO_DATE('3-DEC-1981', '%d-%b-%Y'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        STR_TO_DATE('3-DEC-1981', '%d-%b-%Y'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        STR_TO_DATE('23-JAN-1982', '%d-%b-%Y'), 1300, NULL, 10);


CREATE TABLE DEPT (
    DEPTNO INT(2) not null,
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);
insert into dept values(20, 'IT', null);
insert into dept values(10, 'MANAGMENT', null);
insert into dept values(30, 'SALES', null);

CREATE TABLE BONUS (
	empno int(4) not null,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    SAL DECIMAL(10, 2),
    COMM DECIMAL(10, 2)
);
insert into bonus select empno, ename, job, sal, coalesce(comm,0) from emp;

CREATE TABLE SALGRADE (
    GRADE INT,
    LOSAL DECIMAL(10, 2),
    HISAL DECIMAL(10, 2)
);

INSERT INTO SALGRADE VALUES (1,  700.00, 1200.00);
INSERT INTO SALGRADE VALUES (2, 1201.00, 1400.00);
INSERT INTO SALGRADE VALUES (3, 1401.00, 2000.00);
INSERT INTO SALGRADE VALUES (4, 2001.00, 3000.00);
INSERT INTO SALGRADE VALUES (5, 3001.00, 9999.00);

-- Set 1
-- 1.	Select all the rows and columns of all the tables.
select emp.* from emp;
select dept.* from dept;
select bonus.* from bonus;
select salgrade.* from salgrade;

-- 2.	Print the employees with the new salary which is the 500 more than original salary.
select *, sal+500 as new_salary from emp;

-- 3.	Print the empno, name and the annual salary.
select empno, ename, 12*sal as annual_salary from emp;

-- 4.	Print the empno, name and the annual salary where the salary is hiked by 500.
select empno, ename, 12*(sal+500) as annual_salary from emp;

-- 5.	Print the annual salary where where salary is calculated by adding the commission. Provide a column alias as “AnnualSal”.
select *, 12*(sal+coalesce(comm,0)) as AnnualSal from emp;

-- 6.	Display name, sal, comm and hiredate for employees with salary less than 1200.
select ename, sal, comm, hiredate from emp where sal<1200;

-- 7.	Print the employe and their Job title in the format “Employee1 works as jobtitle1.”
select concat(ename,' works as ',job,'.') as Jobs from emp;


-- Set 2
-- 1.	Display different job types without duplicating.
select distinct job from emp;

-- 2.	List employees in department 10 and 30 in alphabetical order of names.
select ename from emp where deptno=10 or DEPTNO=30 order by ename;

-- 3.	List clerks in department 20
select ename from emp where deptno=20 and job='ÇLERK';

-- 4.	List employees having ‘LL’ or ‘TH’ in their names.
select ename from emp where ename like '%LL%' or ename like '%TH%';

-- 5.	List employees who do not have manager.
select ename from emp where mgr is null;

-- 6.	List employees hired in year 81.
select ename from emp where year(hiredate)=1981;

-- 7.	Display first name and join date of the employees who is either Manager or SalesMan.
select ename, hiredate from emp where job='MANAGER' OR job='SALESMAN';

-- 8.	Display details of jobs in the descending order of the title.
select job, avg(sal) as avg_sal, avg(comm) as avg_comm from emp group by job order by job desc;

-- 9.	List salesmen having salary greater than commission. Sort on their salaries in descending and names ascending.
select ename, sal, comm from emp where job='SALESMAN' and sal>comm order by sal desc;

-- 10.	List o/p as ‘SMITH works since 17-DEC-80 as CLERK’ using concatenation operator.
select concat(ename,' works since ',hiredate,' as ',job) as list_output from emp;

-- 11.	List all clerks earning less than 1000 and all managers
select empno, ename, job, sal from emp where job='MANAGER' or (job='CLERK' and sal<1000);

-- 12.	List employees having annual remuneration > 30000. Annual remuneration should include commission
select empno, ename, job, 12*(sal+coalesce(comm,0)) from emp where 12*(sal+coalesce(comm,0))>30000;

-- 13.	 Write a query to display the name, job, mgr, hire date, and employee number for each employee, with employee number appearing first.
-- Provide an alias STARTDATE for the HIREDATE column. 
select empno, ename, job, mgr, hiredate as startdate from emp;
