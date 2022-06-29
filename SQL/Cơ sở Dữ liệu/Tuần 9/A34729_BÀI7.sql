use master
go
if exists (select * from sysdatabases where name='Pictures')
	drop database Pictures
create database Pictures
go
use Pictures
go
create table NgheSy(
ButDanh varchar(100) primary key,
TenNS varchar(150),
Address varchar(150),
City varchar(100)
)
go
create table Tranh(
MaTranh char(6) primary key,
TenTranh varchar(100),
NamSangTac int,
ButDanh varchar(100),
constraint FK_Tranh_NgheSy foreign key(ButDanh)
						references NgheSy(ButDanh)
)
go
create table TranhVe(
MaTranh char(6),
ChatLieu varchar(100),
constraint FK_TranhVe_Tranh foreign key(MaTranh)
						references Tranh(MaTranh)
)
go
create table TranhAnh(
MaTranh char(6) ,
KichThuoc int,
constraint FK_TranhAnh_Tranh foreign key(MaTranh)
						references Tranh(MaTranh)
)
go

create table GroupNS(
GroupID char(10) primary key,
NamTG int,
ButDanh varchar(100),
constraint FK_GroupNS_NgheSy foreign key(ButDanh)
							references NgheSy(ButDanh)
)
create table NgheSy_GroupNS(
ButDanh varchar(100),
GroupID char(10),
constraint PK_NgheSy_GroupNS primary key(ButDanh,GroupID),
constraint FK_NgheSy_GroupNS_NgheSy foreign key(ButDanh)
									references NgheSy(ButDanh),
constraint FK_NgheSy_GroupNS_GroupNs foreign key(GroupID)
									references GroupNS(GroupID)
)