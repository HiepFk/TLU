#include <iostream>
using namespace std;
int main(){
	int n, i, j ;
	cout<<"Nhap cap : ";
	cin>>n;
for(i=1; i<n+1; i++){
	for(j=1; j<2*n; j++){
		if ((j>=n-i+1) &&(j<=n+i-1)){
		cout<<"*";}
		else{
		cout<<" ";}
	}
	cout<<endl;
}
}

