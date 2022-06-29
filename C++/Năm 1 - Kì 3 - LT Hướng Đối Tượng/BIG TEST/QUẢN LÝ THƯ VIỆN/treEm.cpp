#include"treEm.h"
void treEm::Input()
{
    // goi lai  nhap thong tin doc gia cua lop docGia 
    docGia::Input();
    cin.ignore();
    cout<<" Nhap ten nguoi dai dien : ";
    getline(cin,daiDien);
}
void treEm::Output()
{
    docGia::Output();
    cout<<"\nHo ten nguoi dai dien : "<<daiDien<<endl;
}

int treEm::tinhTien()
{
    return soThang * 5000;
}
treEm::treEm()
{}
treEm::~treEm()
{}