#include <iostream>
#include <fstream>
#include <string.h>
#include<iomanip>

using namespace std;


string hoten[500];
string soDienThoai[500];
int dem = 0;

 void printMenu();

 void themLienHe() {
     cout << "\n Moi nhap ho ten: " ;
     cin.ignore();
     getline(cin, hoten[dem]);
     cout << "\n Moi nhap so dien thoai:";
     getline(cin, soDienThoai[dem]);
     dem += 1;

     printMenu();
 }

 void xemDanhBa() {
     cout <<"\n" << setw(10) << "STT" << setw(22) << "Ho ten" << setw(12) << "SDT";
     for(int i =0; i < dem; i++) {
         cout <<"\n" << setw(10) << i+1 << setw(22) << hoten[i] << setw(12) << soDienThoai[i];
     }

    int x;
    cin >> x;
    printMenu();
      
 }

 void xoaLienHe() {
    cout << "ban muon xoa lien he thu may: "; 
    int x;
    cin >> x;
    x = x - 1;

    for (int i = x; i < dem; i ++)  
    {
        hoten[i] = hoten[i+1]; 
        soDienThoai[i] = soDienThoai[i+1];
    }
    dem -= 1;

    printMenu();
 }


 void timLienHe() { 
     cout << "Moi nhap ten:";
     string ten;
     cin.ignore();
     getline(cin, ten);
     
     for(int i = 0; i < dem; i++) {
         if (hoten[i].find(ten) != string ::npos) {
             cout << "\n tim thay :" << hoten[i] << "  sdt: " << soDienThoai[i];
         }
     }
    int x;
    cin >> x;
    
    printMenu();

 }
 
 void suaLienhe() { 
     cout << "Moi nhap ten:";
     string ten;
     cin.ignore();
     getline(cin, ten);
     cout<<"Nhap so moi:";
     string a;
     cin>>a;
     for(int i = 0; i < dem; i++) {
         if (hoten[i].find(ten) != string ::npos) 
	   soDienThoai[i]= a;    
     }
    int x;
    cin >> x;
    printMenu();
 }

 void printMenu() {
    system("CLS");

    cout<<"\t1. Them lien he\n";
    cout<<"\t2. Hien thi toan danh ba\n";
    cout<<"\t3. Sua lien he\n";
    cout<<"\t4. Xoa lien he\n";
    cout<<"\t5. Tim lien he\n";
    cout<<"\t6. Thoat\n";
    cout<<"\tMoi chon chuc nang: ";	
    int select ;
    cin >> select;
    if (select == 1) {
        themLienHe();
    }
    if (select == 2) {
        xemDanhBa();
    }
    if (select == 3) {
        suaLienhe();
    }
    if (select == 4) {
        xoaLienHe();
    }
    if (select == 5) {
        timLienHe();
    }
    if (select == 6) {
        exit(1);
    }
 }

 int main()
{
    
    printMenu();
    return 0;
}
