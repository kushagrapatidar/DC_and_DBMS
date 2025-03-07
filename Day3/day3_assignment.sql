use emps;

select deptno, sum(sal)
from emp
group by deptno
having deptno!=10;

select deptno, count(*)
from emp
group by deptno
having count(*)>4;

select job, avg(sal)
from emp
group by job
having avg(sal)>2000
order by avg(sal);

select mgr, count(*)
from emp
group by mgr;

select mgr, min(sal)
from emp
group by mgr
having isnull(mgr)=0 and min(sal)>800
order by min(sal) desc;