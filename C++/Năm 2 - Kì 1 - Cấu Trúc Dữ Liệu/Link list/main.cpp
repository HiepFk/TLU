#include<iostream>
#include "list.h"
using namespace std;
int main()
{
	List<int> l, l2(10) , l3(10,5),l4; 
 
  l.Add(5);
  l.Add(5);
  l.Add(5);
  l.Add(4);
  l.Add(7);
  l.Add(7);
  cout<<l<<endl;

  for(int i = 1; i<=l.Count();i++)
  {
    cout<<l.Get(i)<<" ";
  }
	
}