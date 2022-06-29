#pragma once
#include<iostream>
#include<string.h>
#include"docGia.h"
using namespace std;

class nguoiLon : public docGia    // tre em ke thua lop doc gia 
{
    private : 
        int cmt;
    public :
        nguoiLon();
        ~nguoiLon(); 
        void Input();
        void Output();
        int tinhTien();
        
};