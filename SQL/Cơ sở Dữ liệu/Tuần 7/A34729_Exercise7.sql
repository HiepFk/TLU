----------------------------------------------------BÀI THI CUỐI KỲ-----------------------------------------------------------------------------
------------------------------------- MÔN: CƠ SỞ DỮ LIỆU     THỜI GIAN: 90'---------------------------------------------------------------------
------------------------------------------------------- ĐỀ SỐ 1---------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------
/*PHẦN 1: THIẾT KẾ CƠ SỞ DỮ LIỆU
-------------------------------------------------------------------------------------------------------------------------------------------------
Hãy thiết kế, cài đặt cơ sở dữ liệu cho bài toán được mô tả như sau:
Ngân hàng ABC có 3 loại tài khoản ngân hàng khác nhau dành cho khách hàng của họ. Mỗi khách hàng có thể có bất kỳ số lượng tài khoản ngân hàng, 
và tất cả các tài khoản có số tài khoản duy nhất. Một tài khoản cũng có thể do một hoặc nhiều khách hàng làm chủ. Thông tin về khách hàng gồm:
số thẻ căn cước công dân, họ tên, địa chỉ và số điện thoại. Đối với tài khoản tiết kiệm, ngân hàng ABC phải lưu trữ số dư tài khoản, lãi suất, 
và ngày tài khoản được mở. Loại tài khoản thứ 2 là tài khoản không trả lãi. Với loại tài khoản này, ngân hàng cần theo dõi số dư và ngày mở tài
khoản. Loại tài khoản thứ ba là tài khoản cho vay, đòi hỏi phải lưu trữ ngày khoản vay đã được vay và tỷ lệ lãi suất của khoản vay. Mỗi tài 
khoản đều có số tài khoản để phân biệt các tài khoản với nhau. Tài khoản vay được giao cho một nhân viên quản lý, theo dõi tài khoản đảm bảo 
rằng khách hàng thanh toán đúng hạn. Thông tin về nhân viên bao gồm: mã nhân viên, họ tên, số điện thoại di động
Yêu cầu:
1.	Hãy thiết kế cơ sở dữ liệu dựa trên mô hình ER hoặc lý thuyết thiết kế (phần này sinh viên tự làm ra nháp, không cần nộp)
2.	Viết 1 script (phía dưới) để tạo cơ sở dữ liệu với tên là Mã sinh viên của mình gồm các bảng dữ liệu đã được thiết kế ở trên.
*/
USE master
GO
IF EXISTS(SELECT * FROM sys.sysdatabases WHERE name='A34729') --Kiểm tra nếu tồn tại CSDL với tên là MASV 
	DROP DATABASE A34729 -- Xóa CSDL cũ với tên MASV
GO
CREATE DATABASE A34729 -- Tạo mới CSDL với tên MASV 
GO
USE A34729 -- Mở CSDL MASV để thực hiên quá trình tạo các bảng phía dưới 
GO -- Tạo bảng phía dưới đây
create table customers (
						 Idcustomer int primary key  ,
						 name char(20),
						 address char(20),
						 number int ,
)
go
create table Staff (
						IdStaff int primary key , 
						name char(20),
						number int ,
)
go
create table TkTietKiem (
							IdTK1 int primary key, 
							SoDu int , 
							LaiSuat int , 
							DateOfOpen date ,
							Idcustomer int,
)
go
create table TkKoTraLai (
						 IdTK2 int primary key , 
						 SoDu int , 
						 DateOfOpen int ,
						 Idcustomer int,
)
go
create table TkVay (
					 IdTK3 int primary key , 
					 NgayVay date , 
					 TyLeLaiSuat int ,
					 Idcustomer int,
					 IdStaff int,
					 constraint FK_TkVay_teller foreign key(IdStaff)
																	references Staff(IdStaff),
)
go 
create table customer_TK ( Idcustomer int,
						   IdTK int , 
						   constraint PK_customer_TK primary key (Idcustomer ,IdTK),
						   constraint FK_customer_TK_customers foreign key(Idcustomer)
																	references customers(Idcustomer),
						   constraint FK_customer_TK_TkTietKiem foreign key(IdTK)
																	references TkTietKiem(IdTK1),
						   constraint FK_customer_TK_TkKoTraLai foreign key(IdTK)
																	references TkKoTraLai(IdTK2),
						   constraint FK_customer_TK_TkVay foreign key(IdTK)
																	references TkVay(IdTK3),
)