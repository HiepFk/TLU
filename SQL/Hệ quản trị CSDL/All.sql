-- I. Phân quyền 
-- Tạo các login 
use master
go
create login A34729_H1 with password='1'
create login A34729_H2 with password='1'

use Northwind
go
create user DB_A34729_H1 for login A34729_H1
create user DB_A34729_H2 for login A34729_H2

-- Cấp quền 
	-- User 1 
			--Quyền cấp mới user và phân quyền cho các user khác.
			exec sp_addsrvrolemember 'A34729_H1','securityadmin' 
			use Northwind
			go 
			grant control on [dbo].[Orders] to DB_A34729_H1 
			grant control on [dbo].[Order Details] to DB_A34729_H1 
			grant Select on [dbo].[Categories] to DB_A34729_H1
			grant Select on [dbo].[CustomerCustomerDemo] to DB_A34729_H1	
			grant Select on [dbo].[CustomerDemographics] to DB_A34729_H1	
			grant Select on [dbo].[Customers] to DB_A34729_H1	
			grant Select on [dbo].[CustomersTemp] to DB_A34729_H1	
			grant Select on [dbo].[Employees] to DB_A34729_H1	
			grant Select on [dbo].[EmployeeTerritories] to DB_A34729_H1	
			grant Select on [dbo].[Products] to DB_A34729_H1
			grant Select on [dbo].[Region] to DB_A34729_H1	
			grant Select on [dbo].[Shippers] to DB_A34729_H1	
			grant Select on [dbo].[Territories] to DB_A34729_H1	
			grant Select on [dbo].[Suppliers] to DB_A34729_H1	
			--Quyền tạo mới cơ sở dữ liệu trên hệ quản trị 
			exec sp_addrolemember 'db_accessadmin','DB_A34729_H1' -- Khải , Cường , .. dùng thế
			exec sp_addsrvrolemember 'A34729_H1', 'dbcreator' -- Trên mạng dùng thế 
			--Quyền tạo mới bảng 
			use Northwind
			grant create table to DB_A34729_H1 with grant option

	-- User 2 
			use Northwind
			go
			grant Select,Insert,Update,Delete on [dbo].[Products] to DB_A34729_H2
			grant Select,Insert,Update,Delete on [dbo].[Suppliers] to DB_A34729_H2
			--Quyền backup  
			grant backup database to DB_A34729_H2
			-- Quyền tạo mới login
			use master
			go
			grant alter any login to A34729_H2

-- Kiểm tra lệnh 
	-- user 1
		use Northwind
		go
		select * from fn_my_permissions (null,'database')
		Select * from fn_my_permissions ('Customers', 'object')
		Select * from fn_my_permissions ('Orders', 'object')
		Select * from fn_my_permissions ('Categories', 'object')
		Select * from fn_my_permissions ('CustomerCustomerDemo', 'object')
		Select * from fn_my_permissions ('[CustomerDemographics]', 'object')
		Select * from fn_my_permissions ('[CustomerTemp]', 'object')
		Select * from fn_my_permissions ('[CustomerTrans]', 'object')
		Select * from fn_my_permissions ('[Employees]', 'object')
		Select * from fn_my_permissions ('[EmployeeTerritories]', 'object')
		Select * from fn_my_permissions ('[Order Details]', 'object')
		Select * from fn_my_permissions ('[Products]', 'object')
		Select * from fn_my_permissions ('[Region]', 'object')
		Select * from fn_my_permissions ('[Shippers]', 'object')
		Select * from fn_my_permissions ('[Suppliers]', 'object')
	-- User 2
		use Northwind
		go
		select * from fn_my_permissions (null,'database')
		select * from fn_my_permissions ('Suppliers','object')
		select * from fn_my_permissions ('Products','object')
		-- kiểm tra tạo login
		use Northwind
		go
		create login Test with password='1'
		-- Kiểm tra tạo backup
		backup database DB_A34729_H2 to disk = 'D:\NW_BK.bak'

--II. SP
	--1 In ra thông tin nhân viên có mã là ALFKi (có thể tự truyền vào)
			use Northwind
			go
			create proc Bai1(@CustomerID varchar(5))
			as
			begin
				select * from Customers
				where CustomerID=@CustomerID
			end
			go

			exec Bai1 'ALFKI'
			go
	--2.    Trên CSDL Northwind, viết một thủ tục thêm mới dữ liệu vào bảng Territories với 
	--		các tham số đầu vào là Territory ID, Territory Description và Region ID.
			create proc Bai2(@TerritoryID nvarchar(20),@Territory_Description nchar(50),@RegionID int)
			as 
			begin
			INSERT INTO [dbo].[Territories]
							([TerritoryID],	[TerritoryDescription],	[RegionID])
				 VALUES	    (@TerritoryID,	@Territory_Description,	@RegionID)
			end
			go

			exec Bai2 'A34729','34729',4
			go
			select * from Territories where RegionID=4

		--2 	Viết một thủ tục đệ quy tính tổng dãy số của một số (triangular) nguyên.
		--Đầu vào: Một số nguyên n (n=5)
		--Đầu ra: Tổng của dãy số T=n+ (n-1) + ... + 1.
		--(ví dụ với n=5, T=5+4+3+2+1)
			go
			CREATE PROC spTinh @ValueIn int, @ValueOut int
			OUTPUT
			AS
			DECLARE @InWorking int
			DECLARE @OutWorking int
			IF @ValueIn != 0
				BEGIN
					SELECT @InWorking = @ValueIn - 1
					EXEC spTinh @InWorking, @OutWorking OUTPUT
					SELECT @ValueOut = @ValueIn + @OutWorking
				END
			ELSE
				BEGIN
					SELECT @ValueOut = 0
				END
			RETURN

			DECLARE @WorkingOut int
			DECLARE @WorkingIn int
			SELECT @WorkingIn = 6
			EXEC spTinh @WorkingIn, @WorkingOut
			OUTPUT
			PRINT ' SUM : ' + CAST(@WorkingOut AS varchar)

--III Function
	--9.	Trên CSDL Northwind, viết một hàm  với:
	--a.	Đầu vào: Mã khách hàng (CustomerID)
	--b.	Đầu ra: Chuỗi ký tự chứa danh sách mã hoá đơn (OrderID) của khách hàng. 
	--	Mỗi mã hoá đơn cách nhau bởi dấu ‘;’
		go
		create function dbo.GetDSHoaDonTheoMaKH(@CustID nchar(5))
		returns varchar(1000)
		as
		Begin
			Declare @DSOrder varchar(1000);
			set @DSOrder='';
			Select @DSOrder = @DSOrder + cast(OrderID as varchar) + '; '
			from Orders where CustomerID = @CustID;
			return @DSOrder;
		End

		go
		select C.CustomerID, dbo.GetDSHoaDonTheoMaKH(C.CustomerID) as DSHD
		from Customers as C
--IV  Cursor
		--4.Trên CSDL Northwind, viết một thủ tục (SP) sử dụng Cursor đọc dữ liệu từ bảng Employees 
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
--V Trigger
	--2.	Tạo một After triggers thực hiện kiểm tra khi thêm mới
	-- cập nhật thông tin sản phẩm vào bảng [Order Details]
	--Công việc kiểm tra như sau: kiểm tra trong bảng Product
	--, nếu sản phẩm đó đã ngừng bán (Discontinued = 1)
	-- thì không cho phép thêm mới và cập nhật sản phẩm vào trong bảng [Order Details].  
	GO
	CREATE TRIGGER hihi
	On [dbo].[Order Details]
	for INSERT -- after insert
	As
	Begin
		Declare @Disc bit;
		Select @Disc = Discontinued
		from Inserted I join Products P on I.ProductID= P.ProductID
		--join Orders O on I.OrderID = O.OrderID
		if (@Disc=1)
		Begin
			raiserror('San pham nay da ngung ban', 11, 1)
			rollback tran
		End
	End

	GO
	INSERT [Order Details]
	(OrderID, ProductID, UnitPrice, Quantity, Discount)
	VALUES(10000, 1, 21.35, 5, 0)
	GO

	--Bai 3 Tạo một Instead of triggers để thực hiện công việc kiểm tra như bài 2.
	create TRIGGER [dbo].[OrderDetailNotDiscontinued_I]
	ON [dbo].[Order Details]
	instead of INSERT
	AS
		Declare @Disc bit;
		Select @Disc = Discontinued
		from Inserted  I join Products P on I.ProductID= P.ProductID 
		if (@Disc=1)
			RAISERROR('San pham da ngung ban. khong the them moi.',16,1)
		ELSE
			insert into [Order Details] select * from inserted
	GO