#include <iostream>
#include <string>
using namespace std;
int check1(int n ){
	int d=0;
	for ( int i=1; i<n; i++){
		if (n%i==0)
			d=d+1;}
		if (d==1){return 1;}
		else {return 0;}
}
int check2(int n){
	int b=0, c, d;
	c=n;
	while (n>0){
		d=n%10;
		b=b*10+d;
		n=n/10;	
		}
	if (b==c){return 1;}
	else {return 0;}
		
}
int main()
{
	int m,n,d=0;
	cin>>m;
	while(n!=0)
	{
	cin>>n;
	if ( check1(n)==1 && check2(n)==1){cout<<n<<endl;d=d+1;}
	else{cout<<"Try Agian"<<endl;}
	if (d==m){break;}
	}
}			

