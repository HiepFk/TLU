#include<iostream>
#include"list.h"
using namespace std;
int main()
{
    UngVien dm[100];
    int n ;
    cout<<"Moi nhap so ung vien : ";
    cin>>n;
    for(int i =0;i<n;i++)
    {   cout<<"Ung cu vien thu "<<i+1<<" : ";
        cin>>dm[i];}
    cout<<"     Danh sach Ung cu vien : "<<endl;
    for(int i=0;i<n;i++)
    {cout<<dm[i];} 
    timMax(dm,n);
}