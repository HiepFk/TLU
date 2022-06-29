a=float(input(' Moi ban nhap diem giua ki: '))
b=float(input(' Moi ban nhap diem cuoi ki: '))
c=int(input(' Moi ban nhap so buoi vang: '))
d=10-c
e=d*0.3 + a*0.7
f=e*0.3 + b*0.7
print(' Diem trung binh: ' +str(f))
if c>3 or e<4 :
	print (' Cam thi ')
else :
	if f>=9 :
		print('Ban xep hoc luc  Xuat sac')
	else :
		if f>=8 :
			print('Ban xep hoc luc  Gioi')
		else :
			if f>=6.5 :
				print('Ban xep hoc luc Kha')
			else :
				if f>=4 :
					print('Ban xep hoc luc Trung binh')
				else :
					print('Ban xep hoc luc  Kem')
