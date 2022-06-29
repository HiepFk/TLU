#include<iostream>
#include<math.h>
#include<string.h>
using namespace std;
int main()
{
long int a, c;
cin >> a;
cout<<0;
c = pow(2,a);
int bien[c];
for(int i=1; i<c; i++){
	bien[i]=i;}
for (int i=1; i<c;i++){
	string d;
	while(bien[i]> 0){
		d = char((bien[i] % 2) + 48) + d;
		bien[i] = bien[i] / 2;
	}
	cout<<d;}
	return 0;
}

