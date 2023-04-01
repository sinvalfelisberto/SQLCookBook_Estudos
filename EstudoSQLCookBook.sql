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

create view V
as
select e.ENAME + ' ' + e.DEPTNO as data
from emp e

select * from V

select
data
from V
order by substring(data, len(data) - 1,  2)

select 
data
from V
order by right(data, 2)

select 
data
from V
order by substring(data, len(data) - len(data) + 1, 2)

--better solution than substring
--order by deptno
select
data
from V
order by replace(data,
		 replace(
		 translate(data, '0123456789', '##########'), '#',''),'')

--order by ename
select data
from V
order by replace(
		 translate(data, '0123456789', '##########'),'#','')

use SQL_COOKBOOK

select 
	data,
	replace(data,
	replace(
	translate(data, '0123456789', '##########'),'#', ''),'') nums,
	replace(
	translate(data, '0123456789', '##########'), '#', '') chars
from v



----cte

with tabela as (
	select 	'sinval' + ' ' + '40' as data
)

select 
	 data, 
	 replace(translate(data, '0123456789', '##########'), '#', '') nome,
	 replace(data, replace(translate(data, '0123456789', '##########'),'#', ''), '') idade,
	 len(replace(translate(data, '0123456789', '##########'), '#', '')) nomeTamanho,
	 len(replace(data, replace(translate(data, '0123456789', '##########'),'#', ''), '')) idadeTamanho
	 ,translate(data, '0123456789', '##########') translate_numeros
	 ,translate(data, 'abcdefghijklmnopqrstuvwxyz', '##########################') letras
	 ,replace(data, replace(translate(data, '0123456789', '##########'), '#', ''), '') so_numeros
	 ,replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '##########################'), '#', '')

from tabela

select
data
,replace(translate(data, '0123456789', '$$$$$$$$$$'), '$', '') nome
,replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '&&&&&&&&&&&&&&&&&&&&&&&&&&'), '&', '') idade
from V
	order by replace(translate(data, 'abcdefghijklmnopqrstuvwxyz', '&&&&&&&&&&&&&&&&&&&&&&&&&&'), '&', '') --idade


select 
data
,replace(translate(data, '0123456789', '##########'), '#', '') nome
,replace(data, replace(translate(data, '0123456789', '##########'), '#', ''), '') idade 
--de dentro pra fora: pego os numeros e troco #, 
--depois substituo os # por '', pra pegar o nome, 
--depois substituo o nome, por '', pra ter o número.
from V


SELECT REPLACE('SINVAL','SINVAL', 'SINVAL, A LENDA')

SELECT REPLICATE('EUTEAMO ', 9*8*7*6*5*4*3*2*1)

select replicate('&', len('abcdefghijklmnopqrstuvwxyz'))



/**************************************************************/
/*** Continuar da página 21 Dealing with Nulls When Sorting ***/
/**************************************************************/

with testando as
(
	select
	concat(e.ENAME, ' ', e.SAL) as line
	from emp e
)

select
line,
replace(translate(line, '0123456789.', '###########'), '#', '') name,
format(cast(replace(line, replace(translate(line, '0123456789.','###########'), '#', ''), '') as numeric(18,2)) * 1.115, 'c', 'pt-br') salary_with_raise
from testando