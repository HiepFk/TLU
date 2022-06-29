#include<iostream>
using namespace std ; 
int main()
{
    int a , b ,c;
    cout<<"Nhap a : ";cin>>a;
    cout<<"Nhap b : ";cin>>b;
    c=a;
    a=b;
    b=c;
    cout<<" a : "<<a<<endl;
    cout<<" b : "<<b<<endl;
}