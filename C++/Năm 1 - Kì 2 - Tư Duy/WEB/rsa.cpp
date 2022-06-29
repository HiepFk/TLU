#include<iostream>
#include <math.h>
using namespace std;
int check(int i)
{
	int  n;
	n=0;
	for (int j=1; j<i+1; j++){
	if (i%j==0){n=n+1;}}
return n;
}
int main(){
	int a,b,d=0;
	cin>>a>>b;
	for(int i=a;i<b+1;i++)
	{	
		if ( check(i)==4)
		{d=d+1;}
	}
	cout<<d<<endl;;
}
