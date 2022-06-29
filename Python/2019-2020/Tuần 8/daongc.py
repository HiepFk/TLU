n=int(input('Nhap so: '))
t=''
while n!=0 :
	r=n%10
	t=t+str(r)
	n=n//10 
print(t)
