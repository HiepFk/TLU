--use master
--go
--if exists(select *  from sys.databases where name = 'CSDLPhanQuyen')
--	drop database CSDLPhanQuyen
--create database CSDLPhanQuyen
--go
--use CSDLPhanQuyen

--go

--create table HT_User ( TenDangNhap varchar(20) primary key,
--						MaDonVi varchar(10),
--						HangDKV char(1) null,
--						MaDKV varchar(20) null,
--						MatKhau varchar(150),
--						Hoten nvarchar(50),
--						Ten nvarchar(20),
--						NgaySinh date,
--						SoCMT varchar(15) null
--						)

--go
--create table HT_Role (MaRole tinyint primary key ,
--						TenRole nvarchar(50),
--						Mota nvarchar(500) null
--						)

--go
--create table HT_RoleUser (MaRole tinyint,
--							TenDangNhap varchar(20)
--							constraint HT_RoleUser_pk primary key(MaRole,TenDangNhap),
--							constraint FK_HT_RoleUser_User foreign key(TenDangNhap)
--									references HT_User(TenDangNhap),
--									constraint FK_HT_RoleUser_Role foreign key(MaRole)
--									references HT_Role(MaRole)
--							)


--Sinh viên 1 
use master
go
create login SinhVien1 with password ='1'
execute sp_addsrvrolemember 'SinhVien1', 'dbcreator'

use CSDLPhanQuyen
go 
create user dbSinhVien1 for login SinhVien1
use master
go 
grant create any database to SinhVien1
use CSDLPhanQuyen
grant select,insert,delete,update on HT_User to dbSinhVien1 with grant option;
grant select,insert,delete,update on HT_RoleUser to dbSinhVien1
grant backup database to dbSinhVien1

--Sinh viên 2 
use master
create login [Hiep-FK\SinhVien2] from windows
use CSDLPhanQuyen
create user dbSinhVien2 for login [Hiep-FK\SinhVien2]
grant select on HT_User to dbSinhVien2
grant select,insert,delete,update on HT_User to dbSinhVien2
grant select,insert,delete,update on HT_RoleUser to dbSinhVien2



select * from fn_my_permissions ('HT_User','object');
select * from fn_my_permissions ('HT_RoleUser','object');
select USER_NAME()

select * from fn_my_permissions('NULL','database')
select * from fn_my_permissions ('ten bang','object')
select USER_NAME()

use master
backup database Sanpham to disk = 'D:\SanPham.bak'



--Câu 2
use CSDLPhanQuyen
go 
create user userA for login SinhVien1
grant create database to userA
revoke create database on userA from SinhVien1












