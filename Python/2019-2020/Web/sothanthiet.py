a=int(input())
b=int(input())
x=0
y=0
for i in range(1,a): 
	if a%i==0 : 
		x=x+i 
for i in range(1,b): 
	if b%i==0 : 
		y=y+i 
if x==b and y==a: 
	print('YES')
else : 
	print('NO') 
