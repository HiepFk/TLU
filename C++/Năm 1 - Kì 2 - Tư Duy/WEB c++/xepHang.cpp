#include<iostream>
using namespace std;
int check(int k){
    int h=1;
    for(int i=1;i<k+1;i++)
    {h=h*i;}
    return h;
}
int main(){
    int a,b,n,s;
    cin>>n;
    int S=0;
    for(a=1;a<n;a++){
        for(b=1;b<(a+2);b++){
            if(a+b==n){s=check(a)*check(a)/check(a-b) +1;S=S+s;}
        }
    }
    cout<<S;
}