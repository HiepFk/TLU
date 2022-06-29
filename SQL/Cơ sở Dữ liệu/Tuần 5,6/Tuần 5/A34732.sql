--Câu 1. Hiển thị tên, địa chỉ, thành phố, đất nước của những khách hàng Mexico mua hàng.
select CompanyName ,Address,City ,Country
from Customers
where Country='Mexico'

--Câu 2. Hiện thị Tên liên lạc, Địa chỉ, Thành phố của những nhà cung cấp có cùng thành phố với nhà cung cấp có tên là Exotic Liquids.
select ContactName ,Address,City
from Suppliers
where City =
			(select City
			from Suppliers
			where CompanyName='Exotic Liquids' )

--Câu 3. Hiển thị Tên sản phẩm và Giá của những sản phẩm chưa được bán hoặc đã ngưng bán - Discontinued (0-Đang bán, 1-ngưng bán)
select ProductName,UnitPrice
from Products
where Discontinued='0' or Discontinued='1'

--Câu 4. Hiển thị Mã nhà cung cấp, Tên nhà cung cấp, Số mặt hàng theo từng nhà cung cấp.
select a.SupplierID,a.CompanyName,b.QuantityPerUnit
from Suppliers a,Products b
where a.SupplierID= b.SupplierID
--Câu 5. Hiện thị Số hóa đơn, ngày bán, tổng tiền (UnitPrice*Quantity) theo từng hóa đơn.
select a.OrderID,a.OrderDate,UnitPrice*Quantity
from Orders a,[Order Details] b
where a.OrderID=b.OrderID
--Câu 6. Hiển thị Mã khách hàng, Tên khách hàng, Thành phố có tổng tiền (UnitPrice*Quantity) các lần mua hàng lớn hơn>1000
select b.CustomerID,b.CompanyName,b.City
from [Order Details] a,Customers b
where UnitPrice*Quantity>1000
group by b.CustomerID,b.CompanyName,b.City