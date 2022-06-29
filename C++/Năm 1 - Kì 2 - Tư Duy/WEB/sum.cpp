#include<iostream>
using namespace std;
int check(int a )
{
	int b=0, c, d;
	c=a;
	while (a>0){
		d=a%10;
		b=b*10+d;
		a=a/10;	}
	return b;
}
int main()
{	int n;
	cin>>n;
	for(int i=0;i<n;i++)
	{
	int x,y,S;
	cin>>x>>y;
	S=check(x) + check(y);
	cout<<check(S)<<endl;
	}
}
