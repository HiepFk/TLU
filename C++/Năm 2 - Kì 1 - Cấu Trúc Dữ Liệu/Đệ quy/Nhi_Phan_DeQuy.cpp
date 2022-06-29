#include <iostream>
using namespace std;
#include <math.h>
char InHexa(int a)
{
  return 'A' + a-10;
}
int a[100];
int T = 16;
void SinhNP(int v, int N){
  if(v > N){
    for(int i=0; i<N; i++){
      if (a[i]<=9){
        cout<<a[i];
      }
      else{
        cout<<InHexa(a[i]);
      }
    } 
    cout<<endl;
  }
  else{
    for(int x = 0; x<T; x++)
    {
      a[v-1] = x;
      SinhNP(v+1, N);
    }
  }
}  
int main() 
{ 
  int a  ;
  cin>>a; 
  SinhNP(1,a);
  return 0;
}