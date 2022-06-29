/* Câu 1: Cho biết thông tin tác giả (authors) ở thành phố ‘Menlo Park’ đã xuất bản sách */
SELECT *
FROM authors
WHERE city = 'Menlo Park' and au_id in (select distinct au_id
										from titleauthor)

/*Câu 2: Cho biết thông tin nhà xuất bản (publishers) ở USA đã xuất bản những quyển sách giá trên 10 đô.*/
SELECT *
FROM publishers
WHERE country = 'USA' and pub_id in (select pub_id
									 from titles
									 where price > 10)

/*Câu 3: Cho biết thông tin và tổng tiền (price*qty) theo từng quyển sách*/
--C1:
SELECT t.title_id,title,type,pub_id, sum(price*qty) as tongtien
FROM titles t inner join sales s
	on t.title_id = s.title_id
group by t.title_id,title,type,pub_id
--C2: 
select *
from titles as t inner join 
		(select title_id,sum(qty)as soluong
		from sales
		group by title_id) as sl
	on t.title_id = sl.title_id
/*Câu 3: Cho biết thông tin và tổng tiền (price*qty) theo từng quyển sách đã bán trong năm 1994*/
select t.title_id,title,type,pub_id, sum(price*qty) as tongtien
from titles as t inner join 
		(select *
		from sales
		where YEAR(ord_date)=1994) s1
	on t.title_id = s1.title_id
group by t.title_id,title,type,pub_id
/*Câu 4: Cho biết danh sách kho (stores) và tổng số lượng bán (qty) 
--những quyển sách của mã nhà xuất bản (pub_id) là ‘0877’*/
select s.*,tongSLsach
from stores as s inner join 
		(select stor_id, sum(qty) as tongSLsach
		from sales
		where title_id IN
				(select title_id
				from titles
				where pub_id = '0877') 
		group by stor_id) as s1
	on s.stor_id = s1.stor_id
/*Câu 5: Cho biết danh sách nhà xuất bản có tổng tiền trung bình (qty*price) 
--cao hơn tổng tiền trung bình của tất cả các nhà xuất bản*/
select p.*,tongtien
from publishers as p inner join
	(select pub_id, avg(qty*price) as tongtien
	from titles as t inner join sales as s on t.title_id=s.title_id
	group by pub_id
	having avg(qty*price) >
						(select avg(qty*price) as tongtien
						from titles as t inner join sales as s on t.title_id=s.title_id)) as p1
on p.pub_id = p1.pub_id
/*Câu 6: Cho biết thông tin nhà xuất bản (publishers) không xuất bản quyển sách nào trong năm 1991*/
SELECT *
FROM publishers
WHERE pub_id not in ( select distinct pub_id
				  from titles
				  where year(pubdate) =1991)

/*Câu 7: Cho biết danh sách 10 quyển sách bán chạy (có số lượng bán nhiều nhất) 
--trong năm 1991 của nhà xuất bản ‘New Moon Books’*/
select top 10 s1.title_id,title,sum(qty) as Tongsach
from sales s inner join 
				(select title_id,title
				from titles
				where pub_id =	(SELECT pub_id
									FROM publishers
									where pub_name = 'New Moon Books')) as s1
			on s.title_id = s1.title_id
where year(ord_date)=1994
group by s1.title_id,title
order by Tongsach desc

/*Câu 8: Cho biết thông tin tác giả ở thành phố ‘Oakland’ và số lượng sách đã bán trong năm 1994*/
--C1:
select *
from 
		(select *
		from titleauthor
		where au_id IN 
						(select au_id
						from authors
						where city='Oakland')) as o
				inner join 
						(select title_id, sum(qty) as tongSL
						from sales
						where year(ord_date)=1994
						group by title_id) as s
				on o.title_id = s.title_id

--C2:
SELECT a.au_id,au_lname,au_fname,phone,address,city,ta.qty
FROM authors a inner join 
				(select au_id, ts.qty
				from titleauthor ti inner join
									( select t.title_id, sum(qty)as tongSL
									from titles t inner join sales s
										on t.title_id = s.title_id
									where year(pubdate) = 1991
									group by t.title_id, qty) as ts
					on ti.title_id = ts.title_id
				) as ta
		on a.au_id = ta.au_id
where city = 'Oakland'
group by a.au_id,au_lname,au_fname,phone,address,city,ta.qty

/*Câu 9: Cho biết thông tin quyển sách (titles) và tổng số lượng bán của từng quyển sách trong từng năm */
select *
from titles as t inner join 
		(select title_id, year(ord_date) as nam, sum(qty) as tongSL
		from sales
		group by title_id,year(ord_date)) as o
	on t.title_id = o.title_id


/*Câu 10: Cho biết danh sách tác giả ở thành phố ‘Oakland’ có nhiều đầu sách xuất bản trong năm 1991 nhất*/
SELECT a.au_id,au_fname,au_lname,city,tongdausach
FROM authors a inner join ( select au_id,count(t.title_id) as tongdausach
							from titleauthor ta inner join titles t
								on ta.title_id = t.title_id
							where pubdate like '%1991%'
							group by au_id ) as tt
	on a.au_id = tt.au_id
WHERE city = 'Oakland'
GROUP BY a.au_id,au_fname,au_lname,city,tongdausach
