a=int(input())

for i in range (a,0,-1):
	if a%i==0 :
		d=0 
		for n in range (1,i):
			if i%n==0:
				d=d+1
       		if d==1:
			print(i)
             		break
