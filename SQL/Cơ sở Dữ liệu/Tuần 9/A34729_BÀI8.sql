use master
go
if exists (select * from sysdatabases where name='Bai_8')
	drop database Bai_8
create database Bai_8
go

use Bai_8
go
create table Team(
TeamID char(10) primary key,
TeamName varchar(150)
)
go
create table Player(
PlayerID char(10) primary key,
PlayerName varchar(150),
PlayerNumber int,
PlayerSituation varchar(100),
TeamID char(10),
constraint FK_Player_Team foreign key(TeamID)
						references Team(TeamID)
)
create table InformationMatch(
MatchID char(10) primary key,
Date int,
Time int,
Address varchar(150),
TeamID char(10),
PlayerID char(10),
constraint FK_InformationMatch_TeamID foreign key(TeamID)
									references Team(TeamID),
constraint FK_InformationMatch_Player foreign key(PlayerID)
									references Player(PlayerID)
)
create table Goal(
PlayerID char(10),
MatchID char(10),
GoalNumber int,
constraint FK_Goal_InformationMatch foreign key(MatchID)
									references InformationMatch(MatchID),
constraint FK_Goal_Player foreign key(PlayerID)
						references Player(PlayerID)
)