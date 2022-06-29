#include <iostream> 
#include <math.h> 
using namespace std; 
int main()
{
float a, b, c;
cout<<"Nhap 3 canh : ";
cin>>a>>b>>c;
if ( a+b<c || a+c<b || b+c<a ) 
{
cout<<"Ko ton tai tam giac"<<endl;
}
else 
{
float s=(a+b+c)/2;
cout<<"Dien tich tam giac : "<<sqrt(s*(s-a)*(s-b)*(s-c))<<endl;
}
}
