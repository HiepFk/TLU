use master
go
if exists (select * from sysdatabases where name='Bai_9pro')
	drop database Bai_9pro
create database Bai_9pro
go

use Bai_9pro
go
create table Holiday (
						HolidayID int primary key , 
						HolidayName varchar(30),
					 ) 
go
create table Groupmb ( 
					 GroupID int primary key ,
					 NameGroup varchar(30),
					 HolidayID int , 
					 constraint FK_Groupmb_Holiday foreign key(HolidayID)
						references Holiday(HolidayID)

					)
go
create table Member ( 
						MemberID int primary key ,
						GroupID int , 
						HolidayID int , 
						MemberName varchar(30), 
						DateBorn varchar(30),
						Hometown varchar(30),
						DanToc varchar(30), 
						TonGiao varchar(30),
						city varchar(30)
						constraint FK_Member_Groupmb foreign key(GroupID)
						references Groupmb(GroupID),
						constraint FK_Member_Holiday foreign key(HolidayID)
						references Holiday(HolidayID)
						
					) 

