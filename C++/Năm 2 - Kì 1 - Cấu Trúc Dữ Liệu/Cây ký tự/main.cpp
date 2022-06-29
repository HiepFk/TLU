#include <iostream>
#include "tree.h"
#include "list.h"
using namespace std;
int main() 
{
Tree<char> t;
t.AddRoot('A');
t.AddLeft('A', 'B');
t.AddRight('A', 'C');
t.AddLeft('B', 'D');
t.AddRight('B', 'E');

List<char> l = t.getChild('B');
cout<<l<<endl;

}