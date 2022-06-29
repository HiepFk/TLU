n=int(input('Nhap so:'))
b=1
for i in range(2,n):
	if n%i==0:
		b=0
	break
print(b)
