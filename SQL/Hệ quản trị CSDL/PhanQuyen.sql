-- Tạo 2 user login như sau
--o 1 login có tên là SinhVien1 của SQL Server, user này có quyền cấp mới
--user và phân quyền cho các user khác.
--o 1 login có tên là SinhVien2 của Windows.
-- User SinhVien1 có quyền Backup, tạo mới cơ sở dữ liệu trên hệ quản trị.
-- User SinhVien1 có quyền Select, Insert, Update, Delete trên bảng HT_User và
--HT_RoleUser. Không được phép truy cập vào bảng còn lại.
-- User SinhVien2 có quyền Select trên bảng HT_User, và quyền (Select, Insert,
--Update, Delete ) trên bảng HT_Role, HT_RoleUser
--Login vào theo user SinhVien1 và SinhVien2 và thực hiện các câu lệnh để kiểm tra
--việc phân quyền

--o 1 login có tên là SinhVien1 
use master 
create login SinhVien1 with password = '1'
--user này có quyền cấp mới user và phân quyền cho các user khác.
exec sp_addsrvrolemember 'SinhVien1' , 'securityadmin' 
--o 1 login có tên là SinhVien2 của Windows.
create login "DESKTOP-9IJ80IO\SinhVien2" from windows
-- User SinhVien1 có quyền Backup, tạo mới cơ sở dữ liệu trên hệ quản trị.

use PhanQuyen
create user SinhVien1_DB for login SinhVien1
exec sp_addrolemember 'Db_backupoperator' ,'SinhVien1_DB' --quyền Backup
exec sp_addrolemember 'Db_accessadmin' ,'SinhVien1_DB' --tạo mới cơ sở dữ liệu trên hệ quản trị
 

--ktra quyen
execute as user = 'SinhVien1_DB'
select * from fn_my_permissions (null,'database ')
select * from fn_my_permissions ('[dbo].[HT_User]','object')
select * from fn_my_permissions ('[dbo].[HT_RoleUser]','object')
revert 
select USER_NAME()
-- grant any database to SinhVien1_DB (tạo mới cơ sở dữ liệu trên hệ quản trị)

--User SinhVien1 có quyền Select, Insert, Update, Delete trên bảng HT_User và HT_RoleUser. Không được phép truy cập vào bảng còn lại.
use PhanQuyen
grant Select, Insert, Update, Delete on HT_User to SinhVien1_DB
grant Select, Insert, Update, Delete on HT_RoleUser to SinhVien1_DB

-- User SinhVien2 có quyền Select trên bảng HT_User, và quyền (Select, Insert, Update, Delete ) trên bảng HT_Role, HT_RoleUser
use PhanQuyen
create user SinhVien2_DB for login "DESKTOP-05IRUIL\SinhVien2"
grant Select on HT_User to SinhVien2_DB
grant Select, Insert, Update, Delete on HT_Role to SinhVien2_DB
grant Select, Insert, Update, Delete on HT_RoleUser to SinhVien2_DB

--Login vào theo user SinhVien1 và SinhVien2 và thực hiện các câu lệnh để kiểm tra việc phân quyền.
-- login sinh vien 1
execute as user = 'SinhVien1_DB'
select * from fn_my_permissions (null,'Database')
select * from fn_my_permissions ('[dbo].[HT_User]', 'object')
select * from fn_my_permissions ('[dbo].[HT_RoleUser]', 'object')
select USER_NAME()
revert
--login sinh vien 2 
execute as user = 'SinhVien2_DB'
select * from fn_my_permissions (null,'Database')
select * from fn_my_permissions ('[dbo].[HT_RoleUser]', 'object')
select * from fn_my_permissions ('[dbo].[HT_Role]','object' )
select USER_NAME()
revert

--- Login theo SinhVien1, thực hiện thao tác BackUp CSDL vừa tạo thành file PhanQuyen.bak. (1đ)
use PhanQuyen
execute as user = 'SinhVien1'
select USER_NAME()
backup database SinhVien1 to disk = 'd:\PhanQuyen.bak'
-- or 
BACKUP DATABASE SinhVien1
TO DISK = 'C:\a.bak'

-- bai 2:
-- cấp quyền tạo bảng cho SinhVien1
use phanquyen
grant create table to SinhVien1_DB with grant option 

execute as user = 'SinhVien1_DB'
select * from fn_my_permissions (null,'Database')
revert
select USER_NAME()
-- tạo 
use master 	
create login UserA with password = '1'
use phanquyen
create user UserA_DB for login UserA 


create login UserB with password = '1'
use phanquyen
create user UserB_DB for login UserB 


-- Trong Sinhvien1
select * from fn_my_permissions (null,'Database')
select USER_NAME()
grant create table to UserA_DB with grant option
 
-- Trong UserA
select * from fn_my_permissions (null,'Database')
select USER_NAME()
grant create table to UserB_DB with grant option
 
-- Trong UserB
select * from fn_my_permissions (null,'Database')


-- Thu hồi quyền
use phanquyen 
revoke create table to SinhVien1_DB cascade
