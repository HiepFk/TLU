#include"docGia.h"
using namespace std;
void docGia::Input()
{   cin.ignore();
    cout<<" Nhap ho ten doc gia : ";
    getline(cin,hoTen);
    cout<<" Moi nhap date : ";
    getline(cin , date); // ngay thang nam 
    cout<<" Moi nhap so thang : ";
    cin>>soThang;
}
void docGia::Output()
{
    cout<<"\nHo ten : "<<hoTen;
    cout<<"\nNgay lap the : "<<date;
    cout<<"\nSo thang co hieu luc : "<<soThang;
}
docGia::docGia()
{}
docGia::~docGia()
{}