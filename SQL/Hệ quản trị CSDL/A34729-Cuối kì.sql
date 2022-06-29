--Phần 1 
use master
go
create login A34729_L1 with password='1'
create login A34729_L2 with password='1'
use Northwind
go
create user DB_A34729_L1 for login A34729_L1
create user DB_A34729_L2 for login A34729_L2

--User 1
exec sp_addsrvrolemember 'A34729_L1','securityadmin' 

use master
go
grant alter any login to A34729_L1

use Northwind
grant  Select, Insert, Update, Delete on [dbo].[Employees] to DB_A34729_L1 
grant  Select, Insert, Update, Delete on [dbo].[Suppliers] to DB_A34729_L1 

--User 2 
exec sp_addrolemember 'db_accessadmin','DB_A34729_L2'
use master
grant create any database to A34729_L2
go
use Northwind
grant  Select, Insert, Update, Delete on [dbo].[Customers] to DB_A34729_L2 
grant  Select, Insert, Update, Delete on [dbo].[Orders] to DB_A34729_L2


-- Kiểm tra lệnh  
-- 1
		use Northwind
		go
		select * from fn_my_permissions (null,'database')
		Select * from fn_my_permissions ('Employees', 'object')
		Select * from fn_my_permissions ('Suppliers', 'object')

		use Northwind
		go
		create login Test with password='1'
--2	
		use Northwind
		go
		select * from fn_my_permissions (null,'database')
		Select * from fn_my_permissions ('Customers', 'object')
		Select * from fn_my_permissions ('Orders', 'object')

		use master 
		create database A34729_DB


--Phần 2 
-- Bài 1
	use Northwind
	go
	alter proc dsSp @EmployeeID int
	as
	begin
		declare @OrderID int,@OrderDate nvarchar(40),@SlgSP int,@TongTienSP money
		declare SpCursor cursor for
			select O.OrderID,O.OrderDate,count(Quantity) as SlgSP,sum(od.UnitPrice * Quantity * (1-Discount)) as TongTienSP
			from Orders O join [Order Details] od on O.OrderID = od.OrderID
			where O.EmployeeID = @EmployeeID
			group by O.OrderID , O.OrderDate
			order by  year(O.OrderDate) desc
		open SpCursor 
		fetch next from SpCursor into @OrderID,@OrderDate,@SlgSP,@TongTienSP
		while @@FETCH_STATUS = 0
		begin
			print '-' + convert(varchar,@OrderID) + ' | ' + convert(varchar,@OrderDate) + ' | ' + convert(varchar,@SlgSP) + ' | ' + convert(varchar,@TongTienSP)
			fetch next from SpCursor into @OrderID,@OrderDate,@SlgSP,@TongTienSP
		end
		close SpCursor
		deallocate SpCursor
	end
	go
	exec dsSp 2
	go
--Bài 2 
	GO
	alter TRIGGER dbo.NotCountry
	On [dbo].[Suppliers]
	after INSERT 
	As
	Begin
		Declare @Ctr bit;
		Select @Ctr = s.Country from Inserted I join Suppliers s on I.SupplierID = s.SupplierID
		if(@Ctr='USA' )
		Begin
			raiserror('Ko the them', 16, 1)
			rollback tran
		End
	End

	INSERT [dbo].[Suppliers]
	([CompanyName],[Country])
	VALUES('test','USA')
	GO
