#include "string.h"
#include "math.h"
using namespace std;
class DaThuc
{
  private : 
    int n ;
    float a[100];
  public :
    DaThuc(){}
    DaThuc(int b,float so)
	  { 
	    n=b;
		  for(int i=0;i<n+1;i++)
		  { 
			  a[i]= so;
		  }
	  } 
    friend istream &operator>>(istream &is,DaThuc &k)
      { 
        cout<<"Moi nhap bac cua da thuc : ";
        is>>k.n;
        cout<<"Moi nhap cac he so : ";
        for(int i=0;i<k.n+1;i++)
        {
          float x;
          is>>x;
          k.a[i]=x;
        }
        return is;
      }
    friend ostream &operator<<(ostream &os,DaThuc k)
      {
        cout<<"Ta co da thuc : ";
        for(int i=0;i<k.n+1;i++)
        { 
          if(i==0){cout<<k.a[i];}
          else {
          cout<<k.a[i]<<"x^"<<i;}
          if(i!=k.n) cout<<" + ";
        }
        cout<<endl;
        return os;
      }

    DaThuc operator+(DaThuc k) 
      { 
        int min, max;
        if(n>k.n)
        { 
          max=n; min=k.n;
          DaThuc h(max,0); 
          h=*this;
          for(int i=0;i<max;i++)
          {
            h.a[i]=a[i] + k.a[i];
          }
          return h;
        }
        if(k.n>=n)
        {
          min=n; max=k.n;
          for(int i=0;i<max+1;i++)
          {
            k.a[i]=k.a[i] + a[i];
          }
          return k;
        }
      }
      
    DaThuc operator-(DaThuc k)
      {
        int min, max;
        if(n>k.n)
        { 
          max=n; min=k.n;
          DaThuc h(max,0); 
          h=*this;
          for(int i=0;i<max;i++)
          {
            h.a[i]=a[i]-k.a[i];
          }
          return h;
        }
        if(k.n>=n)
        {
          min=n; max=k.n;
          for(int i=0;i<max+1;i++)
          {
            k.a[i]=a[i]-k.a[i];
          }
          return k;
        }
      }

    DaThuc operator*(DaThuc k)
    {
      int dem=n+k.n;
      DaThuc q(dem,0);
      for (int x=0;x<=dem;x++)
      {
        for (int i=0;i<=n;i++)
        {
          for (int j=0;j<=k.n;j++)
          {
            if(i+j==x)
            {
              q.a[x]=q.a[x] + a[i] * k.a[j];
            }
          }
        }
      }
      return q;
    }

      DaThuc operator+(float x) 
      {
        DaThuc h;
        h=*this;
        h.a[0]=h.a[0] + x;
        return h ;
      }
      friend DaThuc operator+(float x , DaThuc h)
      {
        h.a[0]=h.a[0] + x;
        return h ;
      }
      DaThuc operator-(float x) 
      {
        DaThuc h;
        h=*this;
        h.a[0]=h.a[0]-x;
        return h ;
      }
      friend DaThuc operator-(float x, DaThuc h)
      {
        h.a[0]=x-h.a[0];
        for(int i=1;i<h.n+1;i++)
        {
          h.a[i]=-h.a[i];
        }
        return h ;
      }
      DaThuc operator*(float x)
      {
        DaThuc h;
        h=*this;
        for(int i=0;i<n+1;i++)
        {
          h.a[i]=h.a[i] * x;
        }
        return h;
      }
      friend DaThuc operator*(float x, DaThuc k)
      {
        for(int i=0;i<k.n+1;i++)
        {
          k.a[i]=k.a[i] * x;
        }
        return k;
      }
    void ThayDoiHeSo(int x, int y )
    {
      a[x-1]=y;
    }
    int Tinh(int x)
    { 
      cout<<"Ket qua cua da thuc : ";
      float s=0;
      for (int i=0;i<n+1;i++)
      {
        s=s+a[i] * pow(x,i);
      }
      return s; 
    }

    void DaoHam()
    { 
      DaThuc h(n,0);
      for(int i=0;i<n+1;i++)
      {
        h.a[i]=a[i+1]*(i+1) ;
      }
      h.n--;
      cout<<h;
    }

    void NguyenHam()
    { 
      n++;
      DaThuc h(n,0);
      for(int i=1;i<n+1;i++)
      {
        h.a[i]=a[i-1]/i;
      }
      cout<<h ;
    }
};