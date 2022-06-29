--6.16	List the price and type of all rooms at the Grosvenor Hotel.
SELECT price , type
FROM Room 
WHERE hotelNo = ( SELECT hotelNo
				  FROM Hotel
				  WHERE hotelName = 'Grosvenor' );

--6.17	List all guests currently staying at the Grosvenor Hotel.
SELECT guestNo, guestName, guestAddress
FROM Guest
WHERE guestNo = (SELECT guestNo
				 FROM Booking
				 WHERE dateFrom < '2020/10/18' AND dateTo > '2020/10/18' AND  hotelNo = (SELECT hotelNo
																				     FROM Hotel
																				     WHERE hotelName = 'Grosvenor' ));

--6.18	List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the room is occupied.
SELECT a.roomNo , a.price, a.type , b.guestName
FROM Room a, Guest b , Hotel c , Booking d
WHERE b.guestNo = d.guestNo AND d.hotelNo = c.hotelNo AND d.dateFrom < '2020/10/18' AND d.dateTo > '2020/10/18' AND c.hotelName = 'Grosvenor';

--6.19	What is the total income from bookings for the Grosvenor Hotel today?
SELECT SUM(price)
FROM Room
WHERE hotelNo IN ( SELECT hotelNo
				   FROM Hotel
				   WHERE hotelName='Grosvenor' AND roomNo = ( SELECT roomNo
															  FROM Booking
															  WHERE dateFrom='2020/10/18'));
--6.20	List the rooms that are currently unoccupied at the Grosvenor Hotel.
SELECT roomNO , price , type
FROM Room 
WHERE roomNo = ( SELECT roomNo
				 FROM Booking
				 WHERE dateTo < '2020/10/18' and hotelNo= ( SELECT hotelNo
													      FROM Hotel
														  WHERE hotelName='Grosvenor'));

--6.21	What is the lost income from unoccupied rooms at the Grosvenor Hotel?
SELECT SUM(price) AS roma
FROM Room
WHERE roomNo IN(SELECT roomNo
				FROM Booking
				WHERE dateFrom <'2020/10/18' AND hotelNo= (SELECT hotelNo
														 FROM Hotel
														 WHERE hotelName='Grosvenor'));
--6.22	List the number of rooms in each hotel.
SELECT COUNT(type) AS roma ,hotelNo 
FROM Room
GROUP BY hotelNo
ORDER BY hotelNo;
--6.23	List the number of rooms in each hotel in London.
SELECT COUNT(type) AS roma ,hotelNo 
FROM Room
WHERE hotelNo IN (SELECT hotelNo
				  FROM Hotel
				  WHERE city='London')
GROUP BY hotelNo
ORDER BY hotelNo;
--6.24	What is the average number of bookings for each hotel in August?
SELECT AVG(price) AS roma ,b.hotelNo
FROM Booking a ,Room b
WHERE MONTH(a.dateFrom)=8 AND  a.roomNo =b.roomNo 
GROUP BY b.hotelNo 
ORDER BY hotelNo; 

--6.25	What is the most commonly booked room type for each hotel in London?
SELECT max(type), hotelNo
FROM Room
WHERE hotelNo IN ( SELECT hotelNo
				   FROM Hotel
				   WHERE city ='London')
GROUP BY hotelNo
ORDER BY hotelNo ;
--6.26	What is the lost income from unoccupied rooms at each hotel today
SELECT SUM(price) AS roma ,hotelNo
FROM Room
WHERE hotelNo IN(SELECT hotelNo
				 FROM Booking
				 WHERE dateFrom <'2020/10/18')
GROUP BY hotelNo
ORDER BY hotelNo ;
