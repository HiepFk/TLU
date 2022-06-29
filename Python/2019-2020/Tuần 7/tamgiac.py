n=int(input('Nhap n: ' ))
x=' '
y='*'
for i in range (n,0,-1) : 
	print(((n-i)*y+y)+(i*x))
