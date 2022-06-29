n=int(input('Nhap so: '))
x=0
while n//10 !=0 :
	
	x=x+n%10
	n=n//10
x=x+n
print(x)
