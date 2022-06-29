#include<iostream>
using namespace std;
void hoanVi(int a,int b)
{
    int c=a;
    a=b;
    b=c;
}
int sapXep(int a[], int n)
{   
    int d=0;
    for(int i=0 ; i<n-1;i++){
        for (int j=i+1;j<n;j++){
            if(a[i]>a[j])
            { 
                hoanVi(a[i],a[j]);
                d=d+1;
            }
        }
    }
    return d;
}
int main()
{
    int k;
    cin>>k;
    for(int z=0;z<k;z++){
    int x;
    cin>>x;
    int a[x];
    for(int i=0;i<x;i++){
        int m;
        cin>>m;
        a[i]=m;
    }
    cout<<sapXep(a,x)<<endl;}
}