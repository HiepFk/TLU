use Hotels
EXEC sp_changedbowner 'sa'
--CASE STUDY 1:
/*For Exercises 6.7–6.28, use the Hotel schema defined at the start of the Exercises at the end of Chapter 4.
		Hotel (hotelNo, hotelName, city)
	 	Room (roomNo, hotelNo, type, price)
	 	Booking (hotelNo, guestNo, dateFrom, dateTo, roomNo)
	 	Guest (guestNo, guestName, guestAddress)
*/

--6.7	List full details of all hotels.
--6.7. Liệt kê chi tiết tất các khách sạn
select *
from Hotel
--6.8	List full details of all hotels in London.
--6.8. Hiện thị chi tiết tấ cả khách sạn ở London
select *
from Hotel
where city ='London'

--6.9	List the names and addresses of all guests living in London, alphabetically ordered by name.
--6.9. Hiển thị danh sách tên và địa chỉ của tất cả các khách ở London, sắp xếp theo tên
SELECT guestName ,guestAddress
FROM Guest
WHERE guestAddress LIKE '%London%'
ORDER BY guestName

--6.10	List all double or family rooms with a price below £40.00 per night, in ascending order of price.
--6.10. Hiện thị tất cả các phòng Double và Family có giá thuê dưới 40 EUR, SX tăng dần theo giá
select *
from Room
where (type ='Double' or type ='Family') and price < 40 
order by price
--6.11	List the bookings for which no dateTo has been specified.
-- 6.11. Liệt kê việc đặt phòng không có dateTo
select *
from Booking
where dateTo is null
--6.12	How many hotels are there?
--6.12. Có bao nhiêu khách sạn?
select count(*) as SoKS
from Hotel
--6.13	What is the average price of a room?
-- 6.13. Giá trung bình của khách sạn là bao nhiêu? 
select AVG(price)as GiaTB
from Room
--6.14	What is the total revenue per night from all double rooms?
-- 6.14. Tổng doanh thu hàng đêm của phòng Double
select SUM(price)as Tonggia
from Room
where type ='Double'
--6.15	How many different guests have made bookings for August?
--6.15. Có bao nhiêu khách hàng khác nhau đặt phòng trong tháng 8
select count(distinct guestNo) as SoKH
from Booking
where month(dateFrom) =8 --year, month, day
--6.16	List the price and type of all rooms at the Grosvenor Hotel
--6.16. Hiển thị giá và loại phòng của KS Grosvenor
--C1: chưa tối ưu
select price, type
from Hotel h inner join Room r on h.hotelNo=r.hotelNo
where hotelName = 'Grosvenor'
--C2: Tối ưu vì hạn chế được số lượng bản ghi trước khi kết nối
select price,type
from Room r inner join (
						Select hotelNo
						from Hotel
						where hotelName = 'Grosvenor'
						) as g
						on r.hotelNo=g.hotelNo
--6.17	List all guests currently staying at the Grosvenor Hotel.
--6.17. Liệt kê các khách hiện tại đang ở tại KS Grosvenor
SELECT guestNo, guestName, guestAddress
FROM Guest
WHERE guestNo = (SELECT guestNo
				 FROM Booking
				 WHERE dateFrom < getdate() AND dateTo >= getdate() AND  hotelNo = (SELECT hotelNo
																				    FROM Hotel
																				    WHERE hotelName = 'Grosvenor' ));

/*6.18	List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the
room is occupied.*/
/* 6.18. Liệt kê chi tiết tất cả các phòng ở KS Grosvenor gồm cả tên của khách đang ở tại phòng*/
select *
from guest as gu inner join
						 ( select * 
						   from Booking
						   where hotelNo IN (select hotelNo	
											 from Hotel
											 where hotelName ='Grosvenor')
						  ) as GH 
						  on gu.guestNo = gh.guestNo
														 

--6.19	What is the total income from bookings for the Grosvenor Hotel today?
-- 6.19. Tổng thu nhập từ việc đặt phòng ngày hôm nay của KS Grosvenor

select sum(price) as [Total income]
from Room
where hotelNo IN ( select hotelNo
				   from Booking 
				   where dateFrom =getdate() and hotelNo IN ( select hotelNo
															  from Hotel
															  where hotelName ='Grosvenor' ))

--6.20	List the rooms that are currently unoccupied at the Grosvenor Hotel.
-- 6.20. Liệt kê các phòng hiện tại không có người ở của KS Grosvenor
select *
from Room	
where hotelNo IN ( select hotelNo
				   from Hotel
				   where hotelName ='Grosvenor' ) and roomNo not in ( select roomNo
																	  from Booking 
																	  where (dateFrom <=getdate() and dateTo >=getdate()))


--6.21	What is the lost income from unoccupied rooms at the Grosvenor Hotel?
-- 6.21. Mất bao nhiêu thu nhập từ việc không đặt phòng tại KS Grosvenor? 
SELECT SUM(price) AS roma
FROM Room
WHERE roomNo IN(SELECT roomNo
				FROM Booking
				WHERE dateFrom <getdate() AND hotelNo= (SELECT hotelNo
														   FROM Hotel
														   WHERE hotelName='Grosvenor'));
--Grouping
--6.22	List the number of rooms in each hotel.
--6.22. Liệt kê số phòng cho mỗi KS
select h.hotelName,h.hotelNo,Tong
from Hotel as h inner join 
						(SELECT hotelNo ,COUNT(roomNo) AS Tong
						 FROM Room
						 GROUP BY hotelNo
						 ) as b
						 on h.hotelNo=b.hotelNo
ORDER BY Tong
--6.23	List the number of rooms in each hotel in London.
--6.23. Liệt kê số phòng cho mỗi KS ở London
SELECT hotelNo ,COUNT(roomNo) AS Tong 
FROM Room
WHERE hotelNo IN (SELECT hotelNo
				  FROM Hotel
				  WHERE city='London')
GROUP BY hotelNo
--6.24	What is the average number of bookings for each hotel in August?
--6.24. Trung bình số lần đặt phòng cho mỗi KS trong tháng 8 
select hotelNo,avg(solandat) as trungbinh
from  ( select hotelNo, count(roomNo) as solandat
		from Booking
		where month(dateFrom)=8
		group by hotelNo ) as T8
group by hotelNo

--6.25	What is the most commonly booked room type for each hotel in London?
-- 6.25. Loại phòng thường đặt cho mỗi KS ở London\
select hotelNo , max(solandat)
from ( 
				select hotelNo , type ,count(type) as solandat
				from 
							(select r.* 
							 from Room r inner join 
													(
													 select hotelNo , roomNo
													 from Booking 
													 where hotelNo in (
																		select hotelNo
																		from Hotel
																		where city ='London'
													)				   )
													  as ld
													 on r.roomNo= ld.roomNo ) as ld1 
													 group by hotelNo, type ) as SL 
													 group by hotelNo
--6.26	What is the lost income from unoccupied rooms at each hotel today?
-- 6.26. Thu nhập bị mất vì không đặt phòng cho mỗi KS ngày hôm nay?
select hotelNo, sum(price) as [lost income] 
from Room
where roomNo not in
(select roomNo
from Booking 
where dateFrom <='2020/06/06' and dateTo >='2020/06/06')
group by hotelNo

--6.27	Insert rows into each of these tables.
--6.27. Chèn các dòng cho mỗi bảng (chỉ cần chèn mỗi bảng 1 bản ghi)

--6.28	Update the price of all rooms by 5%.
--6.28. Cập nhật giá của các phòng tăng thêm 5%
