#include<iostream>
using namespace std;
int main(){
	int a ;
	cin>>a;
	for (int b=a-1; b>1; b=b-1){
		int n=0;
		for ( int c=2;c<b;c++){
			if (b%c==0)
				n=n+1;
				break;}
		if (n==0){
			cout<<b<<endl;
		   break;}
			           }
return 0;
}
