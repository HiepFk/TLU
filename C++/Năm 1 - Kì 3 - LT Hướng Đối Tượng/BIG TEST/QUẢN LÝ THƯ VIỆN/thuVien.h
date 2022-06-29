#pragma once
#include<iostream>
#include"treEm.h"
#include"nguoiLon.h"
#include<vector>
class thuVien
{
    private : 
        vector<treEm> ds_treEm;
        vector<nguoiLon> ds_nguoiLon;
    public: 
        thuVien();
        ~thuVien();
        void Input();
        void Output();
        int tinhTientb();
        
};