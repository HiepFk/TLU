#include <iostream> 
#include <math.h> 
using namespace std;
int main()
{
unsigned long long int n;
cin>>n;
for (unsigned long long int i=0;i<n;i++){
	int x;
	cin>>x;
	for( int a=x;a>0;a=a-1){
		int s= (a+1)*((a-1)+2)/4;
		if ( s<x && a%2!=0){
		    cout<<a<<endl;
		    break;}
			       } 

		      }
}




