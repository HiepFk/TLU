--Sinh viên 2
use master
go
create login sinhvien2 with password = '1'

execute sp_addsrvrolemember 'sinhvien2', 'dbcreator'

use Northwind
go
create user sinhvien2_NW for login sinhvien2

use master
go 
grant create any database to sinhvien2
use Northwind
grant insert, delete, select, update on Orders to sinhvien2_NW
grant insert, delete, select, update on [Order Details] to sinhvien2_NW
grant select on Customers to sinhvien2_NW

--Sinh viên 1
use master
go

use Northwind
go
create user sinhvien1_NW for login [Hiep-FK\sinhvien_1]

grant create any database to [Hiep-FK\sinhvien_1]

grant control on dbo.Customers to sinhvien1_NW
