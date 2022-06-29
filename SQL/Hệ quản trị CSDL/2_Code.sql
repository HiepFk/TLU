Declare @age int ;
Declare @fristName char(20) ,@middleName char(20), @lastName char(20);
set @age = 20;
select @fristName = 'Nguyen' , @middleName = 'Huy' , @lastName ='Hiep' 
select @fristName , @middleName , @lastName , @age;
print @fristName +' ' + @middleName +' ' +  @lastName;

Go
--Biển số xe if else 
DECLARE @city char(15) , @bienSo char(20)
set @city = 'Thai Binh'
if @city = 'Thai Binh'
SET @bienSo = 17
ELSE
SET @bienSo = 'Unknow'
SELECT @bienSo AS BienSo

Go
-- Vòng lặp 
DECLARE @counter INT ,  @text1 char(5) , @text2 char(5);
SElect  @counter=1  , @text1 ='Hi' , @text2 = 'Ho';
WHILE @counter <= 6
BEGIN
	if @counter % 2 = 1
	PRINT @text1 
	else
	print @text2
	select @text1 
	SET @counter=@counter+1
END

