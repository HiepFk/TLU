a=int(input())
for i in range(a,0,-1):
	b=0
	for n in range(1,i):
		if i%n==0:
			b=b+n
	if i==b :
		print(i)
		break 
	
