use master 
go
if exists (select * from sys.databases where name = 'A34729_Course')
	drop database A34729_Course
go 
create database A34729_Course
go 
use A34729_Course
go 
create table Students (
						StudentID char(6) primary key , 
						Name varchar(30),
						Major varchar(20)
					  )
go 
create table Courses (
					 CourseID char (6) primary key ,
					 deptname nvarchar (30),
					 title nvarchar (100),
					 credit int ,
					 hours int , 
					 description nvarchar (100)
					)
go 
create table Enrollment (
						  CourseID char(6),
						  StudentID char (6)
						  constraint PK_Enrollment primary key(CourseID,StudentID),
						  constraint FK_Enrollment_Courses foreign key(CourseID)
										references Courses(CourseID),
						  constraint FK_Enrollment_Students foreign key(StudentID)
										references Students(StudentID)
						)
go 
create table Room (
					RoomID char(6) primary key , 
					BuildingName varchar(30),
					Capacity int ,
				  )
go 
create table Section (
						SectionID char(6) ,
						Semester nvarchar(10),
						Profession nvarchar (10),
						CourseID char (6),
						RoomID char (6)
						constraint PK_Section primary key (CourseID, RoomID),
						constraint FK_Section_Courses foreign key(CourseID)
										references Courses(CourseID),
						constraint FK_Section_Room foreign key(RoomID)
										references Room(RoomID)
					)

						
						

