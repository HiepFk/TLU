#include<iostream>
using namespace std;
int main() 
{
	int n, d=0, x=2;
	cin>>n;	
	while (d<n) {
	int f=0;
	for ( int i =2; i<x; i++){
		if (x%i==0)
			f=1;		
		}
	if (f==0){
	d=d+1;
		if (d==n)
		break; 		
		}
	x=x+1;
		     }	
cout<<x<<endl;
}
