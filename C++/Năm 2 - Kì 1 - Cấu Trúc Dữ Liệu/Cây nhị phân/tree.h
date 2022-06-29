#pragma once
#include "node.h"
using namespace std;
template <class T>
class Tree
{
private:
    Node<T> *root;
    void Duyet_InOrder(Node<T>* p) const  // trung tự
    {
      if(p==NULL)
      {return ;}
      Duyet_InOrder(p->left);
      cout<<p->data<<" ";
      Duyet_InOrder(p->right);
    }

    void Duyet_PreOrder(Node<T>* p) const  // tiền tự
    {
      if(p==NULL)
      {return ;}
      cout<<p->data<<" ";
      Duyet_PreOrder(p->left);
      Duyet_PreOrder(p->right);
    }

    void Duyet_PosOrder(Node<T>* p ) const // hậu tự 
    {
      if(p==NULL)
      {return ;}
      Duyet_PosOrder(p->left);
      Duyet_PosOrder(p->right);
      cout<<p->data<<" ";
    }

    int treeLevel(Node<T> *t) const
    {
      if (t == NULL) return -1;
      return 1 + max(treeLevel(t->left), treeLevel(t->right));
    }
    bool checkAvl(Node<T> *t){
      if (t == NULL)
      {
        return true;
      }	
      if (abs(treeLevel(t->left) - treeLevel(t->right)) > 1)
      {
        return false;
      } 
      return true;
    }

    Node<T> *turnRight(Node<T> *a){
      Node<T> *b = a->left;
      Node<T> *d = b->right;
      a->left = d;
      b->right = a;
      return b;
    }
    Node<T> *turnLeft(Node<T> *a){
      Node<T> *b = a->right;
      Node<T> *c = b->left;
      a->right = c;
      b->left = a;
      return b;
    }

    Node<T>* updateTreeAvl(Node<T> *t)
    {
      if (abs(treeLevel(t->left) - treeLevel(t->right)) > 1)
      {
        if (treeLevel(t->left) > treeLevel(t->right))
        {
          Node<T> *p = t->left;
          if (treeLevel(p->left) >= treeLevel(p->right))
          {
            t = turnRight(t);
          }
          else
          {
            t->left = turnLeft(t->left);
            t = turnRight(t);
          }
        } 
        else {
          Node<T> *p = t->right;
          if (treeLevel(p->right) >= treeLevel(p->left))
          {
            t = turnLeft(t);
          } 
          else{
            t->right = turnRight(t->right);
            t = turnLeft(t);  
          }
        }	
      }
      if (t->left != NULL) t->left = updateTreeAvl(t->left);
      if (t->right != NULL) t->right = updateTreeAvl(t->right);
      return t;
    } 
    
public:
    Tree()
    {
        root=0;
    }
    void Add(T v)
    {
      Node<T>* p = new Node<T>;
      p->data=v;
      p->right=0;
      p->left=0;
      if(root==0)
      {
        root=p;
      }
      else{
        Node<T>*q = root;
        while(q!=0)
        {
          if(v<q->data)
          {
            if(q->left==0)
            {
              q->left=p;
              break;
            }
            q=q->left;
          }
          else if(v>q->data){
            if(q->right==0)
            {
              q->right=p;
              break;
            }
            q=q->right;
          }
        }  
       }
    }

    void InOrder() 
    {
      Duyet_InOrder(root);
      cout<<endl;
    }
    void PreOrder()
    {
      Duyet_PreOrder(root);
      cout<<endl;
    }
    void PosOrder()
    {
      Duyet_PosOrder(root);
      cout<<endl;
    }

    bool AVl()
    {
      return checkAvl(root);
    }

    void TreeAVL()
    {
      root= updateTreeAvl(root);
    }

};