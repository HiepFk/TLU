#include<iostream>
using namespace std;
int kiemtra(int n){
	int x=0;
	for ( int i=1;i<n;i++){
		if (n%i==0)
		x=x+1;
		}
	if (x==1){
		return true ;}
	if (x !=1){
		return false ;}
}
int main()
{	int n;
	cin>>n;
	if ( kiemtra(n)== false ){cout<<"0";}
	
	if ( kiemtra(n)== true ){
	while  (n!=0){
		n=n/10;
		if ( kiemtra(n)== true ){cout<<"1";break;}
		else {continue;}
	cout<<"1";}}
		
		    
}
		
			
