m=int(input()) 
t=0 
for n in range(1,m)  : 
	s=(n+1)*((n-1)+1)/4
	if n%2 != 0 and s<m and n>=t:  
		t=n 
		print(t)
		 
		
		 
		
		
