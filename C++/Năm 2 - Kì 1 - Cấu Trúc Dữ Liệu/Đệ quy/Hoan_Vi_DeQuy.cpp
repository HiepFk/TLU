#include<iostream>
using namespace std;
int a[100];
int N  ;
int B[100] ={0};
void HienThi()
{
    for(int i = 1 ; i<=N; i++)
    {
        cout<<a[i];
    }
    cout<<endl;
}
void BienDoi(int dem)
{
    for(int i = 1; i<=N;i++)
    {
        if(B[i]==0)
        {
            a[dem] =i;
            B[i] = 1;
            if(dem==N)
            {HienThi();}
            else{
                BienDoi(dem+1);
            }
            B[i]=0;
        }
    }
}
int main()
{   
    cin>>N;
    BienDoi(1);
    return 0 ; 
}