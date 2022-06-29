UPDATE Hotel set city ='London' where city = 'San Jose'
--6.7	List	full	details	of	all	hotels
SELECT *
FROM Hotel
-- 6.8	List full details of all hotels	in	London
SELECT *
FROM Hotel
WHERE city ='London'
-- 6.9	List the names and addresses of	all	guests	living	in	London,	alphabetically	ordered	by	name
SELECT guestName ,guestAddress
FROM Guest
WHERE guestAddress LIKE '%London%'
ORDER BY guestName
-- 6.10	List	all	double	or	family	rooms	with	a	price	below	£40.00	per	night,	in	ascending	order	of	price
SELECT roomNo, type , price 
FROM Room
WHERE type='Double'or type ='Family' and price <4000

-- 6.11 List	the	bookings	for	which	no	dateTo	has	been	specified
SELECT *
FROM Booking
WHERE dateTo IS NULL 
-- 6.12	How many hotels	are there? 
SELECT COUNT(*) AS mycount
FROM Hotel

-- 6.13	What	is	the	average	price	of	a	room
SELECT SUM(price) / COUNT(*) AS TBmoney 
FROM Room 

-- 6.14	What	is	the	total	revenue	per	night	from	all	double	rooms? 
SELECT SUM (price)
FROM Room
WHERE type = 'double'

-- 6.15 How many different guests have made bookings for August?
SELECT COUNT(guestNo)
FROM Booking
WHERE MONTH(dateFrom) = 8 
