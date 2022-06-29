use NORTHWND
--Câu 1. Hiển thị tên, địa chỉ, thành phố, đất nước của những khách hàng Mexico mua hàng.
SELECT ContactName, Address, City ,Country
FROM Customers
WHERE Country ='Mexico' and CustomerID in ( select CustomerID
										    from Orders) 

--Câu 2. Hiện thị Tên liên lạc, Địa chỉ, Thành phố của những nhà cung cấp có cùng thành phố với nhà cung cấp có tên là Exotic Liquids.
SELECT ContactName, Address, City
FROM Suppliers
WHERE  City = ( Select City 
				FROM Suppliers
				WHERE CompanyName = 'Exotic Liquids' ) ;
--Câu 3. Hiển thị Tên sản phẩm và Giá của những sản phẩm chưa được bán hoặc đã ngưng bán - Discontinued (0-Đang bán, 1-ngưng bán)
SELECT ProductName, UnitPrice
FROM Products
WHERE Discontinued = 1 or ProductID not in ( select ProductID
											 from [Order Details] ) 

--Câu 4. Hiển thị Mã nhà cung cấp, Tên nhà cung cấp, Số mặt hàng theo từng nhà cung cấp.
SELECT a.SupplierID, a.CompanyName,  b.QuantityPerUnit
FROM Suppliers a, Products b 
WHERE a.SupplierID = b.SupplierID

--Câu 5. Hiện thị Số hóa đơn, ngày bán, tổng tiền (UnitPrice*Quantity) theo từng hóa đơn.
SELECT a.OrderId , a.OrderDate , (b.UnitPrice * b.UnitPrice) AS Roma 
FROM Orders a, [Order Details] b 
WHERE a.OrderID = b.OrderID

--Câu 6. Hiển thị Mã khách hàng, Tên khách hàng, Thành phố có tổng tiền (UnitPrice*Quantity) các lần mua hàng lớn hơn 1000 
select b.CustomerID,b.CompanyName,b.City
from [Order Details] a,Customers b
where UnitPrice*Quantity>1000
group by b.CustomerID,b.CompanyName,b.City