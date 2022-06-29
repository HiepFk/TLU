#pragma once 
#include"node.h"
using namespace std;
template <class T>
class List
{
private :
	Node<T> * head;
public : 
	List()
	{head = 0 ;}
	List(int dem)
	{	
		head = 0 ; 
		for(int i = 0; i<dem; i++)
		{
			Add(i);
		}
	}
	List(int dem, T val)
	{	
		head = 0 ; 
		for(int i = 0; i<dem; i++)
		{
			Add(val);
		}
	}


	void Add(T v ) 
	{
		Node<T> * p = new Node<T>;
		p->data= v;
		p->next=0;
		if(head ==0)
		{ 
			head = p ; 
		}
		else{
			Node<T> *q = head ; 
			while(q->next!=0)
			{
				q=q->next;
			}
			q->next=p;
		}
	}


  
	void Push(T v) // thêm giá trị vào đầu danh sách 
	{
		Node<T> * p = new Node<T>;
		p->data= v;
		p->next=0;
		if(head ==0)
		{ 
			head = p ; 
		}
		else{
		//	Node<T> *q = head ; 
			p->next = head;
			head = p ; 
		}
	}
	T Pop() // lấy giá trị đầu và xóa 
	{
		Node<T> * q = head; 
		T a= q->data;
		head = head->next;
		delete q;
		return a;
	}
	bool IsEmpty() // Kiểm tra danh sách có rỗng ko 
	{
		if(head ==0){return true ; }
		return false;
	}
	T Get(int pos) const 
	{	
		Node<T>* p = head;
		for(int i = 1 ; i<pos;i++)
		{
			p=p->next;
		}
		return p->data;
	}
	void Delete(int pos)
	{
		if(pos==1)
		{	Node<T> *q = head;
			head = head ->next;
			delete q;
		}
		else{
			Node<T> *p = head;
			for(int i=1;i<pos-1;i++)
			{
				p=p->next;
			}
			Node<T> * q = p->next;
			p->next = q->next;
			delete q;
		}
		
	}
	int Count() const // đếm số phần tử của dãy 
	{	
		//cout<<"So luong phan tu : ";
		int dem = 0 ; 
		Node<T> *p = head;
		while(p!=0)
		{
			dem++;
			p=p->next;
		}
		return dem;
	}
    int CheckPt(T v) // kiểm tra trong mảng có giá trị truyền vào ko ( có thì là 1 , ko là có là 0 )
    {
      Node<T> *p = head;
			while(p!=0)
			{
				if(p->data==v){return 1;}
				p=p->next;
			}
			return 0;
    }
    int CountPt(T v) const // đếm số phần tử có giá trị = giá trị truyền vào 
    { 
      int dem = 0;
      Node<T> *p = head;
			while(p!=0)
			{
				if(p->data==v){dem++;}
				p=p->next;
			}
			return dem;
    }
    void ViTriPT(T v ) // in ra vị trị các giá trị = giá trị truyền vào 
    {
      int pos = 1;
      Node<T> *p = head;
			while(p!=0)
			{
				if(p->data==v){cout<<pos<<" ";}
				p=p->next;
        		pos++;
			}
			cout<<endl;
    }
    void Xoa_Trung(T v) // xóa các phần tử có giá trị = giá trị truyền vào
    { 
      List<T> b;
		  for(int i = 1; i<=Count();i++)
     	{
        if(Get(i)!=v){
          b.Add(Get(i));
				}
     	}
     	*this = b ;
    }
    void Xoa_Lap() // chỉ để các phần tử khác nhau còn lại trong mảng
     {
     	List<T> b;
		  for(int i = 1; i<=Count();i++)
     	{
        if(b.CheckPt(Get(i))==0){
          b.Add(Get(i));
				}
     	}
     	*this = b ; 
     }
	void Insert(int pos , T v) // chèn phần tử vào vị trị chuyền vào 
	{	Node<T> * p = new Node<T>;
		p->data = v;
		p->next = 0 ; 
		Node<T> * q = head;
		for(int i=1;i<pos-1;i++)
		{
			q=q->next;
		}
		p->next = q->next;
		q->next = p;
	}
	void Sort() // sắp xếp phần tử
	{
		for(Node<T>*p=head ; p!=0; p=p->next)
		{
			for(Node<T>*q=p->next; q!=0;q=q->next)
			{
				if(p->data>=q->data)
				{
					T k = p->data;
					p->data=q->data;
					q->data= k;
				}
			}
		}
	}
	friend ostream &operator<< (ostream &out , List<T> l) // quá tải toán tử xuất 
	{
		Node<T> *p = l.head;
		while(p!=0)
		{
			out<<p->data<<" ";
			p=p->next;
		}
		return out;
	} 
	
	void operator = (const List<T> &K ) // gán 2 list
	{
		head=0;
		for(int i = 1; i<=K.Count();i++)
		{
			Add(K.Get(i));
		}
	}
	int Pos_Close(T v ) // lấy  vị trị gần nhất có giá trị = giá trị truyền vào 
    {
      int pos = 1, dem=0;
      Node<T> *p = head;
			while(p!=0)
			{	
				if(p->data==v)
				{return pos;}
				p=p->next;
        		pos++; 
			}
			return 0 ; 
    }
     
     void Replace(int pos , T v)
     {
     	Node<T> * p = head ;
     	for(int i =1 ; i<=pos-1;i++)
     	{p=p->next;}
     	p->data = v;  
     	
     }
     void Rp_From(int pos , T v)
     {
     	Node<T> * p = head ;
     	int dem = 1; 
     	while(p!=0)
     	{
     		if(dem>=pos)
     		{
     			p->data = v;
     		}
     		dem++;
     		p=p->next;
     	} 
     }
  
    List<T> Giao(List<T> &k) 
    { 
      List<T> a; 
      for(int i = 1; i<=Count();i++)
      {
        for(int j = 1 ; j<=k.Count();j++)
        {
          if(Get(i)==k.Get(j) && a.CheckPt(k.Get(j))==0)
          {
           a.Add(Get(i));
          }
        }
      }
      return a ; 
    } 
    List<T> Hop(List<T> &k) 
    { 
      List<T> b;
      for(int i = 1; i<=k.Count();i++)
      {
          if(b.CheckPt(k.Get(i))==0)
            {
          b.Add(k.Get(i));
        }
      }
      for(int j = 1 ; j<=Count();j++)
      {
        if(b.CheckPt(Get(j))==0)
        {
          b.Add(Get(j));
        }
      }
      return b ; 
    } 
};