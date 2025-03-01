use assignment3;
show tables;
insert into departments values(dept_id,'it');
insert into departments values(dept_id,'finance');
insert into departments values(dept_id,'manager');
select* from departments;

insert into employees values(emp_id, 'john','clark','jclark@company.com',STR_TO_DATE('17-DEC-1980', '%d-%b-%Y'), STR_TO_DATE('14-OCT-2004', '%d-%b-%Y'), 80000, 2);
insert into employees values(emp_id, 'allen','path','apath@company.com',STR_TO_DATE('3-MAR-1997', '%d-%b-%Y'), STR_TO_DATE('8-JAN-2021', '%d-%b-%Y'), 40000, 3);
insert into employees values(emp_id, 'ohm','jane','ojane@company.com',STR_TO_DATE('17-DEC-1990', '%d-%b-%Y'), STR_TO_DATE('10-AUG-2010', '%d-%b-%Y'), 50000, 3);
insert into employees values(emp_id, 'cooper','field','fcooper@company.com',STR_TO_DATE('17-DEC-1993', '%d-%b-%Y'), STR_TO_DATE('16-OCT-2013', '%d-%b-%Y'), 90000, 1);
insert into employees values(emp_id, 'tim','brown','tbrown@company.com',STR_TO_DATE('17-DEC-1995', '%d-%b-%Y'), STR_TO_DATE('19-NOV-2017', '%d-%b-%Y'), 30000, 2);
insert into employees values(emp_id, 'john','smith','jsmith@company.com',STR_TO_DATE('17-DEC-1999', '%d-%b-%Y'), STR_TO_DATE('12-JUL-2019', '%d-%b-%Y'), 45000, 1);
insert into employees values(emp_id, 'peter','england','pengland@company.com',STR_TO_DATE('17-DEC-1970', '%d-%b-%Y'), STR_TO_DATE('13-MAY-2021', '%d-%b-%Y'), 15000, 3);
insert into employees values(emp_id, 'peter','parker','ppeter@company.com',STR_TO_DATE('17-DEC-1996', '%d-%b-%Y'), STR_TO_DATE('30-APR-2016', '%d-%b-%Y'), 21000, 2);
insert into employees values(emp_id, 'ben','park','bpark@company.com',STR_TO_DATE('17-DEC-1994', '%d-%b-%Y'), STR_TO_DATE('25-FEB-2014', '%d-%b-%Y'), 95000, 1);
insert into employees values(emp_id, 'emilia','clark','eclark@company.com',STR_TO_DATE('17-DEC-1986', '%d-%b-%Y'), STR_TO_DATE('18-DEC-2008', '%d-%b-%Y'), 85000, 2);
