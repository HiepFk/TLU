#include<iostream>
using namespace std;
int kiemtra(int n){
	int x=0;
	for ( int i=1;i<n;i++){
		if (n%i==0)
		x=x+1;
		}
	if (x==1){return true ;}
	if (x!=1){return false;}		
		
}
int main()
{	int a;
	cin>>a;
	for (int n=a+1;n>0;n++){
	kiemtra(n);
	if (kiemtra(n)==true){cout<<n; break;}}
	
}

