#include<iostream>
#include<math.h>
using namespace std;
int check(int n){
    int d=0;
    for ( int x=1;x<sqrt(n+1);x++){
        if(n%x==0){d=d+1;}
    } return d;
}
int main()
{
    int n;
    cin>>n;
    int s =0;
    for(int i=1;i<n+1;i++){
        s = s + check(i);
    }
    cout<<s<<endl;
}