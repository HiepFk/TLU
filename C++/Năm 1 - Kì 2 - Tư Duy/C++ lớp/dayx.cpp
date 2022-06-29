#include <iostream>
using namespace std;
int main(){
int a, b, c, x, n;
cout<<"Nhap so so hang : ";
cin>>n;
a=2;
b=2;
for(x=1; x<n+1; x++){
cout<<a<<endl;
c=a+b;
b=a;
a=c;
}
}
