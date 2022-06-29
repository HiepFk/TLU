/*•	Liệt kê tất cả các cặp nhân viên có thể từ bảng nhân viên trong cơ sở dữ liệu Northwind.*/
SELECT E1.FirstName, E1.LastName AS emp1, E2.FirstName, 
E2.LastName AS emp2
FROM dbo.Employees AS E1 CROSS JOIN dbo.Employees AS E2;

/* Liệt kê các hoá đơn được đặt bởi các khách hàng người Mỹ*/

select o.OrderID
from 
(select CustomerID 
from Customers 
where Country = 'USA' ) as D inner join Orders o  on  D.CustomerID = o.CustomerID

/*•	Liệt kê thông tin về mã khách hàng, tên công ty và mã hoá đơn của tất cả khách hàng có hoá đơn và không có hoá đơn (OrderID).*/
select cu.CustomerID , o.OrderID
from Customers as cu left join Orders as o on cu.CustomerID = o.CustomerID

/*•	Liệt kê các khách hàng không có hóa đơn nào */
select c.CustomerID
from Customers c
where c.CustomerID not in (	select CustomerID 
							from Orders)

/*Liệt kê tất cả nhân viên và người quản lý của họ. */
select e1.EmployeeID as NhanVien , e1.ReportsTo as QuanLy
from Employees e1 


/*Liệt kê tất cả tên khách hàng có đơn đặt hàng và tên nhà cung cấp sản phẩm cho khách hàng đó.*/
/*Cách 1  */
select DISTINCT su.SupplierID as MaNhaCC , om.CustomerID as MaKhachHang
from 
	( select p.SupplierID , ol.CustomerID 
	  from 
			(select ok.ProductID , co.CustomerID
			 from 
			(
				select o.OrderID , c.CustomerID
				from Customers c inner join Orders o 
				on c.CustomerID = o.CustomerID
			) as co
			inner join [Order Details] ok  on co.OrderID = ok.OrderID )
			as ol
		inner join Products p on ol.ProductID = p.ProductID ) 
		as om
inner join Suppliers su
			on om.SupplierID = su.SupplierID

/* Cách 2 */ 
select  distinct c.CompanyName as KhachHang , su.CompanyName as NhaCungCap 
from Customers c join Orders o on c.CustomerID = o.CustomerID
				 join [Order Details] od on o.OrderID = od.OrderID
				 join Products p on p.ProductID = od.ProductID 
				 join Suppliers su on su.SupplierID = p.SupplierID


/*Liệt kê tên công ty khách hàng và tên nhà cung cấp sản phẩm cho khách hàng đó. 
(Lưu ý  liệt kê cả những khách hàng không có nhà cung cấp)*/






/* Phan 2 */
/* 1	Liệt kê tất cả  thành phố (Country, Region, City) xuất hiện trong bảng Employees hoặc Customers, loại bỏ các dòng giống nhau */
select City 
from Employees 
union
select City
from Customers
/* 2	Liệt kê những thành phố xuất hiện trong bảng Employees hoặc Customers */
select City 
from Employees 
union all 
select City
from Customers
										
/*3	Liệt kê những thành phố chỉ xuất hiện ở bảng Employees và không xuất hiện ở bảng Customers */
select City 
from Employees 
except 
select City
from Customers
/*4	Liệt kê những thành phố chỉ xuất hiện ở bảng Customers và không xuất hiện ở bảng Employees */
select City 
from Customers 
except  
select City
from Employees

/*5	Liệt kê những thành phố xuất hiện ở cả bảng Customers và bảng Employees */
select eo.City
from Customers as cus inner join 
						(Select e.City , o.CustomerID
						From Employees as e inner join Orders as o 
						on e.EmployeeID = o.EmployeeID ) as eo  
					  on eo.CustomerID = cus.CustomerID
/*6	Liệt kê các thành phố của nhà cung cấp không phải là thành phố của nhân viên và khách hàng. */
select city 
from Suppliers
except
(select city
from Employees
union 
select city
from Customers
)


/*7	Liệt kê các thành phố của nhà cung cấp mà không phải là thành phố của nhân viên và cũng là thành phố của khách hàng. */
(select city 
from Suppliers
union 
select city
from Customers)
except
(select city
from Employees
)

use Northwind
go

/* Phần 3 */ 
/*· Liệt kê tổng số dòng dữ liệu trong bảng Customers */

use Northwind
go

select count(CustomerID) as Soluong 
from Customers


/*· Tính số lượng Region được tìm thấy trong bảng Customers */
select SUM(RegionID)
from Territories as te join EmployeeTerritories as em on te.TerritoryID = em.TerritoryID
						join Employees as e on em.EmployeeID = e.EmployeeID
						join Orders as o on e.EmployeeID = o.EmployeeID
						join Customers as c on c.CustomerID = o.CustomerID

/* Tính số lượng Region khác nhau được tìm thấy trong bảng Customers */
select sum(RegionID) , RegionID
from Territories as te join EmployeeTerritories as em on te.TerritoryID = em.TerritoryID
						join Employees as e on em.EmployeeID = e.EmployeeID
						join Orders as o on e.EmployeeID = o.EmployeeID
						join Customers as c on c.CustomerID = o.CustomerID
group by RegionID

/* Tính tổng chi phí vận chuyển (Freight) trong bảng Order */
select SUM(freight) as TongPhi
from Orders 

/* Tính tổng chi phí theo mỗi nhà vận chuyển */


/*Liệt kê những thành phố và đất nước có chi phí vận chuyển lớn hơn 1000. */
select SUM(freight) as TongPhi , ShipCity
from Orders 
group by ShipCity 
having SUM(freight) >1000



ALTER AUTHORIZATION ON DATABASE::pubs TO sa
use pubs
go
/*Liệt kê danh sách cửa hàng, số hoá đơn bán hàng, tên sách được bán, ngày bán, số lượng bán, tỷ lệ % giữa số lượng bán trên tổng số lượng sách được bán và sự khác nhau về số lượng bán so với trung bình của tổng số sách được bán.*/
select s.stor_name , sa.ord_num as HoaDon, t.title as tenSach , sa.ord_date , count(sa.title_id) as soLuongBan 
from stores as s join sales as sa on s.stor_id = sa.stor_id
				 join titles as t on t.title_id = sa.title_id
group by sa.title_id , s.stor_name , sa.ord_num , t.title , sa.ord_date 

/*Liệt kê danh sách cửa hàng, số hoá đơn bán hàng, tên sách được bán, ngày bán, số lượng bán, tổng số lượng sách được bán, số lượng hoá đơn bán hàng, số lượng trung bình các sách được bán, số lượng sách được bán nhỏ nhất và lớn nhất.*/


/*Liệt kê danh sách cửa hàng, số hoá đơn bán hàng, tên sách được bán, ngày bán, số lượng bán, tỷ lệ % giữa số lượng bán trên tổng số lượng sách của mỗi cửa hàng và sự khác nhau về số lượng bán so với trung bình của tổng số sách được bán của mỗi cửa hàng.*/

