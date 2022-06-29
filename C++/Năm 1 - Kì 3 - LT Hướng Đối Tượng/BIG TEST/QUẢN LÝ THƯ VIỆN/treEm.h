#pragma once
#include<iostream>
#include<string.h>
#include"docGia.h"
using namespace std;

class treEm : public docGia    // tre em ke thua lop doc gia 
{
    private : 
        string daiDien;
    public : 
        treEm();
        ~treEm();
        void Input();
        void Output();
        int tinhTien();
        
};