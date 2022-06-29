#ifndef date_h
#define date_h
using namespace std;
class Date
{
  private : 
    int day; 
    int month; 
    int year ; 
  public :
    Date(){}
    Date(int a, int b, int c)
    {
      day = a; 
      month = b;
      year = c; 
    }
    friend istream &operator>>(istream &is,Date &k)
    {   
        is>>k.day>>k.month>>k.year;
        return is;
    }
    friend ostream &operator<<(ostream &os,Date k)
    { 
      os<<k.day<<"."<<k.month<<"."<<k.year;
      return os ; 
    }
};
#endif