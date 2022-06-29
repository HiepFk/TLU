					
use master
go
if exists (select * from sys.databases where name ='Oto')
drop database Oto
go
create database Oto
go
use Oto
go
create table HangXe( HangXeid int primary key,
					 mauxe char(50) unique,
					)
go
create table Mau( Mauid int primary key,
				  Tenmau char(100),
				)
go
create table DacTinh( DacTinhid int primary key,
					  TenDacTinh char(100),
					)
go
create table DungTich( DungTichid int primary key,
					   sodt int ,
					  )
go
create table Xe( Xeid int primary key,
				 mauxe char(50),
				constraint FK_Xe_HangXe foreign key(mauxe)
					references HangXe(mauxe),
				nam int,
				gia int ,
				Mauid int,
				constraint FK_Xe_Mau foreign key(Mauid)
					references Mau(Mauid),
				DacTinhid int,
				DungTichid int,
				)
go
create table DacTinh_Xe( DacTinhid int,
			             Xeid int,
						 constraint PK_DacTinh_Xe primary key (DacTinhid,Xeid),
						 constraint FK_DacTinh_Xe_Xe foreign key(Xeid)
									references Xe(Xeid),
						 constraint FK_DacTinh_Xe_DacTinh foreign key(DacTinhid)
									references DacTinh(DacTinhid),
)

go
create table DungTich_Xe( Xeid int,
						  DungTichid int,
						  constraint PK_DungTich_Xe primary key (DungTichid,Xeid),
						  constraint FK_DungTich_Xe_Xe foreign key(Xeid)
									references Xe(Xeid),
						  constraint FK_DungTich_Xe_DungTich foreign key(DungTichid)
									references DungTich(DungTichid),
)
			