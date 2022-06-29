#include <iostream>
#include"queue.h"
using namespace std;
int main() {
  Queue<int> q;
  int i = 0 ;
  while(i<10)
  {
    q.EnQueue(i);
    i++;
  }
  q.Display();
  cout<<q.Count()<<endl;
  cout<<q.Top()<<endl; 
  cout<<endl;

  cout<<q.DeQueue()<<endl;
  q.Display();
  cout<<q.Count()<<endl;
  cout<<q.Top()<<endl; 

}