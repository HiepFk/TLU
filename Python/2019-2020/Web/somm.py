a=int(input())
x=a 
d=0
while a>0 : 
	r=a%10
	d=d+ r**3
	a=a//10 
if d==x : 
	print('1') 
else : 
	print('0') 
	
