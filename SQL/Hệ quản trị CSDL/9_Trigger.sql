use Northwind
go 
drop table CustomersTemp
go 
select CustomerID , CompanyName into CustomersTemp
from Customers

select * from CustomersTemp
Go 
alter Trigger dbo.CustomersTemp_I
on dbo.CustomersTemp
after insert
as
	print 'Ban vua them moi ' +cast(@@rowcount as varchar) +'ban ghi'
	select * from inserted
go 

insert into CustomersTemp values ('ABCDE' ,'VN company ')

-- Bai 1
create proc tran_Orders(@orderID int , @orderdate date , @ProductId int)
as
begin 
	begin try 
	begin transaction 
		update Orders
		set OrderDate = @orderdate
		where OrderID = @orderID
		update Products
		set UnitPrice = UnitPrice *0.2
		where ProductID=@ProductId
		commit tran
	end try
	begin catch
		rollback tran
	end catch
end 
go

exec tran_Orders '36187' , '03-09-2020' , 101
go


--Bai 2
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
