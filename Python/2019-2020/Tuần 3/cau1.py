import sys

a = int(sys.argv[1])
b = int(sys.argv[2])
c = int(sys.argv[3])
d = int(sys.argv[4])
if a>b and a>c and a>d :
	print(str(a))
else:
	if b>a and b>c and b>d :
		print(str(b))
	else:
		if c>a and c>b and c>d :
			print(str(c))
		else :
			print(str(d)) 
