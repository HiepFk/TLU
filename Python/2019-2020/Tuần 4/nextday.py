import sys

a = int(sys.argv[1])
b = int(sys.argv[2])
c = int(sys.argv[3])
m =0
if b==1 or b==3 or b==5 or b==7 or b==8 or b==10 or b==12:
	m=31
else :
	if b==4 or b==6 or b==9 or b==11 :
		m=30
	else :
		if c%4==0 and (c%400==0 or c%100 !=0 ): 
			m=29
		else :
			m=28
if a<m:
	print(str(a+1)+' '+ str(b)+' ' + str(c))
else :
	if a==m and b<12:
		print('1 '+ str(b+1)+' ' +str(c)) 
	elif a==m and b==12: 
		print("1 1 " + str(c+1))

