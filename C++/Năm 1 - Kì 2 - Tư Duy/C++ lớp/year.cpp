#include <iostream> 
#include <math.h> 
using namespace std; 
int main()
{
int a, b, c;
cout<<"Nhap ngay thang nam : ";
cin>>a>>b>>c;
if (b==1 || b==3 || b==5 || b==7 || b==8 || b==10 || b==12)
{
int d=31;
cout<<d<<endl;
}
if (b==4 || b==6 || b==9 || b==11)
{
int d=30;
cout<<d<<endl;
}
if (c%4==0 && (c%400==0 || c%100 !=0 ))
{
int d=29;
cout<<d<<endl;
}
else
{
int d=28;
cout<<d<<endl;
}
}
