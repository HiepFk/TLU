use master 
go
if exists (select * from sys.databases where name ='CTTV')
	drop database CTTV 
go
create database CTTV
go
use CTTV 
go
create table BoPhan(
					 IDBoPhan int primary key , 
					 NameBoPhan varchar(50),
)
go
create table ChuongTrinh(
						NameChuowngTrinh varchar(50) primary key ,
						IDBoPhan int,
						ThoiDiemPhatSong time , 
						ThoiLuong int , 
						constraint FK_ChuongTrinh_BoPhan foreign key(IDBoPhan)
												references  BoPhan(IDBoPhan),
)
go
create table NhanVien(
						IDNhanVien int primary key , 
						NameNhanVien varchar(50),
						SĐT int ,
)
go
create table NhanVien_ChuongTrinh (
								   NameChuowngTrinh varchar(50),
								   IDNhanVien int,
								   ViTri varchar(50),
								   constraint PK_NhanVien_ChuongTrinh primary key(NameChuowngTrinh,IDNhanVien),
								   constraint FK_NhanVien_ChuongTrinh_ChuongTrinh foreign key(NameChuowngTrinh)
												references  ChuongTrinh(NameChuowngTrinh),
								   constraint FK_NhanVien_ChuongTrinh_NhanVien foreign key(IDNhanVien)
												references NhanVien(IDNhanVien),

)
