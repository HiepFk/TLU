#include<iostream>
#include <math.h>
using namespace std;
int main(){
    long long int n;
    cin>>n;
    int m= n/ pow(10,14);
    long long int s= pow(10,12);
    int d= m % s;
    if(d==0){cout<<"Dung";}
    if(d==1){cout<<"Nang";}
    if(d==10){cout<<"Lap dat";}
    if(d==1){cout<<"Di chuyen";}

}