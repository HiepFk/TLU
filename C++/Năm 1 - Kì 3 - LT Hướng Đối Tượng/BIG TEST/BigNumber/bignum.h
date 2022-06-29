#ifndef bignum_h
#define bignum_h
#include <string.h>
#include <math.h>
class BigNum 
{
private:
  char a[1000];
public:
  BigNum()
  {
    a[0] = '0';
    a[1] = '\0';
  };
  BigNum(const char *m)
  {
    strcpy(a, m);

  };
  friend ostream & operator<<(ostream &o, BigNum b)
  {
    o<<b.a;
    return o;
  };
  BigNum operator+(BigNum b) const
  {
    char x[1000];
    int k = 0, r1 = strlen(a), r2 = strlen(b.a);
    int nho =0;
    while (r1>=1 && r2>=1)
    {
      int t = a[r1-1] + b.a[r2-1] + nho - 2 * '0';
      if (t>9)
      {
        nho = 1;
        t = t-10;
      }
      else
      {
        nho = 0;
      }
      x[k] = t + '0';
      k++;
      r1--; r2--;
    }
    if (r1 == 0)
    {
      while(r2 >= 1)
      {
        int t = b.a[r2-1] + nho - '0';
        if (t>9)
        {
          nho = 1;
          t = t-10;
        }
        else
        {
          nho = 0;
        }
        x[k] = t + '0';
        k++;
        r2--;
      }
    }
    else
    {
      while(r1 >= 1)
      {
        int t = a[r1-1] + nho - '0';
        if (t>9)
        {
          nho = 1;
          t = t-10;
        }
        else
        {
          nho = 0;
        }
        x[k] = t + '0';
        k++;
        r1--;
      }
    }
    if (nho == 1)
    {
      x[k] = '1';
      k++;
    }
    r1 = 1; r2 = k;
    while (r1<r2)
    {
      char ch = x[r1-1];
      x[r1-1] = x[r2-1];
      x[r2-1] = ch;
      r1++; r2--;
    }
    x[k] = '\0';
    return BigNum(x);
  };
  BigNum operator++()
  {
    char kq[1000];
    int nho = 1, k = 0;
    int len = strlen(a);
    for(int i = len; i>= 1; i--)
    {
      int t = a[i-1] + nho - '0';
      if (t> 9)
      {
        nho = 1;
        t = t - 10;
      }
      else
        nho = 0;
      kq[k++] = '0' + t;
    }
    if (nho == 1)
      kq[k++] = '1';
    for(int i = 0; i<k; i++)
      a[i] = kq[k-i-1];
    a[k] = '\0';
    return BigNum(a);
  };
  BigNum operator*(BigNum b) const
  {
    BigNum kq("0");
    BigNum s("1");
    while (s <= b)
    {
      kq = kq + BigNum(a);
      s = s + BigNum("1");

    }
    return kq;
  };
  // int k = stoll(s); chuyển từ string sang int 
  BigNum operator-(BigNum b) 
  {
    int t,  r1 = strlen(a), r2 = strlen(b.a);
    char x[1000];
    int r=r1-r2;
    a[r-1]--; 
    int k =r2;
    while(k>=1)
    { 
        if(k==r2){int t = 10 - (b.a[k-1]- '0');}
        else     {int t = 9  - (b.a[k-1]- '0');}
        x[k-1]=t + '0';
        k--;
    }
    return x ;
  } 

  bool operator<=(BigNum b) const
  {
    int len1 = strlen(a);
    int len2 = strlen(b.a);
    if (len1<len2)
      return true;
    if (len1 > len2)
      return false;
    for(int i = 0; i<len1; i++) 
    {
      if (a[i] < b.a[i])
        return true;
      if (a[i] > b.a[i])
        return false;        
    };  
    return true;
  };
};

#endif