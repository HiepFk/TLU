n=int(input('Nhap so: '))
a=n 
t=0
while n!=0 :
	r=n%10
	t=t*10 + r
	n=n//10 

if t==a :
	print(str(a)+' la so doi xung')
else :
	print(str(a)+' ko la so doi xung') 
