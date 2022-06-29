--  DreamHome Case Study 
--  presented in the book DATABASE SYSTEMS 
--  by Connolly and Begg
--
--  +------------------------------------------------------------+
--  |  DREAMHOME_SQL2005.TXT                                             |
--  |                                                            |
--  |  Create tables for DreamHome Real Estate Agency Database   |
--  |  (implementation by HAAGA-HELIA / ML)              |
--  |                                                            |
--  +------------------------------------------------------------+

--  For SQL Server 2005 : 
--  First log-on as system administrator and create the database
--  (details to be studied by the students)
--
USE Master ;
CREATE DATABASE DreamHome ;
GO
--  DATETIME of SQL Server will be used as DATE data type of the standard SQL
USE DreamHome ;
EXEC sp_addtype DATE, 'DATETIME';
GO
--  end of SQL Server specific preparations. --------------------

--  For SOLID :
--  comment out all CONSTRAINT lines below

--
--  Create all the necessary tables
--

CREATE TABLE Branch (
branchNo   CHAR(4) NOT NULL, 
street     VARCHAR(25) NOT NULL, 
city       VARCHAR(15) NOT NULL, 
postcode   VARCHAR(8) NOT NULL, 
CONSTRAINT branch_PK
       PRIMARY KEY (branchNo)
);

CREATE TABLE Staff (
staffNo    VARCHAR(5) NOT NULL, 
fName      VARCHAR(15) NOT NULL, 
lName      VARCHAR(15) NOT NULL, 
oPosition  VARCHAR(10) NOT NULL, 
sex        CHAR
           CONSTRAINT Staff_sexCHK
           CHECK (sex IN ('M','F')), 
DOB        DATE, 
salary     DECIMAL(9,2) NOT NULL, 
branchNo   CHAR(4) NOT NULL,
CONSTRAINT staff_PK
       PRIMARY KEY (staffNo),
CONSTRAINT Staff_Branch_FK 
       FOREIGN KEY (branchNo) 
           REFERENCES Branch(branchNo)
);

CREATE TABLE PrivateOwner (
ownerNo    VARCHAR(7) NOT NULL, 
fName      VARCHAR(15) NOT NULL, 
lName      VARCHAR(15) NOT NULL, 
address    VARCHAR(50) NOT NULL, 
telNo      VARCHAR(13) NOT NULL,
CONSTRAINT privateOwner_PK
       PRIMARY KEY (ownerNo)
);

CREATE TABLE PropertyForRent (
propertyNo VARCHAR(8) NOT NULL, 
street     VARCHAR(25) NOT NULL, 
city       VARCHAR(15) NOT NULL, 
postcode   VARCHAR(8) NOT NULL, 
propertyType VARCHAR(10) NOT NULL, 
rooms      SMALLINT NOT NULL, 
rent       DECIMAL(5, 1) NOT NULL, 
ownerNo    VARCHAR(7) NOT NULL, 
staffNo    VARCHAR(5), 
branchNo   CHAR(4) NOT NULL,
CONSTRAINT propertyForRent_PK
       PRIMARY KEY (propertyNo),
CONSTRAINT Property_Owner_FK 
       FOREIGN KEY (ownerNo) 
       REFERENCES PrivateOwner(ownerNo),
CONSTRAINT Property_Staff_FK 
       FOREIGN KEY (staffNo) 
       REFERENCES Staff(staffNo),
CONSTRAINT Property_Branch_FK 
       FOREIGN KEY (branchNo) 
       REFERENCES Branch(branchNo)
);

CREATE TABLE Client (
clientNo   VARCHAR(7) NOT NULL, 
fName      VARCHAR(15) NOT NULL, 
lName      VARCHAR(15) NOT NULL, 
telNo      VARCHAR(13) NOT NULL, 
prefType   VARCHAR(10) NOT NULL,
maxRent    DECIMAL(5, 1) NOT NULL, 
CONSTRAINT client_PK
       PRIMARY KEY (clientNo)
);

CREATE TABLE Viewing (
clientNo   VARCHAR(7) NOT NULL, 
propertyNo VARCHAR(8) NOT NULL, 
viewDate   DATE NOT NULL, 
comments   VARCHAR(50),
CONSTRAINT viewing_PK
       PRIMARY KEY (propertyNo, clientNo),
CONSTRAINT Viewing_Propty_FK 
       FOREIGN KEY (propertyNo) 
       REFERENCES PropertyForRent(propertyNo),
CONSTRAINT Viewing_Client_FK 
       FOREIGN KEY (clientNo) 
       REFERENCES Client(clientNo)
);

CREATE TABLE Registration (
clientNo   VARCHAR(7) NOT NULL,
branchNo   CHAR(4) NOT NULL, 
staffNo    VARCHAR(5) NOT NULL, 
dateJoined DATE NOT NULL,
CONSTRAINT registration_PK
       PRIMARY KEY (clientNo, branchNo),
CONSTRAINT Regist_Client_FK 
       FOREIGN KEY (clientNo) 
       REFERENCES Client(clientNo),
CONSTRAINT Regist_Branch_FK 
       FOREIGN KEY (branchNo) 
           REFERENCES Branch(branchNo),
CONSTRAINT Regist_Staff_FK 
       FOREIGN KEY (staffNo) 
       REFERENCES Staff(staffNo)
);

-- COMMIT

-- Inserting the test data
--
-- Note: SQL Server and some other DBMS do not accept DATE in front of date literals
--       so you may need to remove the DATE words from the INSERT commands below.

INSERT INTO Branch VALUES ('B005', '22 Deer Rd',   'London',   'SW1 4EH');
INSERT INTO Branch VALUES ('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU');
INSERT INTO Branch VALUES ('B003', '163 Main St',  'Glasgow',  'G11 9QX');
INSERT INTO Branch VALUES ('B004', '32 Manse Rd',  'Bristol',  'BS99 1NZ');
INSERT INTO Branch VALUES ('B002', '56 Clover Dr', 'London',   'NW10 6EU');

INSERT INTO Staff VALUES ('SL21', 'John', 'White','Manager',   'M', '1945-10-01', 30000, 'B005');
INSERT INTO Staff VALUES ('SG37', 'Ann',  'Beech','Assistant', 'F', '1960-10-11', 12000, 'B003');
INSERT INTO Staff VALUES ('SG14', 'David','Ford', 'Supervisor','M', '1958-11-24', 18000, 'B003');
INSERT INTO Staff VALUES ('SA9',  'Mary', 'Howe', 'Assistant', 'F', '1970-02-19', 9000, 'B007');
INSERT INTO Staff VALUES ('SG5',  'Susan','Brand','Manager',   'F', '1940-06-03', 24000, 'B003');
INSERT INTO Staff VALUES ('SL41', 'Julie','Lee',  'Assistant', 'F', '1965-06-13', 9000, 'B005');

INSERT INTO PrivateOwner VALUES ('CO46', 'Joe',  'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX','01224-861212');
INSERT INTO PrivateOwner VALUES ('CO87', 'Carol','Farrel','6 Achray St, Glasgow G32 9DX', '0141-357-7419');
INSERT INTO PrivateOwner VALUES ('CO40', 'Tina', 'Murphy','63 Well St, Glasgow G42',      '0141-943-1728');
INSERT INTO PrivateOwner VALUES ('CO93', 'Tony', 'Shaw',  '12 Park Pl, Glasgow G4 0QR',   '0141-225-7025');

INSERT INTO PropertyForRent VALUES ('PA14', '16 Holhead',  'Aberdeen', 'AB7 5SU', 'House',6, 650, 'CO46', 'SA9', 'B007');
INSERT INTO PropertyForRent VALUES ('PL94', '6 Argyll St',  'London',  'NW2',     'Flat', 4, 400, 'CO87', 'SL41', 'B005');
INSERT INTO PropertyForRent VALUES ('PG4',  '6 Lawrence St','Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', NULL, 'B003');
INSERT INTO PropertyForRent VALUES ('PG36', '2 Manor Rd',   'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003');
INSERT INTO PropertyForRent VALUES ('PG21', '18 Dale Rd',   'Glasgow', 'G12',     'House',5, 600, 'CO87', 'SG37', 'B003');
INSERT INTO PropertyForRent VALUES ('PG16', '5 Novar Dr',   'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

INSERT INTO Client VALUES ('CR76', 'John', 'Kay',     '0207-774-5632', 'Flat',  425);
INSERT INTO Client VALUES ('CR56', 'Aline','Stewart', '0141-848-1825', 'Flat',  350);
INSERT INTO Client VALUES ('CR74', 'Mike', 'Ritchie', '01475-392178',  'House', 750);
INSERT INTO Client VALUES ('CR62', 'Mary', 'Tregar',  '01224-196720',  'Flat',  600);

INSERT INTO Viewing VALUES ('CR56', 'PA14', '2001-05-24', 'too small');
INSERT INTO Viewing VALUES ('CR76', 'PG4',  '2001-04-20', 'too --ote');
INSERT INTO Viewing VALUES ('CR56', 'PG4',  '2001-05-26', NULL);
INSERT INTO Viewing VALUES ('CR62', 'PA14', '2001-05-14', 'no dining room');
INSERT INTO Viewing VALUES ('CR56', 'PG36', '2001-04-28', NULL);

INSERT INTO Registration VALUES ('CR76', 'B005', 'SL41', '2001-01-02');
INSERT INTO Registration VALUES ('CR56', 'B003', 'SG37', '2000-04-11');
INSERT INTO Registration VALUES ('CR74', 'B003', 'SG37', '1999-11-16');
INSERT INTO Registration VALUES ('CR62', 'B007', 'SA9',  '2000-03-07');

-- By default SQL Server uses AutoCommit mode, but to protect the data
-- in case of using other implementations we include here COMMIT
-- There is no harm of the SQL Server warning we will get on missing BEGIN TRANSACTION

COMMIT ;