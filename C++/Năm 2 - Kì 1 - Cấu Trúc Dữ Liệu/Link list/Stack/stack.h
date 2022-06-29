#include "node.h"
using namespace std; 
template <class T >
class Stack 
{
  private : 
    Node<T> *head; 
  public : 
    Stack()
    { head = 0; }
    void Push(T v)
    {
      Node<T>* p = new Node<T>; 
      p->data = v; 
      p->next = 0 ; 
      if(head==0)
      {
        head = p ; 
      }
      else
      {
        p->next = head ; 
        head = p;
      }
    }
    T Pop()
    {
      if(head ==0 )
      {
        throw 1;
      }
      else
      {
        T v = head ->data;
        Node<T> *p = head ; 
        head = head ->next ; 
        delete p ; 
        return v ; 
      }
    }
    T Top()
    {
      Node<T> *p = head;
      return p->data; 
    }
    bool isEmpty()
    {
      if(head==0)
      {
        return true;
      }
      return false;
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