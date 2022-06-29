a=float(input())
b=float(input())
c=a/(b*b) 

if c>25 : 
	print('Overweight') 
else : 
	if 18.5<= c <= 25 : 
		print('Normal weight') 
	elif c<18.5 : 
		print('Underweigh') 
