def soto(t):
	m=[1,5,10,20,100]
	i=4	
	st=0
	while t>0 :
		if t>=m[i]:
			st=st+t//m[i]
			t=t%m[i]
		i=i-1
	return(st)
x=int(input())
print(soto(x))
