/** Chapter 1 - Retrieving Records **/

select 
e.ENAME
,e.DEPTNO
,e.SAL
from emp e


select
* 
from
(select e.SAL as Salary, e.COMM as Commission
from emp e) x
where Salary < 2000

select
--e.ENAME || ' works as a ' || e.JOB oracle
concat(e.ENAME,' works as a ', e.JOB) as msg
from 
emp e
where e.DEPTNO = 10

select
e.ENAME name
,e.SAL salary
,case when sal <= 2000 then 'UNDERPAID'
	  when sal >= 4000 then 'OVERPAID'
	  else 'OK' 
end as status
from emp e


--selecionar dados aleat�rios
select top 5
e.ENAME,
e.JOB
from emp e
order by newid()

select 
*
from emp
where comm is null

select
coalesce(comm, 0) comm
from emp

select case
	   when comm is not null then comm
	   else 0
	   end
from emp

select 
e.ENAME
,e.JOB
from emp e
where e.DEPTNO in (10, 20)
	and (e.ENAME like '%I%' or e.job like '%er')

/** Chapter 2 - Sorting Query Results **/

select
e.ENAME
,e.JOB
,e.SAL
from emp e
where e.DEPTNO = 10
order by e.sal asc

select 
e.ename
,e.JOB
,e.SAL
from emp e
where e.DEPTNO = 10
order by e.SAL desc

select 
e.ename
,e.JOB
,e.SAL
from emp e
where e.DEPTNO = 10
order by 3 desc

select 
	 e.EMPNO
	,e.DEPTNO
	,e.SAL
	,e.ENAME
	,e.JOB
from emp e
order by e.DEPTNO asc, 
		 e.SAL desc


select 
	e.ENAME
	,e.JOB
from emp e
order by right(e.job, 2) desc

select 
	e.ENAME
	,e.JOB
from emp e
order by substring(job, len(job) - 1, 2)

--create view V
--as
--select e.ENAME + ' ' + e.DEPTNO as data
--from emp e

--select * from V

--select
--data
--from V
--order by substring(data, len(data) - 1,  2)

--select 
--data
--from V
--order by right(data, 2)

--select 
--data
--from V
--order by substring(data, len(data) - len(data) + 1, 2)

----better solution than substring
----order by deptno
--select
--data
--from V
--order by replace(data,
--		 replace(
--		 translate(data, '0123456789', '##########'), '#',''),'')

----order by ename
--select data
--from V
--order by replace(
--		 translate(data, '0123456789', '##########'),'#','')

--use SQL_COOKBOOK

--select 
--	data,
--	replace(data,
--	replace(
--	translate(data, '0123456789', '##########'),'#', ''),'') nums,
--	replace(
--	translate(data, '0123456789', '##########'), '#', '') chars
--from v



------cte

--with tabela as (
--	select 	'sinval' + ' ' + '40' as data
--)

--select 
--	 data, 
--	 replace(translate(data, '0123456789', '##########'), '#', '') nome,
--	 replace(data, replace(translate(data, '0123456789', '##########'),'#', ''), '') idade,
--	 len(replace(translate(data, '0123456789', '##########'), '#', '')) nomeTamanho,
--	 len(replace(data, replace(translate(data, '0123456789', '##########'),'#', ''), '')) idadeTamanho
--	 ,translate(data, '0123456789', '##########') translate_numeros
--	 ,translate(data, 'abcdefghijklmnopqrstuvwxyz', '##########################') letras
--	 ,replace(data, replace(translate(data, '0123456789', '##########'), '#', ''), '') so_numeros
--	 ,replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '##########################'), '#', '')

--from tabela

--select
--data
--,replace(translate(data, '0123456789', '$$$$$$$$$$'), '$', '') nome
--,replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '&&&&&&&&&&&&&&&&&&&&&&&&&&'), '&', '') idade
--from V
--	order by replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '&&&&&&&&&&&&&&&&&&&&&&&&&&'), '&', '') --idade


--select 
--data
--,replace(translate(data, '0123456789', '##########'), '#', '') nome
--,replace(data, replace(translate(data, '0123456789', '##########'), '#', ''), '') idade 
----de dentro pra fora: pego os numeros e troco #, 
----depois substituo os # por '', pra pegar o nome, 
----depois substituo o nome, por '', pra ter o n�mero.
--from V


--SELECT REPLACE('SINVAL','SINVAL', 'SINVAL, A LENDA')

--SELECT REPLICATE('EUTEAMO ', 9*8*7*6*5*4*3*2*1)

--select replicate('&', len('abcdefghijklmnopqrstuvwxyz'))



/**************************************************************/
/*** Continuar da p�gina 21 Dealing with Nulls When Sorting ***/
/**************************************************************/

--with testando as
--(
--	select
--	concat(e.ENAME, ' ', e.SAL) as line
--	from emp e
--)

--select
--line,
--replace(translate(line, '0123456789.', '###########'), '#', '') name,
--format(cast(replace(line, replace(translate(line, '0123456789.','###########'), '#', ''), '') as numeric(18,2)) * 1.115, 'c', 'pt-br') salary_with_raise
--from testando

--use SQL_COOKBOOK
--select
--data
--,replace(translate(data, '0123456789', '**********'), '*', '') nome
--,replace(data, replace(translate(data, '1234567890', '**********'), '*', ''), '') job
--from V

--- Dealing with nulls when sorting

select
e.ENAME, 
e.SAL,
e.COMM
from emp e
order by 3 

select
e.ENAME, 
e.SAL,
e.COMM,
E.is_null
from (select e.ENAME, 
			 e.SAL, 
			 e.COMM,
			 case when comm is null or comm = '' then 0 
			 else 1 
			 end as is_null 
		from emp e) e
order by e.is_null , COMM asc

select
e.ename
,e.SAL
,e.JOB
,e.COMM
from emp e
order by case when e.JOB = 'SALESMAN' then e.COMM else e.SAL end


select ename,sal,job,comm
from emp
order by case when job = 'SALESMAN' then COMM else sal end

select e.ENAME, e.SAL, e.JOB, e.COMM,
		case when e.JOB = 'SALESMAN' then e.COMM else sal end as ordered
from emp e
order by ordered

--Summming up
select top 5 *
from emp e
order by NEWID()

select * from emp

--- Chapter 3
--- Working with Multiple Tables

select
emp.ENAME,
emp.DEPTNO
from emp
where emp.DEPTNO = 10

union all
select '-------------', ' '
union all

select
dept.DNAME,
dept.DEPTNO
from dept

select 
emp.DEPTNO
from emp
union
select
dept.DEPTNO
from dept


SELECT DISTINCT DEPTNO FROM(
select 
emp.DEPTNO
from emp
union ALL
select
dept.DEPTNO
from dept) X

--equi-join, a type of inner join
select 
e.ENAME, d.LOC
from emp e, dept d
where e.DEPTNO = d.DEPTNO
and e.DEPTNO = 10

select
e.ename, d.loc
from emp e join dept d
	on (e.DEPTNO = d.DEPTNO)
where e.DEPTNO = 10

drop view V

--create view V
--as
--select e.ENAME, e.JOB, e.SAL from emp e
--where e.JOB = 'clerk'

--select * from V

--select 
--e.EMPNO
--,v.ENAME
--,v.JOB
--,v.SAL
--,e.DEPTNO
--from V v
--inner join emp e
-- on (e.ENAME = v.ENAME and v.JOB = e.JOB and v.SAL = e.SAL)


/********************************************************************************************/
/*** Continuar da p�gina 34 Retrieving Values from One Table That Do Not Exist in Another ***/
/********************************************************************************************/

select 
d.DEPTNO
from dept d
left join emp e on (e.DEPTNO = d.DEPTNO) 
where e.DEPTNO is null

select 
d.DEPTNO
from dept d
where d.DEPTNO not in (select distinct DEPTNO from emp)

select DEPTNO from dept
except
select deptno from emp

--create table new_dept(deptno integer)
insert into new_dept values(10), (50), (null)

select *
from dept
where deptno not in (select DEPTNO from new_dept)

select *
from dept
where deptno in (10, 50, null)

select *
from dept 
where (deptno=10 or deptno = 50 or deptno=null)

select *
from dept
where deptno not in (select DEPTNO from new_dept where deptno is not null) --exclu�r resultados nulos pra n�o dar problemas com a tabela verdade...


select * from dept

select * from new_dept

select * from dept where DEPTNO not in (select DEPTNO from new_dept)

select *
from dept d
where not exists (
select 0
from new_dept nd
where d.deptno = nd.deptno
)



select
*
from dept d
where not exists (select 0 from emp where emp.DEPTNO = d.DEPTNO)

select d.*
from dept d
left join emp e
	on (d.DEPTNO = e.DEPTNO)
where e.DEPTNO is null


select
e.ENAME, e.DEPTNO as emp_depto, d.*
from dept d
left outer join emp e
on (d.DEPTNO = e.DEPTNO)

--create table emp_bonus (empno integer, received date, type integer)
insert into emp_bonus values (7369, getdate(), 1), (7900, getdate(), 2 ), (7788, getdate(), 3)

select e.ename, d.loc, eb.received
  from emp e join dept d 
	on (e.DEPTNO = d.DEPTNO) --or inner join
  left join emp_bonus eb 
	on (eb.empno = e.EMPNO)
order by 2

select e.ename, d.loc, 
	   (select eb.received from emp_bonus eb 
	     where eb.empno = e.EMPNO) as received
  from emp e, dept d
 where e.DEPTNO = d.DEPTNO
order by 2

--select e.DEPTNO,
--	   e.ENAME,
--	   e.SAL,
--	   (select d.dname, d.loc, getdate() today 
--	      from dept d 
--		 where e.deptno=d.deptno)
--  from emp e

--3.7 Determining wheter 2 tables have the same data
--create view V
--as
--select * from emp where DEPTNO != 10
--union all
--select * from emp where ename = 'WARD'

(
select V.EMPNO, V.ENAME, V.JOB, V.MGR, V.HIREDATE, V.SAL, V.COMM, V.DEPTNO, count(*) as cnt
  from V
group by V.EMPNO, V.ENAME, V.JOB, V.MGR, V.HIREDATE, V.SAL, V.COMM, V.DEPTNO
except
select emp.EMPNO, emp.ENAME, emp.JOB, emp.MGR, emp.HIREDATE, emp.SAL, emp.COMM, emp.DEPTNO, count(*) as cnt
  from emp
group by emp.EMPNO, emp.ENAME, emp.JOB, emp.MGR, emp.HIREDATE, emp.SAL, emp.COMM, emp.DEPTNO
)
union all
(
select emp.EMPNO, emp.ENAME, emp.JOB, emp.MGR, emp.HIREDATE, emp.SAL, emp.COMM, emp.DEPTNO, count(*) as cnt
  from emp
group by emp.EMPNO, emp.ENAME, emp.JOB, emp.MGR, emp.HIREDATE, emp.SAL, emp.COMM, emp.DEPTNO
except
select V.EMPNO, V.ENAME, V.JOB, V.MGR, V.HIREDATE, V.SAL, V.COMM, V.DEPTNO, count(*) as cnt
  from V
group by V.EMPNO, V.ENAME, V.JOB, V.MGR, V.HIREDATE, V.SAL, V.COMM, V.DEPTNO
)

--outra forma de fazer somente no sql server

select * --ok
  from ( --ok
  select e.empno,e.ename,e.job,e.mgr,e.hiredate,
	     e.sal,e.comm,e.deptno, count(*) as cnt
	from emp e
	group by e.empno,e.ename,e.job,e.mgr,e.hiredate,
	     e.sal,e.comm,e.deptno
  ) e
  where not exists (
	select null
	  from (
		select empno,ename,job,mgr,hiredate, 
			   sal,comm,deptno, count(*) as cnt
		from V 
		group by empno,ename,job,mgr,hiredate, sal,comm,deptno
	  ) v
	  where v.empno				= e.EMPNO
		and v.cnt				= e.cnt
	    and v.ename				= e.ENAME
		and v.job				= e.JOB
		and coalesce(v.mgr, 0)	= coalesce(e.mgr, 0)
		and v.hiredate			= e.HIREDATE
		and v.sal				= e.SAL
		and coalesce(v.comm, 0)	= coalesce(e.COMM, 0)
		and v.cnt				= e.cnt
  )
  union all
  select * from (
	select empno,ename,job,mgr,hiredate, sal,comm,deptno, count(*) as cnt
	  from V
	group by empno,ename,job,mgr,hiredate, sal,comm,deptno
  ) v
  where not exists (
  select null 
    from (
	select e.empno,e.ename,e.job,e.mgr,e.hiredate,
	     e.sal,e.comm,e.deptno, count(*) as cnt
	  from emp e
	group by e.empno,e.ename,e.job,e.mgr,e.hiredate,
	     e.sal,e.comm,e.deptno
	) e
	  where v.empno				= e.EMPNO
		and v.deptno			= e.DEPTNO
	    and v.ename				= e.ENAME
		and v.job				= e.JOB
		and coalesce(v.mgr, 0)	= coalesce(e.mgr, 0)
		and v.hiredate			= e.HIREDATE
		and v.sal				= e.SAL
		and coalesce(v.comm, 0)	= coalesce(e.COMM, 0)
		and v.cnt				= e.cnt
  )
/********************************************/
/******  continuar da p�gina 46 *************/
/********************************************/

select count(*) from emp e
union
select count(*) from dept d

select *, count(*) ctn from V group by *, ctn
where not exists (select *, count(*) ctn from emp)

select * from emp where not exists (select * from V)

--3.1 Stacking One Rowset atop Another

	select ename ename_and_dname, deptno from emp
	where deptno = 10
	union all
	select '---------------', null
	union all
	select dname, deptno from dept

	select deptno from emp
	union
	select deptno from dept


--3.2 Combining Related Rows

select e.ename, d.LOC from emp e, dept d
where (e.DEPTNO = d.DEPTNO) 
	  and e.DEPTNO = 10

	  --join//equi-join a type of inner join 

/** Aqui a l�gica do join est� no where **/
select   e.ENAME
		,d.LOC
		,e.DEPTNO as �mp_deptno
		,d.DEPTNO as dept_deptno
from emp e, dept d
where e.deptno = d.deptno and e.DEPTNO = 10

/** Aqui a l�gica do join est� no FROM **/
select e.ename, d.LOC from emp e
 inner join dept d
	on (e.DEPTNO = d.DEPTNO)
 where e.DEPTNO = 10

 --3.3 Finding Rows in Common Between Two Tables

 --create view Vi
 --as
 --select
 --ename, job, sal
 --from emp where job = 'CLERK'

select * from Vi

select * from emp

select e.EMPNO,
	   v.ename,
	   v.job,
	   v.sal,
	   e.DEPTNO
from Vi v
left join emp e
	on (e.ENAME = v.ename)

select 
	e.EMPNO
	,v.ename
	,v.job
	,v.sal
	,e.DEPTNO
 from emp e, Vi v
where e.ename = v.ename
  and e.job = v.job
  and e.sal = v.sal

select 
	e.EMPNO
	,v.ename
	,v.job
	,v.sal
	,e.DEPTNO
from emp e join Vi v
	on (e.ename = v.ename
	and e.job = v.job
	and e.sal = v.sal)

--3.8 Identifying and Avoiding Cartesian Products

--Problem: You want to return the name of each employee in departament 10 along with the location of the department. The following query is returning incorrect data:

use SQL_COOKBOOK
select e.ename, d.loc from emp e, dept d
where e.DEPTNO = 10 

--solution 
select e.ename, d.loc from emp e, dept d
where e.DEPTNO = d.DEPTNO -- we need to add the joining keys
and e.DEPTNO = 10 

--3.9 Performing Joins When Using Aggregates

--Problem
/*
You want to perform aggregation, but your query involves multiple tables. you want to ensure that joins do not disrupt the aggregation. For example, you want
to find the sum of the salaries for employees in department 10 along(junto) with the sum of their bunuses. Some employee have more than one bonus, and join 
between table emp and table emp_bonus is causing incorrect values to be returned by the aggregate function sum. For this problem, table emp_bonus contains 
the following data:
*/

--EMPNO	RECEIVED	TYPE
--7934	17/03/2005	1
--7934	15/03/2005	2
--7839	15/02/2005	3
--7782	15/02/2005	1

CREATE TABLE emp_bonus 
(
	EMPNO VARCHAR(4),
	RECEIVED DATE,
	TYPE INT
)

INSERT INTO emp_bonus values ('7934', '17/03/2005',	1),
('7934', '15/03/2005',2), ('7839', '15/02/2005',3), ('7782', '15/02/2005',1) 
select * from emp_bonus

select e.EMPNO,
	   e.ENAME,
	   e.SAL,
	   e.DEPTNO,
	   cast(e.sal * case when eb.type = 1 then 0.1
					when eb.type = 2 then 0.2
					when eb.type = 3 then 0.3
					else 0.0
					end as numeric(18,2)) as bonus
from emp e, emp_bonus eb
where e.EMPNO = eb.empno
and e.DEPTNO = 10

select e.DEPTNO,
	   sum(e.SAL) as total_sal,
	   sum(e.bonus) as total_bonus

from (
select e.EMPNO,
	   e.ENAME,
	   e.SAL,
	   e.DEPTNO,
	   cast(e.sal * case when eb.type = 1 then 0.1
					when eb.type = 2 then 0.2
					when eb.type = 3 then 0.3
					else 0.0
					end as numeric(18,2)) as bonus
from emp e, emp_bonus eb
where e.EMPNO = eb.empno
and e.DEPTNO = 10 ) e
group by e.DEPTNO

/*
DEPTNO	total_sal	total_bonus
10		10050.00	2135.00

total sal is wrong!
*/



select e.DEPTNO,
	   sum(distinct e.SAL) as total_sal,
	   sum(e.bonus) as total_bonus

from (
select e.EMPNO,
	   e.ENAME,
	   e.SAL,
	   e.DEPTNO,
	   cast(e.sal * case when eb.type = 1 then 0.1
					when eb.type = 2 then 0.2
					when eb.type = 3 then 0.3
					else 0.0
					end as numeric(18,2)) as bonus
from emp e, emp_bonus eb
where e.EMPNO = eb.empno
and e.DEPTNO = 10 ) e
group by e.DEPTNO

/*
DEPTNO	total_sal	total_bonus
10		8750.00		2135.00
we need to use distinct to sum only one time the the salary of each employee.
*/