def soto(t):
	mg=[1,2,5,10,20,50,100,200,500]
	i=8
	while t>0 :
		if t>=mg[i] :
			print(str(t//mg[i]) +' to ' +str(mg[i]))
			t=t%mg[i]
		i=i-1

n=int(input('So tien: '))
soto(n)
