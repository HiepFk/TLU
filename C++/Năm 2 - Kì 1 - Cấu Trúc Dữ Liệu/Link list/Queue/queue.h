#include "node.h"
using namespace std; 
template <class T >
class Queue
{
  private : 
    Node<T> *head; 
  public : 
    Queue()
    { head = 0; }
    void EnQueue(T v)
    {
      Node<T>  *a=new Node<T>;
      a->data=v;
      a->next=0;
      if(head==0)
        head=a;
      else{
        Node<T> *p=head;
        while(p->next!=0){
          p=p->next;			
        }
        p->next=a;
      }	
	  }
	  T DeQueue() //trả về gt đầu xg xóa
    {
      T v=head->data;
      Node<T> *p=head;
      head=head->next;
      delete p;
      return v;
    }
    T Top()
    {
      Node<T> *p = head;
      return p->data; 
    }
    int Count() const 
    {
      int count = 0;
      Node<T> * p = head;
      while (p!=0) {
        count++;
        p = p->next;
      }
      return count;
    }
    bool isEmpty()
    {
      if(head==0)
      {
        return true;
      }
      return false;
    }
    void Display()
    {
      Node<T>* p = head;
      while (p!= 0) {
        cout<<p->data<<" ";
        p = p-> next;
      }
    cout << endl;
    }
};