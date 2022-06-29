/*PHẦN 1: THIẾT KẾ CƠ SỞ DỮ LIỆU
Hãy thiết kế, cài đặt cơ sở dữ liệu cho bài toán sau:
Một công ty taxi cần xây dựng cơ sở dữ liệu để quản lý phân phối xe. Công ty có nhiều xe. Thông tin về xe chở khách gồm có biển số xe, loại xe, số chỗ ngồi.  
Một xe được phân công cho một tài xế vào ngày nào đó, số ngày lái, số giờ lái. Thông tin về tài xế gồm họ tên, mã số tài xế, điện thoại di động. Một tài xế thuộc về 1 chi nhánh của công ty. 
Một chi nhánh có thể có nhiều tài xế. Một tài xế thuộc về 1 chi nhánh. Một chi nhánh cũng quản lý nhiều xe. Tuy nhiên một xe chỉ được quản lý ở một chi nhánh. Thông tin chi nhánh gồm mã, tên chi nhánh. Một chi nhánh ở một thành phố. Mỗi thành phố có 1 chi nhánh. Thông tin về thành phố gồm mã và tên thành phố
Yêu cầu:
1.	Hãy thiết kế cơ sở dữ liệu dựa trên mô hình ER hoặc lý thuyết thiết kế (phần này sinh viên tự làm ra nháp, không cần nộp)
2.	Tạo cơ sở dữ liệu với tên là Mã sinh viên của mình gồm các bảng dữ liệu đã được thiết kế ở trên. (sinh viên viết các câu lệnh SQL để tạo cơ sở dữ liệu, tạo bảng với đầy đủ các quan hệ nếu có ở phía dưới)
*/

/*SV viết câu lệnh tạo CSDL vào dưới đây, chú ý đổi tên file về dạng MSV_Hoten_BaithiCSDL.sql */
use DreamHome
/*Câu 1: Cho biết Mã nhân viên, Họ, Tên, Giới tính của các nhân viên nữ (giới tính = ‘F’)*/
SELECT staffNo, fName,lName, sex
FROM Staff
WHERE sex = 'F'

/*Câu 2: Đưa ra Mã nhân viên, Họ, Tên, Mã chi nhánh, Tên đường, thành phố của những nhân viên Nam (giới tính =’M’)*/
SELECT b.staffNo , b.fName , b.lName, b.branchNo, a.street , a.city
FROM Branch a , Staff b
WHERE b.sex= 'M' AND b.branchNo = a.branchNo

/*Câu 3: Tìm những người thuê nhà (Mã người thuê, Họ, Tên, eamail) không sử dụng gmail */
SELECT *
FROM Client
WHERE eMail is NULL 

/*Câu 4: Đưa ra danh sách những nhân viên có lương từ 500 đến 1000 một tháng, thông tin cần hiển thị bao gồm Mã nhân viên, Họ, Tên, Lương theo tháng (chú ý: salary là lương năm, cần chia cho 12 để tính ra lương tháng). Sắp xếp kết quả theo Lương năm giảm dần.*/
SELECT staffNo , fName , lName , (salary /12) AS Luong
FROM Staff
WHERE salary/12 BETWEEN 500 AND 1000
ORDER BY  salary DESC 
/*Câu 5: Cho biết Mã chủ nhà, Họ, Tên, email của người cho thuê là căn hộ (Flat) mà ở thành phố Glasgow. Chú ý: loại bỏ trùng lặp*/
SELECT a.ownerNo , a.fName,a.lName,a.eMail 
FROM PrivateOwner a, PropertyForRent b
WHERE b.propertyType = 'Flat'  and b.branchNo = (select branchNo
												 from Branch
												 where city = 'Glasgow' );

/*Câu 6: Cho biết danh sách nhân viên và thông tin nhà cho thuê mà nhân viên đó quản lý (Mã nhân viên, Họ, Tên, email, Mã nhà cho thuê, địa chỉ) kể cả những nhân viên chưa quản lý bất ký nhà nào*/
SELECT s.staffNo,fName,lName,propertyNo,street
FROM Staff s,PropertyForRent p
where s.staffNo=p.staffNo and s.oPosition = 'Manager';


/*Câu 7: Tính tổng lương theo năm của từng chi nhánh 8*/
SELECT SUM(b.salary) AS TOng
FROM Branch a , Staff b
WHERE a.branchNo = b.branchNo
Group By b.branchNo 

/*Câu 8: Đưa ra danh sách các chi nhánh có số nhân viên > 2 người*/
SELECT branchNo,count(staffNo) as mycount
FROM Staff
group by branchNo
having count(staffNo) >2
order by branchNo;


/*Câu 9: Cho biết danh sách người thuê nhà (clientNo, fName, lName, type, Maxrent) mà đã xem nhà ở địa chỉ ‘6 Lawrence St’*/
SELECT clientNo,fName,lName,prefType,maxRent
FROM Client
where clientNo in (select clientNo
				   from Viewing
			       where propertyNo = (select propertyNo
									   from PropertyForRent
									   where street = '6 Lawrence St'));

/*Câu 10: Danh sách các chi nhánh có số nhân viên ít hơn số nhân viên của chi nhánh B005*/
SELECT branchNo,count (staffNo) as mycount
FROM Staff
group by branchNo
having count (staffNo)<(SELECT count (staffNo) as mycount
						FROM Staff
						where branchNo = 'B005'
						group by branchNo)
