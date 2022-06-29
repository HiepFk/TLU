import stdio
import sys 
import math 
a=float(sys.argv[1])
pi = 3.14
b= math.sin(a/2)**2
c= math.cos(3*pi/2 + a/2)
d= math.cos(a/2)
e= 3*b*c + 3*b*d
stdio.writeln(str(e))
