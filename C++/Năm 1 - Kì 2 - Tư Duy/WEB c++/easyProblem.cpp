#include<iostream>
using namespace std;
int main()
{
    int n, m, S,x;
    cin>>x;
    for(int i=0;i<x;i++){
    cin>>n;
    S=0;
    m=1;
    do{
        m=m+2;
        S=S+m;
    }while(S+m<n);
    cout <<m<<endl;}
}