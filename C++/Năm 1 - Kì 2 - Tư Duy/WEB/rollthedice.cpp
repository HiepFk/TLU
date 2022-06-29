#include<iostream>
#include<math.h>
using namespace std;
int main()
{
	long long a,b,c,d=0;
	cin>>a>>b>>c;
	for (int i=1;i<a+1;i++){
	 for(int j=b;j>0;j=j-1){
		if(i+j==c){d=d+1;}
	}} 
if(d>0){cout<<"There are "<<d<<" ways to get the sum "<<c;}
if(d==0){cout<<"No way";}
}
