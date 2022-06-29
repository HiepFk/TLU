import sys

a = int(sys.argv[1])
b = int(sys.argv[2])
c = int(sys.argv[3])
d = int(sys.argv[4])
x = a*a + b*b 
y = c*c + d*d 
if x>y : 
	print('Point('+str(a)+','+str(b)+ ') cach xa goc toa do hon Point(' + str(c)+','+str(d)+')')
else : 
	if x<y : 
		print('Point('+str(c)+','+str(d)+ ') cach xa goc toa do hon Point(' + str(a)+','+str(b)+')')
	else : 
		print('Point('+str(a)+','+str(b)+ ') va Point('+str(c)+','+str(d)+') co cung khoang cach toi goc toa do')
