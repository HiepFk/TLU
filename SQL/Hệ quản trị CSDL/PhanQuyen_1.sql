use master
create login sv_2 with password ='123';
exec sp_addsrvrolemember 'sv_2', 'dbcreator'
use Northwind
create user sv_2db for login sv_2
exec sp_addrolemember 'db_datareader', 'sv_2db'
use master
--Grant create any database to sv_2
use Northwind
grant update, delete, insert on Customers to sv_2db
drop user sv_2db
drop login sv_2