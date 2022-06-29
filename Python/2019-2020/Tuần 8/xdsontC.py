n=int(input(' Nhap so:'))
i=2
dem=0
while(i<n):
	if n%i==0 :
		dem=1
	i=i+1
if dem==0 :
	print(str(n)+' la so nt')
else :
	print(str(n)+' ko la so nt') 	
