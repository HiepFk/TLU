use Booking
ALTER AUTHORIZATION ON DATABASE::Booking TO sa
--Câu 1
select * 
from Room 
where hotelNo in ( select hotelNo
					from Hotel
					where hotelName = 'Toby') 
--Câu 2 
select * 
from Booking
where MONTH(dateFrom) = 1 and (Year(dateFrom) = 2018 or  Year(dateFrom) = 2019 ) 

-- Câu 3 
select * 
from Guest
where guestNo not in ( select guestNo
						from Booking
						where hotelNo in ( select hotelNo
											from Hotel
											where city = 'Mesa' ))

-- Câu 4 
select * 
from Hotel
where city = 'Mesa ' or city = 'Lubbock'  and hotelNo not in ( select hotelNo
																from Booking )

-- Câu 5


-- Câu 6 

select g.guestNo , guestName , guestAddress , dateFrom , roomNo
from guest as g 
inner join ( select guestNo , dateFrom , roomNo
			 from Booking
			 where month(dateFrom) = 9 ) as b on b.guestNo = g.guestNo

--Câu 7 
select top(5) * 
from guest as g
inner join  ( select guestNo , count(guestNo) as soLuot
			  from Booking
	    	  group by guestNo) as b
					on g.guestNo = b.guestNo

-- Câu 8 

select  H.hotelNo , hotelName , soLanDat
from Hotel as H inner join (
							select hotelNo , count(roomNo) as soLanDat
							from Room
							where hotelNo	in ( select hotelNo
												 from Booking
												 where YEAR(dateFrom) = 2018) 
							group by hotelNo ) as k on k.hotelNo = H.hotelNo

 

-- Câu 9 danh sách khách hàng đặt phòng có giá rẻ nhất ở khách sạn ivan 
select g.guestNo,guestName ,guestAddress
from guest as g
inner join ( select guestNo , b.hotelNo
			 from Booking as b 
			 inner join (select h.hotelNo
						 from Hotel as h
						  inner join  ( select hotelNo, min(price) as giaMin
									    from Room
										group by hotelNo
										) as R on h.hotelNo = R.hotelNo
						 where hotelName = 'Ivan' ) 
			as k on k.hotelNo = b.guestNo) as m
		on m.guestNo = g.guestNo
									 
-- Câu 10 
		
						


