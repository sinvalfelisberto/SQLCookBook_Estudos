  create table SalesEcom(
	ProductID int, ProductDesc varchar(50), ProductColor varchar(10), Qty int
  )

  --SalesStore
  --SalesEcom

  --insert into SalesEcom values(711, 'Sport-100 Helmet, Blue', 'Blue', 2125),
		--					  (707, 'Sport-100 Helmet, Red', 'Red', 2230),
		--					  (708, 'Sport-100 Helmet, Black', 'Black', 2085)

--create view vEcomSalesByProduct as
--(
--	select * from SalesEcom
--)
use AdventureWorksDW2019
--store sales
select * from vStoreSalesByProduct

--Ecom sales
select * from vEcomSalesByProduct

select * from vStoreSalesByProduct s
	inner join vEcomSalesByProduct e 
		on e.ProductID = s.ProductID

select * from vStoreSalesByProduct s
	left outer join vEcomSalesByProduct e 
		on e.ProductID = s.ProductID

select * from vStoreSalesByProduct s
	full outer join vEcomSalesByProduct e 
		on e.ProductID = s.ProductID

select s.ProductID, e.ProductID, s.Qty, e.Qty
from vStoreSalesByProduct s
	full outer join vEcomSalesByProduct e 
		on e.ProductID = s.ProductID


--merging the query...
select coalesce(s.ProductID, e.ProductID) as ProductID, isnull(s.Qty, 0) as StoreQty, isnull(e.Qty, 0) as EcomQty
from vStoreSalesByProduct s
	full outer join vEcomSalesByProduct e 
		on e.ProductID = s.ProductID
order by 1

--intersect
select ProductID, ProductDesc
from vStoreSalesByProduct s
intersect
select ProductID, ProductDesc
from vEcomSalesByProduct e

--except
select ProductID, ProductDesc
from vStoreSalesByProduct s
except
select ProductID, ProductDesc
from vEcomSalesByProduct e

use AdventureWorks2019

--pivot
select c.Name,
	   count(p.ProductID) as TotalProducts
  from Production.Product p
  inner join Production.ProductCategory c
	on c.ProductCategoryID = p.ProductSubcategoryID
group by c.Name

--pivot
--Accessories	Bikes Clothing	Components
--8			32	  22		43	

select * from
(
select p.ProductID, c.Name as Category
  from Production.Product p
  inner join Production.ProductCategory c
	on c.ProductCategoryID = p.ProductSubcategoryID
) t PIVOT (COUNT(ProductID) FOR Category in (
							[Components],
							[Bikes],
							[Accessories],
							[Clothing] )) as Count_of_Products