use master 
go
if exists (select * from sys.databases where name ='Hospital')
	drop database Hospital 
go
create database Hospital
go
use Hospital 
go
create table Khoa(	khoaID int primary key,
					nghanhID int,
					khoaName varchar(255),
					)
go
create table BacSi(	bacSiID int primary key,
					bacSiName varchar(255),
					diachi varchar(255),
					sdt int ,
					khoaID int,
					constraint FK_BacSi_Khoa foreign key(khoaID)
												references  Khoa(khoaID),
					)
go
create table BenhNhan(	bnID int primary key,
						bnName varchar(255),
						diachi varchar(255),
						CMT char(11),
						bacSiID int,
						constraint FK_BenhNhan_BacSi foreign key(bacSiID)
												references  BacSi(bacSiID),
						)
go
create table Yta(	ytaID int primary key,	
					bnID int,
					ngayYta date,
					constraint FK_Yta_BenhNhan foreign key(bnID)
												references  BenhNhan(bnID),
					)
go
create table DsKham(	bnID int,
						bacSiID int,
						ytaID int,
						lieuphap varchar(255),
						ngayBS date,
						ngayYta date,
						constraint PK_DsKham primary key (bnID,bacSiID,ytaID),
						constraint FK_DsKham_BacSi foreign key(bacSiID)
												references  BacSi(bacSiID),
						constraint FK_DsKham_BenhNhan foreign key(bnID)
												references  BenhNhan(bnID),
						constraint FK_DsKham_Yta foreign key(ytaID)
												references  Yta(ytaID),
						)