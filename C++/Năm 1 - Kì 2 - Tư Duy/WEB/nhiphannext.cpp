#include<iostream>
#include <math.h>
using namespace std;
int main()
{
	long long int n;
	int p=0, s=0;
	cin>>n;
	while(n>0){
	s=s+(n%10) * pow(2, p);
	p=p+1;
	n=n/10;}
	//cout<<s<<endl;
	

	int a=s+1;
	long long b=0;
	int c=0;
	while(a>0){
	b=b+ (a%2) * pow(10,c);
	c=c+1;
	a=a/2;}
	cout<<b;	
}
