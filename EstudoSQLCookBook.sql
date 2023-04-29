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


--selecionar dados aleatórios
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
----depois substituo o nome, por '', pra ter o número.
--from V


--SELECT REPLACE('SINVAL','SINVAL', 'SINVAL, A LENDA')

--SELECT REPLICATE('EUTEAMO ', 9*8*7*6*5*4*3*2*1)

--select replicate('&', len('abcdefghijklmnopqrstuvwxyz'))



/**************************************************************/
/*** Continuar da página 21 Dealing with Nulls When Sorting ***/
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
/*** Continuar da página 34 Retrieving Values from One Table That Do Not Exist in Another ***/
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
where deptno not in (select DEPTNO from new_dept where deptno is not null) --excluír resultados nulos pra não dar problemas com a tabela verdade...


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
/******  continuar da página 46 *************/
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

/** Aqui a lógica do join está no where **/
select   e.ENAME
		,d.LOC
		,e.DEPTNO as émp_deptno
		,d.DEPTNO as dept_deptno
from emp e, dept d
where e.deptno = d.deptno and e.DEPTNO = 10

/** Aqui a lógica do join está no FROM **/
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

--another way
select distinct deptno,total_sal, total_bonus
from (
select  e.empno,
		e.ename,
		sum(distinct SAL) over (partition by  e.deptno) as total_sal,
	    e.deptno,
		sum(e.sal*case when eb.type = 1 then .1
					   when eb.type = 2 then .2
					   else .3 end) over
		(partition by deptno) as total_bonus
 from emp e, emp_bonus eb
 where e.empno = eb.empno
 and e.deptno = 10
 ) x


 SELECT e.deptno, 
		SUM(e.sal) AS total_sal, 
		SUM(e.sal * CASE WHEN eb.type = 1 THEN 0.1
                         WHEN eb.type = 2 THEN 0.2
                         WHEN eb.type = 3 THEN 0.3
                         ELSE 0.0 END) AS total_bonus
  FROM emp e
 INNER JOIN emp_bonus eb ON e.empno = eb.empno
 WHERE e.deptno = 10
 GROUP BY e.deptno



 select 
 sum(sal) over (partition by emp.deptno) as total_sal_dept
 ,* from emp

 create table sales_table
 (
	id int identity primary key not null,
	product varchar(1) not null,
	sales numeric(18,2) not null
 )

 insert into sales_table values ('A', 100.00), ('A', 200.00), ('B', 150.00), ('B', 350.00)


 select distinct a.product, a.total_sales from
 (
 select
		st.id, 
		st.product,
		st.sales,
		sum(st.sales) over (partition by st.product) as total_sales
 from sales_table st
 ) a



 select  deptno,total_sal,total_bonus
	from (
 SELECT e.deptno, 
		SUM(distinct e.sal) AS total_sal, 
		SUM(distinct e.sal * CASE WHEN eb.type = 1 THEN 0.1
                         WHEN eb.type = 2 THEN 0.2
                         WHEN eb.type = 3 THEN 0.3
                         ELSE 0.0 END) AS total_bonus
  FROM emp e
 INNER JOIN emp_bonus eb ON e.empno = eb.empno
 WHERE e.deptno = 10
 GROUP BY e.deptno
 ) x


 --3.11 Returning Missing Data from Multiple Tables

 select
	 d.DEPTNO
	,d.DNAME
	,e.ENAME
 from dept d
 left outer join emp e on e.DEPTNO = d.DEPTNO

 insert into emp(EMPNO, ename, job, mgr, HIREDATE, sal, COMM, DEPTNO)
 select 1111, 'YODA', 'JEDI', NULL, HIREDATE, SAL, COMM, null
 from emp
 where ENAME = 'KING'

 --DELETE FROM EMP
 --WHERE EMPNO = 1111

 select 
 d.DEPTNO, d.DNAME, e.ENAME
 from dept d 
 right outer join emp e on e.DEPTNO = d.DEPTNO

  select 
 d.DEPTNO, d.DNAME, e.ENAME
 from dept d 
 full outer join emp e on e.DEPTNO = d.DEPTNO

 select 
 d.DEPTNO, d.DNAME, e.ENAME
 from dept d 
 left outer join emp e on e.DEPTNO = d.DEPTNO
 union
  select 
 d.DEPTNO, d.DNAME, e.ENAME
 from dept d 
 right outer join emp e on e.DEPTNO = d.DEPTNO

 --3.12 Using NULLs in Operations and Comparisons

 use SQL_COOKBOOK
 select 
 ename,
 coalesce(COMM, 0) COMM
 from emp 
 where isnull(comm, 0) < (select comm from emp where ename = 'ward')

 --4.1 Inserting a New Record
 insert into dept (DEPTNO, dname, loc) 
 values (50, 'PROGRAMMING', 'BALTIMORE')

 insert into dept values (50, 'PROGRAMMING', 'BALTIMORE'), (50, 'PROGRAMMING', 'CLEVELAND')

 CREATE TABLE D (ID INTEGER DEFAULT 0)

 SELECT * FROM D
INSERT INTO D VALUES (DEFAULT)

 SELECT * FROM D

 INSERT INTO D VALUES ()
 DROP TABLE D
 CREATE TABLE D (ID INTEGER DEFAULT 0, FOO VARCHAR(10))

 INSERT INTO D (FOO) VALUES ('BAR')

 SELECT * FROM D

 INSERT INTO D VALUES (NULL, 'BRIGHTEN')
 INSERT INTO D (FOO) VALUES ('DARKEN')

 --DEFAULT IS USED TO APPLY VALUES TO PREVENT NULLs.
 CREATE TABLE dept_east
 (
	deptno integer, 
	dname varchar(10), 
	loc varchar(50)
 )


 insert into dept_east (deptno, dname, loc)
 select deptno, dname, loc
 from dept
 where loc in ('NEW YORK', 'BOSTON')
 
--para criar uma cópia vazia da tabela, sem os registros: usar um where que não retorna nada no select * into!!!
select *
into dept_2
from dept
where 1=0


select * from dept_2

select *
into dept_west
from dept
where 1=0

--insert all
--when loc in ('NEW YORK','BOSTON') then
--into dept_east (deptno,dname,loc) values (deptno,dname,loc)
--when loc = 'CHICAGO' then
--into dept_mid (deptno,dname,loc) values (deptno,dname,loc)
--else
--into dept_west (deptno,dname,loc) values (deptno,dname,loc)
--select deptno,dname,loc
--from dept

--sql server does not support multitable inserts

--4.8 Modifying Records in a Table
select 
e.DEPTNO,
e.ENAME,
e.SAL
from emp e
where e.DEPTNO = 20
order by 1,3 

update emp
set emp.sal = sal * 1.1
where emp.DEPTNO = 20

--4.9 Updating When Corresponding Rows Exist
select distinct
eb.empno,
e.ENAME
from emp_bonus eb
left join emp e on e.EMPNO = eb.empno

update emp
set emp.SAL = emp.SAL * 1.20
where emp.EMPNO in (select a.empno from emp_bonus a)

update emp 
set SAL = SAL * 1.20
where exists (select null from emp_bonus where emp.EMPNO = emp_bonus.empno)

--4.10 Updating with Values from Another Table
create table new_sal (deptno integer, sal decimal(18,2))
insert into new_sal values(10, 4000.0)

update e
	set e.sal = ns.sal,
		e.comm = ns.sal/2
	from emp e,
		 new_sal ns
	where ns.deptno = e.deptno

	select * from emp
	where emp.DEPTNO = 10

--
create table emp_commission (
	deptno varchar(10),
	empno varchar(10),
	ename varchar(50),
	comm decimal(18,2)
)

insert into emp_commission values (10,7782,'CLARK',null), (10,7839,'KING',null), (10,7934,'MILLER',null)

SELECT * FROM emp_commission

--merge into emp_commission ec
--using (select * from emp) emp
--	on (ec.empno = e.empno)
-- when matched then
--	update set ec.comm = 1000
--	delete where (sal < 2000)
--when not matched then
--	insert (ec.empno, ec.ename, ec.deptno, ec.comm)
--	values (emp.EMPNO, emp.ENAME, emp.DEPTNO, emp.COMM)


create table tb_funcionario (
	nome varchar(255),
	dataCadastro datetime,
	dataAlteracao datetime,
	situacao bit
)

insert tb_funcionario values ('Marinho', getdate(), null, 1), ('Andrade', getdate(), null, 1), ('Souza', getdate(), null, 1)

create table tb_funcionarioEmail (nome varchar(255), email varchar(255))
insert tb_funcionarioEmail values ('Marinho', 'marinho@email.com'), ('Andrade', 'andrade@email.com'), ('Souza', 'souza@email.com'), ('Santos', 'santos@email.com')

merge tb_funcionario as a
using tb_funcionarioEmail as b
on a.nome = b.nome
when matched
	then update set situacao = 0, dataAlteracao = getdate()
when not matched
	then insert (nome, dataCadastro, dataAlteracao, situacao) values (nome, getdate(), getdate(), 1)
when not matched by source
	then update set situacao = null, dataAlteracao = getdate();


	insert tb_funcionarioEmail values ('Felisberto','felisberto@email.com')

merge tb_funcionario as a
using tb_funcionarioEmail as b
on a.nome = b.nome
when matched
	then update set situacao = 0, dataAlteracao = getdate()
when not matched
	then insert (nome, dataCadastro, dataAlteracao, situacao) values (nome, getdate(), getdate(), 1)
when not matched by source
	then update set situacao = null, dataAlteracao = getdate();

	select * from tb_funcionario

--merge into emp_commission ec
merge emp_commission as ec
--using (select * from emp) emp
using emp as e
--	on (ec.empno = e.empno)
on e.empno = ec.empno
-- when matched then
when matched
	then update set    comm = 1000
when matched
	then delete where (sal < 2000)
--	update set ec.comm = 1000
--	delete where (sal < 2000)
--when not matched then
when not matched
	then 
	insert (empno, ename, deptno, comm)
	values (e.EMPNO, e.ENAME, e.DEPTNO, e.COMM)

	create table funcionarios2(
		Id int,
		Nome varchar(50),
		Salario decimal(18,2),
		temporario bit
	)

	insert funcionarios1 values (1, 'David', 200.00, 0), (2, 'Tim', 200.00, 0), (3, 'Mary', 200.00, 0), (4, 'Kevin', 200.00, 0)
	insert funcionarios2 values (1, 'David', 200.00, 0), (2, 'Tim', 200.00, 0), (5, 'Aline', 200.00, 0), (6, 'Cook', 200.00, 0)

	merge funcionarios1 as f1
	using funcionarios2 as f2
	on f1.id = f2.id
	when matched
		then update set temporario = 1
	when not matched
		then insert (id, nome, salario, temporario) values (id, nome, salario, 1);

select * from funcionarios1
select * from funcionarios2

update f
	set --f.temporario = 1,
	    f.Salario = 500.00
from funcionarios2 f
where f.Id in (5)

truncate table funcionarios1
truncate table funcionarios2

merge funcionarios1 as target
using funcionarios2 as source
on target.id = source.id
when not matched by target
	then insert (id, nome, salario, temporario)  
		 values (source.id, source.nome, source.salario, source.temporario)
when matched 
	then update set target.temporario = source.temporario, target.salario = source.salario
when not matched by source
	then delete;

select * from funcionarios1
select * from funcionarios2

merge emp_commission as ec
using emp as e
	on (ec.empno = e.empno)
when matched by ec 
then
	update set ec.comm = 1000
when matched by ec and e.sal < 2000 then 
delete 
when not matched then
	insert (empno, ename, deptno, comm)
	values (e.EMPNO, e.ENAME, e.DEPTNO, e.COMM);

--4.16 Deleting Duplicate Records

select * into emp_duplicates from emp

insert emp_duplicates
SELECT TOP (1000) [EMPNO]
      ,[ENAME]
      ,[JOB]
      ,[MGR]
      ,[HIREDATE]
      ,[SAL]
      ,[COMM]
      ,[DEPTNO]
  FROM [SQL_COOKBOOK].[dbo].[emp]

select count(*) from emp_duplicates


WITH CTE AS (
SELECT 
	   ROW_NUMBER() OVER (PARTITION BY [EMPNO], [ENAME],[JOB],[MGR],[HIREDATE],[SAL],[COMM],[DEPTNO] ORDER BY EMPNO) AS ROW
	  ,[EMPNO]
      ,[ENAME]
      ,[JOB]
      ,[MGR]
      ,[HIREDATE]
      ,[SAL]
      ,[COMM]
      ,[DEPTNO]
  FROM [SQL_COOKBOOK].[dbo].emp_duplicates
  )

  DELETE FROM CTE
  WHERE ROW > 1

-- THIS IS A TECHNIQUE TO DELETE DUPLICATE RECORDS WHITOUT IDS... I USE IT EVER

CREATE TABLE DUPES (ID INTEGER, NAME VARCHAR(10))
INSERT DUPES VALUES (1, 'NAPOLEON'), 
					(2, 'DYNAMITE'), 
					(3, 'DYNAMITE'), 
					(4, 'SHE SHELLS'), 
					(5, 'SEA SHELLS'), 
					(6, 'SEA SHELLS'), 
					(7, 'SEA SHELLS')

SELECT * FROM  DUPES WHERE ID NOT IN (SELECT MIN(ID) FROM DUPES GROUP BY NAME)
DELETE FROM DUPES WHERE ID NOT IN(SELECT MIN(ID) FROM DUPES GROUP BY NAME)
SELECT * FROM DUPES
			 
--4.17 Deleting Records Referenced from Another Table
create table dept_accidents
(
	deptno varchar(10),
	accident_name varchar(50)
)

insert dept_accidents values (10, 'BROKEN FOOT'), (10, 'FLESH WOUND'), (20, 'FIRE'), (20, 'FIRE'), (20, 'FLOOD'), (30, 'BRUISED GLUTE')

SELECT * FROM sql_cookbook.dbo.emp
where deptno in (select deptno from SQL_COOKBOOK.dbo.dept_accidents group by deptno having count(*) >= 3)


select * from emp 
where deptno in (
select
	a.deptno
	from dept_accidents a
group by a.deptno
having count(*) >= 3 )

--5.1 Listing Tables in a Schema

select *
from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'

--5.2 Listing a Table's columns

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'dbo'
and TABLE_NAME = 'emp'

--5.3 Listing Indexed Columns for a Table
select a.name table_name,
	   b.name index_name,
	   d.name column_name,
	   c.index_column_id
 FROM sys.tables a,
	  sys.indexes b,
	  sys.index_columns c,
	  sys.columns d
where a.object_id = b.object_id
  and b.object_id = c.object_id
  and b.index_id = c.index_id
  and c.object_id = d.object_id
  and c.column_id = d.column_id
  and a.name	  = 'emp'

alter table [dbo].[emp]
add constraint ak_empno unique(empno)


  select * from emp
  insert emp values (7369, 'SMITH', 'CLERK',	7902,	'2005-12-17',	880.00,	0,	20)

--5.4 Listing Constraints on a Table
select
		a.TABLE_NAME,
		a.CONSTRAINT_NAME,
		b.COLUMN_NAME,
		a.CONSTRAINT_TYPE
from 
INFORMATION_SCHEMA.TABLE_CONSTRAINTS a,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE b
where a.TABLE_NAME = 'emp'
	  and a.TABLE_SCHEMA = 'dbo'
	  and a.TABLE_NAME = b.TABLE_NAME
	  and a.TABLE_SCHEMA = b.TABLE_SCHEMA
	  and a.CONSTRAINT_NAME = b.CONSTRAINT_NAME

--5.6 Using SQL to Generate SQL
use AdventureWorks2019
select 'select count(*) ['+a.TABLE_NAME+' rows] from '+a.TABLE_SCHEMA + '.' + a.TABLE_NAME + ';' cnts
from INFORMATION_SCHEMA.TABLES a

select count(*) [rows] from V;
select count(*) [rows] from tempEmp;
select count(*) [rows] from sales_table;
select count(*) [rows] from emp_duplicates;
select count(*) [rows] from DUPES;
select count(*) [rows] from clientes;
select count(*) [rows] from dept_accidents;
select count(*) [rows] from dept;
select count(*) [rows] from emp;
select count(*) [rows] from D;
select count(*) [rows] from dept_2;
select count(*) [rows] from dept_east;
select count(*) [rows] from dept_mid;
select count(*) [rows] from dept_west;
select count(*) [rows] from new_sal;
select count(*) [rows] from new_dept;
select count(*) [rows] from emp_bonus;
select count(*) [rows] from emp_commission;
select count(*) [rows] from tb_funcionario;
select count(*) [rows] from tb_funcionarioEmail;
select count(*) [rows] from Vi;
select count(*) [rows] from funcionarios1;
select count(*) [rows] from funcionarios2;

select count(*) [EmployeePayHistory rows] from HumanResources.EmployeePayHistory;
select count(*) [SalesOrderHeaderSalesReason rows] from Sales.SalesOrderHeaderSalesReason;
select count(*) [SalesPerson rows] from Sales.SalesPerson;
select count(*) [Illustration rows] from Production.Illustration;
select count(*) [JobCandidate rows] from HumanResources.JobCandidate;
select count(*) [Location rows] from Production.Location;
select count(*) [Password rows] from Person.Password;
select count(*) [SalesPersonQuotaHistory rows] from Sales.SalesPersonQuotaHistory;
select count(*) [Person rows] from Person.Person;
select count(*) [SalesReason rows] from Sales.SalesReason;
select count(*) [SalesTaxRate rows] from Sales.SalesTaxRate;
select count(*) [PersonCreditCard rows] from Sales.PersonCreditCard;
select count(*) [EmailAddress_bkp rows] from Person.EmailAddress_bkp;
select count(*) [vAdditionalContactInfo rows] from Person.vAdditionalContactInfo;
select count(*) [PersonPhone rows] from Person.PersonPhone;
select count(*) [vEmployee rows] from HumanResources.vEmployee;
select count(*) [SalesTerritory rows] from Sales.SalesTerritory;
select count(*) [vEmployeeDepartment rows] from HumanResources.vEmployeeDepartment;
select count(*) [PhoneNumberType rows] from Person.PhoneNumberType;
select count(*) [vEmployeeDepartmentHistory rows] from HumanResources.vEmployeeDepartmentHistory;
select count(*) [vIndividualCustomer rows] from Sales.vIndividualCustomer;
select count(*) [Product rows] from Production.Product;
select count(*) [vPersonDemographics rows] from Sales.vPersonDemographics;
select count(*) [vJobCandidate rows] from HumanResources.vJobCandidate;
select count(*) [vJobCandidateEmployment rows] from HumanResources.vJobCandidateEmployment;
select count(*) [vJobCandidateEducation rows] from HumanResources.vJobCandidateEducation;
select count(*) [vProductAndDescription rows] from Production.vProductAndDescription;
select count(*) [vProductModelCatalogDescription rows] from Production.vProductModelCatalogDescription;
select count(*) [vProductModelInstructions rows] from Production.vProductModelInstructions;
select count(*) [vSalesPerson rows] from Sales.vSalesPerson;
select count(*) [SalesTerritoryHistory rows] from Sales.SalesTerritoryHistory;
select count(*) [vSalesPersonSalesByFiscalYears rows] from Sales.vSalesPersonSalesByFiscalYears;
select count(*) [vStateProvinceCountryRegion rows] from Person.vStateProvinceCountryRegion;
select count(*) [vStoreWithDemographics rows] from Sales.vStoreWithDemographics;
select count(*) [vStoreWithContacts rows] from Sales.vStoreWithContacts;
select count(*) [ScrapReason rows] from Production.ScrapReason;
select count(*) [vStoreWithAddresses rows] from Sales.vStoreWithAddresses;
select count(*) [vVendorWithContacts rows] from Purchasing.vVendorWithContacts;
select count(*) [Shift rows] from HumanResources.Shift;
select count(*) [NewCustomer rows] from Sales.NewCustomer;
select count(*) [vVendorWithAddresses rows] from Purchasing.vVendorWithAddresses;
select count(*) [ProductCategory rows] from Production.ProductCategory;
select count(*) [ShipMethod rows] from Purchasing.ShipMethod;
select count(*) [ProductCostHistory rows] from Production.ProductCostHistory;
select count(*) [ProductDescription rows] from Production.ProductDescription;
select count(*) [ShoppingCartItem rows] from Sales.ShoppingCartItem;
select count(*) [ProductDocument rows] from Production.ProductDocument;
select count(*) [DatabaseLog rows] from dbo.DatabaseLog;
select count(*) [ProductInventory rows] from Production.ProductInventory;
select count(*) [SpecialOffer rows] from Sales.SpecialOffer;
select count(*) [ErrorLog rows] from dbo.ErrorLog;
select count(*) [ProductListPriceHistory rows] from Production.ProductListPriceHistory;
select count(*) [Address rows] from Person.Address;
select count(*) [SpecialOfferProduct rows] from Sales.SpecialOfferProduct;
select count(*) [ProductModel rows] from Production.ProductModel;
select count(*) [AddressType rows] from Person.AddressType;
select count(*) [StateProvince rows] from Person.StateProvince;
select count(*) [ProductModelIllustration rows] from Production.ProductModelIllustration;
select count(*) [AWBuildVersion rows] from dbo.AWBuildVersion;
select count(*) [ProductModelProductDescriptionCulture rows] from Production.ProductModelProductDescriptionCulture;
select count(*) [BillOfMaterials rows] from Production.BillOfMaterials;
select count(*) [Store rows] from Sales.Store;
select count(*) [ProductPhoto rows] from Production.ProductPhoto;
select count(*) [ProductProductPhoto rows] from Production.ProductProductPhoto;
select count(*) [TransactionHistory rows] from Production.TransactionHistory;
select count(*) [vw01_DaosEmpregados rows] from dbo.vw01_DaosEmpregados;
select count(*) [ProductReview rows] from Production.ProductReview;
select count(*) [BusinessEntity rows] from Person.BusinessEntity;
select count(*) [TransactionHistoryArchive rows] from Production.TransactionHistoryArchive;
select count(*) [ProductSubcategory rows] from Production.ProductSubcategory;
select count(*) [BusinessEntityAddress rows] from Person.BusinessEntityAddress;
select count(*) [ProductVendor rows] from Purchasing.ProductVendor;
select count(*) [BusinessEntityContact rows] from Person.BusinessEntityContact;
select count(*) [UnitMeasure rows] from Production.UnitMeasure;
select count(*) [Vendor rows] from Purchasing.Vendor;
select count(*) [ContactType rows] from Person.ContactType;
select count(*) [CountryRegionCurrency rows] from Sales.CountryRegionCurrency;
select count(*) [CountryRegion rows] from Person.CountryRegion;
select count(*) [WorkOrder rows] from Production.WorkOrder;
select count(*) [PurchaseOrderDetail rows] from Purchasing.PurchaseOrderDetail;
select count(*) [CreditCard rows] from Sales.CreditCard;
select count(*) [Culture rows] from Production.Culture;
select count(*) [WorkOrderRouting rows] from Production.WorkOrderRouting;
select count(*) [Currency rows] from Sales.Currency;
select count(*) [PurchaseOrderHeader rows] from Purchasing.PurchaseOrderHeader;
select count(*) [CurrencyRate rows] from Sales.CurrencyRate;
select count(*) [Customer rows] from Sales.Customer;
select count(*) [Department rows] from HumanResources.Department;
select count(*) [Document rows] from Production.Document;
select count(*) [SalesOrderDetail rows] from Sales.SalesOrderDetail;
select count(*) [EmailAddress rows] from Person.EmailAddress;
select count(*) [Employee rows] from HumanResources.Employee;
select count(*) [SalesOrderHeader rows] from Sales.SalesOrderHeader;
select count(*) [EmployeeDepartmentHistory rows] from HumanResources.EmployeeDepartmentHistory;

use SQL_COOKBOOK

select 'alter table ', *
  from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
  where CONSTRAINT_TYPE = 'R'



  --chapter 6
  --Working with Strings
  create table T10 (id integer)
  insert into t10 values(1)
  insert into t10 values(2)
  insert into t10 values(3)
  insert into t10 values(4)
  insert into t10 values(5)
  insert into t10 values(6)
  insert into t10 values(7)
  insert into t10 values(8)
  insert into t10 values(9)
  insert into t10 values(10)

  select substring(e.ename, iter.pos, 1) as C
	from (select ename from emp where  ename = 'FELISBERTO') e,
	(select id as pos from t10) iter
	where iter.pos <= len(e.ename)
