#include <iostream>
#include <string>
#include <fstream>

using namespace std;

struct NguoiChoi {
    string ten;
    int diem;
    int trangThai;
};
int soNguoi =1;
struct CauHoi
{
    int stt;
    string noiDung;
    string cauTraLoi[4];
    int dapAnDung;
    int diemSo;
};

NguoiChoi bangXepHang[1000];
NguoiChoi nguoiChoiHienTai;
CauHoi bangCauHoi[1000];
int MocDiemSo[] = { 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767};

void luuFileNguoiChoi() {
     fstream file;
     file.open("nguoiChoi.txt", ios::out) ;
     file << soNguoi<<endl;
     file << nguoiChoiHienTai.ten << endl;
     file << nguoiChoiHienTai.diem << endl;
     file << nguoiChoiHienTai.trangThai <<endl;
    
     file.close();	
}

void docFileNguoiChoi() {
    fstream file;
    file.open("nguoiChoi.txt", ios::in) ;
    file >> soNguoi;
    for(int i = 0; i < soNguoi; i++)
    {
        file.ignore();
        getline(file, bangXepHang[i].ten);
        file >> bangXepHang[i].diem;
        file >> bangXepHang[i].trangThai;
    }
    nguoiChoiHienTai.ten = bangXepHang[soNguoi - 1].ten;
    nguoiChoiHienTai.diem = bangXepHang[soNguoi - 1].diem;
    nguoiChoiHienTai.trangThai = bangXepHang[soNguoi - 1].trangThai; 
    file.close();
}

void docFileCauHoi() {
    fstream file;
    file.open("cauHoi.txt", ios::in) ;
    int soCau;
    file >> soCau;
    for(int i = 0; i < soCau; i++)
    {
        file >> bangCauHoi[i].stt;
        file.ignore();
        getline(file, bangCauHoi[i].noiDung);
        getline(file, bangCauHoi[i].cauTraLoi[0]);
        getline(file, bangCauHoi[i].cauTraLoi[1]);
        getline(file, bangCauHoi[i].cauTraLoi[2]);
        getline(file, bangCauHoi[i].cauTraLoi[3]);
        file >> bangCauHoi[i].dapAnDung;
        file >> bangCauHoi[i].diemSo;
    }
    file.close();
}

void thongBaoCauHoi() {
    int index = nguoiChoiHienTai.trangThai;
    cout << "\n Cau hoi thu " << (index + 1) << endl;
    cout << bangCauHoi[index].noiDung << endl;
    cout << "A. " << bangCauHoi[index].cauTraLoi[0] << endl;
    cout << "B. " << bangCauHoi[index].cauTraLoi[1] << endl;
    cout << "C. " << bangCauHoi[index].cauTraLoi[2] << endl;
    cout << "D. " << bangCauHoi[index].cauTraLoi[3] << endl;
    cout << " Dap an cuoi cung cua ban la: ";
}

void traLoiCauHoi() {
    int luaChon;
    cin >> luaChon;
    luaChon = luaChon -1;

    int index = nguoiChoiHienTai.trangThai;
    if (bangCauHoi[index].dapAnDung == luaChon) {
        nguoiChoiHienTai.diem += bangCauHoi[index].diemSo;
        nguoiChoiHienTai.trangThai += 1;
        if (nguoiChoiHienTai.trangThai == 15) {
            cout << "Ban da thang giai doc dac \n";
        } else
        {
            cout << "Ban da tra loi dung \n";
            cout << "Dan duoc them " << bangCauHoi[index].diemSo << " diem\n";
            cout << " Ban muon choi tiep (1) hay ket thuc (0): ";
            int luaChon;
            cin >> luaChon;
            if ( luaChon == 1) {
                thongBaoCauHoi();
                traLoiCauHoi();
            } else
            {
		cout<<" Ban duoc so diem : "<< MocDiemSo[index]<<endl;
		luuFileNguoiChoi();
            }
            
        }
    } else {
        if (index >= 10) {
            nguoiChoiHienTai.diem = MocDiemSo[9];
            cout << " Ban ra ve voi " << MocDiemSo[9] << " diem";
            luuFileNguoiChoi();
            return;
        } 

        if (index >= 5 ){
            nguoiChoiHienTai.diem = MocDiemSo[4];
	    cout<< " Cau tra loi cua bạn da sai "<<endl;
            cout << " Ban ra ve voi " << MocDiemSo[4] << " diem"; 
	    luuFileNguoiChoi();
            return;
        } 
        nguoiChoiHienTai.diem =0;
	cout<< " Cau tra loi cua bạn da sai "<<endl;
        cout << "Ban ra ve tay trang.";
	luuFileNguoiChoi();
    }
}

void inMenu0() {
    if (nguoiChoiHienTai.trangThai > 0)
    {
        cout << "Ban muon choi tiep hay khong, chon 1/0 :";
        int luaChon;
        cin >> luaChon;
        if( luaChon == 0) {
	    cout << " Chao Mung ban Den voi Cuoc thi ai la Trieu Phu"<<endl;
            cout << "Moi nhap ten: ";
            cin.ignore();
            getline(cin, nguoiChoiHienTai.ten);
            nguoiChoiHienTai.diem = 0;
            nguoiChoiHienTai.trangThai = 0;
            thongBaoCauHoi();
            traLoiCauHoi();
        } else
             {
             thongBaoCauHoi();
             traLoiCauHoi();
        }   
    }
}


int main() {
    docFileCauHoi();
    docFileNguoiChoi();
    inMenu0();
    return 1;
}






