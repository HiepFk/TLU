def soto(t):
	m=[1,2,5,10,20,50,100,200,500]
	i=8	
	st=0
	while t>0 :
		if t>=m[i]:
			st=st+t//m[i]
			t=t%m[i]
		i=i-1
	return(st)

x=int(input('So tien: '))
print(soto(x))


