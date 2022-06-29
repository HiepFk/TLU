#ifndef sv_h
#define sv_h
#include"date.h"
#include <string.h>
using namespace std;
class SinhVien
{
  private :
    string name;
    Date dt ;
    double toan ; 
    double ly ;
    double anh;
  public : 
    friend void xapSep(SinhVien [], int );
    SinhVien(){}
    SinhVien(const char *k,Date dm , double a, double b, double c)
    {
      name = k ;
      dt = dm;
      toan = a;
      ly=b;
      anh=c;
    }
    SinhVien(const char *k,int a, int b, int c, double x , double y , double z )
    { 
      name = k ;
      dt = Date(a,b,c);
      toan = x;
      ly=y;
      anh=z;
    }
    
    double Tong() const
    {
      int s = toan*2 + ly + anh;
      return s ;
    }
    double TB() const
    {
    double tb = (toan*2 + ly + anh)/4;
    return tb ;
    }
    friend istream &operator>>(istream &is,SinhVien &k)
    {   cin.ignore();
        getline(is,k.name);
        cout<<"      Thong tin sv : ";
        is>>k.dt>>k.toan>>k.ly>>k.anh;
        return is;
    }
    friend ostream &operator<<(ostream &os,SinhVien k)
    {
      os<<k.name<<" "<<k.dt<<" "<<k.toan<<" " <<k.ly<<" "<<k.anh;
      os<<" "<<k.Tong()<<" "<<k.TB()<<endl;
      return os;
    }
};
    void xapSep(SinhVien a[], int n )
    { 
      SinhVien dm;
      for(int i=0;i<n-1;i++)
      {
        for(int j=i+1;j<n;j++)
        {
         if(a[i].Tong()<a[j].Tong())
            {
                dm=a[i];
                a[i]=a[j];
                a[j]=dm;
            }
        }
      }
    }
#endif