#pragma once
using namespace std;
template <class T>
struct Node
{
    T data;
    Node<T> *left; 
    Node<T> *right;
};
