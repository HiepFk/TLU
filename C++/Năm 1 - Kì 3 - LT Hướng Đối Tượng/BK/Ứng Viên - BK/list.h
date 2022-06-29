#include<string.h>
using namespace std;
class UngVien
{
    private : 
        string HoTen;
        int soPhieu;
    public : 
        friend void timMax(UngVien [], int );
        friend int  tong(UngVien [],int);
        UngVien(){};
        friend istream &operator>>(istream &is,UngVien &k)
        {   cin.ignore();
            getline(is,k.HoTen);
            cout<<"         So phieu : ";
            is>>k.soPhieu;
            return is;
            
        }
        friend ostream &operator<<(ostream &os,UngVien k)
        {
            os<<k.HoTen<<" ";
            os<<k.soPhieu<<" "<<endl;
            return os;
        }
};
    void timMax(UngVien a[], int n )
    { 
      UngVien dm;
      for(int i=0;i<n-1;i++)
      {
        for(int j=i+1;j<n;j++)
        {
         if(a[i].soPhieu<a[j].soPhieu)
            {
                dm=a[i];
                a[i]=a[j];
                a[j]=dm;
            }
        }
      }
        int s=0;
        for(int i=0;i<n;i++)
        {
            s=s+a[i].soPhieu;
        }
      cout<<"     The Winner : "<<endl;
      cout<<a[0].HoTen<<" "<<a[0].soPhieu;
      float soPhanTram = a[0].soPhieu * 100 / s;
      cout<<" "<<soPhanTram<<"%"<<endl;
    }
    