use master
go
if exists (select * from sysdatabases where name='DVDpro')
	drop database Pictures
create database DVDpro
go
use DVDpro
go
create table Branch (
						branchNo int primary key,
						street varchar(30),
						city varchar(30),
						state varchar(30),
						zipCode int ,
						telNo int 
					)
go 
create table Staff (
						staffNo int primary key , 
						branchNo int , 
						name varchar(30)  , 
						position varchar(30),
						salary int 
						constraint FK_Staff_Branch foreign key(branchNo)
							references Branch(branchNo)
					)
go 
create table Member (
						memberNo int primary key ,
						fname varchar(30),
						lname varchar(30),
						address varchar(30),
					) 
go 
create table Registration ( dateRegistered varchar(30) primary key, 
							memberNo int , 
							branchNo int , 
							constraint FK_Registration_Branch foreign key(branchNo)
								references Branch(branchNo) ,
							constraint FK_Registration_Member foreign key(branchNo)
								references Member(memberno)
							) 
go 
create table Video (
						videoNo int primary key ,
						namevideo varchar(30) , 
					) 
go 
create table VideoForRent (
							videoNo int , 
							branchNo int , 
							dateRegistered varchar(30),
							constraint FK_VideoForRent_Branch foreign key(branchNo)
								references Branch(branchNo) ,
							constraint FK_VideoForRent_Video foreign key(videoNo)
								references Video(videoNo) ,
							constraint FK_VideoForRent_Registration foreign key(dateRegistered)
								references Registration(dateRegistered) ,
							) 



							



