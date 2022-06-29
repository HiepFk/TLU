#include"nguoiLon.h"
void nguoiLon::Input()
{
    // goi lai  nhap thong tin doc gia cua lop docGia 
    docGia::Input();
    cin.ignore();
    cout<<" Nhap so chung minh thu : ";
    cin>>cmt;
}
void nguoiLon::Output()
{
    docGia::Output();
    cout<<"\nSo chung minh thu : "<<cmt<<endl;;
}

int nguoiLon::tinhTien()
{
    return soThang * 10000;
}

nguoiLon::nguoiLon()
{}
nguoiLon::~nguoiLon()
{}