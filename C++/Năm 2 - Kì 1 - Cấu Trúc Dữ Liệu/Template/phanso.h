#ifndef phanso_h
#define phanso_h

class PhanSo
{
private:
  int tu;
  int mau;
  int UCLN(int a, int b)
  {
    int min = a>b?b:a;
    for(int i = min; i>= 1; i--)
      if (a % i == 0 && b % i == 0)
        return i;
    return 1;
  };
public:
  PhanSo()
  {
    tu = 1;
    mau = 1;
  };
  PhanSo(int t, int m)
  {
    tu = t;
    mau = m;
    int u = UCLN(tu, mau);
    tu = tu / u;
    mau = mau / u;
  };
  friend ostream& operator<<(ostream &out, PhanSo p)
  {
    if (p.mau == 1)
      out<<p.tu;
    else
      out<<p.tu<<"/"<<p.mau;
    return out;
  };
  PhanSo operator+(PhanSo p)
  {
    return PhanSo(tu * p.mau + mau * p.tu, mau * p.mau);
  };
  
};

#endif