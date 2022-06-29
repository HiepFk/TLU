n=int(input('Nhap sp: '))
x=[]

for i in range(1,n+1):
	a=int(input())
	if a%2==0 : 
		x.append(a) 

print(x)
print(sum(x))  
