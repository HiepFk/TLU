#include <iostream>
#include<math.h>
using namespace std;
int Fibonacci(int n){
    if(n<=2){
        return 1;
    }
    return Fibonacci(n-1)+Fibonacci(n-2);
}
int LuyThua(int n )
{
  if(n==0)
  {return 1;}
  if(n==1)
  {return 2;}
  return 2*LuyThua(n-1);
}
int GiaiThua(int n)
{
  if(n==0)
  {return 1;}
  return n* GiaiThua(n-1);
}
int main() {
  cout<<"Giai Thừa : "<<GiaiThua(6)<<endl;
  cout<<"Lũy Thừa  : "<<LuyThua(6)<<endl;
  cout<<"Fibonacci : "<<Fibonacci(6)<<endl;
}