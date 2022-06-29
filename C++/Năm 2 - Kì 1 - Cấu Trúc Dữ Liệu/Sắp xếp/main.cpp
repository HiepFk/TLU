#include<iostream>
#include <fstream>
using namespace std;
void swap(int &a , int &b)
{
  int c = a; 
  a=b;
  b=c;
}
void M(int a[],int s , int e)
{
    int tg = (s+e)/2;
    int l = s , r = tg+1;
    int *b = new int[e-s+1];
    int dem = 0 ; 
    while(l<=tg && r<=e)
    {
        if(a[l-1]<a[r-1])
        {
            b[dem++]=a[l-1];
            l++;
        }
        else{
            b[dem++]=a[r-1];
            r++;
        }
    }
    if(l<=tg)
    {
        for(int i = l ; i <=tg;i++)
        {
            b[dem++]=a[i-1];
        }
    }
    if(r<=e)
    {
        for(int i = r ; i <=e;i++)
        {
            b[dem++]=a[i-1];
        }
    }
    for(int i = 0 ; i<dem;i++)
    {
        a[s+i-1]=b[i];
    }
}
void MS(int a[],int s , int e )
{
    if(s<e)
    {
        MS(a,s,(s+e)/2);
        MS(a,(s+e)/2+1,e);
        M(a,s,e);
    }
}
int main()
{
    int N; 
    ifstream fin("DuLieuSo.txt");
    fin>>N;
    int A[50000];
    for(int i=0;i<N;i++)
    {   
       fin>>A[i]; 
    }
    fin.close();
    // MS(A,1,N);

    for(int i = 0 ; i<N-1;i++)
    {
      for(int j = i+1;j<N;j++)
      {
        if(A[i]>A[j])
        {
          swap(A[i],A[j]);
        }
      }
    }

    ofstream fout("Dl_SapXep.txt");
    fout<<N<<endl;
    for(int i=0;i<N;i++)
    {   
       fout<<A[i]<<" ";
       if((i+1)%10==0){
           fout<<endl;
       }
    }
    fout.close();
    
}