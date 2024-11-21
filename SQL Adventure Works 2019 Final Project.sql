-- SP number by territory and region
select count (BusinessEntityID),Name,CountryRegionCode
from sales.SalesPerson p
join Sales.SalesTerritory t
on t.TerritoryID=p.TerritoryID
group by Name,CountryRegionCode

-- Areas with the highest Sales Last year 
select top 1* 
from Sales.SalesTerritory 
order by SalesLastYear desc

--Areas with the highest Sales so far this year 
select top 1* 
from Sales.SalesTerritory 
order by SalesYTD desc

--Number of Store
select count (distinct Name)
from Sales.Store

-- Number of Order Quantity by Year 
select year(OrderDate) OrderDate, count(OrderQty) OrderQty
from  Sales.SalesOrderHeader h
join  sales.SalesOrderDetail d
on h.SalesOrderID=d.SalesOrderID
group by YEAR (OrderDate)

--Total Sales by year
select year(OrderDate) OrderDate, count(UnitPrice) OrderQty
from  Sales.SalesOrderHeader h
join  sales.SalesOrderDetail d
on h.SalesOrderID=d.SalesOrderID
group by YEAR (OrderDate)

--Total Tax amount by year
select  year(OrderDate) OrderDate ,sum (TaxAmt) 
from Sales.SalesOrderHeader  
group by YEAR (OrderDate)

-- Total Freight amount by yea
select  year(OrderDate) OrderDate ,sum (Freight) 
from Sales.SalesOrderHeader  
group by YEAR (OrderDate)

--Total Tax amount 
select sum (TaxAmt) total_tax 
from Sales.SalesOrderHeader 


--Find the top 10 customers with the highest number of orders:
select top 10(c.CustomerID),sum (TotalDue)
from Sales.Customer  c
join Person.Person p
on c.PersonID=p.BusinessEntityID
join Sales.SalesOrderHeader h
on h.CustomerID= c.CustomerID
group by c.CustomerID

--Find the total number of products in each subcategory:
select count (*)total_number_of_products,s.Name subcategory_name
from Production.Product p
join Production.ProductSubcategory s
on s.ProductSubcategoryID=p.ProductSubcategoryID
group by s.Name

--Find the total number of orders with a specific ship method:
select count( d.OrderQty),m.Name 
from Sales.SalesOrderDetail d
join Sales.SalesOrderHeader h
on d.SalesOrderID= h.SalesOrderID
join Purchasing.ShipMethod m
on  m.ShipMethodID=h.ShipMethodID
group by m.Name

--Territory Name , category name , Total orders in each category
select t.Name as TerritoryName ,c.Name as categoryname ,count(d.OrderQty) as Totalorders
from Sales.SalesTerritory t
join Sales.SalesOrderHeader h
on t.TerritoryID=h.TerritoryID
join sales.SalesOrderDetail d
on h.SalesOrderID=d.SalesOrderID
join Production.Product p
on p.ProductID=d.ProductID
join Production.ProductSubcategory s
on s.ProductSubcategoryID= p.ProductSubcategoryID
join Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID
group by t.Name ,c.Name

-- Product Average Price 
select p.name,avg(UnitPrice) as avgprice 
from Sales.SalesOrderDetail d
join Production.Product p
on p.ProductID=d.ProductID
group by p.name

--What is the average cost of product?
select p.name,avg (c.StandardCost) as avgcost 
from Production.ProductCostHistory c
join Production.Product p
on p.ProductID=c.ProductID
group by p.name

--What is the average listing price of product
select p.name,avg (h.ListPrice) as listprice 
from Production.ProductListPriceHistory h
join Production.Product p
on p.ProductID=h.ProductID
group by p.name

--Territory Name , category name , Total orders in each category
select t.Name as TerritoryName ,c.Name as categoryname ,count(d.OrderQty) as Totalorders
from Sales.SalesTerritory t
join Sales.SalesOrderHeader h
on t.TerritoryID=h.TerritoryID
join sales.SalesOrderDetail d
on h.SalesOrderID=d.SalesOrderID
join Production.Product p
on p.ProductID=d.ProductID
join Production.ProductSubcategory s
on s.ProductSubcategoryID= p.ProductSubcategoryID
join Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID
group by t.Name ,c.Name

--Customer ID & Name , What they purchase , How much they spend 
--, Condition: Customers that spend more the 10000$
select CustomerID,(FirstName+''+LastName)as fullname,PurchaseOrderID, sum(SubTotal)
from Sales.Customer c
join person.Person p
on c.PersonID=p.BusinessEntityID
join  Purchasing.PurchaseOrderHeader h
on h.PurchaseOrderID= p.BusinessEntityID
where SubTotal >10000
group by PurchaseOrderID,CustomerID,(FirstName+''+LastName)

--Total Freight 
select sum(Freight) total_freight
from sales.SalesOrderHeader

--Number of Customers
select count(distinct CustomerID) number_of_customers
from Sales.Customer 

select *
from Sales.Customer

--Number of Orders
select count(distinct salesorderid) number_of_orders
from Sales.SalesOrderDetail


--Number of Products
select count(distinct Name) number_of_products
from Production.Product

--number of customers by education
select count(distinct CustomerID)number_of_customers, Education
from Sales.Customer c join Person.Person p
on c.PersonID = p.BusinessEntityID
join Sales.vPersonDemographics vdemo
on vdemo.BusinessEntityID = p.BusinessEntityID
where Education is not null
group by Education

--Number of stores
select count(distinct StoreID) number_of_stores
from Sales.Customer


--Number of Order by Year
select count(salesorderid) number_of_orders, year(orderdate) year
from sales.SalesOrderHeader
group by year(orderdate)



--Why is 2014 Sales lower than 2013

select count(sod.orderqty) order_quantity,sum(sod.UnitPrice) unit_price, year(soh.ModifiedDate) year
from sales.SalesOrderDetail sod join sales.SalesOrderHeader soh
on sod.SalesOrderID=soh.SalesOrderID
group by year(soh.ModifiedDate)
order by sum(sod.UnitPrice) desc


--Total Tax amount 
select sum (TaxAmt) total_tax 
from Sales.SalesOrderHeader


--Total Sales by territory
select t.Name territortory_name, sum(h.totaldue) total_sales
from Sales.SalesTerritory t join Sales.SalesOrderHeader h
on t.TerritoryID = h.TerritoryID
group by t.Name
order by sum(h.totaldue) desc


--Total sales by year
select sum(TotalDue) total_sales, year(OrderDate) year
from sales.SalesOrderHeader h
group by year(OrderDate) 
order by sum(TotalDue) desc


select *
from Sales.SalesOrderHeader soh join Sales.SalesTerritory t
on soh.TerritoryID = t.TerritoryID