use master
go 
if exists (select * from sys.databases where name = 'A34729_College')
	drop database A34729_College
go 
create database  A34729_College
go 
use  A34729_College
go 
create table Student(
					StudentID int primary key ,
					FristName varchar(255),
					Lastname varchar(255),
					Phone varchar(255)
					)
go 
create table Department (
						DepartmentName varchar(255) primary key ,
						Location varchar(255)
						)
go 
create table Instruction (
							InstructionID int primary key , 
							DepartmentName varchar(255) UNIQUE, 
							headedBy varchar (255),
							FristName varchar (255),
							LastName varchar (255),
							Phone varchar (255)
							constraint FK_Instruction_Department foreign key(DepartmentName)
										references Department(DepartmentName)
									)
go 
create table Course (
						CourseID int primary key , 
						DepartmentName varchar(255) ,
						InstructionID int,
						Duration int , 
						Name varchar(255),
						constraint FK_Course_Department foreign key(DepartmentName)
										references Department(DepartmentName),
						constraint FK_Course_Instruction foreign key(InstructionID)
										references Instruction(InstructionID)
					)
go 
create table Course_Student (
								CourseID int ,
								StudentID int ,
								constraint PK_Enrollment primary key(CourseID,StudentID),
								constraint FK_Course_Student_Course foreign key(CourseID)
										references Course(CourseID),
								constraint FK_Course_Student_Students foreign key(StudentID)
										references Student(StudentID)
							) 

					
						

