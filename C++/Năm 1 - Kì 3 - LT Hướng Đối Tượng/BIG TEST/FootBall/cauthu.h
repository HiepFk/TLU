#include<string.h> 
using namespace std;
class CauThu
{
    private : 
      char name[30] ;
      int tuoi;
      int SoAo;
      int SoThePhat;
      int goal;
      int adj;   // 1 là có , 0 là không 
      char Vitri[10]; // CF lầ tiền đạo , CM là tiền vệ , DF là hậu vệ 
      //string a[3];
    public : 
        Cauthu()
        {}
        friend istream &operator>>(istream &is,CauThu &k)
        {  
            cin.ignore();
            cout<<"Moi nhap ten : ";
            is.getline(k.name,30);
            cout<<"Moi nhap tuoi : ";
            is>>k.tuoi;
            cout<<"Moi nhap so ao : ";
            is>>k.SoAo;
            cout<<"Moi nhap so the phat : ";
            is>>k.SoThePhat;
            cout<<"Moi nhap so ban thang : ";
            is>>k.goal;
            cout<<"Moi nhap trang thai : ";
            is>>k.adj;
            cout<<"Moi nhap vi tri : ";
            is>>k.Vitri; // English;
            
            return is;
        }
        friend ostream &operator<<(ostream &os , CauThu k)
        {   
            
            os<<k.name<<endl;
            os<<k.tuoi<<endl;
            os<<k.SoAo<<endl;
            os<<k.SoThePhat<<endl;
            os<<k.goal<<endl;
            os<<k.adj<<endl;
            os<<k.Vitri<<endl;
            
            return os ; 
        }
};