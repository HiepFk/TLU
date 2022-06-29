n=int(input('Nhap sp: '))
x=[]

for i in range(1,n+1):
	a=int(input()) 
	x.append(a) 
x=list(set(x)) 
print(x) 
