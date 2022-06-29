#include<iostream>
#include<math.h>
using namespace std;
int check1(unsigned long long int a)
{	int d;
	while (a>0)
	{
	d=a%10;
	a=a/10;
	if((d==4) || (d==7)){continue ;}
	}cout<<d;
	if((d==4) || (d==7)){return true ;}
	if ((d!=4) || (d!=7)){return false;}
		
}
int check2(int x)
{
	if(x%4==0){return true;}
	if(x%7==0){return true;}
	if((x%4!=0) && (x%7!=0)){return false;}
	
}
int main()
{
	unsigned long long int a;
	cin>>a;
	if(check1(a)==false && check2(a)==false){cout<<"NO";}
	else {cout<<"YES";}
}
