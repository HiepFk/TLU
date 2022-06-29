#include<iostream>
using namespace std;
#include "tree.h"
int main()
{
    Tree<int> t;
    t.Add(34);
    t.Add(17);
    t.Add(66);
    t.Add(25);
    t.Add(50);
    t.Add(71);
    t.Add(68);
    t.Add(94);
    //t.Add(100);
    // t.InOrder();
    // t.PosOrder();
    t.PreOrder();
    //cout<<t.AVl()<<endl;
    // while(t.AVl()==0)
    // {
    //   t.TreeAVL();
    // }
    //cout<<t.AVl()<<endl;
    //t.PreOrder();
    
    return 0;
}