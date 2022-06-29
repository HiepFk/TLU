a=int(input()) 
t=a
x=0
n=0  
while a>0 : 
	a=a/10 
	n=n+1
for i in range(0,n+1) : 
	r=t//(10**(i)) 
	x=x+r
print(x)   
	
