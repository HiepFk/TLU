#include <iostream>
#include "date.h"
#include "sv.h"
#include "string.h"
using namespace std ; 

int main() {
  //SinhVien sv("Nguyen Huy Hiep",12,8,2001,8,7,8);
    SinhVien sv[100];
    int n ; 
    cout<<"So luong so sv : ";
    cin>>n;
    for(int i =0;i<n;i++)
        {   
            cout<<"Ho ten sv thu "<<i+1<<" la : ";
            cin>>sv[i];}
    cout<<"Danh sach sv : "<<endl;
    for(int i =0;i<n;i++)
        {cout<<sv[i];}

    xapSep(sv,n);
    cout<<"Danh sach sv da sap xep : "<<endl;
    for(int i=0;i<n;i++)
        {cout<<sv[i];}
    


}