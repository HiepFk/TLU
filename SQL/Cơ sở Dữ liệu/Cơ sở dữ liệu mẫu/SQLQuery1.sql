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
drop database DreamHome;
CREATE DATABASE DreamHome;
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
eMail	VARCHAR(50),
password varchar(40),
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
eMail	VARCHAR(50),
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

INSERT INTO staff VALUES('SL21','John','White','Manager','M','1965-10-01',30000,'B005');
INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F','1980-11-10',12000,'B003');
INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M','1978-03-24',18000,'B003');
INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F','1990-02-19',9000,'B007');
INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F','1960-06-03',24000,'B003');
INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F','1985-06-13',9000,'B005');
INSERT INTO staff VALUES('SL99','Jack','Kim','Assistant','F','1981-07-15',9000,'B005');

INSERT INTO privateOwner VALUES('CO46','Joe','Keogh','2 Fergus Dr. Aberdeen AB2 ','01224-861212', 'jkeogh@lhh.com', null);
INSERT INTO privateOwner VALUES('CO87','Carol','Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419', 'cfarrel@gmail.com', null);
INSERT INTO privateOwner VALUES('CO40','Tina','Murphy','63 Well St. Glasgow G42','0141-943-1728', 'tinam@hotmail.com', null);
INSERT INTO privateOwner VALUES('CO93','Tony','Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025', 'tony.shaw@ark.com', null);
INSERT INTO privateOwner VALUES('CO99','An','Nguyen','100 Park Dr. Aberdeen','0124-225-7025', 'an.@ark.com', null);

INSERT INTO propertyForRent VALUES('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO propertyForRent VALUES('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005' );
INSERT INTO propertyForRent VALUES('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40', NULL, 'B003');
INSERT INTO propertyForRent VALUES('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003' );
INSERT INTO propertyForRent VALUES('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO propertyForRent VALUES('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003' );

INSERT INTO client VALUES('CR76','John','Kay','0171-774-5632','Flat',425, 'john.kay@gmail.com');
INSERT INTO client VALUES('CR56','Aline','Steward','0141-848-1825','Flat',350, 'astewart@hotmail.com');
INSERT INTO client VALUES('CR74','Mike','Ritchie','0145-943-1728','House',750, 'mritchie@yahoo.co.uk');
INSERT INTO client VALUES('CR62','Mary','Tregear','01224-196720','Flat',600, 'maryt@gmail.co.uk');


INSERT INTO viewing VALUES('CR56','PA14','2015-05-24','too small');
INSERT INTO viewing VALUES('CR76','PG4','2015-04-20','too remote');
INSERT INTO viewing VALUES('CR56','PG4','2015-05-26','');
INSERT INTO viewing VALUES('CR62','PA14','2015-05-14','no dining room');
INSERT INTO viewing VALUES('CR56','PG36','2015-04-28','');


INSERT INTO registration VALUES('CR76','B005','SL41','2015-01-13');
INSERT INTO registration VALUES('CR56','B003','SG37','2014-04-13');
INSERT INTO registration VALUES('CR74','B003','SG37','2013-11-16');
INSERT INTO registration VALUES('CR62','B007','SA9','2014-03-07');

-- By default SQL Server uses AutoCommit mode, but to protect the data
-- in case of using other implementations we include here COMMIT
-- There is no harm of the SQL Server warning we will get on missing BEGIN TRANSACTION

COMMIT ;