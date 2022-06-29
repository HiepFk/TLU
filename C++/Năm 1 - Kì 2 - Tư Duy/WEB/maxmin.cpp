#include<iostream>
#include<math.h>
using namespace std;
int ucln(int m,int n){
    int sodu;
    while (n != 0){sodu = m % n; m = n; n = sodu;}
    return m;
}
int main(){
	int m,n,d;
	cin>>d;
	for(int i=0;i<d;i++){
		cin>>m>>n;
		cout<<ucln(m,n)<<" "<<m*n/ucln(m,n)<<endl;}
}
