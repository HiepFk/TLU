#include<iostream>
using namespace std;
int main()
{
    float n, m, S;
    while(1){
    cin>>n;
    S=0;
    m=1;
    if(n>0){
    do{
        m=m+1;
        S=S+1/m;
    }while(S<n);
    cout <<m-1<<endl;}
    else{break;}}
}