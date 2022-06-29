/* Câu 1: Cho biết thông tin tác giả (authors) ở thành phố ‘Menlo Park’ đã xuất bản sách */
SELECT *
FROM authors
where city ='Menlo Park'

/*Câu 2: Cho biết thông tin nhà xuất bản (publishers) ở USA đã xuất bản những quyển sách giá trên 10 đô.*/
SELECT *
FROM publishers
where country = 'USA' and pub_id in (select pub_id
									 from titles
									 where price > 10 and title_id in (select title_id
																	   from sales))

/*Câu 3: Cho biết thông tin và tổng tiền (price*qty) theo từng quyển sách*/
SELECT t.title_id , title ,type , sum (t.price * s.qty) as tongtien
FROM titles as t inner join sales as s
					on t.title_id = s.title_id
group by t.title_id , title ,type


/*Câu 4: Cho biết danh sách kho (stores) và tổng số lượng bán (qty) những quyển sách của mã nhà xuất bản (pub_id) là ‘0877’*/
SELECT *
FROM stores
where stor_id in
				(
				select stor_id
				from sales
				where title_id in 
									(
									select title_id
									from titles
									where pub_id = '0877'
									)
				)

/*Câu 5: Cho biết danh sách nhà xuất bản có tổng tiền trung bình (qty*price) cao hơn tổng tiền trung bình của tất cả các nhà xuất bản*/
select max(D.myD) as mymax
from
(SELECT p.*,B.myavg as myD
FROM publishers p inner join 
				(select a.pub_id,avg(a.price*b.qty) as myavg
				from titles a inner join sales b on a.title_id=b.title_id
				group by a.pub_id)as B on p.pub_id=B.pub_id
group by p.pub_id,p.pub_name,p.city,p.country,p.state,B.myavg) as D

/*Câu 6: Cho biết thông tin nhà xuất bản (publishers) không xuất bản quyển sách nào trong năm 1991*/
SELECT *
FROM publishers
where pub_id not in(select pub_id
					from titles
					where YEAR(pubdate)='1991'
					)

/*Câu 7: Cho biết danh sách 10 quyển sách bán chạy (có số lượng bán nhiều nhất) trong năm 1991 của nhà xuất bản ‘New Moon Books’*/
select Distinct a.title
from titles a 
where year(pubdate)='1991' and pub_id in (select pub_id
										  from publishers
										  where pub_name='New Moon Books')

/*Câu 8: Cho biết thông tin tác giả ở thành phố ‘Oakland’ và số lượng sách đã bán trong năm 1991*/

select a.*,sum(b.solgsach)
from authors a,(select  a.title_id ,sum(qty) as solgsach
				from sales a,titleauthor b
				where YEAR(ord_date)='1994' and a.title_id=b.title_id
				group by a.title_id) as b
where city='Oakland' 
group by a.au_id,a.au_fname,a.au_lname,a.address,a.city,a.contract,a.phone,a.state,a.zip


/*Câu 9: Cho biết thông tin quyển sách (titles) và tổng số lượng bán của từng quyển sách trong từng năm */
select B.title_id,B.title,B.type,B.pub_id,B.price,B.advance,B.royalty,B.ytd_sales,B.notes,B.pubdate,B.myyear,sum(B.qty) as tongsoluong
from
(SELECT t.*,s.qty,year(ord_date) as myyear
FROM titles t,sales s
where t.title_id=s.title_id) as B
group by B.myyear,B.title_id,B.title,B.type,B.pub_id,B.price,B.advance,B.royalty,B.ytd_sales,B.notes,B.pubdate

/*Câu 10: Cho biết danh sách tác giả ở thành phố ‘Oakland’ có nhiều đầu sách xuất bản trong năm 1991 nhất*/
SELECT a.*,MAX(d.Max)
FROM authors a,(select c.title_id,max(royalty)as Max
				from titles c,titleauthor b
				where YEAR(pubdate)='1991' and c.title_id=b.title_id
				group by c.title_id) as d
where city ='Oakland'
group by a.au_id,a.au_fname,a.au_lname,a.address,a.city,a.contract,a.phone,a.state,a.zip


