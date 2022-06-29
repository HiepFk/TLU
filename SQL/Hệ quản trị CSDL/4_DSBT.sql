﻿--Bai1
DECLARE @var1 INT
DECLARE @var2 INT
SELECT @var1 = 2, @var2 = 4
PRINT @var1 + @var2

go
--Bai2
use Northwind
DECLARE @MinOrder INT
set @MinOrder = (
	select Min(Quantity * UnitPrice * (1-Discount))
	from Orders o join [Order Details] od on o.OrderID = od.OrderID
	where CustomerID = 'ALFKI')
print @MinOrder

go

--Bai 3
use Northwind
DECLARE @OrderID int
DECLARE @Max int
select @OrderID = OrderID, @Max = tquantity
From (
	SELECT top(1)o.orderid, sum(Quantity)as tquantity
	FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID
	WHERE CustomerID = 'ALFKI'
	group by o.orderid
	order by tquantity desc
	) as K
Print 'OrderID: ' + convert (varchar(20),@OrderID)
Print 'MaxQuatityOrder:' + convert(varchar(20),@Max)

go
--Bai4
DECLARE @counter INT
DECLARE @kq varchar(50)
SET @counter = 10
set @kq = ''
WHILE @counter >= 1
BEGIN
	SET @kq = @kq + CONVERT(varchar, @counter) + ' '
	SET @counter = @counter - 1
END
PRINT @kq


--7.	Trên CSDL Northwind , Viết đoạn lệnh sử dụng lệnh Exec thực hiện việc 
--hiển thị thông tin CompanyName của khách hàng  có CustomerID =ALFKI
go
declare @Company varchar(300)
set @Company = 'select CompanyName from Customers where CustomerID = ''ALFKI'''
exec(@Company)

--8.	Trên CSDL Northwind , Viết đoạn lệnh sử dụng hàm sp_executesql để thực hiện
--	Khai báo biến, nhập thông tin về mã khách hàng
--	Sử dụng hàm sp_executesql để thực hiện câu truy vấn liệt kê tất cả các hoá đơn 
--	của khách hàng có mã khách hàng vừa nhập. 
declare @i as varchar(10)
set @i = 'ALFKI'

declare @sql nvarchar(300)
set @sql = 'select * from Orders where CustomerID = @cusid'
exec sp_executesql
@stmt = @sql,
@params = N'@cusid varchar(10)',
@cusid = @i

--9.	Trên CSDL Northwind , Viết đoạn lệnh thêm mới thông tin vào bảng [Order Details] 
--	(sử dụng cấu trúc Try/Catch để bắt lỗi, dùng hàm Raiserror() để phát sinh lỗi) :
--a.	Khai báo các biến, nhập giá trị cho các biến @OrderID, @ProductID, @UnitPrice, @Quantity, @Discount
--b.	Kiểm tra nếu số lượng hàng (@Quantity) <= 0 thì hiện ra thông báo lỗi “Số lượng sản phẩm phải >0” 
--	và không thực hiện lệnh thêm mới dữ liệu
--c.	Kiểm tra nếu số giảm giá  (@Discount) > 10 thì hiện ra thông báo lỗi “% giảm giá phải <=10%” 
--	và không thực hiện lệnh thêm mới dữ liệu
--d.	Nếu thoả mãn hai điều kiện trên thực hiện thêm mới dữ liệu vào bảng [Order Details]. 
--e.	Bắt các lỗi thêm mới dữ liệu nếu có và hiển thị thông tin của lỗi. 
go
declare  @OrderID int, @ProductID int, @UnitPrice money, @Quantity smallint, @Discount real
select  @OrderID = 1234, @ProductID = 15, @UnitPrice = 18, @Quantity = 0, @Discount = 11

begin try
	if @Quantity <=0
		raiserror ('So luong phai > 0', 10, 1)
	if @Discount >=10
		raiserror ('giam gia <10', 11, 1)
	insert into [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
	values(@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)
	print 'INSERT succeeded.';
end try

begin catch
PRINT Error_message();
--PRINT Error_number();
--PRINT Error_Severity()
--PRINT Error_State()
--PRINT Error_Procedure()
--PRINT Error_Line()
end catch




