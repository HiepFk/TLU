use master
go 
if exists (select * from sys.databases where name = 'A34729_University')
	drop database A34729_University 
go 
create database  A34729_University
go 
use  A34729_University 
go 
create table Student (
						StudentID int primary key,
						Name varchar(255),
						Program varchar(255),
						)
go
create table Course (
						CourseID int primary key,
						Syllabus varchar (255),
						Title varchar (255),
						Credits varchar (255),
						Prerequisite varchar(255)
					)
go
create table Instructor (
							InstructorID int primary key , 
							Name varchar(255),
							Department varchar(255),
							Title varchar(255)
						)
go
create table CourseOffering (
							  StudentID int,
							  InstructorID int,
							  CourseID int, 
							  Time date ,
							  SectionNo int ,
							  RoomID int , 
							  Year int , 
							  Semester char(2),
							  constraint FK_CourseOffering_Course foreign key(CourseID)
										references Course(CourseID),
							  constraint FK_CourseOffering_Student foreign key(StudentID)
										references Student(StudentID),
							  constraint FK_CourseOffering_Instructor foreign key(InstructorID)
										references Instructor(InstructorID)
										) 

