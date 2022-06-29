#include<iostream>
#include<math.h>
using namespace std;
int check(int a,int b){
	int c= a+b;
	return c;
}
int main(){
	int a,b,n;
	cin>>n;
	for(int i=0;i<n;i++)
	{
	cin>>a>>b;
	cout<<check(a,b)<<endl;
	}
return 0;
}



