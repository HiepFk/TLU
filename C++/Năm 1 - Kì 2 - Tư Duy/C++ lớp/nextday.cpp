#include <iostream> 
#include <math.h> 
using namespace std;
int main()
{
int a, b, c;
cout<<"Nhap ngay thang nam : ";
cin>>a>>b>>c;
if (b==1 || b==3 || b==5 || b==7 || b==8 || b==10 || b==12){
	if (a==31 && b<12){
	cout<<1<<" "<<b+1<<" "<<c<<endl;}
	if (a<31) {
	cout<<a+1<<" "<<b<<" "<<c<<endl;}
	if (a==31 && b==12){
	cout<<"1 1 "<<c+1<<endl;}
	}
if (b==4 || b==6 || b==9 || b==11){
	if (a<30) {
	cout<<a+1<<" "<<b<<" "<<c<<endl;}
	if (a==30 && b<12){
	cout<<1<<" "<<b+1<<" "<<c<<endl;}
	if (a==30 && b==12){
	cout<<"1 1 "<<c+1<<endl;}
	}
if (c%4==0 && (c%400==0 || c%100 !=0 )){
	if (a<29) {
	cout<<a+1<<" "<<b<<" "<<c<<endl;}
	if (a==29 && b<12){
	cout<<1<<" "<<b+1<<" "<<c<<endl;}
	if (a==29 && b==12){
	cout<<"1 1 "<<c+1<<endl;}
	}
else{
	if (a<28) {
	cout<<a+1<<" "<<b<<" "<<c<<endl;}
	if (a==28 && b<12){
	cout<<1<<" "<<b+1<<" "<<c<<endl;}
	if (a==28 && b==12){
	cout<<"1 1 "<<c+1<<endl;}
	}	
} 
