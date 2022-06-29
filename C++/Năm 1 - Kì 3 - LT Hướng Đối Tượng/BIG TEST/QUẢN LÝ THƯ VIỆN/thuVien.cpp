#include"thuVien.h"
using namespace std;

void thuVien::Input()
{   int luaChon;
    while(true)
    {   
        system("cls");
        cout<<"      THU VIEN"<<endl;
        cout<<" 1 . Doc gia tre em "<<endl;
        cout<<" 2 . Doc gia nguoi lon "<<endl;
        cout<<" 0 . Thoat"<<endl;
        cout<<"          END"<<endl;
        cout<<" Nhap lua chon : ";
        cin>>luaChon;
        if(luaChon==1)
        {
            treEm x ;// khai bao doi tg - de nhap 
            cout<<" Nhap thong tin :"<<endl;
            x.Input();
            ds_treEm.push_back(x); // them doi tg vao trong mang tg ung
        }
        else if(luaChon==2)
        {
            nguoiLon x ;// khai bao doi tg - de nhap 
            cout<<" Nhap thong tin :"<<endl;
            x.Input();
            ds_nguoiLon.push_back(x);
        }
        else if( luaChon!=1 && luaChon!=2)
        {
            break;
        }
    }
};

void thuVien::Output()
{
    // xuat ds tre em 
    cout<<"     Danh sach doc gia tre em"<<endl;
    for(int i=0;i<ds_treEm.size();i++)
    {
        cout<<"   Thong tin doc gia tre em thu "<<i+1;
        ds_treEm[i].Output();
    }
    // xuat ds nguoi lon 
    cout<<"      Danh sach doc gia nguoi lon"<<endl;
    for(int i=0;i<ds_nguoiLon.size();i++)
    {
        cout<<"   Thong tin doc gia nguoi lon thu "<<i+1;
        ds_nguoiLon[i].Output();
    }
};
int thuVien::tinhTientb()
{   
    int sum =0;
    // ds tre em 
    for(int i=0;i<ds_treEm.size();i++)
    {
        sum=sum+ ds_treEm[i].tinhTien();
    }
    // ds nguoi lon 
    for(int i=0;i<ds_nguoiLon.size();i++)
    {
        sum = sum + ds_nguoiLon[i].tinhTien();
    }
    return sum ; 
};

thuVien::thuVien()
{};
thuVien::~thuVien()
{};