#include <iostream>
using namespace std;
#include "phanso.h"
#include "list.h"
int main() 
{
//   List<int> ds;
//   ds.Add(18);
//   ds.Add(19);
//   ds.Add(17);
//   cout<<ds.GetItem(3)<<endl;
//   cout<<ds<<endl;
  List<PhanSo> dm;
  dm.Add(PhanSo(12,6));
  dm.Add(PhanSo(5,7));
  dm.Add(PhanSo(3,4));
  cout<<dm<<endl;
}


