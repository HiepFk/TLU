#include<iostream>
#include<math.h>
using namespace std; int main()
{ 
	long int x, y, z, a=0, b=0, dem;
	cin >>x>>y>>z;
	for (int i=1; i<= z; i++){
	a=a+i;}
	b=x*a;
	if (y<=b) { 
	dem=b-y; 
	cout <<dem<<endl;}
	else{ 
	cout <<"0"<<endl;}
return 0;
}
