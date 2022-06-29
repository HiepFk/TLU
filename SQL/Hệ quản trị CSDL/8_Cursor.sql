--4.	Trên CSDL Northwind, viết một thủ tục (SP) sử dụng Cursor đọc dữ liệu từ bảng Employees 
--và in ra màn hình thông tin về nhân viên:
--Mã nhân viên(EmployeeID), Tên nhân viên (FirstName + LastName) và Ngày vào công ty (Hirdate).
--Hiển thị Ngày vào công ty theo dạng dd/mm/yyyy.
	go
	create proc sp_EmpLoyeesCursor @CursorForOutput CURSOR VARYING OUTPUT
	as
	begin
		set @CursorForOutput= CURSOR
		for 
		select EmployeeID,concat(FirstName,' ',LastName) as Ten,convert(varchar,HireDate,131) from Employees
		open @CursorForOutput
	end

	go
	DECLARE @OutputCursor CURSOR
	EXEC sp_EmpLoyeesCursor @OutputCursor OUTPUT
	FETCH NEXT FROM @OutputCursor
	WHILE @@FETCH_STATUS=0
	BEGIN
		FETCH NEXT FROM @OutputCursor
	END
	CLOSE @OutputCursor
	DEALLOCATE @OutputCursor
	go
--5.	Viết một thủ tục với kiểu dữ liệu đầu ra (output) là Cursor. Cursor 
--chứa câu truy vấn liệt kê danh sách mã nhân viên (EmployeeID), 
--tên nhân viên có hoá đơn và số lượng hoá đơn của nhân viên đó.
--•	Viết đoạn lệnh sử dụng thủ tục trên in ra danh sách nhân viên ra màn hình.
	create proc OutputCursor (@outputCursor cursor varying out)
	as
	begin
		set @outputCursor = cursor 
		for
		select o.EmployeeID,e.FirstName,e.LastName,count(o.OrderID) SoLuong from Employees e,Orders o
		where e.EmployeeID=o.EmployeeID
		group by o.EmployeeID,e.FirstName,e.LastName
		open @outputCursor
	end

	go
	declare @outputCursor cursor
	exec OutputCursor @outputCursor out
	fetch next from @outputCursor
	while @@FETCH_STATUS=0
	begin
		fetch next from @outputCursor
	end
	close @outputCursor
	DEALLOCATE @outputCursor

--6.	Viết một thủ tục sử dụng Cursor thực hiện các công việc sau:
--a.	Liệt kê, in danh sách khách hàng (Mã khách hàng, Tên khách hàng).
--b.	Với mỗi khách hàng liệt kê, in danh sách hoá đơn với các thông tin: 
--mã hoá đơn (OrderID), Ngày hoá đơn (OrderDate), 
--số lượng sản phẩm và số tiền của mỗi hoá đơn (Quantity * UnitPrice * (1-Discount)) đó.
go
Create proc sp_Cursorr( @outputCursor cursor varying out) --, @outputCursor2 cursor varying out) --cursor varying out 
as
begin
	set @outputCursor=cursor
	for
	select CustomerID,ContactName from Customers
	--set @outputCursor2 = cursor 
	--for
	--select o.OrderID,o.OrderDate,COUNT(o.OrderID) as SoLuongSP--(od.Quantity * od.UnitPrice * (1-od.Discount)) as SoTien
	--from [Order Details] od inner join Orders o on od.OrderID=o.OrderID
	--group by o.OrderID,o.OrderDate
	open @outputCursor
	--open @outputCursor2
end
go
declare @outputCursor cursor
exec sp_Cursorr @outputCursor out 
fetch next from @outputCursor
while @@FETCH_STATUS=0
begin
	declare @outputCursor2 cursor
	set @outputCursor2 = cursor
	for 
	select o.OrderID,o.OrderDate,COUNT(o.OrderID) as [Số sản phẩm]--(od.Quantity * od.UnitPrice * (1-od.Discount)) as SoTien
	from [Order Details] od inner join Orders o on od.OrderID=o.OrderID
	group by o.OrderID,o.OrderDate
	open @outputCursor2
	fetch next from @outputCursor
	while @@FETCH_STATUS=0
	begin
		fetch next from @outputCursor2
	end
	close @outputCursor2
	deallocate @outputCursor2
	fetch next from @outputCursor
end
close @outputCursor
deallocate @outputCursor
go

--7.	Viết một thủ tục sử dụng Cursor cập nhật thông tin trường ShipRegion
--trên bảng Order cho mỗi khách hàng. Nếu ShipRegion là Null thì cập nhật thành ‘N/A’
declare @regi nvarchar(15);
declare @cusID nchar(5);
declare shipregion CURSOR
FOR SELECT ShipRegion,CustomerID FROM Orders ORDER BY ShipRegion,CustomerID; 
open shipregion
FETCH NEXT FROM shipregion INTO @regi,@cusID;
WHILE @@FETCH_STATUS=0 
BEGIN 
	if @regi is null
	begin
		update Orders SET
		ShipRegion ='N/A'
		WHERE CustomerID= @cusID
	end
	FETCH NEXT FROM shipregion INTO @regi,@cusID; 
END 

CLOSE shipregion 
DEALLOCATE shipregion;


-- BÀi của thầy 
use Northwind
go
----using cursor
--DECLARE @order_num INT;
--DECLARE orders_cursor CURSOR
-- FOR SELECT orderID FROM orders ORDER BY orderID;



--OPEN orders_cursor;
--FETCH NEXT FROM orders_cursor into @order_num
--WHILE @@FETCH_STATUS =0
--BEGIN
-- Print @order_num;
-- FETCH NEXT FROM orders_cursor into @order_num
--END
--CLOSE orders_cursor;
--DEALLOCATE orders_cursor
--Bai 1
CREATE VIEW OrdersList
With schemabinding
AS
SELECT dbo.Orders.OrderID, SUM(dbo.[Order Details].Quantity) AS TotalQuantity, COUNT(dbo.[Order Details].ProductID) AS CountOfProduct, sum(cast(Quantity * UnitPrice * (1-Discount) as decimal(10,2))) SumOfAmount
FROM dbo.Orders INNER JOIN dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID
GROUP BY dbo.Orders.OrderID
GO
--Bài 4
create proc spListEmployee
as
Begin
Declare @EmpID as int, @TenNV as varchar(50);
Declare @NgayVaoCT as varchar(10);



DECLARE EmployeeCursor CURSOR FOR
SELECT EmployeeID, FirstName + ' '+ LastName as TenNV,
convert(varchar(10), HireDate, 103) as NgayVaoCT
FROM Employees;
OPEN EmployeeCursor;
FETCH NEXT FROM EmployeeCursor INTO @EmpID,@TenNV, @NgayVaoCT;
WHILE @@FETCH_STATUS=0
BEGIN
print cast(@EmpID as varchar(10)) + ' - ' + @TenNV + ' - ' + @NgayVaoCT



FETCH NEXT FROM EmployeeCursor INTO @EmpID,@TenNV, @NgayVaoCT;
END
CLOSE EmployeeCursor
DEALLOCATE EmployeeCursor



Return
End
GO
--Bai 6
DECLARE CustomerCursor CURSOR
FOR
SELECT CustomerID, CompanyName FROM Customers;
-- Open cursor (retrieve data)
OPEN CustomerCursor;
DECLARE @CustID nchar(5);
DECLARE @CompanyName nvarchar(40);
-- Perform the first fetch (get first row)
FETCH NEXT FROM CustomerCursor INTO @CustID, @CompanyName;



WHILE @@FETCH_STATUS=0
BEGIN
PRINT @CustID + '-' + @CompanyName
--Declare Cursor with Order
DECLARE OrderCursor CURSOR FOR
SELECT O.OrderID,OrderDate, sum(cast(Quantity * UnitPrice * (1-Discount) as decimal(10,2))) SumOFAmount
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID
WHERE CustomerID=@CustID
Group by O.OrderID,OrderDate;
OPEN OrderCursor;
DECLARE @OrderID int;
DECLARE @OrderDate datetime;
DECLARE @SumOfAmount decimal(10,2);

FETCH NEXT FROM OrderCursor INTO @OrderID , @OrderDate, @SumOfAmount;
WHILE @@FETCH_STATUS=0
BEGIN
--PRINT ' ' + cast(@OrderID as varchar) + ' - ' + convert (varchar(10), @OrderDate, 103) + ' ' + cast(@SumOfAmount as varchar)
FETCH NEXT FROM OrderCursor INTO @OrderID , @OrderDate, @SumOfAmount;
END
CLOSE OrderCursor
DEALLOCATE OrderCursor
FETCH NEXT FROM CustomerCursor INTO @CustID, @CompanyName;
END
CLOSE CustomerCursor
DEALLOCATE CustomerCursor