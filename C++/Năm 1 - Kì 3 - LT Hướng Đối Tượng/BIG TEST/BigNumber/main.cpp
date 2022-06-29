#include <iostream>
using namespace std;
#include "bignum.h"

int main() 
{
  BigNum a("18");
  BigNum kq("9");

  kq = a-kq;

  /* for(int i = 1; i<=64; i++)
    kq = kq * a; */
  cout<<kq<<endl;
}