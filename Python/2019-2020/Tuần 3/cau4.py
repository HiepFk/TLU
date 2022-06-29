import math
import sys
a = int(sys.argv[1])
b = int(sys.argv[2])
c = int(sys.argv[3])
p=(a+b+c)/2

if a==b==c :
	print(' Tam giac deu')
	s=math.sqrt(p*(p-a)*(p-b)*(p-c))
	print('Dien tich tam giac: '+str(s))
else :
	if a**2+b**2==c**2 or b**2+a**2==c**2 or b*b+c*c==a*a:
		s=math.sqrt(p*(p-a)*(p-b)*(p-c))
		print(' Tam giac vuong')
		print('Dien tich tam giac: '+str(s))
	else :
		if a+b<=c or b+c<=a or a+c<=b :
			print(' khong ton tai tam giac')
		else :
			s=math.sqrt(p*(p-a)*(p-b)*(p-c))
			print(' tam giac thuong ')
			print('Dien tich tam giac: '+str(s))
