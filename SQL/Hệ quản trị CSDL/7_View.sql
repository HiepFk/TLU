--1.	Tạo một View liệt kê danh sách hoá đơn gồm các trường mã hoá đơn, 
--số lượng sản phẩm, tổng số lượng hàng hoá, tổng số tiền của hoá đơn. 
--Không cho phép thay đổi các đối tượng mà View sử dụng
Create view VOrder
as
select OrderID, count(ProductID) as SoLuongSP, sum(Quantity) as SoLuongHH,  
sum(Quantity*UnitPrice*(1-Discount)) as SoTienHD
from [Order Details]
group by OrderID


--2.	Tạo một View có tên là Manager chỉ hiển thị danh sách nhân viên là người quản lý 
--(là nhân viên quản lý nhân viên khác)
Go 
create view manager
as
select EmployeeID , (LastName +''+FirstName ) as fullName
from Employees
where EmployeeID in (select ReportsTo
						from Employees)
