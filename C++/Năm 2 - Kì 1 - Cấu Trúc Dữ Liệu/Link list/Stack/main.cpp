#include <iostream>
#include "stack.h"
using namespace std;  
int main() {
  //  int i = 0; 
  //  while(i<10)
  //  {
  //    l.Push(i);
  //    i++;
  //  }
  //  l.Display();
  //  cout<<l.Top()<<endl;
  //  //cout<<l.Count()<<endl;
  //  cout<<endl;
   
  //  cout<<l.Pop()<<endl;
  //  l.Display();
  //  cout<<l.Top()<<endl;
  //  //cout<<l.Count()<<endl;
  try
  { 
    Stack<int> l ;
    l.Push(5);
    l.Pop();
    l.Pop();
  }
  catch(int a)
  {
    cout<<"Lỗi "<<endl;
  }
  // char const *a

}