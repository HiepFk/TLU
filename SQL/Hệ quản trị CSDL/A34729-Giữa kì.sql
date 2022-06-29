-- I. Phân quyền 
-- Tạo các login 
use master
go
create login A34729_A1 with password='1'
create login A34729_A2 with password='1'

use Northwind
go
create user DB_A34729_A1 for login A34729_A1
create user DB_A34729_A2 for login A34729_A2
--Phân quyền 
--1
--Quyền cấp mới user và phân quyền cho các user khác.
exec sp_addsrvrolemember 'A34729_A1','securityadmin' 
-- Quyền tạo mới login
use master
go
grant alter any login to A34729_A2
use Northwind
grant  Select, Insert, Update, Delete on [dbo].[Customers] to DB_A34729_A1 
grant  Select, Insert, Update, Delete on [dbo].[Products] to DB_A34729_A1 

--2 
grant control on [dbo].[Employees] to DB_A34729_A2 
grant control on [dbo].[Orders] to DB_A34729_A2 
--Quyền tạo mới bảng 
use Northwind
grant create table to DB_A34729_A2 with grant option


--II 
--1 
			go
			create proc dm @CursorForOutput CURSOR VARYING OUTPUT
			as
			begin
				set @CursorForOutput= CURSOR
				for 
				select  P.ProductID , P.ProductName , O.Quantity , Sum (O.Quantity*O.UnitPrice) as Tong
				from Products P inner join Categories C on P.CategoryID = C.CategoryID
				inner join [Order Details] O on O.ProductID = P.ProductID
				group by P.ProductID , P.ProductName ,O.Quantity , (O.Quantity*O.UnitPrice)
				ORDER BY Tong DESC
				open @CursorForOutput
			end

			go
			DECLARE @OutputCursor CURSOR
			EXEC dm @OutputCursor OUTPUT
			FETCH NEXT FROM @OutputCursor
			WHILE @@FETCH_STATUS=0
			BEGIN
				FETCH NEXT FROM @OutputCursor
			END
			CLOSE @OutputCursor
			DEALLOCATE @OutputCursor
			go

--2 
	create TRIGGER [dbo].[vl]
	ON [dbo].[Products]
	instead of INSERT
	AS
		Declare @Un bit;
		Select @Un =UnitPrice
		from Inserted  I 
		if (@Un<10)
			RAISERROR('Khong the them moi.',16,1)
		ELSE
			insert into [Products] select * from inserted
	GO


	SET IDENTITY_INSERT Products ON;
	INSERT [dbo].[Products]
	([ProductID] ,[ProductName],[SupplierID] ,[CategoryID],[QuantityPerUnit], [UnitPrice], [UnitsInStock],[UnitsOnOrder],
	[ReorderLevel],[Discontinued])
	VALUES(10000, 1, 21.35, 5, 0, 0,0,0,0,0)
	SET IDENTITY_INSERT Products OFF

