#pragma once
#include<iostream>
#include<string.h>
using namespace std;
class docGia // lop cha 
{   
    protected:
        string hoTen; 
        string date; //     d/m/y
        int soThang;
    public: 
        docGia();
        ~docGia();
        void Input();
        void Output();
};