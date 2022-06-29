#include <string>
#include <string.h>
#include <iostream>
#include <fstream> // thao tac voi file

using namespace std;

struct LienHe
{
    string hoTen;
    string soDienThoai;
    string email;
};

LienHe danhBa[100];
int n = 0;

void inDanhBa() {
    for(int i=0; i < n; i++) {
        cout << " stt: " << (i+1) << "  " << danhBa[i].hoTen;
        cout << "  " << danhBa[i].soDienThoai << endl;
    }
}

void ghiRaFile();

void themLienHe() {
    cout << " Moi nhap ten: ";
    getline(cin, danhBa[n].hoTen);
    cout << " Moi nhap sdt: ";
    getline(cin, danhBa[n].soDienThoai);
    n += 1;

    cout << " Ban muon nhap tiep(0) hay thoi(1): ";
    int chon;
    cin >> chon;
    cin.ignore();
    if (chon == 1) {
        cout << "---------------------" <<endl;
        inDanhBa();
        ghiRaFile();
    }

    if (chon == 0) {
        themLienHe();
    }
}

void ghiRaFile() {
    fstream file;
    file.open("danhBa.txt", ios::out);
    file << n << endl;
    for(int i=0; i < n; i++) {
        file << danhBa[i].hoTen << endl;
        file << danhBa[i].soDienThoai << endl;
    }

    file.close();
}

void docFile() {
    fstream file;
    file.open("danhBa.txt", ios::in);
    file >> n;
    file.ignore();

    for(int i =0; i< n; i++) {
        getline(file, danhBa[i].hoTen);
        getline(file, danhBa[i].soDienThoai);
    }

    file.close();
}


int main() {
	
  // themLienHe(); 
   docFile();
   inDanhBa();

    return 0;
}
