#pragma once
#include "tNode.h"
#include "list.h"
using namespace std;
template <class T>
class Tree
{
private:

    TreeNode<T> *root;

public:
    Tree()
    {
        root=0;
    }

    void AddRoot(T v)
    {
      if (root!=0)
      {
        root->data = v;
      }
      else
      {
        root = new TreeNode<T>;
        root->data = v;
        root->left = 0;
        root->right = 0;
      }
    }
    
    TreeNode<T>* find(TreeNode<T>* p , T v) const
    {
        if(p==0)
        {
            return NULL;
        }
        if(p!=0)
        {
            if(p->data==v)
            {
                return p;
            }
            TreeNode<T>* q = find(p->left, v);
            if(q!=0)
            {
                return q;
            }
            
            q=find(p->right, v);
            if(q!=0)
            {
                return q; 
            }
        }
        return NULL;
    }
    
    TreeNode<T> * Find(T v) const
    {
        return find(root, v);
    }

    void AddLeft(T x , T y)
    {   
      TreeNode<T>* temp = Find(x); 
      if (temp != 0)
      {
        if (temp->left!=0)
        {
          temp->left->data = y;
        }
        else
        {
          TreeNode<T>* c = new TreeNode<T>;
          c->data = y;
          c->left = 0;
          c->right = 0;
          temp->left = c;
        }
      }
    }

    void AddRight(T x , T y)
    {   
      TreeNode<T>* temp = Find(x); 
      if (temp != 0)
      {
        if (temp->right!=0)
        {
          temp->right->data = y;
        }
        else
        {
          TreeNode<T>* c = new TreeNode<T>;
          c->data = y;
          c->left = 0;
          c->right = 0;
          temp->right = c;
        }
      }
    }

    List<T> getChild(T x)const
	  {
      List<T> k;
      TreeNode<T>* p = Find(x);
      if (p!=0)
      {
        if (p->left!=0)
        { 
          k.Add(p->left->data);
        }
        if (p->right!=0)
        { 
          k.Add(p->right->data);
        }
      }
      return k;
	  }
 
};