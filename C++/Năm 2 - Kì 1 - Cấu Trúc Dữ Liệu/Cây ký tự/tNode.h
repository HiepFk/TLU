#pragma once
using namespace std;
template <class T>
struct TreeNode
{
    T data;
    TreeNode<T> *left; 
    TreeNode<T> *right;
};
