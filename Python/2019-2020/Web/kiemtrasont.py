a=int(input())
d=0
if a>=2:
	for i in range (1,a):
		if a%i==0:
			d=d+1
        if d==1:
		print(1)
        else:
                print(0)
else:
        print(0)
