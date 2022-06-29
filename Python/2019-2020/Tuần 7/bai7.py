a=[1,2,4,6,8,9,10]
b=[2,4,6,8,9,11,13,125]
a.extend(b)
a=list(set(a))
print a  
