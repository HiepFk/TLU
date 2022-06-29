n=int(input('Nhap so:'))
flag=1
for i in range(2,n):
	if n%i==0:
		flag=0
	break
if flag==1 :
	print(str(n)+ ' la so nt')
else : 
	print(str(n)+ ' ko la so nt' )
