use master
go
if exists (select * from sysdatabases where name='A34729_Bai08')
	drop database A34729_Bai08
create database A34729_Bai08
go
use A34729_Bai08
go
create table DoiBong		(
								MaDoi int primary key,
								TenDoi nvarchar(30),
							)
go
create table CauThu			(
								MaCauThu int primary key,
								MaDoi int,
								TenCauThu nvarchar(30),
								SoAo int,
								ViTriChoi nvarchar(30),
								constraint FK_CauThu_DoiBong foreign key(MaDoi)
																	references DoiBong(MaDoi),
							)
go
create table TranDau		(
								MaTran int primary key,
								Ngay date,
								ThoiGian time,
								DiaDiem nvarchar(50),
							)
go
create table CauThu_TranDau	(	
								MaCauThu int,
								MaTran int,
								SoBanThang int,
								constraint PK_CauThu_TranDau primary key(MaCauThu,MaTran),
								constraint FK_CauThu_TranDau_CauThu foreign key(MaCauThu)
																	references CauThu(MaCauThu),
								constraint FK_CauThu_TranDau_TranDau foreign key(MaTran)
																	references TranDau(MaTran),
							)
go
create table TranDau_DoiBong(
								MaDoi int,
								MaTran int,
								constraint PK_TranDau_DoiBong primary key(MaDoi,MaTran),
								constraint FK_TranDau_DoiBong_DoiBong foreign key(MaDoi)
																	references DoiBong(MaDoi),
								constraint FK_TranDau_DoiBong_TranDau foreign key(MaTran)
																	references TranDau(MaTran),
							)
ALTER AUTHORIZATION ON DATABASE::A34729_Bai08 TO sa

--------------------------------------------------------

use master
go
if exists (select * from sysdatabases where name='A34729_Bai09')
	drop database A34729_Bai09
create database A34729_Bai09
go
use A34729_Bai09
go
create table CSHD			(	
								MaCSHD int primary key,
								HoTen nvarchar(30),
								NgaySinh date,
								QueQuan nvarchar(50),
								DanToc nvarchar(10),
								TonGiao nvarchar(20),
								Tinh nvarchar(20),	
							)

create table DoanVien		(
								MaDoanVien int primary key,
								MaCSHD int,
								Tinh nvarchar (20),
								DanToc nvarchar (10),
								TonGiao nvarchar (20),
								constraint FK_DoanVien_CSHD foreign key(MaCSHD)
													references CSHD(MaCSHD),
							)
go
create table ChuongTrinh	(
								
								MaChuongTrinh int primary key,
								TenChuongTrinh nvarchar(50),
								ThoiGian date,
								DiaDiem nvarchar(50),
								DanhGia nvarchar(250),
								NhanXet nvarchar(250),
							)
go 
create table DoanVien_ChuongTrinh	(
										MaDoanVien int ,
										MaChuongTrinh int,
										constraint PK_DoanVien_ChuongTrinh primary key(MaDoanVien,MaChuongTrinh),
										constraint FK_DoanVien_ChuongTrinh_DoanVien foreign key(MaDoanVien)
																	references DoanVien(MaDoanVien),
										constraint FK_DoanVien_ChuongTrinh_ChuongTrinh foreign key(MaChuongTrinh)
																	references ChuongTrinh(MaChuongTrinh),

									)
ALTER AUTHORIZATION ON DATABASE::A34729_Bai09 TO sa

