import sys
import math 

a = int(sys.argv[1])
b = int(sys.argv[2])
c = int(sys.argv[3])
d = int(sys.argv[4])
e = int(sys.argv[5])
h = math.sqrt((a-c)**2 + (b-d)**2)
if h<e :
	print('Point(' + str(a) + ',' + str(b) + ') thuoc duong tron')
else :
	if h>e :
		print('Point(' + str(a) + ',' + str(b) + ') ko thuoc duong tron')
	else :
		print('Point(' + str(a) + ',' + str(b) + ') nam tren duong tron')
