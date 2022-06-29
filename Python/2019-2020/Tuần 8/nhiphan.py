n=int(input('Nhap so:'))
x=""
while(n>0):
	r=n%2
	n=n//2
	x=str(r) + x
print('ket qua la '+x)
