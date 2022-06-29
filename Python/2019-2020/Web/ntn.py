n=int(input())
d=0
x=2
while d<n : 
	f= 0  
	for i in range (2,x) : 
		if x%i==0 : 
			f=1
	if f == 0:
		d=d+1
		if d==n: 
			break 
	x=x+1
print(x)
