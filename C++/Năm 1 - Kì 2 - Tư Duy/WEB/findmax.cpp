#include<iostream>
#include<math.h>
using namespace std;
int main()
{
	int n;
	cin>>n;
	int max[n];
	for(int i=0;i<n;i++){
	int a;
	cin>>a;
	max[i]=a;}
	int d=0;
	for(int j=0;j<n;j++){
	if (max[j]>d){d=max[j];}}
	cout<<d;
	
}
