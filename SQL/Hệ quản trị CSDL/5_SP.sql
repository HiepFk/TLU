--1 
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
	gO
--2.    Trên CSDL Northwind, viết một thủ tục thêm mới dữ liệu vào bảng Territories với 
--các tham số đầu vào là Territory ID, Territory Description và Region ID.
create proc Bai2(@TerritoryID nvarchar(20),@Territory_Description nchar(50),@RegionID int)
as 
begin
INSERT INTO [dbo].[Territories]
           ([TerritoryID]
           ,[TerritoryDescription]
           ,[RegionID])
     VALUES
           (@TerritoryID,@Territory_Description,@RegionID)
end
go
exec Bai2 'A34729','34729',4
go
select * from Territories where RegionID=4

--3.    Thay đổi thủ tục ở bài 2, thực hiện kiểm tra sự tồn tại của khoá ngoại (Region ID)
--trước khi thêm mới. Nếu khoá ngoại (Region ID) không tồn tại thì bắt lỗi 
--và hiển thị thông báo lỗi “Region ID không tồn tại, phải kiểm tra lại”
	GO
	ALTER PROC Bai2 @TerritoryID nvarchar(20), @TerritoryDescirption
	nchar(50), @RegionID int
	AS
	BEGIN
		DECLARE @Count INT
		SELECT @Count = COUNT(*) --Co the dung not exist
		FROM Region
		WHERE RegionID = @RegionID
		IF @Count < 1
		RAISERROR ('RegionID is not valid. Please check your RegionID and tryagain', 11, 1)
		ELSE
		INSERT INTO Territories (TerritoryID, TerritoryDescription, RegionID)
		VALUES (@TerritoryID, @TerritoryDescirption, @RegionID)
	END



GO

--4.	Thay đổi thủ tục ở bài 3, bắt lỗi khi thực sự không tồn tại khoá ngoại RegionID.
--Bắt tất cả các lỗi khác và hiển thị một thông báo chung là “Có lỗi khi thêm mới
go
----Bai 4
alter PROC Bai2(@TerrID nvarchar(20),@TerritoryDesc nchar(50), @RegionID int)
AS
BEGIN
BEGIN 
	TRY
		insert into Territories(TerritoryID,TerritoryDescription,RegionID)
		values (@TerrID, @TerritoryDesc, @RegionID)
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 547
	RAISERROR (N'Lỗi khóa ngoại RegionID', 11, 1)
ELSE
	RAISERROR (N'Lỗi không xác định', 11, 1)
END CATCH
Return;
END
GO
Bai2 N'5000', N'Thành phố Sài Gòn', 0

--5 	Viết một thủ tục đệ quy tính tổng dãy số của một số (triangular) nguyên.
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