using namespace std;
class Thumon 
{
    private : 
      char name[30] ;
      int tuoi;
      int SoAo;
      int SoThePhat;
      int goal;
      int adj;   // 1 là có , 0 là không 
      char Vitri[10];
    public : 
        Thumon()
        {}
        friend istream &operator>>(istream &is,Thumon &k)
        {   
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
            cout<<"Vi tri : ";
            is>>k.Vitri;
            return is;
        }
        friend ostream &operator<<(ostream &os , Thumon k)
        {   cin.ignore();
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
 
