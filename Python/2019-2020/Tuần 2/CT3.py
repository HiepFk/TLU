import stdio
import sys
import math 

a =  float(sys.argv[1])
b =  float(sys.argv[2])
c = b + min(3,a)
d = a - max(0,b)
e = math.sqrt(2*a**c + 6*b**d)
f = abs(a*a - b**2**3)
g = e/f
stdio.writeln('BXK3CS100=' + str(g))

