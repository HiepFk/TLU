--6.16	List	the	price	and	type	of	all	rooms	at	the	Grosvenor	Hotel.
select price,type
from room
where hotelNo IN
	(
		select hotelNo
		from Hotel
		where hotelName ='Grosvenor'
	)
--6.17	List	all	guests	currently	staying	at	the	Grosvenor	Hotel.
select * 
from Guest
where guestNo IN	
	(select guestNo 
	from Booking
	where dateTo>='2020/06/06' and hotelNo IN 
						(
							select hotelNo
							from Hotel
							where hotelName ='Grosvenor'
						)
		
	)

--6.18	List	the	details	of	all	rooms	at	the	Grosvenor	Hotel,	including	the	name	of	the	guest	staying	in	the	room,	if	the room	is	occupied.
-- 6.18. Liệt kê chi tiết các phòng và tên khách hàng của KS Grosvenor đang được đặt
select hotelNo,roomNo,type,price,guestName
from guest as g inner join
	(
		select guestNo,B.roomNo,type,price, b.hotelNo
		from Booking as B inner join
			(
				select * 
				from Room
				where hotelNo IN
						(select hotelNo
						from Hotel
						where hotelName ='Grosvenor')
			) as GH 
			on B.roomNo = GH.roomNo
	) as BGH 
	on g.guestNo=BGH.guestNo

--6.19	What	is	the	total	income	from	bookings	for	the	Grosvenor	Hotel	today?
select sum(price) as [Total income]
from Room
where roomNo IN
	(
		select roomNo
		from Booking 
		where (dateFrom <='2020/06/06' and dateTo >='2020/06/06') 
					and hotelNo IN 
								(
									select hotelNo
									from Hotel
									where hotelName ='Grosvenor'
								)
	)
--6.20	List	the	rooms	that	are	currently	unoccupied	at	the	Grosvenor	Hotel.
select *
from Room	
where hotelNo IN
			(
				select hotelNo
				from Hotel
				where hotelName ='Grosvenor'
			)
	and roomNo not in
				(
					select roomNo
							from Booking 
							where (dateFrom <='2020/06/06' and dateTo >='2020/06/06') 
									and hotelNo IN 
													(
														select hotelNo
														from Hotel
														where hotelName ='Grosvenor'
													)
				)
--6.21	What	is	the	lost	income	from	unoccupied	rooms	at	the	Grosvenor	Hotel?
--Tự làm
--6.24	What	is	the	average	number	of	bookings	for	each	hotel	in	August?
-- 6.24. Số lượng trung bình đặt phòng cho mỗi khách sạn trong tháng 8
select hotelNo,avg(solandat) as trungbinh
from 
	(
		select hotelNo, count(roomNo) as solandat
		from Booking
		where month(dateFrom)=8
		group by hotelNo
	) as T8
group by hotelNo
--6.26	What	is	the	lost	income	from	unoccupied	rooms	at	each	hotel	today?
select hotelNo, sum(price) as [lost income] 
from Room
where roomNo not in
			(select roomNo
			from Booking 
			where dateFrom <='2020/06/06' and dateTo >='2020/06/06')
group by hotelNo
