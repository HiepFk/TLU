#include<iostream>
#include"thuVien.h"
using namespace std; 
int main()
{
    thuVien *x = new thuVien;
    x->Input();
    x->Output();
    //cout<<"Tong tien"<<x->tinhTientb();

    delete x; // giải phóng con trỏ
	return 0;
}