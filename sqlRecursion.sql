--select EmployeeKey, FirstName, LastName, ParentEmployeeKey
--from DimEmployee 

use AdventureWorksDW2019
with EmployeeHier as (
--boos/ceo
select EmployeeKey, FirstName, LastName, ParentEmployeeKey, 1 as [Level]
from DimEmployee 
where ParentEmployeeKey is null
union all
select e.EmployeeKey, e.FirstName, e.LastName, e.ParentEmployeeKey, eh.[Level] + 1 
from DimEmployee e
	inner join EmployeeHier eh on eh.EmployeeKey = e.ParentEmployeeKey
where e.ParentEmployeeKey is not null
)

select * from EmployeeHier
order by [level]

