#include <iostream> 
#include <math.h> 
using namespace std;
int main()
{
	int n, i;
	cin>>n;
	for(i=n; i>0; i=i-1){
	if ( n%i==0){
		int d=0;
		for ( int x=1; x<i; x++){
			if (i%x==0)
				d=d+1;}
		if (d==1){
			cout<<i<<endl;
			break;	}	
				    
		    }
			      }
return 0;
}
