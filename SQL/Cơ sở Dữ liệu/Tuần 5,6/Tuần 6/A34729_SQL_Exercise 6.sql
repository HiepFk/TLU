use NORTHWND
/*CÂU 1. Cho biết mã khách hàng (CustomerID), tên khách hàng (ContactName), địa chỉ (Address) 
ở đất nước (Country) Spain và UK. Danh sách được sắp xếp giảm dần theo đất nước (Country) */
select CustomerID , ContactName , Address , Country
from Customers
where Country = 'Spain' or Country ='UK'
order by Country Desc


/*CÂU 2. Cho biết mã nhân viên (EmployeeID), tên nhân viên (LastName), 
thành phố (city) chưa thực hiện hóa đơn trong năm 1995 (OrderDate) */
select EmployeeID , LastName, City
from Employees 
where EmployeeID  not in ( select EmployeeID
						   from Orders 
						   where year(OrderDate) = 1995 ) 


/*CÂU 3. Cho biết mã nhà cung cấp (SupplierID), tên nhà cung cấp (CompanyName), địa chỉ (Address) của nhà cung cấp
có cùng đất nước (Country) với tên nhà cung cấp (CompanyName) 'Exotic Liquids'*/
select SupplierID , CompanyName , Address , Country
from Suppliers 
where Country in ( select Country
                   from Suppliers 
				   where CompanyName = 'Exotic Liquids')
			and CompanyName <> 'Exotic Liquids'

/*CÂU 4. Cho biết mã nhà cung cấp (SupplierID), tên nhà cung cấp (CompanyName), 
 thành phố (City) của những nhà cung cấp ở thành phố (city) 'Tokyo' hoặc đã cung cấp sản phẩm */

select SupplierID , CompanyName , City
from Suppliers 
where city = 'Tokyo'  or SupplierID in ( select SupplierID
										 from Products ) 

/*CÂU 5. Cho biết thông tin khách hàng:  mã khách hàng (CustomerID), tên khách hàng (CompanyName), 
địa chỉ (Address), Số lần mua hàng theo từng khách hàng ở đất nước (Country) Italy */
select cus.CustomerID , CompanyName , address , count(OrderID) as solanmau
from Customers as cus inner join Orders as o
				on cus.CustomerID = o.CustomerID 
where Country = 'Italy'
group by cus.CustomerID , CompanyName , address 


/*CÂU 6. Cho biết Mã sản phẩm (ProductID), Tên sản phẩm (ProductName), Mã nhóm sản phẩm (CategoryID) 
của tên nhóm sản phẩm (CategoryName) Seafood và có đơn giá (UnitPrice) lớn hơn 30 */

select dd.[ProductID] , dd.ProductName , dd.CategoryID , dd.UnitPrice
from [dbo].[Categories] as cate
inner join  Products	as dd 
					 on cate.CategoryID = dd.CategoryID
where CategoryName = 'Seafood' and  UnitPrice > 30


/*CÂU 7. Cho biết Mã sản phẩm (ProductID), trung bình thành tiền (UnitPrice*Quantity) 
được bán trong năm 1996 (OrderDate) và có trung bình thành tiền lớn hơn 2000 */

select ProductID ,  AVG([UnitPrice] * [Quantity]) as TB 
from [dbo].[Order Details] as de inner join ( select OrderID , OrderDate
											  from Orders			  
											  where year(OrderDate) = 1996 ) as ord 
											  on de.OrderID = ord.OrderID
group by ProductID 
having AVG([UnitPrice] * [Quantity]) >2000

				  
/*CÂU 8. Cho biết mã nhóm sản phẩm (CategoryID), tên nhóm sản phẩm (CategoryName), 
Tổng số lượng (Quantity) của nhóm sản phẩm có tên là 'Beverages'*/

select b.CategoryID , CategoryName , Tong
from 
(select * 
from [dbo].[Categories] 
where [CategoryName] = 'Beverages') as b inner join 
					(select CategoryID , sum(Quantity) as Tong
					from Products as p inner join [Order Details] as d
											on p.ProductID = d.ProductID 
									group by p.CategoryID ) as ps
									on b.CategoryID = ps .CategoryID

/*CÂU 9. Cho biết mã nhân viên (EmployeeID), tên cuối (LastName), 
có số lượt bán hàng ít nhất 65 lần mà ở thành phố (city) 'Seattle' */

select e.EmployeeID , LastName , count([OrderID] ) as soLanBan , City
from Employees as e inner join Orders as o 
		on e.EmployeeID = o.EmployeeID
where city ='Seattle'
group by e.EmployeeID , LastName , City
having count([OrderID] ) >=65




/*CÂU 10. Cho biết mã khách (CustomerID), tên khách (CompanyName), đất nước (Country), 
tổng thành tiền (Quantity*UnitPrice) theo từng khách hàng theo từng năm 
của những khách hàng ở đất nước (Country) giống đất nước (Country) của nhà cung cấp có tên (CompanyName) là 'Exotic Liquids'  */
select c.customerID, CompanyName, Country, Tong
from 
	(select *
	 from Customers
	 where country in  (select country
						from Suppliers
						where CompanyName='Exotic Liquids')
							)as c inner join (select CustomerID, year (OrderDate) as nam,sum(Quantity*UnitPrice) as tong
											  from Orders as o inner join [Order Details] as d
											  on o.OrderID=d.OrderID
											  group by CustomerID, year(orderdate)
											  )as cy
on c.CustomerID=cy.CustomerID