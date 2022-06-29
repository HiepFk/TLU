#include<iostream>
using namespace std ;
int a[100][100];
int N ;
void HienThi()
{
    for(int i = 0 ; i < N ; i++)
    {
        for(int j = 0 ; j < N ; j++)
        {
           cout<<a[i][j]<<"  ";
        }
        cout<<endl;
    }
    cout<<"**************************************"<<endl;
}
bool HauOk(int k , int dem)
{   
    for(int i = 1; i<=dem ; i++)
    {
        if(a[k-1][i-1]==1){
            return false;
        }
    }
    for(int cot = k-1 , hang = dem-1;cot>=1 && hang>=1 ; cot--,hang--)
    {
        if(a[cot-1][hang-1]==1){
            return false;
        }
    }
    for(int cot = k+1 , hang = dem-1;cot<=N && hang>=1 ; cot++,hang--)
    {
        if(a[cot-1][hang-1]==1){
            return false;
        }
    }
    return true;
}
void DatHau(int dem , int N)
{
    if(dem>N)
    {
        HienThi();
    }
    else{
        for(int k = 1 ; k<= N ; k++)
        {
            if(HauOk(k,dem) == true)
            {
                a[k-1][dem-1]=1;
                DatHau(dem+1, N);
                a[k-1][dem-1]=0;
            }
        }
    }
}
int main()
{   
    cin>>N;
     for(int i = 0 ; i < N ; i++)
        for(int j = 0 ; j < N ; j++)
            a[i][j]=0;

    DatHau(1,N);
    return 0 ; 
}
