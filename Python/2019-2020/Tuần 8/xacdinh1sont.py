n=int(input('Hay nhap so n:'))
count =0;
for i in range (1,n+1) :
	if n%i==0:
		count=count+1
if count==2:
	print(n, 'la so nguyen to')
else :
	print(n, 'khong la so nguyen to')
