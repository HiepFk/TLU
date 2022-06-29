#include<iostream>
#include<math.h>
using namespace std;
int ucln(int m,int n){
    int sodu;
    while (n != 0){sodu = m % n; m = n; n = sodu;}
    return m;
}

int main()
{
	int a ;
	cin>>a;
	for ( int i=0;i<a;i++)	
	{
	int m, n;
	cin>>m>>n;
	if(n>0){
	ucln(m,n);
	cout<<m/ucln(m,n)<<"/"<<n/ucln(m,n)<<endl;}
	if(n==0){cout<<"1"<<"/"<<"0"<<endl;}}
return 0;
}
