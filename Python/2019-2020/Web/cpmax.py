import math
a=int(input())
m=0 
if a>1 :
	for i in range (a,0,-1):
		d=int(math.sqrt(i))
		if i==d**2 :
			m=i
			break
print(m)
