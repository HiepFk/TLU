/*
BÀI KIỂM TRA QUÁ TRÌNH HỌC KỲ 1 NHÓM 2 NĂM 2020-2021
		ĐỀ SỐ 2         THỜI GIAN: 60 phút
Sinh viên restore database và thực hiện các câu SQL bên dưới các câu hỏi
*/
use DreamHome1
EXEC sp_changedbowner 'sa'

use DreamHome1
--Câu 1. Cho biết thông tin về nhân viên sinh trong 2 tháng năm 1990 và 1991
select * 
from Staff
where month(DOB) = 2 and ( YEAR(DOB) =1991 or YEAR(DOB) = 1990)

--Câu 2. Hiển thị mã tài sản, số lần đánh giá theo từng tài sản có số lần đánh giá cao hơn 3
select Pro.propertyNo , soLanDanhGia
from PropertyForRent as Pro
inner join (select propertyNo , count(comments) as soLanDanhGia
			from Viewing 
			group by propertyNo
			) as v on v.propertyNo = Pro.propertyNo
where  soLanDanhGia > 3


--Câu 3. Hiển thị năm sinh và số nhân viên theo từng năm sinh đó. Sắp xếp tăng dần theo số nhân viên
select year(DOB) as NamSinh , count(staffNo) as soNhanVien 
from Staff
group by year(DOB)


--Câu 4. Liệt kê tất các thông tin nhân viên ở chi nhánh tại thành phố có chi nhánh tại Omaha

select * 
from Staff
where branchNo in ( select branchNo
					from Branch
					where city = 'Omaha' ) 

--Câu 5. Cho biết thông tin tài sản ở thành phố Honolulu và Chicago mà chưa được đánh giá lần nào
select * 
from PropertyForRent
where city = 'Honolulu' and city = 'Chicago' and propertyNo  not in (select propertyNo
																     from Viewing
																	)

--Câu 6. Cho biết thông tin nhân viên có mức lương trong khoảng 9910000 đến 9900000
select * 
from Staff
where salary >=9900000 and salary <= 9910000

--Câu 7. Hiển thị danh sách 5 chủ sở hữu có nhiều tài sản ở thành phố Jersey

select top(5) * 
from PrivateOwner as pri 
inner join ( select ownerNo , count(propertyNo) as soTaiSan
			 from PropertyForRent
			 where city = 'Jersey'
			 group by ownerNo ) as o 
			 on o.ownerNo = pri.ownerNo
order by soTaiSan Desc 

--Câu 8. Hiển danh sách khách hàng đánh giá tài sản có giá thuê (rent) rẻ nhất ở thành phố có tên Colorado

select cl.clientNo , fName , lName , telNo , prefType, maxRent , giaMin , comments
from [dbo].[Client] as cl 
inner join 
(select v.propertyNo , clientNo , giaMin , comments
from  [dbo].[Viewing] 
as v  inner join (select min(rent) as giaMin , propertyNo
				  from PropertyForRent 
				  where city = 'Colorado'
				  group by propertyNo) as pro 
								on pro.propertyNo = v.propertyNo ) as d 
		on cl.clientNo = d.clientNo

		

--Câu 9. Cho biết mã tài sản, đường phố, thông tin nhân viên mà quản lý tài sản của khách hàng có số điện thoại là 553-929-8034
			
select propertyNo , street ,Pro.staffNo , fName , lName 
from PropertyForRent as Pro inner join 
			(select st.staffNo , fName , lName 
			from Staff as st inner join ( 
			select r.[clientNo] , [staffNo]
			from [dbo].[Registration] as r  inner join  
				(select clientNo
				 from Client
				 where telNo = '5539298034' ) as cl on r.clientNo = cl.clientNo ) as h 
				 on h.staffNo = st.staffNo ) as k 
				 on pro.staffNo = k.staffNo 

--Câu 10. Hiện thị ma chủ sở hữu (ownerNo) và đơn giá thuê (rent) trung bình theo từng chủ sở hữu. Sắp xếp giảm dần theo đơn giá trung bình.
select pri.ownerNo , giaThueTB
from PrivateOwner as pri 
inner join ( select ownerNo , avg(rent) as giaThueTB 
			 from PropertyForRent
			 group by ownerNo
			) as pro 
			on pro.ownerNo = pri.ownerNo 
order by giaThueTB desc


