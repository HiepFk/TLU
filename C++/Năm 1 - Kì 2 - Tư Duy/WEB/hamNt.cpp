#include<iostream>
using namespace std;
int kiemtra(int n){
	int x=0;
	for ( int i=1;i<n;i++){
		if (n%i==0)
		x=x+1;
		}
	if (x==1){
		cout<<n<<" la so nguyen to"<<endl;}
	if (x !=1){
		cout<<"ko la so nguyen to"<<endl;}
}
int main()
{	int n;
	cin>>n;
	kiemtra(n);
	
}
		
			
