using namespace std;
class TrongTai
{
    private : 
        char name[30];
        int tuoi ;
        int year;
        int point;
    public : 
        TrongTai()
        {}
        friend istream &operator>>(istream &is,TrongTai &k)
        {
            cout<<"Moi nhap ten : ";
            is.getline(k.name,30);
            cout<<"Moi nhap tuoi : ";
            is>>k.tuoi;
            cout<<"Moi nhap so nam cong tac  : ";
            is>>k.year;
            cout<<"Moi nhap so diem tin nhiem : ";
            is>>k.point;
            return is; 
        }
        friend ostream &operator<<(ostream &os,TrongTai k)
        {
            os<<k.name<<endl;
            os<<k.tuoi<<endl;
            os<<k.year<<endl;
            os<<k.point<<endl;
            return os ; 
        }
};